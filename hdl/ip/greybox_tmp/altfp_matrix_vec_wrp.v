//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module altfp_matrix_vec_wrp (
	enable, reset, result, resultr, resulti, startin, startout, sysclk,
	vector_l_data, vector_m_data, vector_l_datar, vector_m_datar, vector_l_datai, vector_m_datai
	);
	parameter	vector_size = 256;
	parameter	width_exp = 8;
	parameter	width_man = 23;
	input	enable;
	input	reset;
	output	[31:0]	result;
	output	[31:0]	resultr;
	output	[31:0]	resulti;
	input	startin;
	output	startout;
	input	sysclk;
	input	[255:0]	vector_l_data;
	input	[255:0]	vector_m_data;
	input	[255:0]	vector_l_datar;
	input	[255:0]	vector_m_datar;
	input	[255:0]	vector_l_datai;
	input	[255:0]	vector_m_datai;

	altfp_matrix_vec_fpc2a vecwrp (
		.L000(vector_l_data[31:0]),
		.L001(vector_l_data[63:32]),
		.L002(vector_l_data[95:64]),
		.L003(vector_l_data[127:96]),
		.L004(vector_l_data[159:128]),
		.L005(vector_l_data[191:160]),
		.L006(vector_l_data[223:192]),
		.L007(vector_l_data[255:224]),
		.M000(vector_m_data[31:0]),
		.M001(vector_m_data[63:32]),
		.M002(vector_m_data[95:64]),
		.M003(vector_m_data[127:96]),
		.M004(vector_m_data[159:128]),
		.M005(vector_m_data[191:160]),
		.M006(vector_m_data[223:192]),
		.M007(vector_m_data[255:224]),
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

