program pointorExpl;

	type
		ptr = ^integer;

	var
		p, q, r: ptr;
		a, b, c: integer;

begin
	a := 1;
	b := 2;
	c := 3;
	new(p);
	new(q);
	new(r);
	q^ := a
end.