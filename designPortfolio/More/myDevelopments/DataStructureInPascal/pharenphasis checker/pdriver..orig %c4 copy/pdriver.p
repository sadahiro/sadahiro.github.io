program pdriver;

	uses
		IOOC, stackADT;
	type
		ErrorType = (NoError, LessLeftP, StackIsFull);

	var
		Fname: str255;
		MyText: text;
		Validity: boolean;
		Error: ErrorType;
		XpressionLine: str255;

	procedure RoadString (var Line: str255; var MyText: text);
	begin
		readln(MyText, Line)
	end;

	procedure Pchecker (var balance: boolean; var myError: ErrorType; var myXpressionLine: str255);
		var
			mySample: char;
			myStack: StackType;
			myPoppedCell: StackElementType;
			myXpressionLength: integer;
			myLoop: integer;
	begin
		balance := true;
		myError := NoError;
		CreateStack(myStack);
		myXpressionLength := length(myXpressionLine);
		for myLoop := 1 to myXpressionLength do
			begin
				mySample := myXpressionLine[myLoop];
				if (mySample = '(') or (mySample = ')') then
					begin
						case mySample of
							'(': 
								if not FullStack(myStack) then
									push(myStack, mySample)
								else
									begin
										balance := false;
										myError := StackIsFull;
									end;				{end of else}
							')': 
								if not EmptyStack(myStack) then
									Pop(myStack, myPoppedCell)
								else
									balance := false;
						end;				{end of case}
					end;				{end of if}
			end;				{end of 'for myLoop to myXpressionLength'}
		if not EmptyStack(myStack) then
			begin
				balance := false;
				myError := LessLeftP;
			end;			{end of 'if EmptyStack'}
	end;				{end of Pchecker}
{*****************************}

	procedure PrintIt (var balance: boolean; var myError: ErrorType; var myXpressionLine: str255);
	begin
		writeln;
		write('The expression: ');
		writeln(myXpressionLine);
		if balance then
			write('		is an valid expression')
		else
			begin
				write('		is not an valid expression because of ');
				case myError of
					LessLeftP: 
						write('too much right parentheses');
					StackIsFull: 
						write('too much expression.  unable to process');
				end;				{end of case}
			end;				{end of else-begin}
	end;				{end of PrintIt}
{*****************************}

begin
	OpenFileIN(MyText, Fname);
	ShowText;
	writeln;
	write('The file: ', Fname);
	writeln;
	write('			is opened');
	while not eof(MyText) do
		begin
			writeln;
			RoadString(XpressionLine, MyText);
			Pchecker(Validity, Error, XpressionLine);
			PrintIt(Validity, Error, XpressionLine)
		end;				{end of whileNotEof}
	writeln;
	writeln;
	writeln('The examining expressions in file ');
	writeln(Fname, '           is finished.');
	CloseFile(MyText);
end.