
{Programmer:	Makoto Sadahiro }
{Class:	CIS-111 Computer Programming in Pascal			section -03}

{Lab number:		-09					Due Date:	Wednesday April 21st '93}

{Purpose:		read source program, list them, get max,min,ave, standad diviation.....}

{Input :	  Fnamestr: str;		the input is from dialog box }

{Outputs :	  Rail: ArrType	as in list;		Fnamestr: str;		ExcessNumeric, GExcessNumeric: integer; }
			{SetCounter: integer;	Max, Min, Ave, StdDiv: real;		GMax, GMin, GAve, GStdDiv: real; }

{comment:	comments? hmmm....}


program lab9 (input, output, datafile);

	uses
		IOOC, MathCalc;

	const
{Capa = 50;	decreared in unit MathCalc}
		wdth = 10;
		dicimalP = 2;

	type
		str = str255;
{ArrType = array[1..Capa] of real;		decreared in unit MathCalc}

	var
		Rail: ArrType;		{the array used mainly to store real numbers}
		OFlw: ArrType;		{the array used in case Rail is over flowed}
		Filetxt: text;		{data file in text}
		Fnamestr: str;		{filename of Filetxt}
		NumericChaser: integer;  {simply means COUNTER-used to count contents in Rail-array}
		ExcessNumeric, GExcessNumeric: integer;		{counter for more than 50 inputs}
		stopper: boolean;		{to get out from loop of reading units}
		SetCounter: integer;		{counts the number of sets in data.file}
		Max, Min, Ave, StdDiv: real;	{locals}
		GMax, GMin, GAve, GStdDiv: real;	{grovals}
		Rws: integer;		{the number of raws to display for inputs}
		Col: integer;		{the number of columns on the last line to display}
		i, j: integer;	{counter for loop}

	procedure LoadRail (var Filetxt: text;
									var Rail: ArrType;
									var OFlw: ArrType;
									var NumericChaser: integer;
									var Stopper: boolean);			{this will load up Rail-array with real numbers}
	begin
		NumericChaser := 0;
		repeat
			if eof(Filetxt) then
				begin
					Stopper := false;
					NumericChaser := NumericChaser + 1
				end
			else
				begin
					NumericChaser := NumericChaser + 1;
					if NumericChaser in [1..50] then		{store up to 50 arrays in here}
						readln(Filetxt, Rail[NumericChaser])
					else if NumericChaser in [51..100] then		{stoer extra 50 arrays in here}
						readln(Filetxt, OFlw[NumericChaser - 50])
				end;															{if data is more than 100?  ha! ha! I donta no!}
		until (Stopper = false) or (Rail[NumericChaser] < 0);
		NumericChaser := NumericChaser - 1		{subtracting negative# already read}
	end;		{end of procedure LoadRail}


	procedure ReCalc (var SetCounter: integer;
									var GMax, GMin, GAve, GStdDiv: real;
									var GExcessNumeric: integer;
									Max, Min, Ave, StdDiv: real;
									ExcessNumeric: integer);		{this will evaluate groval maximum, minimum, }
																{and re culcurate average and standard diviation}
	begin
{Max}
		if Max > GMax then
			GMax := Max;
{Min}
		if Min < GMin then
			GMin := Min;
{Ave}
		GAve := (GAve * SetCounter + Ave) / (SetCounter + 1);
{StdDiv}
		GStdDiv := (GStdDiv * SetCounter + StdDiv) / (SetCounter + 1);
{ExcessNumeric}
		GExcessNumeric := GExcessNumeric + ExcessNumeric;
{Counting Sets}
		SetCounter := SetCounter + 1
	end;		{end of procedure ReCalc}

{HERE!!   THE BEGINNING OF MAIN PROGRAM}
begin
	showText;
	OpenFileIN(Filetxt, FnameStr);
	Stopper := true;	{initializing stopper to get into while loop below}
	SetCounter := 0;	{initialize counter for counting sets in data.file}
	GMax := 0;
	GMin := maxint;
	GAve := 0;
	GStdDiv := 0;
	GExcessNumeric := 0;		{These variables start with G is Groval valuables through all units}
	while (Stopper) do
		begin
			LoadRail(Filetxt, Rail, OFlw, NumericChaser, Stopper);		{roadin real numbers into array-Rail}
			if NumericChaser > 50 then			{checking how many numbers does Rail-array have}
				begin
					ExcessNumeric := NumericChaser - 50;
					NumericChaser := 50
				end
			else
				ExcessNumeric := 0;
			if NumericChaser > 0 then	{0 means nothig in set so skip one empty set}
				begin
					Maxin(Max, Min, Rail, NumericChaser);		{get Maximum number and Minimum number}
					SDnA(Ave, StdDiv, Rail, NumericChaser);		{get standard diviation and average}
	{displlaying data in 5 raws and local summary}
					writeln;
					writeln;		{making space from last set}
					Rws := NumericChaser div 5;
					for i := 1 to Rws do
						begin
							for j := 1 to 5 do
								write(Rail[j + (i - 1) * 5] : wdth : dicimalP);
							writeln	{carige returns line}
						end;
					if NumericChaser mod 5 <> 0 then
						begin
							Col := NumericChaser mod 5;
							for j := 1 to Col do
								write(Rail[j + Rws * 5] : wdth : dicimalP);
							writeln;
						end;
					writeln('the result with the set above is following');	{following lines-summary of the set}
					writeln('the number of data which was dropped because of overflow of data  ', ExcessNumeric : 5);
					writeln('maximum number is ', Max : wdth : dicimalP);
					writeln('minimum number is ', Min : wdth : dicimalP);
					writeln('average of these numbers are ', Ave : wdth : dicimalP);
					writeln('standard diviation of these numbers is ', StdDiv : wdth : dicimalP);
					ReCalc(SetCounter, GMax, GMin, GAve, GStdDiv, GExcessNumeric, Max, Min, Ave, StdDiv, ExcessNumeric);
				end
		end;
{summary as GROBAL}
	writeln;
	writeln;
	writeln;		{making space from units}
	writeln('the source file is  ', Fnamestr);
	writeln('the result with the all sets in the file above is following');	{following lines-summary of the set}
	writeln('the number of sets processed is ', SetCounter : 5);
	writeln('the number of data which was dropped because of overflow of data  ', GExcessNumeric : 5);
	writeln('maximum number is ', GMax : wdth : dicimalP);
	writeln('minimum number is ', GMin : wdth : dicimalP);
	writeln('average of these sets is ', GAve : wdth : dicimalP);
	writeln('standard diviation of these sets is ', GStdDiv : wdth : dicimalP);
{anumcing the end of execution}
	writeln('the end of DATA.FILE.....');
	writeln('finishing execution....files closed..');
	CloseFile(FileTxt)
end.		{do i have to say this?  this is the end of main program}
		{YES!! it is done!!  now i can go home and sleep..i didnt sleep last night..OOp..i have to finish my diagram chart....shit!}