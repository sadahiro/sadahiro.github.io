program oaktree;
{Programmer:	Makoto Sadahiro }
{starting date: Dec 11th '93}
{last modified date:  Dec 11th '93}
{Purpose:		maintaining binary search tree contains name, major, living status}
{Input :	  SourceText: text }
{Outputs :	        roomsCount: integer;  totalCustomer: integer;  }
				{totalPassenger: integer;  peopleWaiting: integer;  aveWait: integer;  }
{comment:	none}
	uses
		IFaceUtil, Message, bsttype, bstadt, FileCom, EditCom, SearchCom;
	var
		Tree: TreeType;
		UserChoice: char;
		Quit: boolean;

begin
	CreateTree(Tree);
	OpenTextWindow(20, 80, 620, 240);
	StartUpMessage;
	Quit := false;
	while not Quit do
		begin
			write('Oak Tree>');
			readln(UserChoice);
			case UserChoice of
				'?': 
					begin
						ComList;
					end;		{?}
				'L': 
					begin
						LoadTree(Tree);
					end;		{L}
				'S': 
					begin
						SaveTree(Tree);
					end;		{S}
				'Q': 
					begin
						Quit := true;
						ShutDown(Tree);
					end;		{Q}
				'A': 
					begin
						AddToTree(Tree);
					end;		{A}
				'D': 
					begin
						DeleteFromTree(Tree);
					end;		{D}
				'F': 
					begin
						FindFromTree(Tree);
					end;		{F}
				'P': 
					begin
						if tree <> nil then
							PrintOutTree(Tree)
						else
							writeln('data does not exist');
					end;		{P}
			end;		{case UserChoice of}
		end;		{while not Quit do}
end.		{OakTree}