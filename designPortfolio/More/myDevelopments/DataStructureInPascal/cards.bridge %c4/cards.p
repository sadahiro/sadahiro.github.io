{Programmer:	Makoto Sadahiro }

{date: oct 6th '93}

{Purpose:		program cards is simple bridge game which uses "unit ucards"}
{which is initDeck, shuffleDeck, printDeck}

{Input :	  choice: integer; }

{Outputs :	     myDeck: deck; mySeats: seats; point: integer; myPlayer: derection;}

{comment:	all carige return is done right before something is printed out on screen}
{this will work better because i might have chance to use procedure which doesnt }
{take care carige return after line was printed out.}
{so, carige return will be taken care by each procedure before something is printed out}
{unless it is very obvious }

program cards;
	uses
{ucards: utility unit, the series of procedures which is used for cards games}
		ucards;

	var
{myDeck is array of record which contains cards information}
{which is defined in unit ucards}
		myDeck: deck;
		mySeats: seats;
		choice: integer;
		cardPosition: boolean;		{true: cards in deck, false: cards in seats}
begin
	showtext;
	cardPosition := true;			{true: cards in deck, false: cards in seats}
	repeat
		writeln;
		writeln('type in the number of your choice');		{choice of operations}
		writeln('1: start-using new set of cards');
		writeln('2: shuffle cards');
		writeln('3: deal cards');
		writeln('4: display cards');
		writeln('5: quitting game');
		readln(choice);
		if (choice in [1..5]) then
			case choice of
				1: 
					begin
						initDeck(myDeck);														{initialize myDeck}
						cardPosition := true
					end;
				2: 
					shuffleDeck(myDeck);													{shuffle myDeck}
				3: 
					begin
						doDeal(myDeck, mySeats);											{deal the cards from myDeck to mySeats}
						cardPosition := false
					end;
				4: 
					if cardPosition then
						printDeck(myDeck)													{print out initialized myDeck}
					else
						printHands(mySeats);												{print out mySeats}
				5: 
					writeln('quitting game...')
			end				{end of case statement}
		else
			writeln('input is invalid....type in again')
	until choice = 5
end.		{end of program cards}