program LabBase;
{Programmer:	Makoto Sadahiro }
{date: Nov 28nd '93}
{Purpose: data base for computer lab}
{comment:	none}
	uses
		Screens, time, IFaceUtill, listype, listADT, Lfile, Ledit;
	var
		LabLog: ListType;
		Choice: char;
		quit: boolean;
				{Declaration}
{*****************************}

begin
	OpenTextWindow(20, 80, 620, 240);
	StartUpScreen;
	quit := false;
	while not quit do
		begin
			write('Base:?,Quit,Open,List,Add,Drop,Sign,weeklyReset>');
			readln(Choice);
{all commands here}
{chosen by case statement}
			case Choice of
				'?': 
					begin
						BaseHelpScreen;
					end;		{?}
{belongs to Lfile}
				'Q': 
					begin
						CloseLabLog(LabLog);
						quit := true;
					end;		{Quit}
				'O': 
					begin
						OpenLabLog(LabLog);
					end;		{Open}
				'L': 
					begin
						ChoseListing(LabLog);
					end;		{Print}
{belongs to Ledit}
				'A': 
					begin
						AddOn(LabLog);
					end;		{Add}
				'D': 
					begin
						DropOff(labLog);
					end;		{Drop}
				'S': 
					begin
						Sign(LabLog);
					end;		{Sign}
				'R': 
					begin
						WReList(LabLog);
					end;		{Reset}
			end;		{case Choice of }
		end;		{while not quit}
	writeln('Application closed.....');
end.		{LabBase}