{Programmer:	Makoto Sadahiro }

{Purpose:		observing a bug which moves randomly on 5 by 5 table top }
				{get a result what happened on bug and make a output }

{Input :	  none }

{Outputs :	     myGrid: grid, result: string[30]  }

{comment:	comments? hmmm....}

program BugObserve;

	uses
{directionGenerator: random generator to get direction}
{countor:  series of counters }
		directionGenerator, countor;

	type
{indicates status of bug at the time}
		status = (fallAsleep, fallOff, moving, poisonized);
{represents position of bug at the time}
		position = record
				row: integer;
				column: integer
			end;
{grid is record which each record is 2d array of grid}
{there are 2 layer of 2d arrays}
{gridTop will store path of bug-footPrint}
{gridBottom will store data of objects which exsts on each cell like poison-objectOnIt}
		footPrint = array[1..7, 1..7] of integer;
		objectOnIt = array[1..7, 1..7] of char;
		grid = record
				gridTop: footPrint;
				gridBottom: objectOnIt
			end;
{end of type declearation}
{************************************}

	var
{actual table top where bug will crawling around}
		myGrid: grid;
{indicate the status of bug}
		myStatus: status;
{end of variable declearation}
{************************************}

{non-repeat procedure}
{initialize both top and bottom cells here}
	procedure initGrid (var myGrid: grid);
		var
			i, j: integer;		{temporary variables for loop}
	begin
{initialize top}
		for i := 1 to 7 do
			for j := 1 to 7 do
				myGrid.gridTop[i, j] := 0;
{initialize bottom}
		for i := 1 to 7 do
			for j := 1 to 7 do
				myGrid.gridBottom[i, j] := 'ô';		{ô stands for Empty}
{initialize outof edges}
		for i := 1 to 7 do
			mygrid.gridBottom[1, i] := 'ê';			{ê stands for out of edge}
		for i := 1 to 7 do
			mygrid.gridBottom[7, i] := 'ê';			{ê stands for out of edge}
		for i := 1 to 7 do
			mygrid.gridBottom[i, 1] := 'ê';			{ê stands for out of edge}
		for i := 1 to 7 do
			mygrid.gridBottom[i, 7] := 'ê';			{ê stands for out of edge}
	end;			{end of procedure initGrid}

{change setting of objects on grids here}
{if you like to set another poison, set it here}
	procedure setObjectOnGrid (var myGrid: grid);
	begin
		myGrid.gridBottom[4, 4] := 'S';			{S stands for startingPoint}
		myGrid.gridBottom[2, 2] := 'P';			{P stands for poison}
		myGrid.gridBottom[2, 6] := 'P';
		myGrid.gridBottom[6, 2] := 'P';
		myGrid.gridBottom[6, 6] := 'P'
	end;
{end of procedures from setUp}
{************************************}

{procedure to set up grid}
	procedure setUp (var myGrid: grid);
	begin
		initGrid(myGrid);
		setObjectOnGrid(myGrid);
	end;			{end of procedure setUp}
{************************************}

{the beginning of procedures for main part-observe}
{procedure to put bug on center of table top}
	procedure initMyPosition (var myPosition: position);
	begin
		myPosition.row := 4;
		myPosition.column := 4;
	end;			{end of initMyPosition}
{************************************}

{procedure to get direction to go and move myposition to there}
	procedure doMove (var myPosition: position; var myGrid: grid; myFootStep: integer);
		var
			dirMove: integer;
	begin
		dirMove := pentaDirection;		{dirMove is random number from 1 to 8 which is from unit directionalGenerator}
				{1  2  3}
				{4      5}
				{6  7  8}
					{each case numbers moves to each these direction on 2d arrays}
		case dirMove of
			1: 
				begin
					myPosition.row := myPosition.row - 1;
					myPosition.column := myPosition.column - 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			2: 
				begin
					myPosition.row := myPosition.row - 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			3: 
				begin
					myPosition.row := myPosition.row - 1;
					myPosition.column := myPosition.column + 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			4: 
				begin
					myPosition.column := myPosition.column - 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			5: 
				begin
					myPosition.column := myPosition.column + 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			6: 
				begin
					myPosition.row := myPosition.row + 1;
					myPosition.column := myPosition.column - 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			7: 
				begin
					myPosition.row := myPosition.row + 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end;
			8: 
				begin
					myPosition.row := myPosition.row + 1;
					myPosition.column := myPosition.column + 1;
					myGrid.gridTop[myPosition.row, myPosition.column] := myFootStep
				end
		end
	end;			{end of doMove}
{************************************}

