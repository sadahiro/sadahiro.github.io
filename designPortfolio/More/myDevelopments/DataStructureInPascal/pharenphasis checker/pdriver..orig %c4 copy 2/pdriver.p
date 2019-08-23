program pdriver;

	uses
		IOOC, stackADT;
	const
		DisplayLength = 25;
	type
		InfoType = char;
		ErrorType = (NoError, LessLeftP, MoreLeftP);
{*****************************}

	procedure Parenphasis (var myStack: StackType; var mySample: char; var balance: boolean; var myError: ErrorType);
	begin
		case mySample of
			'(': 
				if not FullStack(myStack) then
					push(myStack, mySample)
				else
					writeln('shouldnt be here');
			')': 
				if not EmptyStack(myStack) then
					Pop(myStack, mySample)
				else
					begin
						balance := false;
						myError := LessLeftP;
					end;
		end;				{case}
	end;				{Parenphasis}
{*****************************}

	procedure result (balance: boolean; myError: ErrorType);
	begin
		if (balance) then
			writeln('	is valid')
		else
			case myError of
				LessLeftP: 
					writeln('	This espression needs more left parentheses');
				MoreLeftP: 
					writeln('	This espression needs more right parentheses');
			end;			{case}
	end;				{proc}
{*****************************}

	procedure CheckManager;
		var
			myText: text;
			Fname: str255;
			myStack: StackType;
			mySample: char;
			myLoop: integer;
			balance: boolean;
			myError: ErrorType;		{see type declaration}

	begin
		OpenFileIN(myText, Fname);
		write('The file: ', Fname);
		writeln;
		writeln('			is opened');
		while not eof(myText) do
			begin
				CreateStack(myStack);
				writeln('Examning Expression -');
				write('" ');
				while not eoln(myText) do
					begin
						myLoop := myLoop + 1;
						read(myText, mySample);
						write(mySample);
						if (mySample = '(') or (mySample = ')') then
							Parenphasis(myStack, mySample, balance, myerror);
						if myLoop = DisplayLength then
							begin
								writeln(' "');
								write('" ');
								DestroyStack(myStack);
								myLoop := 0;
							end;				{if}
					end;				{while not eoln}
				myLoop := 0;
				readln(myText);
				if not EmptyStack(myStack) then
					begin
						balance := false;
						myError := MoreLeftP;
					end;			{end of 'if EmptyStack'}
				writeln(' "');
				result(balance, myError);
				DestroyStack(myStack);
				writeln;
				myLoop := 0;
				balance := true;
				myError := NoError;
			end;				{while not eof}
		writeln(Fname);
		writeln('      is finished.');
		CloseFile(MyText);
	end;				{end of Pchecker}
{*****************************}

	procedure Wait;
	begin
		while (not Button) do
			begin
			end
	end;
{*****************************}

begin
	ShowText;
	CheckManager;
	Wait
end.