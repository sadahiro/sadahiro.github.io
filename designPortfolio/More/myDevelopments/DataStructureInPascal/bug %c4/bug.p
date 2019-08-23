program Bug (Input, Output);
{  This program contains a common error in using a procedure.}
	var
		Angle: integer;
		Radians: real;

{This procedure gets an integer angle value from the user}

	procedure GetAngle (var InAn: integer);
	begin
		Write('Angle in degrees? ');
		Readln(InAn)
	end; { GetAngle }


begin { main program }

	GetAngle(Angle);
	Radians := Angle * (2 * pi) / 360;  {pi is a built-in constant}
	Writeln;
	Writeln('Angle = ', Angle : 1, ' is ', Radians : 1 : 2, ' radians');
	Writeln('press return to continue');
	Readln
end.