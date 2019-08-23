program CheckerManager;

	uses
		IOOC, stackLL, stringUTILL;

	var
		Fname: str255;
		SourcePointer: SourceTextPointer;
{*****************************}

	procedure Read (var mySourcePointer: SourceTextPointer);
		var
			myPlainText: text;			{whole text from data file}
			myCtr: integer;		{counter}
			chElement: char;		{char which is read from myPlainText}
			myElementLine: aLineElementLength;		{stripe made up}
	begin
		OpenFileIN(myPlainText, Fname);

		SpritRoad(mySourcePointer, myPlainText);
		CloseFile(myPlainText);
	end;
{*****************************}

	procedure Evaluate ();
	begin

	end;				{end of Evaluate}
{*****************************}

begin
	ShowText;
	Read(SourcePointer);
	Evaluate(SourcePointer);
	PrintIt(SourcePointer);
end.