{procedure to check where i am and if there is any object in the same cell, and make status}
	procedure checkStatus (var myStatus: status; myGrid: grid; myPosition: position; myFootStep: integer);
	begin
		if myFootStep = 8 then		{if bug crawled 8 steps, it will fall in asleep}
			myStatus := fallAsleep;
{add more case choices if you add more objects on grid}
{in case bug is poisonized after this line, myStatus=fallAsleep will ignored, and will be myStatus=poisonized}
		case mygrid.gridBottom[myPosition.row, myPosition.column] of
			'P': 
				myStatus := poisonized;
			'ê': 
				myStatus := fallOff
		end
	end;			{end of checkStatus}
{the end of procedures from observe}
{************************************}

{managing observing bug's movement here}
	procedure observe (var myGrid: grid; var myStatus: status);
		var
{myPosition will indicate present position of bug}
			myPosition: position;
{store the number of footsteps}
			myFootStep: integer;
	begin
		initMyPosition(myPosition);
		myStatus := moving;
		myFootStep := 0;
		repeat															{repeat as long as bug is on board and moving}
			addCounter(myFootStep);										{add one to counter-myFootStep}
			doMove(myPosition, myGrid, myFootStep);									{make a movement of bug}
			checkStatus(myStatus, myGrid, myPosition, myFootStep)	{check status and return status}
		until myStatus <> (moving)
	end;			{end of observing bug's movement}
{************************************}

{displays original grid arragement}
	procedure displayGrid (myGrid: grid);
		var
			i, j: integer;		{temporary variables}
	begin
		showtext;			{brings up text screen}
{displaying lower grid with objects}
		writeln;
		writeln('following is the original setting on table');
		writeln('ô indicate each cell of 5 by 5 table');
		writeln('ê indicate off the table which means floor');
		writeln('S is starting point of bug on table');
		writeln('P indicate poison on table');
		for i := 1 to 7 do
			begin
				writeln;
				for j := 1 to 7 do
					begin
						write(' ');
						write(myGrid.gridBottom[i, j])
					end
			end
	end;			{end of displaying grid}
{************************************}

{rewriting information on grid with result and footSteps of bug}
{putting the information of separate 2d array onto one 2d array to display}
{following will rewrite integer of bug's footsteps onto another 2d array as charactor}
	procedure reGrid (var myGrid: grid);
		var
			i, j: integer;			{temporary variable for loops}
	begin
		for i := 1 to 7 do
			for j := 1 to 7 do
				if myGrid.gridTop[i, j] <> 0 then
					begin
						case myGrid.gridTop[i, j] of
							1: 
								myGrid.gridBottom[i, j] := '1';
							2: 
								myGrid.gridBottom[i, j] := '2';
							3: 
								myGrid.gridBottom[i, j] := '3';
							4: 
								myGrid.gridBottom[i, j] := '4';
							5: 
								myGrid.gridBottom[i, j] := '5';
							6: 
								myGrid.gridBottom[i, j] := '6';
							7: 
								myGrid.gridBottom[i, j] := '7';
							8: 
								myGrid.gridBottom[i, j] := '8'
						end
					end
	end;		{end of regrid}
{************************************}


{redisplaying information on grid with result of footSteps of bug}
	procedure redisplayGrid (myGrid: grid);
		var
			i, j: integer;			{temporary variable for loops}
	begin
{displaying lower grid with objects}
		writeln;
		writeln;
		writeln;
		writeln;
		writeln('following table is the result on table');
		writeln('each number indicate the path of bug');
		writeln('P does not show up if bug is dead on poison');
		for i := 1 to 7 do
			begin
				writeln;
				for j := 1 to 7 do
					begin
						write(' ');
						write(myGrid.gridBottom[i, j])
					end
			end;
	end;		{end of redisplayGrid}
{************************************}

{displaying result of bug}
	procedure displayResult (myStatus: status);
		var
			result: string[30];
	begin
		case myStatus of
			fallAsleep: 
				result := 'falling asleep on table';
			fallOff: 
				result := 'falling off from table';
			poisonized: 
				result := 'poisonized'
		end;
		writeln;
		writeln('the bug ended up with ', result)
	end;		{end of display result}
{************************************}

{beginning of main program BugObserve}
begin
	setUp(myGrid);					{initialize and set up objects on the grid}
	observe(myGrid, myStatus);			{main part of program, the bug's movement is made and stored here}
	displayGrid(myGrid);				{displays original table}
	reGrid(myGrid);				{conbine two 2d arrays together}
	redisplayGrid(myGrid);			{redisplay original table with result of footsteps of bug}
	displayResult(myStatus)				{displays result what happened on bug }
end.			{end of program BugObserve}
{************************************}