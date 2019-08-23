{Programmer:	Makoto Sadahiro }

{date: Oct 22th '93}

{Purpose:		program pdriver is test driving program to test procedure CheckManager}

{Input :	  myText:text }

{Outputs :	     mySample:char}

{comment:	none}

program pdriver;

	uses
		IOOC, stackADT;
	const
		DisplayLength = 25;				{ the length of source text displayed on screen can be changed here}
	type
		InfoType = char;
		ErrorType = (NoError, LessLeftP, MoreLeftP, OverFlow);

{*****************************}

{Parenphasis will receive charactor read from text file which is mySample and either push, pop,}
{or return balance and error type}
	procedure Parenphasis (var myStack: StackType; var mySample: char; var balance: boolean; var myError: ErrorType);
	begin
		case mySample of
			'(': 
				if not FullStack(myStack) then
					push(myStack, mySample)
				else
					begin
						balance := false;
						myError := OverFlow;
					end;
			')': 
				if not EmptyStack(myStack) then
					Pop(myStack, mySample)
				else
					begin
						balance := false;
						myError := LessLeftP;
					end;									{else}
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
					writeln('	Missing left parentheses');
				MoreLeftP: 
					writeln('	Missing right parentheses');
				OverFlow: 
					begin
						writeln('I hate to tell this, but I am afraid myStack overflew');
						writeln('		I can not process this expression');
					end;				{OverFlow}
			end;			{case}
	end;				{proc}
{*****************************}

	procedure CheckManager;
		var
			myText: text;
			Fname: str255;				{file name of text}
			myStack: StackType;
			mySample: char;
			myLoop: integer;			{counter}
			balance: boolean;				{balance of parentheses}
			myError: ErrorType;		{see type declaration}

	begin
		balance := true;			{initializing}
		myError := NoError;				{initializing}
		myLoop := 0;					{initializing}
		CreateStack(myStack);			{initializing}
		OpenFileIN(myText, Fname);
		write('The file: ', Fname);
		writeln;
		writeln('			is opened');
		while not eof(myText) do
			begin
				writeln('Examning Expression -');
				write('" ');
				while not eoln(myText) and (balance) do
					begin
						if myLoop <= DisplayLength then
							begin
								myLoop := myLoop + 1;
								read(myText, mySample);
								write(mySample);
								if (mySample = '(') or (mySample = ')') then
									Parenphasis(myStack, mySample, balance, myerror);
							end
						else
							begin
								writeln(' "');
								write('" ');
								myLoop := 0;
							end;				{else}
					end;				{while not eoln}
				if not balance then
					while not eoln(myText) do
						begin
							read(myText, mySample);
							write(mySample);
						end;
				readln(myText);
				if not EmptyStack(myStack) and (myError <> OverFlow) then
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
	end;				{CheckManager}
{*****************************}

{this procedure will hold program running until use click on mouse}
	procedure Wait;
	begin
		while (not Button) do
			begin
			end
	end;				{wait}
{*****************************}

begin
	ShowText;
	CheckManager;
	Wait
end.				{end of program}