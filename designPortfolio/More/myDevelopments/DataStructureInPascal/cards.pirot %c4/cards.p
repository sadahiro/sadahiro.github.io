{Programmer:	Makoto Sadahiro }

{date: sep 27th '93}

{Purpose:		program cards is test driving program to test procedures in "unit ucards"}
{which is initDeck, shuffleDeck, printDeck}

{Input :	  none }

{Outputs :	     "myDeck"-cards which is just after initialized and after they are shuffled}

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

begin
	showtext;
	writeln('procedrue initDeck start');
	initDeck(myDeck);														{initialize myDeck}
	writeln;
	writeln('procedrue initDeck done');
	writeln('*******************************');
	writeln;
	writeln('procedrue printDeck start: print out should be in order');
	printDeck(myDeck);													{print out initialized myDeck}
	writeln;
	writeln('procedrue printDeck done: print out should be in order');
	writeln('*******************************');
	writeln;
	writeln('procedrue shuffleDeck start');
	shuffleDeck(myDeck);													{shuffle myDeck}
	writeln;
	writeln('procedrue shuffleDeck done');
	writeln('*******************************');
	writeln;
	writeln('procedrue printDeck start: print out should be in random order');
	printDeck(myDeck);													{print out shuffled myDeck}
	writeln;
	writeln('procedrue printDeck done: print out should be in random order');
	writeln('*******************************');
	writeln('done')
end.