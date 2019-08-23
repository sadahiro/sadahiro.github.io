program new;

{ Insert your declarations here }
	const
		include_seconds = true;
	var
		myTimeString: str255;
		dateTime: longint;


begin

	getDateTime(dateTime);
	writeln(dateTime);
	IUTimeString(dateTime, INCLUDE_SECONDS, myTimeString);
	writeln(myTimeString);
	dateTime := dateTime + 3600;
	writeln(dateTime);
	IUTimeString(dateTime, INCLUDE_SECONDS, myTimeString);
	writeln(myTimeString);
	dateTime := dateTime + 3600;
	writeln(dateTime);
	IUTimeString(dateTime, INCLUDE_SECONDS, myTimeString);
	writeln(myTimeString);
	dateTime := dateTime + 3600;
	writeln(dateTime);
	IUTimeString(dateTime, INCLUDE_SECONDS, myTimeString);
	writeln(myTimeString);
{gettime(timegota);}
{ Insert your program code here }

end.