//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module altfp_matrix_add6_wrp (
	one, two, three, four, five, six, result,
	oner, twor, threer, fourr, fiver, sixr, resultr,
	onei, twoi, threei, fouri, fivei, sixi, resulti,
	enable, reset, startin, startout, sysclk
	);
	parameter	width_exp = 8;
	parameter	width_man = 23;
	input	[31:0]	one;
	input	[31:0]	two;
	input	[31:0]	three;
	input	[31:0]	four;
	input	[31:0]	five;
	input	[31:0]	six;
	output	[31:0]	result;
	input	[31:0]	oner;
	input	[31:0]	twor;
	input	[31:0]	threer;
	input	[31:0]	fourr;
	input	[31:0]	fiver;
	input	[31:0]	sixr;
	output	[31:0]	resultr;
	input	[31:0]	onei;
	input	[31:0]	twoi;
	input	[31:0]	threei;
	input	[31:0]	fouri;
	input	[31:0]	fivei;
	input	[31:0]	sixi;
	output	[31:0]	resulti;
	input	enable;
	input	reset;
	input	startin;
	output	startout;
	input	sysclk;

	altfp_matrix_add6_fpc1a add6wrp (
		.one(one),
		.two(two),
		.three(three),
		.four(four),
		.five(five),
		.six(six),
		.result(result),
		.enable(enable),
		.reset(reset),
		.startin(startin),
		.startout(startout),
		.sysclk(sysclk)
		);
	assign resultr = 32'b00000000000000000000000000000000;
	assign resulti = 32'b00000000000000000000000000000000;

endmodule

