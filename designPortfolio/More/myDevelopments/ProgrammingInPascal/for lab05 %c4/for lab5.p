program lab5_taxculation (input, output);

{groval constant}
	const
		union_due = 6.00;

{groval variables}
	var
{input variables}
		h_wkd: real;
		n_dep: integer;
		will: char;
{general use variables}
		wages: real;
		soc_tax: real;
		fed_tax: real;
		sta_tax: real;
		health_ins: integer;
		net_pay: real;				{end of groval variables}

{procedures starts here}

{procedure for showing menu}
	procedure menu;
	begin
		writeln('this piece of junk will give you output of each taxes and your gross pay and net pay ');
		writeln('you supposed to be able to culculate this in your brain.');
		writeln('			if you are using thisprogram , shame on you ')
	end;    {end of procedure showing menu, menu}

{procedure for initializing all of numbers in variables}
	procedure initialize_all (var h_wkd, net_pay, wages, soc_tax, fed_tax, sta_tax: real; var health_ins, n_dep: integer);
	begin
{real values}
		h_wkd := 0;
		net_pay := 0;
		wages := 0;
		soc_tax := 0;
		fed_tax := 0;
		sta_tax := 0;
{integer values}
		health_ins := 0;
		n_dep := 0
	end;    {end of procedure for initializing all numbers in variables, initialize_all}

{procedure for making sure if user input for hours worked is valid}
	procedure valid_hr (var pn: char; h_wkd: real);
	begin
		if (h_wkd >= 0) then
			pn := 'p'
		else
			pn := 'n'
	end;    {end of procedure for making sure, valid_wkd}

{procedure for making sure if user input for number of dependents is valid}
	procedure valid_dep (var pn: char; n_dep: integer);
	begin
		if (n_dep >= 0) then
			pn := 'p'
		else
			pn := 'n'
	end;    {end of procedure for macing sure, valid_dep}

{procedure for getting input, hours worked and number of dependents}
	{this will get 2 user inputs and send to procedure valid_* to make sure if input is valid}
		{this procedure also returns value of 2 inputs to groval variable}
	procedure get_input (var h_wkd: real; var n_dep: integer);
		var
			pn: char;
			hour: integer;
			min: integer;
	begin
		pn := 'n';	{initializing pn}
		while (pn <> 'p') do   {while will keep getting inputs as long as input is not valid}
			begin
				writeln('input the hours you worked   only hours, exclude minutes');
				readln(hour);
				writeln('input minutes you worked');
				readln(min);
				h_wkd := hour + ((min * 5) / 300);
				valid_hr(pn, h_wkd);
				if (pn = 'p') then
					begin
						writeln('your input for hours worked is ', hour, 'hours and ', min, 'minutes which is');
						writeln(h_wkd : 0 : 2, '  hours in decimal expression')
					end
				else
					writeln('your input is not valid, try it again')
			end;
			{end reading hours worked, and make sure if valid}
		pn := 'n';	{initializing pn}
		while (pn <> 'p') do   {while will keep getting inputs as long as input is not valid}
			begin
				writeln('imput the number of your dependents excluding yourself');
				readln(n_dep);
				valid_dep(pn, n_dep);
				if (pn = 'p') then
					writeln('your input for the number of dependents is ', n_dep)
				else
					begin
						writeln('your inputis not valid, number of dependents has to be none=0 or larger=1,2,3.....');
						writeln('try it again ')
					end
			end
			{end reading number of dependents, and make sure if valid}
	end;    {end of procedure for getting input,get_input}


{function for rounding value to 2nd decimal position}
	function decimal_2 (num: real): real;
	begin
		decimal_2 := round(num * 100) / 100
	end;    {end of function for rounding a value, decimal_2}

{procedure for culculate over time rate of wages, otrate_wages}
	procedure otrate_wages (var wages: real; h_wkd: real);
		const
			it_rate = 9.73;
			ot_rate = 19.46;
		var
			over_wkd: real;

	begin
		over_wkd := h_wkd - 40;
		wages := (40 * it_rate) + (over_wkd * ot_rate)
	end;    {end of procedure for overtime wages culculation, otrate_wages}

{procedure for culculate in time rate of wages, itrate_wages}
	procedure itrate_wages (var wages: real; h_wkd: real);
		const
			it_rate = 9.73;
	begin
		wages := h_wkd * it_rate
	end;    {end of procedure for intime wages culculation, itrate_wages}

