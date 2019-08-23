program WaitingForBus;
{Programmer:	Makoto Sadahiro }
{date: Nov 3rd '93}
{Purpose:		keep track of passengers in particular bus stop and get statistic}
{Input :	  SourceText: text }
{Outputs :	        roomsCount: integer;  totalCustomer: integer;  }
				{totalPassenger: integer;  peopleWaiting: integer;  aveWait: integer;  }
{comment:	none}
	uses
		QadtTypes, IOOC, initElement, queueADT;

	var
		SourceText: text;
		ExamingFname: str255;

				{Declaration}
{*****************************}

	procedure GetText (var newText: text; var newfname: str255);
	begin
		OpenFileIN(newText, newFname);
		writeln(' following file opened....');
		writeln(newFname);
	end;				{GetText}
{*****************************}

	procedure CloseDown (var closingText: text; var closingFname: str255);
	begin
		writeln(closingFname);
		writeln(' examination of file above finished....');
		CloseFile(closingText)
	end;				{CloseDown}
{*****************************}

	procedure GetInLine (var myQ: QueueType; var myTime, myNewPeople, totalCustomer: integer);
		var
			i: integer;				{local use}
	begin
		writeln(' event-', myTime : 5);
		if myNewPeople = 1 then
			writeln(myNewPeople : 3, ' person arrived')
		else
			writeln(myNewPeople : 3, ' people arrived');				{if}
		totalCustomer := totalCustomer + myNewPeople;
		for i := 1 to myNewPeople do
			begin
				InQueue(myQ, mytime);
			end;				{for}
	end;				{getInLine}
{*****************************}

	function ConvertToMin (var number: integer): integer;
	begin
		ConvertToMin := (number div 100 * 60) + (number mod 100);
	end;				{convertToMin}
{*****************************}

	function ConvertToHr (var number: integer): integer;
	begin
		ConvertToHr := (number div 100 div 60) + (number mod 100);
	end;				{convertToHr}
{*****************************}

	function TimeDifference (var busArriving, TimeBourderArrived: integer): integer;
	begin
		if busArriving < TimeBourderArrived then
			busArriving := busArriving + 2400;
		TimeDifference := ConvertToMin(busArriving) - ConvertToMin(TimeBourderArrived);
	end;				{TimeDifference}
{*****************************}

	procedure GetOnBus (var QInBusStop: QueueType; var myTime, seatsAvailable, totalWaitingTime, totalPassenger: integer);
		var
			i: integer;				{local use}
			TimeBourderArrived: integer;
	begin
		writeln(' event-', myTime : 5);
		if seatsAvailable = 1 then
			writeln('bus arrived with ', seatsAvailable : 3, ' seat')
		else
			writeln('bus arrived with ', seatsAvailable : 3, ' seats');				{if}
		for i := 1 to seatsAvailable do
			begin
				if not EmptyQueue(QInBusStop) then
					begin
						OutQueue(QInBusStop, TimeBourderArrived);
						totalWaitingTime := totalWaitingTime + TimeDifference(myTime, TimeBourderArrived);
						totalPassenger := totalPassenger + 1;
					end;				{if}
			end;				{for}
	end;				{getOnBus}
{*****************************}

	procedure ResultNow (var QInBusStop: QueueType; var lastEventTime, totalWaitingTime, peopleWaiting: integer);
		var
			TimeBourderArrived: integer;
	begin
		while not EmptyQueue(QInBusStop) do
			begin
				OutQueue(QInBusStop, TimeBourderArrived);
				totalWaitingTime := totalWaitingTime + TimeDifference(lastEventTime, TimeBourderArrived);
				peopleWaiting := peopleWaiting + 1;
			end;				{while not}
	end;				{ResultNow}
{*****************************}

	procedure Summary (var QInBusStop: QueueType; var lastEventTime, totalCustomer, totalPassenger, totalWaitingTime: integer);
		var
			peopleWaiting: integer;
			aveWait: integer;
	begin
		writeln('total of ', totalCustomer : 4, ' people were in line in bus station');
		writeln('		and ', totalPassenger : 4, ' people got on bus,');
		InitInteger(peopleWaiting);
		ResultNow(QInBusStop, lastEventTime, totalWaitingTime, peopleWaiting);
		if peopleWaiting = 1 then
			writeln('so ', peopleWaiting : 3, ' person is still waiting for bus')
		else
			writeln('so ', peopleWaiting : 3, ' people are still waiting for bus');
		aveWait := round(totalWaitingTime / totalCustomer);
		aveWait := convertToHr(aveWait);
		writeln('the avelage of time people waiting in bus stop was ', aveWait : 3, ' minutes');
	end;				{summary}
{*****************************}

	procedure Main (var mySourceText: text);
		var
			QInBusStop: QueueType;				{queue of people who is waiting in bus stop}
			incomingID: char;				{tells which object either people or bus arrives}
			myTime: integer;				{tells either people or bus arriving time}
			lastEventTime: integer;				{tells time last event happened}
			roomsCount: integer;				{tells either no. of people or bus seat available}
			totalCustomer: integer;				{tells total passenger who is/was in line}
			totalPassenger: integer;					{tells total number of passengers got board}
			totalWaitingTime: integer;				{tells total waiting time of people}
{this totalWaitingTime will be added to it when people get on bus and at the end of execution}
	begin
		CreateQueue(QInBusStop);
		initInteger(totalCustomer);
		initInteger(totalPassenger);
		initInteger(totalWaitingTime);
		writeln('---- STATISTIC OF BUS STOP RECORD ----');
		writeln;
		while not eof(mySourceText) do
			begin
				readln(mySourceText, incomingID, myTime, roomsCount);
				lastEventTime := myTime;
				if (incomingID = 'P') or (incomingID = 'p') then
					GetInLine(QInBusStop, myTime, roomsCount, totalCustomer)
				else if (incomingID = 'B') or (incomingID = 'b') then
					GetOnBus(QInBusStop, myTime, roomsCount, totalWaitingTime, totalPassenger)
				else
					writeln('shouldnt be here, not reading if it is people or bus arrive');
				writeln;				{spacer inbetween each events}
			end;				{while not}
		Summary(QInBusStop, lastEventTime, totalCustomer, totalPassenger, totalWaitingTime);
		DestroyQueue(QInBusStop);
	end;				{Main}


{********main program***********************************}
begin
	ShowText;
	GetText(SourceText, ExamingFname);
	Main(SourceText);
	CloseDown(SourceText, ExamingFname);
end.				{WaitingForBus}

{comment at the end--}
{I know I don't need to put semi-colone before "end", but I decided to do}
{because It will avoid some of mistake when you modify your code alot....}