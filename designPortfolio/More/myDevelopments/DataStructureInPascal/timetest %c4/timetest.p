program timetest;

	const
		myDateForm = longDate;
		wantSec = true;
	var
		mySecs: longint;
		myDateTimeRec: DateTimeRec;
		g1: longint;
		result: str255;
{*************************************}

	procedure Wait;
	begin
		while (not Button) do
			begin
			end
	end;
{*************************************}

begin
	GetDateTime(mySecs);
	writeln(mySecs);
	wait;
	getTime(myDateTimeRec);
	writeln(myDateTimeRec.year);
	writeln(myDateTimeRec.month);
	writeln(myDateTimeRec.day);
	writeln(myDateTimeRec.hour);
	writeln(myDateTimeRec.minute);
	writeln(myDateTimeRec.second);
	writeln(myDateTimeRec.dayOfWeek);
	date2secs(myDateTimeRec, mysecs);
	writeln(mysecs);
	IUDateString(g1, myDateForm, result);
	writeln(result);
	IUTimeString(g1, wantSec, result);
	writeln(result);
end.