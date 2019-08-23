program lab;
{Programmer:	Makoto Sadahiro }
{date: Nov 3rd '93}
{Purpose:		driving software for loading student data}
{Input :	  SourceList: text }
{Outputs :	        OutList:text}
{comment:	none}
	uses
		IFaceUtill, IOOC, listype, listADT, ListPrints, time;

	var
		SourceList, OutList: text;
		SourceListFname, OutListFname: str255;
		LabLog: ListType;

				{Declaration}
{*****************************}

{manage openning source file}
{open the file and peint the neme of file}
{out: source text}
{post: text file is open}
	procedure GetText (var SourceList: text;
									var SourceListFname: str255);
	begin
		OpenFileIN(SourceList, SourceListFname);
		writeln(' following file opened....');
		writeln('' : 5, SourceListFname);
	end;				{GetText}
{*****************************}

{load list up from source text file}
{in:text file}
{out:list}
{pre: list is empty}
{post:list is loaded}
	procedure SourceToList (var myLabLog: ListType;
									var mySourceList: text);
		var
			iD: integer;
			stuName: string[nameLength];
			aStuLog, aNewStu: ListElementType;
			there: boolean;
	begin
		writeln('loading data......');
		while not eof(mySourceList) and not FullList(myLabLog) do
			begin
				readln(mySourceList, iD, stuName);
				with aNewStu do
					begin
						key := iD;
						name := stuName;
						validity := true;
						maxHr := defHr;
						usdHr := 0;
						remHr := maxHr - usdHr;
						penalty := false;
					end;				{with}
				RetrieveElement(myLabLog, iD, aStuLog, there);
				if (there) then
					begin				{case student is already registered}
						writeln;
						aStuLog.maxHr := aStuLog.maxHr + defHr;
						ModifyElement(myLabLog, aStuLog);
						write('' : 5, 'student #', aStuLog.key : 4, '  overrided.  ');
						write(defHr div 60 : 3, ':');
						if defHr mod 60 = 0 then
							write('00' : 2)
						else
							write(defHr mod 60 : 2);
						writeln(' more hours are added');
					end				{if there then}
				else
					begin				{case student is not already registered}
						InsertElement(myLabLog, aNewStu);
					end;				{if there else}
			end;				{while not and not}
		if FullList(myLabLog) then
			writeln('shouldnt be here, but list is full...sad....');
		writeln('' : 45, '{ ......................data loading done..}');
	end;				{SourceToList}
{*****************************}

{closeing text file}
{in: text file}
{pre: text file is open}
{post:text file is closed}
	procedure CloseSource (var mySourceList: text);
	begin
		CloseFile(mySourceList)
	end;				{CloseSource}
{*****************************}

{make new text file to be saved as data file}
{out: new text file}
{pre: text file doesnt exist}
{post: text file exists}
	procedure MakeNewText (var myOutList: text;
									var myOutListFname: str255);
	begin
		OpenFileOUT(myOutList, myOutListFname);
		writeln('following new file created');
		writeln('' : 5, myOutListFname);
	end;				{OpenFileOUT}
{*****************************}

{write the contents of list into text file to be saved}
{in: list}
{out: text file}
{pre: text file is empty}
{post: text file is loaded}
	procedure ListToOutList (var myOutList: text;
									var myLabLog: ListType);
		var
			myPtr: PointerType;
	begin
		myPtr := myLabLog;
		while myPtr <> nil do
			begin
				myPtr^.Info.remHr := myPtr^.Info.maxHr - myPtr^.Info.usdHr;
				write(myOutList, myPtr^.Info.key);
				write(myOutList, myPtr^.Info.name);
				write(myOutList, myPtr^.Info.validity);
				write(myOutList, myPtr^.Info.maxHr);
				write(myOutList, myPtr^.Info.usdHr);
				write(myOutList, myPtr^.Info.remHr);
				write(myOutList, myPtr^.Info.penalty);
				writeln(myOutList);
				myPtr := myPtr^.next;
			end;				{while}
	end;				{ListToOutList}
{*****************************}

{close the text file to be saved}
{in: text file}
{pre: text file is still open}
{post: text file is closed-saved}
	procedure SaveOutList (var myOutList: text;
									var myOutListFname: str255);
	begin
		CloseFile(myOutList);
		writeln('following file saved');
		writeln('' : 5, myOutListFname);
	end;				{SaveOutList}
{*****************************}

{destroying list structure to avoid wasting memory}
{in: list}
{pre:list is loaded}
{post: list is nil}
	procedure WipeLabLog (var myLabLog: ListType);
	begin
		DestroyList(myLabLog);
	end;				{WipeLabLog}
{*****************************}


{********main program***********************************}
begin
	ShowText;
	GetText(SourceList, SourceListFname);
	SourceToList(LabLog, SourceList);				{adding new student}
	PrintList(LabLog, Wkly);
	CloseSource(SourceList);
	MakeNewText(OutList, OutListFname);
	ListToOutList(OutList, LabLog);
	SaveOutList(OutList, OutListFname);
	WipeLabLog(LabLog);
	writeln(' click mouse button to continue.....');
	Wait;				{wait for mouse click}
end.				{lab}

{comment at the end--}
{I know I don't need to put semi-colone before "end", but I decided to do}
{because It will avoid some of mistake when you modify your code alot....}