{procedure for culculation of wages from user input}
	procedure culc_wages (var wages: real; h_wkd: real);
	begin
		if (h_wkd > 40) then
			otrate_wages(wages, h_wkd)
		else
			itrate_wages(wages, h_wkd);
		wages := decimal_2(wages)		{decimal_2 is a function }
	end;    {end of procedure for culculating wages from hours worked, culc_wages}

{procedure for culculation of taxes from wages}
	{this will return values to groval variable}
	procedure culc_tax (var soc_tax, fed_tax, sta_tax: real; wages: real);
		const
			soc_tax_rate = 0.06;
			fed_tax_rate = 0.14;
			sta_tax_rate = 0.05;
	begin
		soc_tax := wages * soc_tax_rate;
		fed_tax := wages * fed_tax_rate;
		sta_tax := wages * sta_tax_rate
	end;    {end of procedure for culculating taxes from wages, culc_tax}

{procedure for culculating extra cost of health insulance}
	{culc_health will calculate extracost of health insurance from user input of number of dependents}
		{culc_health will return the cost of health insurance to groval}
	procedure culc_health (var health_ins: integer; n_dep: integer);
	begin
		if (n_dep <= 2) then
			health_ins := 0
		else
			health_ins := 10
	end;    {end of procedure for culculating extra cost of health insulance, culc_health}

{procedure for culculating net pay from wages and taxes and union due, health insurance}
	{culc_net will culculate net pay from wages and all of taxes}
		{culc_net will return value of net pay to groval}
	procedure culc_net (var net_pay: real; wages, soc_tax, fed_tax, sta_tax, union_due, health_ins: real);
	begin
		net_pay := wages - (soc_tax + fed_tax + sta_tax + union_due + health_ins)
	end;    {end of procedure for culculating net pay, culc_net}

{procedure for printing results in format}
	procedure print_it (h_wkd, net_pay, wages, soc_tax, fed_tax, sta_tax, union_due, health_ins: real);
	begin
		writeln('hours you worked: ', h_wkd : 5 : 1, '                       gross pay: ', wages : 7 : 2);
		writeln('deductions');
		writeln('                   soc. sec. tax: ', soc_tax : 6 : 2);
		writeln('                        fed. tax: ', fed_tax : 6 : 2);
		writeln('                      state. tax: ', sta_tax : 6 : 2);
		writeln('                       union due: ', union_due : 6 : 2);
		writeln('                      health ins: ', health_ins : 6 : 2);
		writeln('                                                       net pay: ', net_pay : 7 : 2)
	end;    {end of procedure for printing out results, print_it}

{procedure for getting the will of user if go on or quit}
	procedure cont (var will: char);
		var
			ans: char;

	begin
		ans := 'z';{just initializing, ha!}
		writeln('would you still like to go on?  Y or N');
		while not ((ans = 'y') or (ans = 'Y') or (ans = 'n') or (ans = 'N')) do
			begin
				readln(ans);
				if (ans = 'y') or (ans = 'Y') then
					will := 'c'
				else if (ans = 'n') or (ans = 'N') then
					will := 'q'
				else
					writeln('Huh? say it again?')
			end
	end;    {end of procedure for getting the will of user, cont}

{the main program}
begin
	menu;
	will := 'c';{just initializing to get into while bellow}
	while (will = 'c') do
		begin
				{initialize all of values in variables to 0}
			initialize_all(h_wkd, net_pay, wages, soc_tax, fed_tax, sta_tax, health_ins, n_dep);
				{get_input will get 2 user input, and return the values to groval after they are made sure if valid}
			get_input(h_wkd, n_dep);
				{culc_wages will simply calculate wages of both less or more than 40 hours worked}
			{culc_wages will  return the wages to groval variable, culc_wages}
			culc_wages(wages, h_wkd);
				{culc_tax will simply culculate each taxes with users wages, and return the tax rate to groval variable}
			culc_tax(soc_tax, fed_tax, sta_tax, wages);
				{culc_health will calculate extracost of health insurance from user input of number of dependents}
			{culc_health will return the cost of health insurance to groval}
			culc_health(health_ins, n_dep);
				{culc_net will culculate net pay from wages and all of taxes}
			{culc_net will return value of net pay to groval}
			culc_net(net_pay, wages, soc_tax, fed_tax, sta_tax, union_due, health_ins);
				{print_it will print the results in format with values of grovals}
			print_it(h_wkd, net_pay, wages, soc_tax, fed_tax, sta_tax, union_due, health_ins);
				{cont will ask user if s/he want to go on}
			{return a char c or q}
			cont(will)
		end;
		{end of while loop for cont and quit}
	writeln('quitting execution, return key let you go back to TP screen....');
	readln;
end.
	{end of main program}