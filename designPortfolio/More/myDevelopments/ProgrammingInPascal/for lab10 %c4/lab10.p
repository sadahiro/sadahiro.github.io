
{Programmer:	Makoto Sadahiro }
{Class:	CIS-111 Computer Programming in Pascal			section -03}

{Lab number:		-10					Due Date:	Friday April 30th '93}

{Purpose:		read series of cities and tempareture of whole year, get average of each cites and each monthes}

{Input :	  FnameIN: str255;		the input is from dialog box }

{Outputs :	  FnameIN:str255;  CityCount:integer;  Cities:array;  Tempa:2Darray;  }

{comment:	the maximum number of cities are 21, 1 is reserved as space for monthry averages.....}

program lab10 (input, output, datafile);
	uses
		IOOC, MathAverage;

	const
		WordLength = 20;			{defining the length of city names}
					{CityLimit = 21;}
								{citylimit is 20, 1 will be reserved for monthly average of 2d array}
																						{difined in MathAverage}

	type
		CNameLength = string[WordLength];
		CityArr = array[1..CityLimit] of CNameLength;
					{Monthes = (Jan, Feb, Mar, Apr, May, Jun, Jul, Aug, Sep, Oct, Nov, Dec, Ave);}
					{TempaMatrix = array[1..CityLimit, Monthes] of integer;}
																						{difined in MathAverage}
	var
		CityCount: integer;			{counting the number of cities read}
		Cities: CityArr;				{array for city names}
		Tempa: TempaMatrix;		{2D array for temparaatures, pararell to CityArr}

	procedure RoadArray (var CityCount: integer;
									var Cities: CityArr;
									var Tempa: TempaMatrix);
		var
			FtxtIN: text;
			FnameIN: str255;
	begin
		OpenFileIN(FtxtIN, FnameIN);
		writeln('the source file' : 20, '   ', FnameIN);	{echo printing source file name}
		writeln;
		CityCount := 0;
		while not eof(FtxtIN) and (CityCount < CityLimit) do	{reading contents of txt file into pararell arrays}
			begin
				CityCount := CityCount + 1;					{counting number of city until out of loop}
				readln(FtxtIN, Cities[CityCount]);
				readln(FtxtIN, Tempa[CityCount, Jan], Tempa[CityCount, Feb], Tempa[CityCount, Mar], Tempa[CityCount, Apr], Tempa[CityCount, May], Tempa[CityCount, Jun], Tempa[CityCount, Jul], Tempa[CityCount, Aug], Tempa[CityCount, Sep], Tempa[CityCount, Oct], Tempa[CityCount, Nov], Tempa[CityCount, Dec])
			end;
		CityCount := CityCount + 1;						{making one more space on array}
		Cities[CityCount] := 'Monthly Average-> ';		{and placing rabel for monthly average}
		CloseFile(FtxtIN)										{closing file since it is already read into arrays}
	end;				{end of procedure RoadArray}

	procedure Displaier (Tempa: TempaMatrix;
									Cities: CityArr;
									CityCount: integer);
		var
			i: integer;
			j: Monthes;
	begin
		writeln('the results with ' : WordLength, Citycount - 1 : 2, ' cities-');
		writeln;
		write('- The Locations -' : WordLength);
		for j := Jan to Ave do
			write(j : 5);
		writeln;
		for i := 1 to Citycount - 1 do
			begin
				write(Cities[i] : WordLength);
				for j := Jan to Dec do
					write(Tempa[i, j] : 5);
				writeln((Tempa[i, Ave] / 10) : 7 : 1)
			end;
		write(Cities[CityCount] : WordLength + 1);
		for j := Jan to Dec do
			write((Tempa[CityCount, j] / 10) : 5 : 1);
		writeln;
		writeln;
		writeln('The Average temparature in all cities above for whole year is : ', (Tempa[CityCount, Ave] / 100) : 7 : 1)
	end;				{end of procedure Displaier}

	procedure Exe (CityCount: integer;
									Cities: CityArr;
									Tempa: TempaMatrix);
	begin
		HArrAve2D(Tempa, CityCount);				{getting holizontal average}
		VArrAve2D(Tempa, CityCount);				{getting virtical average}
		Displaier(Tempa, Cities, CityCount)			{displaing all results}
	end;				{end of procedure Exe}

begin								{start main program}
	showtext;
	RoadArray(CityCount, Cities, Tempa);
	Exe(CityCount, Cities, Tempa);
end.								{end of main program}