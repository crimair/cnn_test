//**********************************************
//***                                        ***
//*** Generated by Floating Point Compiler   ***
//***                                        ***
//*** Copyright Altera Corporation 2010      ***
//***                                        ***
//***                                        ***
//*** Version 10R2 - December 1, 2010        ***
//***                                        ***
//***                                        ***
//**********************************************

`timescale 1 ps / 1 ps

module altfp_matrix_vec_fpc2a (
      sysclk,
      reset,
      enable,
      startin,
      L000,
      L001,
      L002,
      L003,
      L004,
      L005,
      L006,
      L007,
      M000,
      M001,
      M002,
      M003,
      M004,
      M005,
      M006,
      M007,
      startout,
      result
);

input sysclk;
input reset;
input enable;
input startin;
input [32 : 1] L000;
input [32 : 1] L001;
input [32 : 1] L002;
input [32 : 1] L003;
input [32 : 1] L004;
input [32 : 1] L005;
input [32 : 1] L006;
input [32 : 1] L007;
input [32 : 1] M000;
input [32 : 1] M001;
input [32 : 1] M002;
input [32 : 1] M003;
input [32 : 1] M004;
input [32 : 1] M005;
input [32 : 1] M006;
input [32 : 1] M007;

output startout;
output [32 : 1] result;
wire [32 : 1] synth0000;
wire [32 : 1] synth0001;
wire [32 : 1] synth0002;
wire [32 : 1] synth0003;
wire [32 : 1] synth0004;
wire [32 : 1] synth0005;
wire [32 : 1] synth0006;
wire [32 : 1] synth0007;
wire [32 : 1] synth0008;
wire [32 : 1] synth0009;
wire [32 : 1] synth0010;
wire [32 : 1] synth0011;
wire [32 : 1] synth0012;
wire [32 : 1] synth0013;
wire [32 : 1] synth0014;
wire [32 : 1] synth0015;
wire [32 : 1] synth0016;
wire [49 : 1] synth0017;
wire [49 : 1] synth0018;
wire [49 : 1] synth0019;
wire [49 : 1] synth0020;
wire [49 : 1] synth0021;
wire [49 : 1] synth0022;
wire [49 : 1] synth0023;
wire [49 : 1] synth0024;
wire [49 : 1] synth0025;
wire [49 : 1] synth0026;
wire [49 : 1] synth0027;
wire [49 : 1] synth0028;
wire [49 : 1] synth0029;
wire [49 : 1] synth0030;
wire [49 : 1] synth0031;
wire [32 : 1] synth0032;

reg [25 : 1] startff;

integer k;
  always @ (posedge sysclk or posedge reset)
  begin
    if (reset == 1'b1) begin
        startff <= 25'b0;
    end else begin
      if (enable == 1'b1) begin
        startff[1] <= startin;
        for (k=2; k <= 25; k = k + 1) begin
          startff[k] <= startff[k-1];
        end
      end
    end
  end

  assign synth0000 = L000;
  assign synth0001 = L001;
  assign synth0002 = L002;
  assign synth0003 = L003;
  assign synth0004 = L004;
  assign synth0005 = L005;
  assign synth0006 = L006;
  assign synth0007 = L007;
  assign synth0008 = M000;
  assign synth0009 = M001;
  assign synth0010 = M002;
  assign synth0011 = M003;
  assign synth0012 = M004;
  assign synth0013 = M005;
  assign synth0014 = M006;
  assign synth0015 = M007;

  assign result = synth0032;

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp0 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0007[32 : 1]),
            .bb(synth0015[32 : 1]),
            .cc(synth0017[46 : 1]),
            .ccsat(synth0017[47]),.cczip(synth0017[48]),.ccnan(synth0017[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp1 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0006[32 : 1]),
            .bb(synth0014[32 : 1]),
            .cc(synth0018[46 : 1]),
            .ccsat(synth0018[47]),.cczip(synth0018[48]),.ccnan(synth0018[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp2 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0005[32 : 1]),
            .bb(synth0013[32 : 1]),
            .cc(synth0019[46 : 1]),
            .ccsat(synth0019[47]),.cczip(synth0019[48]),.ccnan(synth0019[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp3 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0004[32 : 1]),
            .bb(synth0012[32 : 1]),
            .cc(synth0020[46 : 1]),
            .ccsat(synth0020[47]),.cczip(synth0020[48]),.ccnan(synth0020[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp4 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0003[32 : 1]),
            .bb(synth0011[32 : 1]),
            .cc(synth0021[46 : 1]),
            .ccsat(synth0021[47]),.cczip(synth0021[48]),.ccnan(synth0021[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp5 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0002[32 : 1]),
            .bb(synth0010[32 : 1]),
            .cc(synth0022[46 : 1]),
            .ccsat(synth0022[47]),.cczip(synth0022[48]),.ccnan(synth0022[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp6 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0001[32 : 1]),
            .bb(synth0009[32 : 1]),
            .cc(synth0023[46 : 1]),
            .ccsat(synth0023[47]),.cczip(synth0023[48]),.ccnan(synth0023[49]));

  hcc_mulfp1_dot # (.mantissa(36),.device(2),.optimization(2),.synthesize(1))
  cmp7 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0000[32 : 1]),
            .bb(synth0008[32 : 1]),
            .cc(synth0024[46 : 1]),
            .ccsat(synth0024[47]),.cczip(synth0024[48]),.ccnan(synth0024[49]));

  hcc_alufp1_dot # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp8  (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0018[46 : 1]),
            .aasat(synth0018[47]),.aazip(synth0018[48]),.aanan(synth0018[49]),
            .bb(synth0017[46 : 1]),
            .bbsat(synth0017[47]),.bbzip(synth0017[48]),.bbnan(synth0017[49]),
            .cc(synth0025[46 : 1]),
            .ccsat(synth0025[47]),.cczip(synth0025[48]),.ccnan(synth0025[49]));

  hcc_alufp1_dot # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp9  (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0020[46 : 1]),
            .aasat(synth0020[47]),.aazip(synth0020[48]),.aanan(synth0020[49]),
            .bb(synth0019[46 : 1]),
            .bbsat(synth0019[47]),.bbzip(synth0019[48]),.bbnan(synth0019[49]),
            .cc(synth0026[46 : 1]),
            .ccsat(synth0026[47]),.cczip(synth0026[48]),.ccnan(synth0026[49]));

  hcc_alufp1_dot # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp10  (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0022[46 : 1]),
            .aasat(synth0022[47]),.aazip(synth0022[48]),.aanan(synth0022[49]),
            .bb(synth0021[46 : 1]),
            .bbsat(synth0021[47]),.bbzip(synth0021[48]),.bbnan(synth0021[49]),
            .cc(synth0027[46 : 1]),
            .ccsat(synth0027[47]),.cczip(synth0027[48]),.ccnan(synth0027[49]));

  hcc_alufp1_dot # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp11  (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0024[46 : 1]),
            .aasat(synth0024[47]),.aazip(synth0024[48]),.aanan(synth0024[49]),
            .bb(synth0023[46 : 1]),
            .bbsat(synth0023[47]),.bbzip(synth0023[48]),.bbnan(synth0023[49]),
            .cc(synth0028[46 : 1]),
            .ccsat(synth0028[47]),.cczip(synth0028[48]),.ccnan(synth0028[49]));

  hcc_alufp1x # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp12 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0026[46 : 1]),
            .aasat(synth0026[47]),.aazip(synth0026[48]),.aanan(synth0026[49]),
            .bb(synth0025[46 : 1]),
            .bbsat(synth0025[47]),.bbzip(synth0025[48]),.bbnan(synth0025[49]),
            .cc(synth0029[46 : 1]),
            .ccsat(synth0029[47]),.cczip(synth0029[48]),.ccnan(synth0029[49]));

  hcc_alufp1x # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp13 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0028[46 : 1]),
            .aasat(synth0028[47]),.aazip(synth0028[48]),.aanan(synth0028[49]),
            .bb(synth0027[46 : 1]),
            .bbsat(synth0027[47]),.bbzip(synth0027[48]),.bbnan(synth0027[49]),
            .cc(synth0030[46 : 1]),
            .ccsat(synth0030[47]),.cczip(synth0030[48]),.ccnan(synth0030[49]));

  hcc_alufp1x # (.mantissa(36),.shiftspeed(1),.outputpipe(1))
  cmp14 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .addsub(1'b 0),
            .aa(synth0030[46 : 1]),
            .aasat(synth0030[47]),.aazip(synth0030[48]),.aanan(synth0030[49]),
            .bb(synth0029[46 : 1]),
            .bbsat(synth0029[47]),.bbzip(synth0029[48]),.bbnan(synth0029[49]),
            .cc(synth0031[46 : 1]),
            .ccsat(synth0031[47]),.cczip(synth0031[48]),.ccnan(synth0031[49]));

  hcc_castxtof # (.mantissa(36),.normspeed(2))
  cmp15 (.sysclk(sysclk),.reset(reset),.enable(enable),
            .aa(synth0031[46 : 1]),
            .aasat(synth0031[47]),.aazip(synth0031[48]),.aanan(synth0031[49]),
            .cc(synth0032[32 : 1]));

  assign startout = startff[25];

endmodule

