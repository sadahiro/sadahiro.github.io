program lab7_2_CRAPS;

	var
		yn_rule: char;
		again: char;

{*********  MAIN PART FOR GAMES  **********}

{function for random}
	function dice_shake: integer;
		var
			die_1: integer;
			die_2: integer;
	begin
		die_1 := random;
		die_1 := abs(die_1 mod 6) + 1;
		die_2 := random;
		die_2 := abs(die_2 mod 6) + 1;
		dice_shake := (die_1 + die_2)
	end;

{counter procedures}
	procedure win_counter (var win: integer);
	begin
		writeln('you got one win');
		win := win + 1
	end;

	procedure loss_counter (var loss: integer);
	begin
		writeln('you got one loss');
		loss := loss + 1
	end;


{procedure part for actual game}
	procedure real_game (var win, loss: integer; times: integer);
		var
			i: integer;
			eye_got: integer;
			more_result: char;

{procedure part for more shuffle in case of tie game IN PROCEDURE REAL_GAME}
		procedure more_battle (var more_result: char; eye_got: integer);
			var
				new_eye: integer;
		begin
			more_result := 'n';
			repeat
				new_eye := dice_shake;
				if (new_eye = eye_got) then
					begin
						more_result := 'w';
						writeln('dice ', new_eye : 2, ' : win game', ' : the same as your first eye:', eye_got : 0)
					end
				else if (new_eye = 7) then
					begin
						more_result := 'l';
						writeln('dice ', new_eye : 2, ' : loss game  : by the rule ')
					end
				else
					writeln('dice ', new_eye : 2, ' : tie game  : not 7, not first eye:', eye_got : 0)
			until more_result in ['w', 'l']
		end;

{start procedure real_game}
	begin
		for i := 1 to times do
			begin
				writeln;
				writeln('Game : ', i : 0);
				eye_got := dice_shake;
				case eye_got of     {case statement for first shuffle}
					7, 11: 
						begin
							writeln('dice ', eye_got : 2, ' : win game :  in [7,11]');
							win_counter(win)
						end;
					2, 3, 12: 
						begin
							writeln('dice ', eye_got : 2, ' : loss game :  in [2,3,12]');
							loss_counter(loss)
						end;
					otherwise
						begin
							writeln('dice ', eye_got : 2, ' : tie game');
							more_battle(more_result, eye_got);
							case more_result of       {case statement for 2nd and later shuffle}
								'w': 
									win_counter(win);
								'l': 
									loss_counter(loss)
							end
						end
				end
			end
	end;



{*********  main control of game  **********}
	procedure game;
		var
			dateTime: longint;
			times: integer;
			win: integer;
			loss: integer;

{getting user input IN PROCEDURE GAME}
		procedure get_input (var times: integer);
		begin
			writeln('how many times wanna play?');
			readln(times)
		end;

{print outs results IN PROCEDURE GAME}
		procedure result (win, loss: integer);
		begin
			writeln;
			writeln('you have ', win : 0, 'win and ', loss : 0, ' loss');
			if (win = loss) then
				writeln('tied')
			else if (win > loss) then
				writeln('you won')
			else
				writeln('you lost')
		end;

{MAIN part of PROCEDURE GAME}
	begin
		GetDateTime(dateTime);
		randSeed := dateTime;
		win := 0;
		loss := 0;
		get_input(times);
		real_game(win, loss, times);
		result(win, loss)
	end;

{*********  main program  **********}
{procedure for showing rules of game}
	procedure rule;
	begin
		writeln('In this game, you will throw 2 dice');
		writeln('If the total of 2 dice is 2,3 or 12, you have lost the game');
		writeln('If the total of 2 dice is 7 or 11, you have won the game');
		writeln('If the total of 2 dice is the other number, you will keep throwing dice');
		writeln('In this case,');
		writeln('You will win if you get the your original dice number');
		writeln('You will lose if you get 7');
		writeln
	end;

{beginning of main program}
begin
	repeat
		writeln('wanna see rule?, y or n');
		readln(yn_rule);
		if yn_rule in ['Y', 'y'] then
			rule;
		game;
		writeln('wanna keep goin?');
		readln(again);
	until again in ['n', 'N']
end.