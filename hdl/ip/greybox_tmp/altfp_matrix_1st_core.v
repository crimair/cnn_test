//altfpc_lib_matrix_mult

//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   ALTFP_MATRIX_1ST_CORE                     ***
//***                                             ***
//***   Function: Dummy module to be called to    ***
//***             include inside compilation list ***
//***                                             ***
//***   24/04/12 CKL                              ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module altfp_matrix_1st_core (
	aclr_in,
	ena_in,
	aclr_out,
	ena_out
);
	
input aclr_in;
input ena_in;
output aclr_out;
output ena_out;
wire aclr_passthru_wire;
wire ena_passthru_wire;

	assign aclr_passthru_wire = aclr_in;
	assign ena_passthru_wire = ena_in;
	assign aclr_out = aclr_passthru_wire;
	assign ena_out = ena_passthru_wire;

endmodule

//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CASTYTOD.V                            ***
//***                                             ***
//***   Function: Cast Internal Double to IEEE754 ***
//***             Double                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_castytod(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
cc
);

parameter [31:0] roundconvert=0;
parameter [31:0] normspeed=3;
parameter [31:0] doublespeed=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [77:1] aa;
input aasat, aazip, aanan;
output [64:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [77:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [64:1] cc;


parameter signdepth = 3 + ((roundconvert * doublespeed)) + normspeed + roundconvert * ((1 + doublespeed));
parameter exptopffdepth = 2 + ((roundconvert * doublespeed));
parameter expbotffdepth = normspeed;
parameter satffdepth = 3 + ((roundconvert * doublespeed)) + normspeed;  //type absfftype IS ARRAY (3 DOWNTO 1) OF STD_LOGIC_VECTOR (64 DOWNTO 1);
//type exptopfftype IS ARRAY (exptopffdepth DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
//type expbotdelfftype IS ARRAY (expbotffdepth DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
wire [64:1] zerovec;
reg [77:1] aaff;
wire [64:1] absinvnode; wire [64:1] absnode; reg [64:1] absff; wire [64:1] absolute;
wire [6:1] countnorm;
wire [64:1] fracout; reg [64:1] fracoutff;
reg [13:1] exptopff [exptopffdepth:1] ;
reg [13:1] expbotff;
reg [13:1] expbotdelff [expbotffdepth:1] ;
wire [13:1] exponent;
reg [satffdepth:1] satff; reg [satffdepth:1] zipff; reg [satffdepth:1] nanff;
reg [signdepth:1] signff;
wire [64:1] zeronumber;
reg [1+normspeed:1] zeronumberff;
wire [53:1] roundoverflow;
reg roundoverflowff;
wire [13:1] expnode;
wire zeroexpnode; wire maxexpnode;
wire zeromantissanode; wire maxmantissanode; wire zeroexponentnode; wire maxexponentnode;  // common to all output flows
reg [52:1] mantissaoutff;
reg [11:1] exponentoutff;  // common to all rounded output flows
reg [52:1] mantissaroundff;
reg [11:1] exponentoneff;
reg zeromantissaff; reg maxmantissaff; reg zeroexponentff; reg maxexponentff;  // only for doublespeed rounded output
wire [54:1] mantissaroundnode;
wire roundbit;
reg [11:1] exponenttwoff;
reg zeromantissadelff; reg maxmantissadelff; reg zeroexponentdelff; reg maxexponentdelff;  // debug

  integer k;
  genvar j;
  assign zerovec = 64'b 0;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaff <= 77'b 0;
      fracoutff <= 64'b 0;
      for (k=1; k <= exptopffdepth; k = k + 1) begin
        //FOR j IN 1 TO 13 LOOP
        exptopff[k] <= 13'b 0;
        //END LOOP;
      end
      for (k=1; k <= satffdepth; k = k + 1) begin
        satff[k] <= 1'b 0;
        zipff[k] <= 1'b 0;
        nanff[k] <= 1'b 0;
      end
      for (k=1; k <= signdepth; k = k + 1) begin
        signff[k] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        aaff <= aa;
        fracoutff <= fracout;
        exptopff[1] <= aaff[13:1] + 13'b 0000000000100;
        for (k=2; k <= exptopffdepth; k = k + 1) begin
          exptopff[k] <= exptopff[(k - 1)];
        end
        satff[1] <= aasat;
        for (k=2; k <= satffdepth; k = k + 1) begin
          satff[k] <= satff[k - 1];
        end
        zipff[1] <= aazip;
        for (k=2; k <= satffdepth; k = k + 1) begin
          zipff[k] <= zipff[k - 1];
        end
        nanff[1] <= aanan;
        for (k=2; k <= satffdepth; k = k + 1) begin
          nanff[k] <= nanff[k - 1];
        end
        signff[1] <= aaff[77];
        for (k=2; k <= signdepth; k = k + 1) begin
          signff[k] <= signff[k - 1];
        end
      end
    end
  end
	
  generate for (j=1; j <= 64; j = j + 1) begin : gna
      assign absinvnode[j] = aaff[j + 13] ^ aaff[77];
  end
  endgenerate
  //*** APPLY ROUNDING TO ABS VALUE (IF REQUIRED) ***
  generate if (((roundconvert == 0) || (roundconvert == 1 && doublespeed == 0))) begin
    if ((roundconvert == 0)) begin
          assign absnode = absinvnode;
    end

    if ((roundconvert == 1)) begin
          assign absnode = absinvnode + ({zerovec[63:1],aaff[77]});
    end

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        absff <= 64'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          absff <= absnode;
        end
      end
    end

    assign absolute = absff;
  end
  endgenerate
  generate if ((roundconvert == 1 && doublespeed == 1)) begin
      if ((synthesize == 0)) begin
          hcc_addpipeb #(
              .width(64),
        .pipes(2))
      absone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(absinvnode),
        .bb(zerovec),
        .carryin(aaff[77]),
        .cc(absolute));

    end

    if ((synthesize == 1)) begin
          hcc_addpipes #(
              .width(64),
        .pipes(2))
      abstwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(absinvnode),
        .bb(zerovec),
        .carryin(aaff[77]),
        .cc(absolute));

    end

  end
  endgenerate

  assign zeronumber[1] = absolute[1];
  generate for (j=2; j <= 64; j = j + 1) begin : gzma
      assign zeronumber[j] = zeronumber[j - 1] | absolute[j];
    end
  endgenerate

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= normspeed+1; k = k + 1) begin
          zeronumberff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          zeronumberff[1] <= ~((zeronumber[64]));
        	 for (k=2; k <= normspeed+1; k = k + 1) begin
             zeronumberff[k] <= zeronumberff[k - 1];
          end
        end
      end
    end

  //******************************************************************
  //*** NORMALIZE HERE - 1-3 pipes (countnorm output after 1 pipe) ***
  //******************************************************************
  hcc_normus64 #(
      .pipes(normspeed))
  normcore(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .fracin(absolute),
    .countout(countnorm),
    .fracout(fracout));

  //****************************
  //*** exponent bottom half ***
  //****************************
  generate if ((expbotffdepth == 1)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 13; k = k + 1) begin
          expbotff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          expbotff[13:1] <= exptopff[(exptopffdepth)] - ({7'b 0000000,countnorm});
        end
      end
    end

    assign exponent = expbotff;
  end
  endgenerate
  generate if ((expbotffdepth > 1)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= expbotffdepth; k = k + 1) begin
          //FOR j IN 1 TO 13 LOOP
          expbotdelff[k] <= 13'b 0;
          //END LOOP;
        end
      end else begin
        if((enable == 1'b 1)) begin
          expbotdelff[1] <= exptopff[(exptopffdepth)] - ({7'b 0000000,countnorm});
          for (k=2; k <= expbotffdepth; k = k + 1) begin
            expbotdelff[k] <= expbotdelff[(k - 1)];
          end
        end
      end
    end

    assign exponent = expbotdelff[(expbotffdepth)];
  end
  endgenerate
  //**************************************
  //*** CALCULATE OVERFLOW & UNDERFLOW ***
  //**************************************
  generate if ((roundconvert == 1)) begin
      assign roundoverflow[1] = fracout[10];
    for (j=2; j <= 53; j = j + 1) begin : grob
          assign roundoverflow[j] = roundoverflow[j - 1] & fracout[j + 9];
    end

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        roundoverflowff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          roundoverflowff <= roundoverflow[53];
        end
      end
    end

  end
  endgenerate
  // fracff, expnode, roundoverflowff (if used) aligned here, depth of satffdepth
  assign zeroexpnode =  ~((expnode[11] | expnode[10] | expnode[9] | expnode[8] | expnode[7] | expnode[6] | expnode[5] | expnode[4] | expnode[3] | expnode[2] | expnode[1]));
  assign maxexpnode = expnode[11] & expnode[10] & expnode[9] & expnode[8] & expnode[7] & expnode[6] & expnode[5] & expnode[4] & expnode[3] & expnode[2] & expnode[1];
  // '1' when true
  generate if ((roundconvert == 0)) begin
      assign zeromantissanode = expnode[12] | expnode[13] | zeroexpnode | maxexpnode | zipff[satffdepth] | satff[satffdepth];
  end
  endgenerate
  generate if ((roundconvert == 1)) begin
      assign zeromantissanode = roundoverflowff | expnode[12] | expnode[13] | zeroexpnode | maxexpnode | zipff[satffdepth] | satff[satffdepth] | zeronumberff[1+normspeed];
  end
  endgenerate
  assign maxmantissanode = nanff[satffdepth];
  assign zeroexponentnode = zeroexpnode | expnode[13] | zipff[satffdepth] | zeronumberff[1+normspeed];
  assign maxexponentnode = (maxexpnode & ~((expnode[12])) &  ~((expnode[13]))) | ((expnode[12]) &  ~((expnode[13]))) | satff[satffdepth] | nanff[satffdepth];
  //**********************
  //*** OUTPUT SECTION ***
  //**********************
  generate if ((roundconvert == 0)) begin
      assign expnode = exponent;
      assign roundbit = 1'b 0;
    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 52; k = k + 1) begin
          mantissaoutff[k] <= 1'b 0;
        end
        for (k=1; k <= 11; k = k + 1) begin
          exponentoutff[k] <= 1'b 0;
        end
      end else begin
        for (k=1; k <= 52; k = k + 1) begin
          mantissaoutff[k] <= fracoutff[k + 10] &  ~((zeromantissanode));
        end
        for (k=1; k <= 11; k = k + 1) begin
          exponentoutff[k] <= ((expnode[k] | maxexponentnode)) &  ~((zeroexponentnode));
        end
      end
    end

  end
  endgenerate
  generate if ((roundconvert == 1 && doublespeed == 0)) begin
      assign expnode = exponent + ({zerovec[12:1],roundoverflowff});
      assign roundbit = (fracoutff[11] & fracoutff[10]) | (~((fracoutff[11])) & fracoutff[10]) & (fracoutff[9] | fracoutff[8] | fracoutff[7]);
    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 52; k = k + 1) begin
          mantissaroundff[k] <= 1'b 0;
          mantissaoutff[k] <= 1'b 0;
        end
        for (k=1; k <= 11; k = k + 1) begin
          exponentoneff[k] <= 1'b 0;
          exponentoutff[k] <= 1'b 0;
        end
        zeromantissaff <= 1'b 0;
        maxmantissaff <= 1'b 0;
        zeroexponentff <= 1'b 0;
        maxexponentff <= 1'b 0;
      end else begin
        mantissaroundff <= fracoutff[62:11] + ({zerovec[51:1],roundbit});
        for (k=1; k <= 52; k = k + 1) begin
          mantissaoutff[k] <= (mantissaroundff[k] | maxmantissaff) &  ~((zeromantissaff));
        end
        exponentoneff <= expnode[11:1];
        for (k=1; k <= 11; k = k + 1) begin
          exponentoutff[k] <= ((exponentoneff[k] | maxexponentff)) &  ~((zeroexponentff));
        end
        // '1' when true
        zeromantissaff <= zeromantissanode;
        maxmantissaff <= maxmantissanode;
        zeroexponentff <= zeroexponentnode;
        maxexponentff <= maxexponentnode;
      end
    end

  end
  endgenerate
  generate if ((roundconvert == 1 && doublespeed == 1)) begin
      assign expnode = exponent + ({zerovec[12:1],roundoverflowff});
      assign roundbit = (fracoutff[11] & fracoutff[10]) | (~((fracoutff[11])) & fracoutff[10]) & (fracoutff[9] | fracoutff[8] | fracoutff[7]);
    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 52; k = k + 1) begin
          mantissaoutff[k] <= 1'b 0;
        end
        for (k=1; k <= 11; k = k + 1) begin
          exponentoneff[k] <= 1'b 0;
          exponenttwoff[k] <= 1'b 0;
          exponentoutff[k] <= 1'b 0;
        end
        zeromantissaff <= 1'b 0;
        maxmantissaff <= 1'b 0;
        zeroexponentff <= 1'b 0;
        maxexponentff <= 1'b 0;
        zeromantissadelff <= 1'b 0;
        maxmantissadelff <= 1'b 0;
        zeroexponentdelff <= 1'b 0;
        maxexponentdelff <= 1'b 0;
      end else begin
        for (k=1; k <= 52; k = k + 1) begin
          mantissaoutff[k] <= (mantissaroundnode[k] &  ~((zeromantissadelff))) | maxmantissadelff;
        end
        exponentoneff <= expnode[11:1];
        exponenttwoff <= exponentoneff;
        for (k=1; k <= 11; k = k + 1) begin
          exponentoutff[k] <= (exponenttwoff[k] &  ~((zeroexponentdelff))) | maxexponentdelff;
        end
        // '1' when true
        zeromantissaff <= zeromantissanode;
        maxmantissaff <= maxmantissanode;
        zeroexponentff <= zeroexponentnode;
        maxexponentff <= maxexponentnode;
        zeromantissadelff <= zeromantissaff;
        maxmantissadelff <= maxmantissaff;
        zeroexponentdelff <= zeroexponentff;
        maxexponentdelff <= maxexponentff;
      end
    end

    if ((synthesize == 0)) begin
          hcc_addpipeb #(
              .width(54),
        .pipes(2))
      roone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(fracoutff[64:11]),
        .bb(zerovec[54:1]),
        .carryin(roundbit),
        .cc(mantissaroundnode));

    end

    if ((synthesize == 1)) begin
          hcc_addpipes #(
              .width(54),
        .pipes(2))
      rotwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(fracoutff[64:11]),
        .bb(zerovec[54:1]),
        .carryin(roundbit),
        .cc(mantissaroundnode));

    end

  end
  endgenerate
  //*** OUTPUTS ***
  assign cc[64] = signff[signdepth];
  assign cc[63:53] = exponentoutff;
  assign cc[52:1] = mantissaoutff;
    //*** DEBUG ***
  //aaexp <= aa(13 DOWNTO 1);
  //aaman <= aa(77 DOWNTO 14);
  //ccsgn <= signff(signdepth);
  //ccexp <= exponentoutff;
  //ccman <= mantissaoutff;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CASTDTOY.V                            ***
//***                                             ***
//***   Function: Cast IEEE754 Double to Internal ***
//***             Double                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
// double <=> internal double
`timescale 1 ps / 1 ps

module hcc_castdtoy(
sysclk,
reset,
enable,
aa,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] target=0;
parameter [31:0] roundconvert=0;
parameter [31:0] outputpipe=0;
parameter [31:0] doublespeed=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [64:1] aa;
output [67 + 10 * target:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [64:1] aa;
wire [67 + 10 * target:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


//type exponentfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
wire [53 + 11 * target:1] zerovec;
reg [64:1] aaff;
wire expmaxnode; wire zipnode; wire mannonzeronode;
wire satnode; wire nannode;
reg satff; reg zipff; reg nanff;
wire [13:1] expnode;
wire [54 + 10 * target:1] fracnode;
reg [67 + 10 * target:1] ccff;
wire [64:1] mantissanode;
reg [13:1] exponentff_1;
reg [13:1] exponentff_2;
reg [2:1] satdelff; reg [2:1] zipdelff; reg [2:1] nandelff;

  // ieee754: sign (64), 8 exponent (63:53), 52 mantissa (52:1)
  // x format: (signx5,!sign,mantissa XOR sign, sign(xx.xx)), exponent(13:1)
  // multiplier, divider : (SIGN)('1')(52:1), exponent(13:1)
  // (multiplier & divider use unsigned numbers, sign packed with input)

	 genvar j;
  generate if ((roundconvert == 1)) begin : gza
    for (j=1; j <= 53 + 11 * target; j = j + 1) begin : gzb
          assign zerovec[j] = 1'b 0;
    end
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaff <= 64'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        aaff <= aa;
      end
    end
  end

  // if exponent = 1023 => saturate, if 0 => 0
  assign expmaxnode = aaff[63] & aaff[62] & aaff[61] & aaff[60] & aaff[59] & aaff[58] & aaff[57] & aaff[56] & aaff[55] & aaff[54] & aaff[53];
  assign zipnode =  ~((aaff[63] | aaff[62] | aaff[61] | aaff[60] | aaff[59] | aaff[58] | aaff[57] | aaff[56] | aaff[55] | aaff[54] | aaff[53]));
  assign mannonzeronode =  (aaff[52] | aaff[51] | aaff[50] | aaff[49] | aaff[48] | aaff[47] | aaff[46] | aaff[45] | aaff[44] | aaff[43] | aaff[42] | aaff[41] |
  					   		aaff[40] | aaff[39] | aaff[38] | aaff[37] | aaff[36] | aaff[35] | aaff[34] | aaff[33] | aaff[32] | aaff[31] | aaff[30] | aaff[29] |
  					   		aaff[28] | aaff[27] | aaff[26] | aaff[25] | aaff[24] | aaff[23] | aaff[22] | aaff[21] | aaff[20] | aaff[19] | aaff[18] | aaff[17] |
  					   		aaff[16] | aaff[15] | aaff[14] | aaff[13] | aaff[12] | aaff[11] | aaff[10] | aaff[9] | aaff[8] | aaff[7] | aaff[6] | aaff[5] |
  					   		aaff[4] | aaff[3] | aaff[2] | aaff[1]);

  assign satnode =  expmaxnode & ~((mannonzeronode));
  assign nannode =  expmaxnode & mannonzeronode;

  generate for (j=1; j <= 11; j = j + 1) begin : gexpa
      assign expnode[j] = ((aaff[j + 52] | expmaxnode)) &  ~((zipnode));
  end
  endgenerate
  assign expnode[12] = 1'b 0;
  assign expnode[13] = 1'b 0;
  //**************************************
  //*** direct to multipier or divider ***
  //**************************************
  generate if ((target == 0)) begin
      // already in "01"&mantissa format used by multiplier and divider
    assign fracnode = {aaff[64],1'b 1,aaff[52:1]};
    if ((outputpipe == 0)) begin
          assign cc = {fracnode,expnode};
      assign ccsat = satnode;
      assign cczip = zipnode;
      assign ccnan = nannode;
    end

    if ((outputpipe == 1)) begin
          always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          ccff <= 67'b 0;
          satff <= 1'b 0;
          zipff <= 1'b 0;
          nanff <= 1'b 0;
        end else begin
          if((enable == 1'b 1)) begin
            ccff <= {fracnode,expnode};
            satff <= satnode;
            zipff <= zipnode;
            nanff <= nannode;
          end
        end
      end

      assign cc = ccff;
      assign ccsat = satff;
      assign cczip = zipff;
      assign ccnan = nanff;
    end

  end
  endgenerate
  //***********************
  //*** internal format ***
  //***********************
  generate if ((target == 1)) begin
      assign fracnode[64] = aaff[64];
    assign fracnode[63] = aaff[64];
    assign fracnode[62] = aaff[64];
    assign fracnode[61] = aaff[64];
    assign fracnode[60] = aaff[64];
    assign fracnode[59] =  ~((aaff[64]));
    // '1' XOR sign
    for (j=1; j <= 52; j = j + 1) begin : gfa
          assign fracnode[j + 6] = (aaff[j] ^ aaff[64]);
    end

    for (j=1; j <= 6; j = j + 1) begin : gfb
          assign fracnode[j] = aaff[64];
            // '0' XOR sign
    end

    //*** OUTPUT STAGE(S) ***
    if ((roundconvert == 0 && outputpipe == 0)) begin
          assign cc = {fracnode,expnode};
      assign ccsat = satnode;
      assign cczip = zipnode;
      assign ccnan = nannode;
    end

    if ((outputpipe == 1 && ((roundconvert == 0) || (roundconvert == 1 && doublespeed == 0)))) begin
      if ((roundconvert == 0)) begin
              assign mantissanode = fracnode;
      end

      if ((roundconvert == 1)) begin
              assign mantissanode = fracnode + ({zerovec[63:1],aaff[64]});
      end

      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          ccff <= 77'b 0;
          satff <= 1'b 0;
          zipff <= 1'b 0;
          nanff <= 1'b 0;
        end else begin
          if((enable == 1'b 1)) begin
            ccff <= {mantissanode,expnode};
            satff <= satnode;
            zipff <= zipnode;
            nanff <= nannode;
          end
        end
      end

      assign cc = ccff;
      assign ccsat = satff;
      assign cczip = zipff;
      assign ccnan = nanff;
    end

    if ((roundconvert == 1 && doublespeed == 1)) begin
        if ((synthesize == 0)) begin
              hcc_addpipeb #(
                .width(64),
				.pipes(2))
		addone(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(fracnode),
          .bb(zerovec[64:1]),
          .carryin(aaff[64]),
          .cc(mantissanode));

      end

      if ((synthesize == 1)) begin
              hcc_addpipes #(
                  .width(64),
          .pipes(2))
        addtwo(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(fracnode),
          .bb(zerovec[64:1]),
          .carryin(aaff[64]),
          .cc(mantissanode));

      end

      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          exponentff_1 <= 13'b 0;
          exponentff_2 <= 13'b 0;
          satdelff <= 2'b 00;
          zipdelff <= 2'b 00;
          nandelff <= 2'b 00;
        end else begin
          if((enable == 1'b 1)) begin
            exponentff_1[13:1] <= expnode;
            exponentff_2[13:1] <= exponentff_1[13:1];
            satdelff[1] <= satnode;
            satdelff[2] <= satdelff[1];
            zipdelff[1] <= zipnode;
            zipdelff[2] <= zipdelff[1];
            nandelff[1] <= nannode;
            nandelff[2] <= nandelff[1];
          end
        end
      end

      assign cc = {mantissanode,exponentff_2[13:1]};
      assign ccsat = satdelff[2];
      assign cczip = zipdelff[2];
      assign ccnan = nandelff[2];
    end

  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_SGNPSTN.V                             ***
//***                                             ***
//***   Function: Leading 0/1s for a small signed ***
//***             number                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_sgnpstn (
	signbit,
    inbus,
    position
);

parameter [31:0] offset = 0;
parameter [31:0] width = 5;

input signbit;
input [4:1] inbus;
output [width:1] position;

reg [width:1] pluspos, minuspos;

always @ (inbus) begin
	case (inbus)
      4'b0000 : pluspos = {width{1'b0}};
      4'b0001 : pluspos = offset+3;
      4'b0010 : pluspos = offset+2;
      4'b0011 : pluspos = offset+2;
      4'b0100 : pluspos = offset+1;
      4'b0101 : pluspos = offset+1;
      4'b0110 : pluspos = offset+1;
      4'b0111 : pluspos = offset+1;
      4'b1000 : pluspos = offset;
      4'b1001 : pluspos = offset;
      4'b1010 : pluspos = offset;
      4'b1011 : pluspos = offset;
      4'b1100 : pluspos = offset;
      4'b1101 : pluspos = offset;
      4'b1110 : pluspos = offset;
      4'b1111 : pluspos = offset;
      default : pluspos = {width{1'b0}};
    endcase

    case (inbus)
      4'b0000 : minuspos = offset;
      4'b0001 : minuspos = offset;
      4'b0010 : minuspos = offset;
      4'b0011 : minuspos = offset;
      4'b0100 : minuspos = offset;
      4'b0101 : minuspos = offset;
      4'b0110 : minuspos = offset;
      4'b0111 : minuspos = offset;
      4'b1000 : minuspos = offset+1;
      4'b1001 : minuspos = offset+1;
      4'b1010 : minuspos = offset+1;
      4'b1011 : minuspos = offset+1;
      4'b1100 : minuspos = offset+2;
      4'b1101 : minuspos = offset+2;
      4'b1110 : minuspos = offset+3;
      4'b1111 : minuspos = {width{1'b0}};
      default : minuspos = {width{1'b0}};
    endcase
end

  genvar j;
  generate for (j = 1; j <= width; j = j+1) begin : gaa
    assign position[j] = (pluspos[j] & ~((signbit))) | (minuspos[j] & signbit);
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CNTSGN36.V                            ***
//***                                             ***
//***   Function: Count leading bits in a signed  ***
//***             36 bit number                   ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_cntsgn36(
frac,
count
);

input [36:1] frac;
output [6:1] count;

wire [36:1] frac;
wire [6:1] count;


//type positiontype IS ARRAY (9 DOWNTO 1) OF STD_LOGIC_VECTOR (6 DOWNTO 1);
wire [9:1] possec; wire [9:1] negsec; wire [9:1] sec; wire [9:1] sel;
wire [4:1] lastfrac;  //signal position : positiontype;
wire [6:1] position_1;
wire [6:1] position_2;
wire [6:1] position_3;
wire [6:1] position_4;
wire [6:1] position_5;
wire [6:1] position_6;
wire [6:1] position_7;
wire [6:1] position_8;
wire [6:1] position_9;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // for single 36 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [36][35..32][31][30..8][7..4][321]
  // for double 64 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [64][63..60][59][58..7][6..4][321] - NB underflow less than overflow
  // find first leading '1' in inexact portion for 32 bit positive number
  assign possec[1] = frac[35] | frac[34] | frac[33] | frac[32];
  assign possec[2] = frac[31] | frac[30] | frac[29] | frac[28];
  assign possec[3] = frac[27] | frac[26] | frac[25] | frac[24];
  assign possec[4] = frac[23] | frac[22] | frac[21] | frac[20];
  assign possec[5] = frac[19] | frac[18] | frac[17] | frac[16];
  assign possec[6] = frac[15] | frac[14] | frac[13] | frac[12];
  assign possec[7] = frac[11] | frac[10] | frac[9] | frac[8];
  assign possec[8] = frac[7] | frac[6] | frac[5] | frac[4];
  assign possec[9] = frac[3] | frac[2] | frac[1];
  // find first leading '0' in inexact portion for 32 bit negative number
  assign negsec[1] = frac[35] & frac[34] & frac[33] & frac[32];
  assign negsec[2] = frac[31] & frac[30] & frac[29] & frac[28];
  assign negsec[3] = frac[27] & frac[26] & frac[25] & frac[24];
  assign negsec[4] = frac[23] & frac[22] & frac[21] & frac[20];
  assign negsec[5] = frac[19] & frac[18] & frac[17] & frac[16];
  assign negsec[6] = frac[15] & frac[14] & frac[13] & frac[12];
  assign negsec[7] = frac[11] & frac[10] & frac[9] & frac[8];
  assign negsec[8] = frac[7] & frac[6] & frac[5] & frac[4];
  assign negsec[9] = frac[3] & frac[2] & frac[1];
  genvar j;
  generate for (j=1; j <= 9; j = j + 1) begin : gaa
      assign sec[j] = ((possec[j] &  ~((frac[36])))) | (~((negsec[j])) & frac[36]);
  end
  endgenerate
  assign sel[1] = sec[1];
  assign sel[2] = sec[2] &  ~((sec[1]));
  assign sel[3] = sec[3] &  ~((sec[2])) &  ~((sec[1]));
  assign sel[4] = sec[4] &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[5] = sec[5] &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[6] = sec[6] &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  assign sel[7] = sec[7] &  ~((sec[6])) &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  assign sel[8] = sec[8] &  ~((sec[7])) &  ~((sec[6])) &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  assign sel[9] = sec[9] &  ~((sec[8])) &  ~((sec[7])) &  ~((sec[6])) &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  hcc_sgnpstn #(
      .offset(0),
    .width(6))
  pone(
      .signbit(frac[36]),
    .inbus(frac[35:32]),
    .position(position_1[6:1]));

  hcc_sgnpstn #(
      .offset(4),
    .width(6))
  ptwo(
      .signbit(frac[36]),
    .inbus(frac[31:28]),
    .position(position_2[6:1]));

  hcc_sgnpstn #(
      .offset(8),
    .width(6))
  pthr(
      .signbit(frac[36]),
    .inbus(frac[27:24]),
    .position(position_3[6:1]));

  hcc_sgnpstn #(
      .offset(12),
    .width(6))
  pfor(
      .signbit(frac[36]),
    .inbus(frac[23:20]),
    .position(position_4[6:1]));

  hcc_sgnpstn #(
      .offset(16),
    .width(6))
  pfiv(
      .signbit(frac[36]),
    .inbus(frac[19:16]),
    .position(position_5[6:1]));

  hcc_sgnpstn #(
      .offset(20),
    .width(6))
  psix(
      .signbit(frac[36]),
    .inbus(frac[15:12]),
    .position(position_6[6:1]));

  hcc_sgnpstn #(
      .offset(24),
    .width(6))
  psev(
      .signbit(frac[36]),
    .inbus(frac[11:8]),
    .position(position_7[6:1]));

  hcc_sgnpstn #(
      .offset(28),
    .width(6))
  pegt(
      .signbit(frac[36]),
    .inbus(frac[7:4]),
    .position(position_8[6:1]));

  hcc_sgnpstn #(
      .offset(28),
    .width(6))
  pnin(
      .signbit(frac[36]),
    .inbus(lastfrac),
    .position(position_9[6:1]));

  assign lastfrac = {frac[3:1],frac[36]};

  generate for (j=1; j <= 6; j = j + 1) begin : gmc
      assign count[j] = ((position_1[j] & sel[1])) | ((position_2[j] & sel[2])) | 
							((position_3[j] & sel[3])) | ((position_4[j] & sel[4])) |
							((position_5[j] & sel[5])) | ((position_6[j] & sel[6])) |
							((position_7[j] & sel[7])) | ((position_8[j] & sel[8])) |
							((position_9[j] & sel[9]));
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_USGNPOS.V                             ***
//***                                             ***
//***   Function: Leading 0/1s for a small        ***
//***             unsigned number                 ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_usgnpos (
	ingroup,
	position
);

parameter [6:1] start;
input [6:1] ingroup;
output [6:1] position;
reg [6:1] position_w;

/*assign position_w = (ingroup == 6'b000000 ) ? 6'b0 : 
  					(ingroup == 6'b000001 ) ? {start + 'd5} : 6'b0;*/ 

always @ (ingroup)
	case (ingroup)
		6'b000000 : position_w = 6'b0;

	    6'b000001 : position_w = start + 6'b000101;

	    6'b000010 : position_w = start + 6'b000100;
	    6'b000011 : position_w = start + 6'b000100;

	    6'b000100 : position_w = start + 6'b000011;
	    6'b000101 : position_w = start + 6'b000011;
	    6'b000110 : position_w = start + 6'b000011;
	    6'b000111 : position_w = start + 6'b000011;

	    6'b001000 : position_w = start + 6'b000010;
	    6'b001001 : position_w = start + 6'b000010;
	    6'b001010 : position_w = start + 6'b000010;
	    6'b001011 : position_w = start + 6'b000010;
	    6'b001100 : position_w = start + 6'b000010;
	    6'b001101 : position_w = start + 6'b000010;
	    6'b001110 : position_w = start + 6'b000010;
	    6'b001111 : position_w = start + 6'b000010;

	    6'b010000 : position_w = start + 6'b000001;
	    6'b010001 : position_w = start + 6'b000001;
	    6'b010010 : position_w = start + 6'b000001;
	    6'b010011 : position_w = start + 6'b000001;
	    6'b010100 : position_w = start + 6'b000001;
	    6'b010101 : position_w = start + 6'b000001;
	    6'b010110 : position_w = start + 6'b000001;
	    6'b010111 : position_w = start + 6'b000001;
	    6'b011000 : position_w = start + 6'b000001;
	    6'b011001 : position_w = start + 6'b000001;
	    6'b011010 : position_w = start + 6'b000001;
	    6'b011011 : position_w = start + 6'b000001;
	    6'b011100 : position_w = start + 6'b000001;
	    6'b011101 : position_w = start + 6'b000001;
	    6'b011110 : position_w = start + 6'b000001;
	    6'b011111 : position_w = start + 6'b000001;

	    6'b100000 : position_w = start;
	    6'b100001 : position_w = start;
	    6'b100010 : position_w = start;
	    6'b100011 : position_w = start;
	    6'b100100 : position_w = start;
	    6'b100101 : position_w = start;
	    6'b100110 : position_w = start;
	    6'b100111 : position_w = start;
	    6'b101000 : position_w = start;
	    6'b101001 : position_w = start;
	    6'b101010 : position_w = start;
	    6'b101011 : position_w = start;
	    6'b101100 : position_w = start;
	    6'b101101 : position_w = start;
	    6'b101110 : position_w = start;
	    6'b101111 : position_w = start;
	    6'b110000 : position_w = start;
	    6'b110001 : position_w = start;
	    6'b110010 : position_w = start;
	    6'b110011 : position_w = start;
	    6'b110100 : position_w = start;
	    6'b110101 : position_w = start;
	    6'b110110 : position_w = start;
	    6'b110111 : position_w = start;
	    6'b111000 : position_w = start;
	    6'b111001 : position_w = start;
	    6'b111010 : position_w = start;
	    6'b111011 : position_w = start;
	    6'b111100 : position_w = start;
	    6'b111101 : position_w = start;
	    6'b111110 : position_w = start;
	    6'b111111 : position_w = start;
		default : position_w = 6'b0;
	endcase

assign position = position_w;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CNTUSPIPE64.V                         ***
//***                                             ***
//***   Function: Count leading bits in an        ***
//***             unsigned 64 bit number          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_cntuspipe64(
sysclk,
reset,
enable,
frac,
count
);

input sysclk;
input reset;
input enable;
input [64:1] frac;
output [6:1] count;

wire sysclk;
wire reset;
wire enable;
wire [64:1] frac;
wire [6:1] count;


//type positiontype IS ARRAY (11 DOWNTO 1) OF STD_LOGIC_VECTOR (6 DOWNTO 1); 
//signal position, positionff, positionmux : positiontype; 
wire [6:1] position [11:1];
reg [6:1] positionff [11:1];
wire [6:1] positionmux [11:1];
wire [11:1] zerogroup; reg [11:1] firstzeroff;
wire [6:1] lastfrac;

  integer k;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      for (k = 1; k <= 11; k = k + 1) begin
      	positionff[k] <= 6'b000000;
      end
    end else begin
      if((enable == 1'b 1)) begin
        firstzeroff[1] <= zerogroup[1];
        firstzeroff[2] <=  ~((zerogroup[1])) & zerogroup[2]; 
        firstzeroff[3] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) & zerogroup[3]; 
        firstzeroff[4] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) & zerogroup[4];
        firstzeroff[5] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) & zerogroup[5];
        firstzeroff[6] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) & zerogroup[6];
        firstzeroff[7] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) &  ~((zerogroup[6])) & zerogroup[7];
        firstzeroff[8] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) &  ~((zerogroup[6])) &  ~((zerogroup[7])) & zerogroup[8];
        firstzeroff[9] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) &  ~((zerogroup[6])) &  ~((zerogroup[7])) &  ~((zerogroup[8])) & zerogroup[9];
        firstzeroff[10] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) &  ~((zerogroup[6])) &  ~((zerogroup[7])) &  ~((zerogroup[8])) &  ~((zerogroup[9])) & zerogroup[10];
        firstzeroff[11] <=  ~((zerogroup[1])) &  ~((zerogroup[2])) &  ~((zerogroup[3])) &  ~((zerogroup[4])) &  ~((zerogroup[5])) &  ~((zerogroup[6])) &  ~((zerogroup[7])) &  ~((zerogroup[8])) &  ~((zerogroup[9])) &  ~((zerogroup[10])) & zerogroup[11];

        for (k = 1; k <= 11; k = k + 1) begin
        	positionff[k] <= position[k];
        end
      end
    end
  end

  assign zerogroup[1] = frac[63] | frac[62] | frac[61] | frac[60] | frac[59] | frac[58];
  assign zerogroup[2] = frac[57] | frac[56] | frac[55] | frac[54] | frac[53] | frac[52];
  assign zerogroup[3] = frac[51] | frac[50] | frac[49] | frac[48] | frac[47] | frac[46];
  assign zerogroup[4] = frac[45] | frac[44] | frac[43] | frac[42] | frac[41] | frac[40];
  assign zerogroup[5] = frac[39] | frac[38] | frac[37] | frac[36] | frac[35] | frac[34];
  assign zerogroup[6] = frac[33] | frac[32] | frac[31] | frac[30] | frac[29] | frac[28];
  assign zerogroup[7] = frac[27] | frac[26] | frac[25] | frac[24] | frac[23] | frac[22];
  assign zerogroup[8] = frac[21] | frac[20] | frac[19] | frac[18] | frac[17] | frac[16];
  assign zerogroup[9] = frac[15] | frac[14] | frac[13] | frac[12] | frac[11] | frac[10];
  assign zerogroup[10] = frac[9] | frac[8] | frac[7] | frac[6] | frac[5] | frac[4]; 
  assign zerogroup[11] = frac[3] | frac[2] | frac[1];
  hcc_usgnpos #(
      .start(0))
  pone(
      .ingroup(frac[63:58]),
    .position(position[1][6:1]));

  hcc_usgnpos #(
      .start(6))
  ptwo(
      .ingroup(frac[57:52]),
    .position(position[2][6:1]));

  hcc_usgnpos #(
      .start(12))
  pthr(
      .ingroup(frac[51:46]),
    .position(position[3][6:1]));

  hcc_usgnpos #(
      .start(18))
  pfor(
      .ingroup(frac[45:40]),
    .position(position[4][6:1]));

  hcc_usgnpos #(
      .start(24))
  pfiv(
      .ingroup(frac[39:34]),
    .position(position[5][6:1]));

  hcc_usgnpos #(
      .start(30))
  psix(
      .ingroup(frac[33:28]),
    .position(position[6][6:1]));

  hcc_usgnpos #(
      .start(36))
  psev(
      .ingroup(frac[27:22]),
    .position(position[7][6:1]));

  hcc_usgnpos #(
      .start(42))
  pegt(
      .ingroup(frac[21:16]),
    .position(position[8][6:1]));

  hcc_usgnpos #(
      .start(48))
  pnin(
      .ingroup(frac[15:10]),
    .position(position[9][6:1]));

  hcc_usgnpos #(
      .start(54))
  pten(
      .ingroup(frac[9:4]),
    .position(position[10][6:1]));

  hcc_usgnpos #(
      .start(60))
  pelv(
      .ingroup(lastfrac),
    .position(position[11][6:1]));

  assign lastfrac = {frac[3:1],3'b 000};

  genvar l;
  generate for (l=1; l <= 6; l = l + 1) begin : gma
      assign positionmux[1][l] = positionff[1][l] & firstzeroff[1];
      genvar j;
      for (j=2; j <= 11; j = j + 1) begin : gmb
          assign positionmux[j][l] = positionmux[j-1][l] | ((positionff[j][l] & firstzeroff[j])); 
    end
  end
  endgenerate
  assign count = positionmux[11];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_LSFTPIPE64.V                          ***
//***                                             ***
//***   Function: 1 pipeline stage left shift, 64 ***
//***             bit number                      ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_lsftpipe64(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [64:1] inbus;
input [6:1] shift;
output [64:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [64:1] inbus;
wire [6:1] shift;
wire [64:1] outbus;


wire [64:1] levzip; wire [64:1] levone; wire [64:1] levtwo; wire [64:1] levthr; 
reg [6:5] shiftff;
reg [64:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  assign levone[1] = (levzip[1] &  ~((shift[2])) &  ~((shift[1])));
  assign levone[2] = ((levzip[2] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[1] &  ~((shift[2])) & shift[1]));
  assign levone[3] = ((levzip[3] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[2] &  ~((shift[2])) & shift[1])) | ((levzip[1] & shift[2] &  ~((shift[1]))));
  genvar k;
  generate for (k=4; k <= 64; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k - 1] &
							~((shift[2])) & shift[1])) | ((levzip[k - 2] & shift[2] &  ~((shift[1])))) |
							((levzip[k - 3] & shift[2] & shift[1]));
  end
  endgenerate
  // shift by 0,4,8,12
  generate for (k=1; k <= 4; k = k + 1) begin : gba
      assign levtwo[k] = (levone[k] &  ~((shift[4])) &  ~((shift[3])));
  end
  endgenerate

  generate for (k=5; k <= 8; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3]));
  end
  endgenerate

  generate for (k=9; k <= 12; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) | ((levone[k - 8] & shift[4] &  ~((shift[3]))));
  end
  endgenerate

  generate for (k=13; k <= 64; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) |
 						((levone[k - 8] & shift[4] &  ~((shift[3])))) | ((levone[k - 12] & shift[4] & shift[3]));
  end
  endgenerate

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      shiftff <= 2'b 00;
      levtwoff <= 64'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[6:5];
        levtwoff <= levtwo;
      end
    end
  end


  generate for (k=1; k <= 16; k = k + 1) begin  : gca
      assign levthr[k] = (levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])));
  end
  endgenerate

  generate for (k=17; k <= 32; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])))) | ((levtwoff[k - 16] &  ~((shiftff[6])) & shiftff[5]));
  end
  endgenerate

  generate for (k=33; k <= 48; k = k + 1) begin : gcc
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])))) | ((levtwoff[k - 16] &  ~((shiftff[6])) & shiftff[5])) | ((levtwoff[k - 32] & shiftff[6] &  ~((shiftff[5]))));
  end
  endgenerate

  generate for (k=49; k <= 64; k = k + 1) begin : gcd
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])))) | ((levtwoff[k - 16] &  ~((shiftff[6])) & shiftff[5])) |
							((levtwoff[k - 32] & shiftff[6] &  ~((shiftff[5])))) | ((levtwoff[k - 48] & shiftff[6] & shiftff[5]));
  end
  endgenerate
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_NORMUS64.V                            ***
//***                                             ***
//***   Function: Normalize 64 bit unsigned       ***
//***             mantissa                        ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_normus64(
sysclk,
reset,
enable,
fracin,
countout,
fracout
);

parameter [31:0] pipes=1;
// currently 1,2,3
input sysclk;
input reset;
input enable;
input [64:1] fracin;
output [6:1] countout;
output [64:1] fracout;

wire sysclk;
wire reset;
wire enable;
wire [64:1] fracin;
wire [6:1] countout;
wire [64:1] fracout;


//type delfracfftype IS ARRAY(2 DOWNTO 1) OF STD_LOGIC_VECTOR (64 DOWNTO 1); 
wire [6:1] count; reg [6:1] countff;
reg [64:1] fracff;  //signal delfracff : delfracfftype;
reg [64:1] delfracff_1;
reg [64:1] delfracff_2;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      countff <= 6'b 000000;
      fracff <= 64'b 0;
      delfracff_1 <= 64'b 0;
      delfracff_2 <= 64'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        countff <= count;
        fracff <= fracin;
        delfracff_1[64:1] <= fracin;
        delfracff_2[64:1] <= delfracff_1[64:1];
      end
    end
  end

  generate if ((pipes == 1)) begin
      hcc_cntuscomb64 ccone(
          .frac(fracin),
      .count(count));

    assign countout = countff;
    // always after 1 clock for pipes 1,2,3
    hcc_lsftcomb64 sctwo(
          .inbus(fracff),
      .shift(countff),
      .outbus(fracout));

  end
  endgenerate
  generate if ((pipes == 2)) begin
      hcc_cntuscomb64 cctwo(
          .frac(fracin),
      .count(count));

    assign countout = countff;
    // always after 1 clock for pipes 1,2,3
    hcc_lsftpipe64 sctwo(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .inbus(fracff),
      .shift(countff),
      .outbus(fracout));

  end
  endgenerate
  generate if ((pipes == 3)) begin
      hcc_cntuspipe64 cctwo(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .frac(fracin),
      .count(count));

    assign countout = count;
    // always after 1 clock for pipes 1,2,3
    hcc_lsftpipe64 sctwo(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .inbus(delfracff_2[64:1]),
      .shift(countff),
      .outbus(fracout));

  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_ADDPIPES.V                            ***
//***                                             ***
//***   Function: Synthesizable Pipelined Adder   ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_addpipes(
sysclk,
reset,
enable,
aa,
bb,
carryin,
cc
);

parameter [31:0] width=64;
parameter [31:0] pipes=1;
input sysclk;
input reset;
input enable;
input [width:1] aa, bb;
input carryin;
output [width:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [width:1] aa;
wire [width:1] bb;
wire carryin;
wire [width:1] cc;



  lpm_add_sub #(
      .lpm_direction("ADD"),
    .lpm_hint("ONE_INPUT_IS_CONSTANT=NO,CIN_USED=YES"),
    .lpm_pipeline(pipes),
    .lpm_type("LPM_ADD_SUB"),
    .lpm_width(width))
  addtwo(
      .dataa(aa),
    .datab(bb),
    .cin(carryin),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(cc));


endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_NORMFP2X.V                            ***
//***                                             ***
//***   Function: Normalize double precision      ***
//***             number                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***   05/03/08 - correct expbotffdepth constant ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
//***************************************************
//***  NOTES : TODOS                              ***
//***************************************************
//*** NEED OVERFLOW CHECK - if 01.11111XXX11111 rounds up to 10.000..0000
`timescale 1 ps / 1 ps

module hcc_normfp2x(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] roundconvert=1;
parameter [31:0] roundnormalize=1;
parameter [31:0] normspeed=3;
parameter [31:0] doublespeed=1;
parameter [31:0] target=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [77:1] aa;
input aasat, aazip, aanan;
output [67 + 10 * target:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [77:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [67 + 10 * target:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


parameter latency = 3 + normspeed + ((roundconvert * doublespeed)) + ((roundnormalize + roundnormalize * doublespeed));
parameter exptopffdepth = 2 + roundconvert * doublespeed;
parameter expbotffdepth = normspeed + roundnormalize * ((1 + doublespeed));  // 05/03/08
// if internal format, need to turn back to signed at this point 
parameter invertpoint = 1 + normspeed + ((roundconvert * doublespeed));
//type exptopfftype IS ARRAY (exptopffdepth DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
//type expbotfftype IS ARRAY (expbotffdepth DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
wire [64:1] zerovec;
reg [77:1] aaff;
//signal exptopff : exptopfftype;
reg [13:1] exptopff [exptopffdepth:1];
reg [13:1] expbotff;
//signal expbotdelff : expbotfftype;
reg [13:1] expbotdelff [expbotffdepth:1];
wire [13:1] exponent;
wire [13:1] adjustexp;
reg [latency:1] aasatff; reg [latency:1] aazipff; reg [latency:1] aananff;
reg [latency - 1:1] mulsignff;
wire [64:1] aainvnode; wire [64:1] aaabsnode; reg [64:1] aaabsff; wire [64:1] aaabs;
wire [64:1] normalaa;
wire [6:1] countnorm;
reg [55 + 9 * target:1] normalaaff;
wire [55:1] overflowbitnode;
wire overflowcondition;
reg overflowconditionff;
wire [54 + 10 * target:1] mantissa;
wire [54 + 10 * target:1] aamannode;
reg [54 + 10 * target:1] aamanff;
wire sign;

  integer k;
  assign zerovec = 64'b 0;

  //*** INPUT REGISTER ***
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaff <= 77'b 0;

      for (k=1; k <= exptopffdepth; k = k + 1) begin
        //FOR j IN 1 TO 13 LOOP
        exptopff[k] <= 13'b 0000000000000;
        //END LOOP;
      end
      for (k=1; k <= latency; k = k + 1) begin
        aasatff[k] <= 1'b 0;
        aazipff[k] <= 1'b 0;
        aananff[k] <= 1'b 0;
      end
      for (k=1; k <= latency - 1; k = k + 1) begin
        mulsignff[k] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        aaff <= aa;
        exptopff[1] <= aaff[13:1] + adjustexp;
        for (k=2; k <= exptopffdepth; k = k + 1) begin 
          exptopff[k] <= exptopff[(k - 1)];
        end
        aasatff[1] <= aasat;
        aazipff[1] <= aazip;
        aananff[1] <= aanan;
        for (k=2; k <= latency; k = k + 1) begin
          aasatff[k] <= aasatff[k - 1];
          aazipff[k] <= aazipff[k - 1];
          aananff[k] <= aananff[k - 1];
        end
        mulsignff[1] <= aaff[77];
        for (k=2; k <= latency - 1; k = k + 1) begin
          mulsignff[k] <= mulsignff[k - 1];
        end
      end
    end
  end

  // exponent bottom half
  generate if ((expbotffdepth == 1)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 13; k = k + 1) begin
          expbotff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          expbotff[13:1] <= exptopff[exptopffdepth] - ({7'b 0000000,countnorm});
        end
      end
    end

    assign exponent = expbotff;
  end
  endgenerate
  generate if ((expbotffdepth == 2)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= expbotffdepth; k = k + 1) begin 
          //FOR j IN 1 TO 13 LOOP
          expbotdelff[k] <= 13'b 0000000000000;
          //END LOOP;
        end
      end else begin
        if((enable == 1'b 1)) begin
          expbotdelff[1] <= exptopff[exptopffdepth] - ({7'b 0000000,countnorm});
          expbotdelff[2] <= expbotdelff[1] - ({12'b 000000000000,overflowcondition});
        end
      end
    end

    assign exponent = expbotdelff[expbotffdepth];
  end
  endgenerate
  generate if ((expbotffdepth > 2)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= expbotffdepth; k = k + 1) begin 
          //FOR j IN 1 TO 13 LOOP
          expbotdelff[k] <= 13'b 0000000000000;
          //END LOOP;
        end
      end else begin
        if((enable == 1'b 1)) begin
          expbotdelff[1] <= exptopff[exptopffdepth] - ({7'b 0000000,countnorm});
          for (k=2; k <= expbotffdepth - 1; k = k + 1) begin 
            expbotdelff[k] <= expbotdelff[(k - 1)];
          end
          expbotdelff[expbotffdepth] <= expbotdelff[expbotffdepth - 1] + ({12'b 000000000000,overflowcondition});
        end
      end
    end

    assign exponent = expbotdelff[expbotffdepth];
  end
  endgenerate
  // add 4, because Y format is SSSSS1XXXX, seem to need this for both targets  
  assign adjustexp = 13'b 0000000000100;

  genvar j;
  generate for (j=1; j <= 64; j = j + 1) begin : gna
      assign aainvnode[j] = aaff[j + 13] ^ aaff[77];
  end
  endgenerate
  //*** APPLY ROUNDING TO ABS VALUE (IF REQUIRED) ***
  generate if (((roundconvert == 0) || (roundconvert == 1 && doublespeed == 0))) begin
    if ((roundconvert == 0)) begin
          assign aaabsnode = aainvnode;
    end
    if ((roundconvert == 1)) begin
          assign aaabsnode = aainvnode + ({zerovec[63:1],aaff[77]}); 
    end
    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
          aaabsff <= 64'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          aaabsff <= aaabsnode;
        end
      end
    end

    assign aaabs = aaabsff;
  end
  endgenerate
  generate if ((roundconvert == 1 && doublespeed == 1)) begin
      if ((synthesize == 0)) begin
          hcc_addpipeb #(
              .width(64),
        .pipes(2))
      absone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(aainvnode),
        .bb(zerovec),
        .carryin(aaff[77]),
        .cc(aaabs));

    end
    if ((synthesize == 1)) begin
          hcc_addpipes #(
              .width(64),
        .pipes(2))
      abstwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(aainvnode),
        .bb(zerovec),
        .carryin(aaff[77]),
        .cc(aaabs));

    end
  end
  endgenerate
  //*** NORMALIZE HERE - 1-3 pipes (countnorm output after 1 pipe) 
  hcc_normus64 #(
      .pipes(normspeed))
  normcore(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .fracin(aaabs),
    .countout(countnorm),
    .fracout(normalaa));

  generate if ((target == 0)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
          normalaaff <= 54'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          normalaaff <= normalaa[64:10];
        end
      end
    end

    //*** ROUND NORMALIZED VALUE (IF REQUIRED)***
    //*** note: normal output is 64 bits
    if ((roundnormalize == 0)) begin
          assign mantissa = normalaaff[55:2];
          assign overflowcondition = 1'b 0;
    end
    if ((roundnormalize == 1)) begin
          assign overflowbitnode[1] = normalaaff[1];
          for (j=2; j <= 55; j = j + 1) begin : gova
            assign overflowbitnode[j] = (overflowbitnode[j - 1] & normalaaff[j]);
          end
        if ((doublespeed == 0)) begin
              assign aamannode = normalaaff[55:2] + ({zerovec[53:1],normalaaff[1]});
              assign overflowcondition = overflowbitnode[55];
        always @(posedge sysclk or posedge reset) begin
          if((reset == 1'b 1)) begin
            for (k=1; k <= 54; k = k + 1) begin
              aamanff[k] <= 1'b 0;
            end
          end else begin
            if((enable == 1'b 1)) begin
              aamanff <= aamannode;
            end
          end
        end

        assign mantissa = aamanff;
      end
      if ((doublespeed == 1)) begin
        always @(posedge sysclk or posedge reset) begin
          if((reset == 1'b 1)) begin
            overflowconditionff <= 1'b 0;
          end else begin
            if((enable == 1'b 1)) begin
              overflowconditionff <= overflowbitnode[55];
            end
          end
        end
        assign overflowcondition = overflowconditionff;
          if ((synthesize == 0)) begin
                  hcc_addpipeb #(
                      .width(54),
            .pipes(2))
          rndone(
                      .sysclk(sysclk),
            .reset(reset),
            .enable(enable),
            .aa(normalaaff[55:2]),
            .bb(zerovec[54:1]),
            .carryin(normalaaff[1]),
            .cc(mantissa));

        end
        if ((synthesize == 1)) begin
                  hcc_addpipes #(
                      .width(54),
            .pipes(2))
          rndtwo(
                      .sysclk(sysclk),
            .reset(reset),
            .enable(enable),
            .aa(normalaaff[55:2]),
            .bb(zerovec[54:1]),
            .carryin(normalaaff[1]),
            .cc(mantissa));

        end
      end
    end
    assign sign = mulsignff[latency - 1];
    assign cc = {sign,(mantissa[54]|mantissa[53]),mantissa[52:1],exponent};
    assign ccsat = aasatff[latency];
    assign cczip = aazipff[latency];
    assign ccnan = aananff[latency];
  end
  endgenerate
  generate if ((target == 1)) begin
      assign overflowcondition = 1'b 0;
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 64; k = k + 1) begin
          normalaaff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          for (k=1; k <= 59; k = k + 1) begin
            normalaaff[k] <= normalaa[k + 4] ^ mulsignff[invertpoint]; 
          end
          normalaaff[60] <= mulsignff[invertpoint];
          normalaaff[61] <= mulsignff[invertpoint];
          normalaaff[62] <= mulsignff[invertpoint];
          normalaaff[63] <= mulsignff[invertpoint];
          normalaaff[64] <= mulsignff[invertpoint];
        end
      end
    end

	if ((roundnormalize == 0)) begin
          assign mantissa = normalaaff;
            // 1's complement
    end
    if ((roundnormalize == 1)) begin
        if ((doublespeed == 0)) begin
              assign aamannode = normalaaff + ({zerovec[63:1],mulsignff[invertpoint + 1]}); 
        always @(posedge sysclk or posedge reset) begin
          if((reset == 1'b 1)) begin
            for (k=1; k <= 64; k = k + 1) begin
              aamanff[k] <= 1'b 0;
            end
          end else begin
            if((enable == 1'b 1)) begin
              aamanff <= aamannode;
            end
          end
        end

        assign mantissa = aamanff;
      end
      if ((doublespeed == 1)) begin
             if ((synthesize == 0)) begin
                  hcc_addpipeb #(
                      .width(64),
            .pipes(2))
          rndone(
                      .sysclk(sysclk),
            .reset(reset),
            .enable(enable),
            .aa(normalaaff),
            .bb(zerovec[64:1]),
            .carryin(mulsignff[invertpoint + 1]),
            .cc(mantissa));

        end
        if ((synthesize == 1)) begin
                  hcc_addpipes #(
                      .width(64),
            .pipes(2))
          rndtwo(
                      .sysclk(sysclk),
            .reset(reset),
            .enable(enable),
            .aa(normalaaff),
            .bb(zerovec[64:1]),
            .carryin(mulsignff[invertpoint + 1]),
            .cc(mantissa));

        end
      end
    end
    assign cc = {mantissa[64:1],exponent};
    assign ccsat = aasatff[latency];
    assign cczip = aazipff[latency];
    assign ccnan = aananff[latency];
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_DELMEM.V                              ***
//***                                             ***
//***   Function: Delay an arbitrary width an     ***
//***             arbitrary number of stages      ***
//***                                             ***
//***   Note: this code megawizard generated      ***
//***                                             ***
//***   12/12/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_delmem(
sysclk,
enable,
aa,
cc
);

parameter [31:0] width=79;
parameter [31:0] delay=7;
input sysclk;
input enable;
input [width:1] aa;
output [width:1] cc;

wire sysclk;
wire enable;
wire [width:1] aa;
wire [width:1] cc;


wire [width:1] dummy;

  altshift_taps #(
      .lpm_hint("RAM_BLOCK_TYPE=M512"),
    .lpm_type("altshift_taps"),
    .number_of_taps(1),
    .tap_distance(delay),
    .width(width))
  delcore(
      .clock(sysclk),
    .clken(enable),
    .shiftin(aa),
    .taps(dummy),
    .shiftout(cc),.aclr(1'b0));


endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_DELAY.V                               ***
//***                                             ***
//***   Function: Delay an arbitrary width an     ***
//***             arbitrary number of stages      ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_delay(
sysclk,
reset,
enable,
aa,
cc
);

parameter [31:0] width=32;
parameter [31:0] delay=10;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [width:1] aa;
output [width:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [width:1] aa;
wire [width:1] cc;


//type delmemfftype IS ARRAY (delay DOWNTO 1) OF STD_LOGIC_VECTOR (width DOWNTO 1); 
//signal delmemff : delmemfftype;
reg [width:1] delmemff [delay:1];
reg [width:1] delinff; wire [width:1] deloutff;

  generate if ((delay == 1)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
          delinff <= {width{1'b 0}};
      end else begin
        if((enable == 1'b 1)) begin
          delinff <= aa;
        end
      end
    end

    assign cc = delinff;
  end
  endgenerate

  generate if ((((delay > 1) && (delay < 5) && synthesize == 1) || ((delay > 1) && synthesize == 0))) begin
	integer k;
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        //FOR j IN 1 TO delay LOOP
        for (k = 1; k <= delay; k = k + 1) begin
          delmemff[k] <= {width{1'b 0}};
        end
        //END LOOP;
      end else begin
        if((enable == 1'b 1)) begin
          delmemff[1] <= aa;
          for (k=2; k <= delay; k = k + 1) begin
            delmemff[k] <= delmemff[k - 1];
          end
        end
      end
    end

    assign cc = delmemff[delay];
  end
  endgenerate
  generate if ((delay > 4 && synthesize == 1)) begin
      hcc_delmem #(
          .width(width),
      .delay(delay))
    core(
          .sysclk(sysclk),
      .enable(enable),
      .aa(aa),
      .cc(cc));

  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_LSFTPIPE32.V                          ***
//***                                             ***
//***   Function: 1 pipeline stage left shift, 32 ***
//***             bit number                      ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_lsftpipe32(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [32:1] inbus;
input [5:1] shift;
output [32:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [32:1] inbus;
wire [5:1] shift;
wire [32:1] outbus;


wire [32:1] levzip; wire [32:1] levone; wire [32:1] levtwo; wire [32:1] levthr; 
reg shiftff;
reg [32:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  assign levone[1] = (levzip[1] &  ~((shift[2])) &  ~((shift[1])));
  assign levone[2] = ((levzip[2] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[1] &  ~((shift[2])) & shift[1]));
  assign levone[3] = ((levzip[3] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[2] &  ~((shift[2])) & shift[1])) | ((levzip[1] & shift[2] &  ~((shift[1]))));
  genvar k;
  generate for (k=4; k <= 32; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k - 1] &  ~((shift[2])) & shift[1])) | ((levzip[k - 2] & shift[2] &  ~((shift[1])))) | ((levzip[k - 3] & shift[2] & shift[1]));
  end
  endgenerate
  // shift by 0,4,8,12

  generate for (k=1; k <= 4; k = k + 1) begin : gba
      assign levtwo[k] = (levone[k] &  ~((shift[4])) &  ~((shift[3])));
  end
  endgenerate

  generate for (k=5; k <= 8; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3]));
  end
  endgenerate

  generate for (k=9; k <= 12; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) | ((levone[k - 8] & shift[4] &  ~((shift[3]))));
  end
  endgenerate

  generate for (k=13; k <= 32; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) | ((levone[k - 8] & shift[4] &  ~((shift[3])))) | ((levone[k - 12] & shift[4] & shift[3]));
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin : gbe
	   integer j;
    if((reset == 1'b 1)) begin
      shiftff <= 1'b 0;
      for (j=1; j <= 32; j = j + 1) begin
        levtwoff[j] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[5];
        levtwoff <= levtwo;
      end
    end
  end

  generate for (k=1; k <= 16; k = k + 1) begin : gca
      assign levthr[k] = (levtwoff[k] &  ~((shiftff)));
  end
  endgenerate

  generate for (k=17; k <= 32; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff)))) | ((levtwoff[k - 16] & shiftff));
  end
  endgenerate
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CNTSGN32.V                            ***
//***                                             ***
//***   Function: Count leading bits in a signed  ***
//***             32 bit number                   ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_cntsgn32(
frac,
count
);

input [32:1] frac;
output [6:1] count;

wire [32:1] frac;
wire [6:1] count;


//type positiontype IS ARRAY (8 DOWNTO 1) OF STD_LOGIC_VECTOR (5 DOWNTO 1);
wire [8:1] possec; wire [8:1] negsec; wire [8:1] sec; wire [8:1] sel;
wire [4:1] lastfrac;  //signal position : positiontype;
wire [5:1] position_1;
wire [5:1] position_2;
wire [5:1] position_3;
wire [5:1] position_4;
wire [5:1] position_5;
wire [5:1] position_6;
wire [5:1] position_7;
wire [5:1] position_8;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // for single 36 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [36][35..32][31][30..8][7..4][321]
  // for double 64 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [64][63..60][59][58..7][6..4][321] - NB underflow less than overflow
  // find first leading '1' in inexact portion for 32 bit positive number
  assign possec[1] = frac[31] | frac[30] | frac[29] | frac[28];
  assign possec[2] = frac[27] | frac[26] | frac[25] | frac[24];
  assign possec[3] = frac[23] | frac[22] | frac[21] | frac[20];
  assign possec[4] = frac[19] | frac[18] | frac[17] | frac[16];
  assign possec[5] = frac[15] | frac[14] | frac[13] | frac[12];
  assign possec[6] = frac[11] | frac[10] | frac[9] | frac[8];
  assign possec[7] = frac[7] | frac[6] | frac[5] | frac[4];
  assign possec[8] = frac[3] | frac[2] | frac[1];
  // find first leading '0' in inexact portion for 32 bit negative number
  assign negsec[1] = frac[31] & frac[30] & frac[29] & frac[28];
  assign negsec[2] = frac[27] & frac[26] & frac[25] & frac[24];
  assign negsec[3] = frac[23] & frac[22] & frac[21] & frac[20];
  assign negsec[4] = frac[19] & frac[18] & frac[17] & frac[16];
  assign negsec[5] = frac[15] & frac[14] & frac[13] & frac[12];
  assign negsec[6] = frac[11] & frac[10] & frac[9] & frac[8];
  assign negsec[7] = frac[7] & frac[6] & frac[5] & frac[4];
  assign negsec[8] = frac[3] & frac[2] & frac[1];
  genvar k;
  generate for (k=1; k <= 8; k = k + 1) begin : gaa
      assign sec[k] = ((possec[k] &  ~((frac[32])))) | (( ~((negsec[k])) & frac[32]));
  end
  endgenerate
  assign sel[1] = sec[1];
  assign sel[2] = sec[2] &  ~((sec[1]));
  assign sel[3] = sec[3] &  ~((sec[2])) &  ~((sec[1]));
  assign sel[4] = sec[4] &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[5] = sec[5] &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[6] = sec[6] &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  assign sel[7] = sec[7] &  ~((sec[6])) &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  assign sel[8] = sec[8] &  ~((sec[7])) &  ~((sec[6])) &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  hcc_sgnpstn #(
      .offset(0),
    .width(5))
  pone(
      .signbit(frac[32]),
    .inbus(frac[31:28]),
    .position(position_1[5:1]));

  hcc_sgnpstn #(
      .offset(4),
    .width(5))
  ptwo(
      .signbit(frac[32]),
    .inbus(frac[27:24]),
    .position(position_2[5:1]));

  hcc_sgnpstn #(
      .offset(8),
    .width(5))
  pthr(
      .signbit(frac[32]),
    .inbus(frac[23:20]),
    .position(position_3[5:1]));

  hcc_sgnpstn #(
      .offset(12),
    .width(5))
  pfor(
      .signbit(frac[32]),
    .inbus(frac[19:16]),
    .position(position_4[5:1]));

  hcc_sgnpstn #(
      .offset(16),
    .width(5))
  pfiv(
      .signbit(frac[32]),
    .inbus(frac[15:12]),
    .position(position_5[5:1]));

  hcc_sgnpstn #(
      .offset(20),
    .width(5))
  psix(
      .signbit(frac[32]),
    .inbus(frac[11:8]),
    .position(position_6[5:1]));

  hcc_sgnpstn #(
      .offset(24),
    .width(5))
  psev(
      .signbit(frac[32]),
    .inbus(frac[7:4]),
    .position(position_7[5:1]));

  hcc_sgnpstn #(
      .offset(28),
    .width(5))
  pegt(
      .signbit(frac[32]),
    .inbus(lastfrac),
    .position(position_8[5:1]));

  assign lastfrac = {frac[3:1],frac[32]};

  generate for (k=1; k <= 5; k = k + 1) begin : gmc
      assign count[k] = ((position_1[k] & sel[1])) | ((position_2[k] & sel[2])) | ((position_3[k] & sel[3])) | ((position_4[k] & sel[4])) | ((position_5[k] & sel[5])) | ((position_6[k] & sel[6])) | ((position_7[k] & sel[7])) | ((position_8[k] & sel[8]));
  end
  endgenerate
  assign count[6] = 1'b 0;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_NORMSGN3236.V                            ***
//***                                             ***
//***   Function: Normalize 32 or 36 bit signed   ***
//***             mantissa                        ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_normsgn3236(
sysclk,
reset,
enable,
fracin,
countout,
fracout
);

parameter [31:0] mantissa=32;
parameter [31:0] normspeed=1;
// 1 or 2
input sysclk;
input reset;
input enable;
input [mantissa:1] fracin;
output [6:1] countout;
// 1 clock earlier than fracout
output [mantissa:1] fracout;

wire sysclk;
wire reset;
wire enable;
wire [mantissa:1] fracin;
wire [6:1] countout;
wire [mantissa:1] fracout;


wire [6:1] count; reg [6:1] countff;
reg [mantissa:1] fracff;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      countff <= 6'b 000000;
      fracff <= {mantissa{1'b 0}};
    end else begin
      if((enable == 1'b 1)) begin
        countff <= count;
        fracff <= fracin;
      end
    end
  end

  generate if ((mantissa == 32)) begin
      hcc_cntsgn32 countone(
          .frac(fracin),
      .count(count));

    if ((normspeed == 1)) begin
          hcc_lsftcomb32 shiftone(
              .inbus(fracff),
        .shift(countff[5:1]),
        .outbus(fracout));

    end

    if ((normspeed > 1)) begin
          // if mixed single & double, 3 is possible
      hcc_lsftpipe32 shiftone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(fracff),
        .shift(countff[5:1]),
        .outbus(fracout));

    end
  end
  endgenerate
  generate if ((mantissa == 36)) begin
      hcc_cntsgn36 counttwo(
          .frac(fracin),
      .count(count));

    if ((normspeed == 1)) begin
          hcc_lsftcomb36 shiftthr(
              .inbus(fracff),
        .shift(countff[6:1]),
        .outbus(fracout));
    end

    //pcc: PROCESS (sysclk,reset)
    //BEGIN
    //  IF (reset = '1') THEN
    //    countff <= "000000";
    //  ELSIF (rising_edge(sysclk)) THEN
    //    IF (enable = '1') THEN
    //      countff <= count;
    //    END IF;
    //  END IF;
    //END PROCESS;
    if ((normspeed > 1)) begin
          // if mixed single & double, 3 is possible
      hcc_lsftpipe36 shiftfor(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(fracff),
        .shift(countff[6:1]),
        .outbus(fracout));

    end
  end
  endgenerate
  assign countout = countff;
    // same time as fracout for normspeed = 1, 1 clock earlier otherwise 

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_NORMFP1X.V                            ***
//***                                             ***
//***   Function: Normalize single precision      ***
//***             number                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***   28/12/07 - divider target uses all of     ***
//***   mantissa width                            ***
//***   06/02/08 - fix divider norm               ***
//***   21/03/08 - fix add tree output norm       ***
//***                                             ***
//***************************************************
// normalize signed numbers (x input format) - for 1x multipliers
// format signed32/36 bit mantissa, 10 bit exponent
// unsigned numbers for divider (S,1,23 bit mantissa for divider)
// divider packed into 32/36bit mantissa + exponent
`timescale 1 ps / 1 ps

module hcc_normfp1x(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] inputnormalize=1;
parameter [31:0] roundnormalize=1;
parameter [31:0] normspeed=2;
parameter [31:0] target=0;
// 0 = mult target (signed), 1 = divider target (unsigned), 2 adder tree 
input sysclk;
input reset;
input enable;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


//type expfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1);
reg [mantissa + 10:1] aaff;
wire [mantissa + 10:1] ccnode;  // scale
reg aasatff; reg aazipff; reg aananff;
wire [3:1] countaa;  //  normalize
wire [mantissa - 1:1] zerovec;
wire [mantissa:1] normfracnode; wire [mantissa:1] normnode;
reg [mantissa:1] normfracff; reg [mantissa:1] normff;
wire [10:1] countadjust;  //signal exptopff, expbotff : expfftype; 
reg [2 * 10:1] exptopff; reg [2 * 10:1] expbotff;
reg maximumnumberff;
wire zeroexponent; reg zeroexponentff;
wire [10:1] exponentmiddle;
reg [5:1] aasatdelff; reg [5:1] aazipdelff; reg [5:1] aanandelff;
wire [6:1] countsign;
wire [mantissa:1] normsignnode;  //signal aaexp, ccexp : STD_LOGIC_VECTOR (10 DOWNTO 1);
//signal aaman, ccman : STD_LOGIC_VECTOR (mantissa DOWNTO 1);
//FOR_DEBUG wire [10:1] aaexp; wire [10:1] ccexp;
//FOR_DEBUG wire [mantissa:1] aaman; wire [mantissa:1] ccman;

  //******************************************************** 
  //*** scale multiplier                                 *** 
  //*** multiplier format [S][1][mantissa....]           *** 
  //*** one clock latency                                *** 
  //******************************************************** 
  // make sure right format & adjust exponent
  generate if ((inputnormalize == 0)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        aaff <= {(mantissa + 10){1'b 0}};
        aasatff <= 1'b 0;
        aazipff <= 1'b 0;
        aananff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          aaff <= aa;
          aasatff <= aasat;
          aazipff <= aazip;
          aananff <= aanan;
        end
      end
    end

    // no rounding when scaling
    hcc_scmul3236 #(
          .mantissa(mantissa))
    sma(
          .frac(aaff[mantissa + 10:11]),
      .scaled(ccnode[mantissa + 10:11]),
      .count(countaa));

    assign ccnode[10:1] = aaff[10:1] + ({7'b 0000000,countaa});
    assign cc = ccnode;
    assign ccsat = aasatff;
    assign cczip = aazipff;
    assign ccnan = aananff;
  end
  endgenerate
  //******************************************************** 
  //*** full normalization of input - 4 stages           *** 
  //*** unlike double, no round required on output, as   *** 
  //*** no information lost                              *** 
  //******************************************************** 
  genvar j;
  integer k;
  generate if ((inputnormalize == 1)) begin
      // normalize
    assign zerovec = {(mantissa - 1){1'b 0}};

    // if multiplier, "1" which is nominally in position 27, is shifted to position 31
    // add 4 to exponent when multiplier, 0 for adder
    if ((target < 2)) begin
          //countadjust <= conv_std_logic_vector (4,10); 
      assign countadjust = 10'b 0000000100;
    end

    if ((target == 2)) begin
          //countadjust <= conv_std_logic_vector (4,10); 
      assign countadjust = 10'b 0000000100;
    end

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= mantissa + 10; k = k + 1) begin 
          aaff[k] <= 1'b 0;
        end
        for (k=1; k <= mantissa; k = k + 1) begin
          normfracff[k] <= 1'b 0;
          normff[k] <= 1'b 0;
        end
        for (k=1; k <= 2 * 10; k = k + 1) begin
          exptopff[k] <= 1'b 0;
          //exptopff(2)(k) <= '0';
          expbotff[k] <= 1'b 0;
          //expbotff(2)(k) <= '0';
        end
        maximumnumberff <= 1'b 0;
        zeroexponentff <= 1'b 0;
        for (k=1; k <= 5; k = k + 1) begin
          aasatdelff[k] <= 1'b 0;
          aazipdelff[k] <= 1'b 0;
          aanandelff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          aaff <= aa;
          normfracff <= normfracnode;
          //might not get used
          normff <= normnode;
          exptopff[10:1] <= aaff[10:1] + countadjust;
          exptopff[2 * 10:(((2 - 1)) * 10 + 1)] <= exptopff[10:1] - ({4'b 0000,countsign}); 
          //might not get used
          expbotff[10:1] <= exponentmiddle; 
          expbotff[2 * 10:(((2 - 1)) * 10 + 1)] <= expbotff[10:1]; 
          maximumnumberff <= aaff[mantissa+10] ^ aaff[mantissa+9];
          zeroexponentff <= zeroexponent;
          aasatdelff[1] <= aasat;
          aazipdelff[1] <= aazip;
          aanandelff[1] <= aanan;
          for (k=2; k <= 5; k = k + 1) begin
            // 4&5 might not get used
            aasatdelff[k] <= aasatdelff[k - 1];
            aazipdelff[k] <= aazipdelff[k - 1];
            aanandelff[k] <= aanandelff[k - 1];
          end
        end
      end
    end

    hcc_normsgn3236 #(
          .mantissa(mantissa),
      .normspeed(normspeed))
    nrmc(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .fracin(aaff[mantissa + 10:11]),
      .countout(countsign),
      // stage 1 or 2
      .fracout(normfracnode));

    // stage 2 or 3
    assign zeroexponent = ~((countsign[6] | countsign[5] | countsign[4] | countsign[3] | countsign[2] | countsign[1] | maximumnumberff)); 

      for (j=1; j <= 10; j = j + 1) begin : gen_exp_mid
          assign exponentmiddle[j] = exptopff[j+10] & ~((zeroexponentff)); 
      end
    if ((target == 1)) begin
      for (j=1; j <= mantissa; j = j + 1) begin : gnc
          assign normsignnode[j] = normfracff[j] ^ normfracff[mantissa]; 
      end

      assign normnode[mantissa - 1:1] = normsignnode[mantissa - 1:1] + ({zerovec[mantissa - 2:1],normfracff[mantissa]});
      // 06/02/08 make sure signbit is packed with the mantissa
      assign normnode[mantissa] = normfracff[mantissa];
      //*** OUTPUTS ***
      assign ccnode[mantissa + 10:11] = normff;
      assign ccnode[10:1] = expbotff[normspeed * 10:(((normspeed - 1)) * 10 + 1)];
      assign ccsat = aasatdelff[3 + normspeed];
      assign cczip = aazipdelff[3 + normspeed];
      assign ccnan = aanandelff[3 + normspeed];
    end

    if ((target == 0)) begin
          //*** OUTPUTS ***
      assign ccnode[mantissa + 10:11] = normfracff;
      if ((normspeed == 1)) begin
              assign ccnode[10:1] = exponentmiddle; 
      end

      if ((normspeed > 1)) begin
              assign ccnode[10:1] = expbotff[10:1];
      end

      assign ccsat = aasatdelff[2 + normspeed];
      assign cczip = aazipdelff[2 + normspeed];
      assign ccnan = aanandelff[2 + normspeed];
    end

    if ((target == 2)) begin
      if ((roundnormalize == 1)) begin
              assign normnode = ({normfracff[mantissa],normfracff[mantissa],normfracff[mantissa],normfracff[mantissa],normfracff[mantissa:5]}) + ({zerovec[mantissa - 1:1],normfracff[4]});
      end

      //*** OUTPUTS ***
      if ((roundnormalize == 0)) begin
              // 21/03/08 fixed this to SSSSS1XXXXX
        assign ccnode[mantissa + 10:11] = {normfracff[mantissa],normfracff[mantissa],normfracff[mantissa],normfracff[mantissa],normfracff[mantissa:5]};
      end

      if ((roundnormalize == 1)) begin
              assign ccnode[mantissa + 10:11] = normff;
      end

      if ((normspeed == 1 && roundnormalize == 0)) begin 
              assign ccnode[10:1] = exponentmiddle; 
      end

      if (((normspeed == 2 && roundnormalize == 0) || (normspeed == 1 && roundnormalize == 1))) begin
              assign ccnode[10:1] = expbotff[10:1];
      end

      if ((normspeed == 2 && roundnormalize == 1)) begin 
              assign ccnode[10:1] = expbotff[2 * 10:(((2 - 1)) * 10 + 1)]; 
      end

      assign ccsat = aasatdelff[2 + normspeed + roundnormalize]; 
      assign cczip = aazipdelff[2 + normspeed + roundnormalize]; 
      assign ccnan = aanandelff[2 + normspeed + roundnormalize]; 
    end

    assign cc = ccnode;
  end
  endgenerate
    //*** DEBUG ***
  //aaexp <= aa(10 DOWNTO 1);
  //FOR_DEBUG   assign aaexp = aa[10:1];
  //aaman <= aa(mantissa+10 DOWNTO 11);
  //FOR_DEBUG   assign aaman = aa[mantissa+10:11];
  //ccexp <= ccnode(10 DOWNTO 1);
  //FOR_DEBUG   assign ccexp = ccnode[10:1];
  //ccman <= ccnode(mantissa+10 DOWNTO 11);
  //FOR_DEBUG   assign ccman = ccnode[mantissa+10:11];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_LSFTPIPE36.V                          ***
//***                                             ***
//***   Function: 1 pipeline stage left shift, 36 ***
//***             bit number                      ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_lsftpipe36(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [36:1] inbus;
input [6:1] shift;
output [36:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [36:1] inbus;
wire [6:1] shift;
wire [36:1] outbus;


wire [36:1] levzip; wire [36:1] levone; wire [36:1] levtwo; wire [36:1] levthr; 
reg [6:5] shiftff;
reg [36:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  assign levone[1] = (levzip[1] &  ~((shift[2])) &  ~((shift[1])));
  assign levone[2] = ((levzip[2] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[1] &  ~((shift[2])) & shift[1]));
  assign levone[3] = ((levzip[3] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[2] &  ~((shift[2])) & shift[1])) | ((levzip[1] & shift[2] &  ~((shift[1]))));
  genvar k;
  generate for (k=4; k <= 36; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k - 1] &  ~((shift[2])) & shift[1])) | ((levzip[k - 2] & shift[2] &  ~((shift[1])))) | ((levzip[k - 3] & shift[2] & shift[1]));
  end
  endgenerate
  // shift by 0,4,8,12

  generate for (k=1; k <= 4; k = k + 1) begin : gba
      assign levtwo[k] = (levone[k] &  ~((shift[4])) &  ~((shift[3])));
  end
  endgenerate

  generate for (k=5; k <= 8; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3]));
  end
  endgenerate

  generate for (k=9; k <= 12; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) | ((levone[k - 8] & shift[4] &  ~((shift[3]))));
  end
  endgenerate

  generate for (k=13; k <= 36; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k - 4] &  ~((shift[4])) & shift[3])) | ((levone[k - 8] & shift[4] &  ~((shift[3])))) | ((levone[k - 12] & shift[4] & shift[3]));
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      shiftff <= 2'b 00;
      levtwoff <= 36'b0;
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[6:5];
        levtwoff <= levtwo;
      end
    end
  end


  generate for (k=1; k <= 16; k = k + 1) begin : gca
      assign levthr[k] = (levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])));
  end
  endgenerate

  generate for (k=17; k <= 32; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])))) | ((levtwoff[k - 16] &  ~((shiftff[6])) & shiftff[5]));
  end
  endgenerate

  generate for (k=33; k <= 36; k = k + 1) begin : gcc
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[6])) &  ~((shiftff[5])))) | ((levtwoff[k - 16] &  ~((shiftff[6])) & shiftff[5])) | ((levtwoff[k - 32] & shiftff[6] &  ~((shiftff[5]))));
  end
  endgenerate
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CNTUSGN36.V                           ***
//***                                             ***
//***   Function: Count leading bits in an        ***
//***             unsigned 36 bit number          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_cntusgn36(
frac,
count
);

input [36:1] frac;
output [6:1] count;

wire [36:1] frac;
wire [6:1] count;


//type positiontype IS ARRAY (6 DOWNTO 1) OF STD_LOGIC_VECTOR (6 DOWNTO 1);
wire [6:1] sec; wire [6:1] sel;
wire [6:1] lastfrac;  //signal position : positiontype;
wire [6:1] position_1;
wire [6:1] position_2;
wire [6:1] position_3;
wire [6:1] position_4;
wire [6:1] position_5;
wire [6:1] position_6;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // for single 36 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [36][35..32][31][30..8][7..4][321]
  // for double 64 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [64][63..60][59][58..7][6..4][321] - NB underflow less than overflow
  // find first leading '1' in inexact portion for 32 bit positive number
  assign sec[1] = frac[35] | frac[34] | frac[33] | frac[32] | frac[31] | frac[30];
  assign sec[2] = frac[29] | frac[28] | frac[27] | frac[26] | frac[25] | frac[24];
  assign sec[3] = frac[23] | frac[22] | frac[21] | frac[20] | frac[19] | frac[18];
  assign sec[4] = frac[17] | frac[16] | frac[15] | frac[14] | frac[13] | frac[12];
  assign sec[5] = frac[11] | frac[10] | frac[9] | frac[8] | frac[7] | frac[6];  
  assign sec[6] = frac[5] | frac[4] | frac[3] | frac[2] | frac[1]; 
  assign sel[1] = sec[1];
  assign sel[2] = sec[2] &  ~((sec[1]));
  assign sel[3] = sec[3] &  ~((sec[2])) &  ~((sec[1]));
  assign sel[4] = sec[4] &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[5] = sec[5] &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[6] = sec[6] &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  hcc_usgnpos #(
      .start(0))
  pone(
      .ingroup(frac[35:30]),
    .position(position_1[6:1]));

  hcc_usgnpos #(
      .start(6))
  ptwo(
      .ingroup(frac[29:24]),
    .position(position_2[6:1]));

  hcc_usgnpos #(
      .start(12))
  pthr(
      .ingroup(frac[23:18]),
    .position(position_3[6:1]));

  hcc_usgnpos #(
      .start(18))
  pfor(
      .ingroup(frac[17:12]),
    .position(position_4[6:1]));

  hcc_usgnpos #(
      .start(24))
  pfiv(
      .ingroup(frac[11:6]),
    .position(position_5[6:1]));

  hcc_usgnpos #(
      .start(30))
  psix(
      .ingroup(lastfrac),
    .position(position_6[6:1]));

  assign lastfrac = {frac[5:1],1'b 0};
  genvar k;
  generate for (k=1; k <= 6; k = k + 1) begin : gmc
      assign count[k] = ((position_1[k] & sel[1])) | ((position_2[k] & sel[2])) | ((position_3[k] & sel[3])) | ((position_4[k] & sel[4])) | ((position_5[k] & sel[5])) | ((position_6[k] & sel[6]));
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_NORMUSGN3236.V                        ***
//***                                             ***
//***   Function: Normalize 32 or 36 bit unsigned ***
//***             mantissa                        ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_normusgn3236(
sysclk,
reset,
enable,
fracin,
countout,
fracout
);

parameter [31:0] mantissa=32;
parameter [31:0] normspeed=1;
// 1 or 2
input sysclk;
input reset;
input enable;
input [mantissa:1] fracin;
output [6:1] countout;
// 1 clock earlier than fracout
output [mantissa:1] fracout;

wire sysclk;
wire reset;
wire enable;
wire [mantissa:1] fracin;
wire [6:1] countout;
wire [mantissa:1] fracout;


wire [6:1] count; reg [6:1] countff;
reg [mantissa:1] fracff;

  always @(posedge sysclk or posedge reset) begin : gza
	integer k;
    if((reset == 1'b 1)) begin
      countff <= 6'b 000000;
      for (k=1; k <= mantissa; k = k + 1) begin
        fracff[k] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        countff <= count;
        fracff <= fracin;
      end
    end
  end

  generate if ((mantissa == 32)) begin : gna
      hcc_cntusgn32 countone(
          .frac(fracin),
      .count(count));

    if ((normspeed == 1)) begin
          hcc_lsftcomb32 shiftone(
              .inbus(fracff),
        .shift(countff[5:1]),
        .outbus(fracout));
    end

    if ((normspeed > 1)) begin
          // if mixed single & double, 3 is possible
      hcc_lsftpipe32 shiftone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(fracff),
        .shift(countff[5:1]),
        .outbus(fracout));
    end
  end
  endgenerate

  generate if ((mantissa == 36)) begin : gnd
      hcc_cntusgn36 counttwo(
          .frac(fracin),
      .count(count));

    if ((normspeed == 1)) begin
          hcc_lsftcomb36 shiftthr(
              .inbus(fracff),
        .shift(countff[6:1]),
        .outbus(fracout));
    end

    //pcc: PROCESS (sysclk,reset)
    //BEGIN
    //  IF (reset = '1') THEN
    //    countff <= "000000";
    //  ELSIF (rising_edge(sysclk)) THEN
    //    IF (enable = '1') THEN
    //      countff <= count;
    //    END IF;
    //  END IF;
    //END PROCESS;
    if ((normspeed > 1)) begin
          // if mixed single & double, 3 is possible
      hcc_lsftpipe36 shiftfor(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(fracff),
        .shift(countff[6:1]),
        .outbus(fracout));
    end
  end
  endgenerate

  assign countout = countff;
    // same time as fracout for normspeed = 1, 1 clock earlier otherwise 

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CNTUSGN32.V                           ***
//***                                             ***
//***   Function: Count leading bits in an        ***
//***             unsigned 32 bit number          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_cntusgn32(
frac,
count
);

input [32:1] frac;
output [6:1] count;

wire [32:1] frac;
wire [6:1] count;


//type positiontype IS ARRAY (6 DOWNTO 1) OF STD_LOGIC_VECTOR (6 DOWNTO 1);
wire [6:1] sec; wire [6:1] sel;
wire [6:1] lastfrac;  //signal position : positiontype;
wire [6:1] position_1;
wire [6:1] position_2;
wire [6:1] position_3;
wire [6:1] position_4;
wire [6:1] position_5;
wire [6:1] position_6;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // for single 36 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [36][35..32][31][30..8][7..4][321]
  // for double 64 bit mantissa
  // [S ][O....O][1 ][M...M][O..O][RGS]
  // [64][63..60][59][58..7][6..4][321] - NB underflow less than overflow
  // find first leading '1' in inexact portion for 32 bit positive number
  assign sec[1] = frac[31] | frac[30] | frac[29] | frac[28] | frac[27] | frac[26];
  assign sec[2] = frac[25] | frac[24] | frac[23] | frac[22] | frac[21] | frac[20];
  assign sec[3] = frac[19] | frac[18] | frac[17] | frac[16] | frac[15] | frac[14];
  assign sec[4] = frac[13] | frac[12] | frac[11] | frac[10] | frac[9] | frac[8];
  assign sec[5] = frac[7] | frac[6] | frac[5] | frac[4] | frac[3] | frac[2]; 
  assign sec[6] = frac[1];
  assign sel[1] = sec[1];
  assign sel[2] = sec[2] &  ~((sec[1]));
  assign sel[3] = sec[3] &  ~((sec[2])) &  ~((sec[1]));
  assign sel[4] = sec[4] &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[5] = sec[5] &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1])); 
  assign sel[6] = sec[6] &  ~((sec[5])) &  ~((sec[4])) &  ~((sec[3])) &  ~((sec[2])) &  ~((sec[1]));
  hcc_usgnpos #(
      .start(0))
  pone(
      .ingroup(frac[31:26]),
    .position(position_1[6:1]));

  hcc_usgnpos #(
      .start(6))
  ptwo(
      .ingroup(frac[25:20]),
    .position(position_2[6:1]));

  hcc_usgnpos #(
      .start(12))
  pthr(
      .ingroup(frac[19:14]),
    .position(position_3[6:1]));

  hcc_usgnpos #(
      .start(18))
  pfor(
      .ingroup(frac[13:8]),
    .position(position_4[6:1]));

  hcc_usgnpos #(
      .start(24))
  pfiv(
      .ingroup(frac[7:2]),
    .position(position_5[6:1]));

  hcc_usgnpos #(
      .start(30))
  psix(
      .ingroup(lastfrac),
    .position(position_6[6:1]));

  assign lastfrac = {frac[1],5'b 00000};
  genvar k;
  generate for (k=1; k <= 6; k = k + 1) begin : gmc
      assign count[k] = ((position_1[k] & sel[1])) | ((position_2[k] & sel[2])) | ((position_3[k] & sel[3])) | ((position_4[k] & sel[4])) | ((position_5[k] & sel[5])) | ((position_6[k] & sel[6]));
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CASTXTOF.V                            ***
//***                                             ***
//***   Function: Cast Internal Single to IEEE754 ***
//***             Single                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_castxtof(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
cc
);

parameter [31:0] mantissa=32;
parameter [31:0] normspeed=2;
// 1 or 2
input sysclk;
input reset;
input enable;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
output [32:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [32:1] cc;


// latency = 5 if normspeed = 1
// latency = 7 if normspeed = 2 (extra pipe in normusgn3236 and output stage)
//type exptopfftype IS ARRAY (3 DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1); 
//type expbotfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1); 
wire [mantissa - 1:1] zerovec;
wire [6:1] count;
reg [mantissa + 10:1] aaff;
wire [mantissa:1] absnode; wire [mantissa:1] absroundnode; reg [mantissa:1] absff;
wire [mantissa:1] fracout; reg [mantissa:1] fracoutff;  //signal exptopff : exptopfftype; 
reg [10:1] exptopff_1;
reg [10:1] exptopff_2;
reg [10:1] exptopff_3;  //signal expbotff : expbotfftype;
reg [10:1] expbotff_1;
reg [10:1] expbotff_2;
wire [24:1] roundoverflow;
reg roundoverflowff;
reg [3 + normspeed:1] satff; reg [3 + normspeed:1] zipff; reg [3 + normspeed:1] nanff;
reg [2 + 2 * normspeed:1] signff;
wire [mantissa:1] zeronumber;
reg [1 + normspeed:1] zeronumberff;
wire [10:1] preexpnode; wire [10:1] expnode;
reg [8:1] exponentff;
wire [23:1] mantissanode;
wire roundbit;
reg [23:1] mantissaroundff;
reg [23:1] mantissaff;
wire zeroexpnode; wire maxexpnode;
wire zeromantissanode; wire maxmantissanode; wire zeroexponentnode; wire maxexponentnode;
reg zeromantissaff; reg maxmantissaff; reg zeroexponentff; reg maxexponentff;  // debug section 

  genvar j;
  integer k;
  generate for (j=1; j <= mantissa - 1; j = j + 1) begin : gza 
      assign zerovec[j] = 1'b 0;
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaff <= {mantissa + 10{1'b 0}};

      absff <= {mantissa{1'b 0}};

      fracoutff <= {mantissa{1'b 0}};

      //FOR k IN 1 TO 3 LOOP
      exptopff_1 <= 10'b0;
      exptopff_2 <= 10'b0;
      exptopff_3 <= 10'b0;
      //END LOOP;
      roundoverflowff <= 1'b 0;
      satff <= {3 + normspeed{1'b 0}};
      zipff <= {3 + normspeed{1'b 0}};
      nanff <= {3 + normspeed{1'b 0}};
      signff <= {2 + 2 * normspeed{1'b 0}};
      zeronumberff <= {1 + normspeed{1'b 0}};

    end else begin : gzb
      if((enable == 1'b 1)) begin
        aaff <= aa;
        absff <= absnode + absroundnode;
        fracoutff <= fracout;
        exptopff_1[10:1] <= aaff[10:1];
        // add 4 because of maximum 4 bits wordgrowth in X mantissa
        exptopff_2[10:1] <= exptopff_1[10:1] + 10'b 0000000100;
        exptopff_3[10:1] <= exptopff_2[10:1] - ({4'b 0000,count}); 
        roundoverflowff <= roundoverflow[24];
        satff[1] <= aasat;
        for (k=2; k <= 3 + normspeed; k = k + 1) begin 
          satff[k] <= satff[k - 1];
        end
        zipff[1] <= aazip;
        for (k=2; k <= 3 + normspeed; k = k + 1) begin 
          zipff[k] <= zipff[k - 1];
        end
        nanff[1] <= aanan;
        for (k=2; k <= 3 + normspeed; k = k + 1) begin 
          nanff[k] <= nanff[k - 1];
        end
        signff[1] <= aaff[mantissa + 10];
        for (k=2; k <= 2 + 2 * normspeed; k = k + 1) begin 
          signff[k] <= signff[k - 1];
        end
        zeronumberff[1] <= ~((zeronumber[mantissa]));
        for (k=2; k <= 1 + normspeed; k = k + 1) begin 
          zeronumberff[k] <= zeronumberff[k - 1];
        end
      end
    end
  end

  // if normspeed = 1, latency = 5. if normspeed > 1, latency = 7
  generate if ((normspeed == 1)) begin : gsa
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        exponentff <= 8'b 00000000;
        for (k=1; k <= 23; k = k + 1) begin
          mantissaff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
          for (k=1; k <= 8; k = k + 1) begin
            exponentff[k] <= ((expnode[k] & ~((zeroexponentnode))) | maxexponentnode); 
          end
          for (k=1; k <= 23; k = k + 1) begin
            mantissaff[k] <= (mantissanode[k] &  ~((zeromantissanode))) | maxmantissanode; 
          end
        end
      end
    end

    assign preexpnode = exptopff_3[10:1];
  end
  endgenerate
  // if normspeed = 1, latency = 5. if normspeed > 1, latency = 7
  generate if ((normspeed == 2)) begin : gsb
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        expbotff_1[10:1] <= 10'b 0000000000;
        expbotff_2[10:1] <= 10'b 0000000000;
        exponentff <= 8'b 00000000;
        for (k=1; k <= 23; k = k + 1) begin
          mantissaroundff[k] <= 1'b 0;
          mantissaff[k] <= 1'b 0;
        end
        zeromantissaff <= 1'b 0;
        maxmantissaff <= 1'b 0;
        zeroexponentff <= 1'b 0;
        maxexponentff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          expbotff_1[10:1] <= exptopff_3[10:1];
          expbotff_2[10:1] <= expnode;
          for (k=1; k <= 8; k = k + 1) begin
            exponentff[k] <= ((expbotff_2[k] &  ~((zeroexponentff))) | maxexponentff);
          end
          mantissaroundff <= mantissanode;
          for (k=1; k <= 23; k = k + 1) begin
            mantissaff[k] <= (mantissaroundff[k] &  ~((zeromantissaff))) | maxmantissaff;
          end
          zeromantissaff <= zeromantissanode;
          maxmantissaff <= maxmantissanode;
          zeroexponentff <= zeroexponentnode;
          maxexponentff <= maxexponentnode;
        end
      end
    end

    assign preexpnode = expbotff_1[10:1];
  end
  endgenerate
  // round absolute value any way - need register on input of cntusgn

  generate for (j=1; j <= mantissa; j = j + 1) begin : gaa 
      assign absnode[j] = aaff[j + 10] ^ aaff[mantissa + 10];
  end
  endgenerate
  assign absroundnode = {zerovec[mantissa - 1:1],aaff[mantissa + 10]}; 
  assign zeronumber[1] = absff[1]; 
  generate for (j=2; j <= mantissa; j = j + 1) begin : gzma 
      assign zeronumber[j] = zeronumber[j - 1] | absff[j];
  end
  endgenerate
  hcc_normusgn3236 #(
      .mantissa(mantissa),
    .normspeed(normspeed))
  core(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .fracin(absff[mantissa:1]),
    .countout(count),
    .fracout(fracout));

  assign roundoverflow[1] = fracout[7];

  generate for (j=2; j <= 24; j = j + 1) begin : gna
      assign roundoverflow[j] = roundoverflow[j - 1] & fracout[j + 6]; 
  end
  endgenerate
  assign expnode = preexpnode[10:1] + ({9'b 000000000,roundoverflowff}); 
  // always round single output
  assign roundbit = (fracoutff[mantissa - 24] & fracoutff[mantissa - 25]) | (~((fracoutff[mantissa - 24])) & fracoutff[mantissa - 25]) & (fracoutff[mantissa - 26] | fracoutff[mantissa - 27] | fracoutff[mantissa - 28]);
  assign mantissanode = fracoutff[mantissa - 2:mantissa - 24] + ({zerovec[22:1],roundbit});
  //*** Check for special cases, apply to outputs ***
  assign zeroexpnode =  ~((expnode[9] | expnode[8] | expnode[7] | expnode[6] | expnode[5] | expnode[4] | expnode[3] | expnode[2] | expnode[1]));
  assign maxexpnode = expnode[8] & expnode[7] & expnode[6] & expnode[5] & expnode[4] & expnode[3] & expnode[2] & expnode[1];
  // '1' when true
  assign zeromantissanode = roundoverflowff | zeroexpnode | maxexpnode | expnode[9] | expnode[10] | zipff[3 + normspeed] | satff[3 + normspeed] | zeronumberff[1 + normspeed];
  assign maxmantissanode = nanff[3 + normspeed];
  assign zeroexponentnode = zeroexpnode | expnode[10] | zipff[3 + normspeed] | zeronumberff[1 + normspeed];
  assign maxexponentnode = maxexpnode | ((expnode[9] &  ~((expnode[10])))) | satff[3 + normspeed] | nanff[3 + normspeed];
  //*** OUTPUTS ***
  assign cc[32] = signff[2 + 2 * normspeed];
  assign cc[31:24] = exponentff;
  assign cc[23:1] = mantissaff[23:1];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_CASTFTOX.V                            ***
//***                                             ***
//***   Function: Cast IEEE754 Single to Internal ***
//***             Single                          ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***   06/02/08 - divider mantissa aa to aaff    ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_castftox(
sysclk,
reset,
enable,
aa,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] target=1;
parameter [31:0] roundconvert=1;
parameter [31:0] mantissa=32;
parameter [31:0] outputpipe=1;
// 0 no pipe, 1 output always registered
input sysclk;
input reset;
input enable;
input [32:1] aa;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [32:1] aa;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


wire [mantissa - 1:1] zerovec;
reg [32:1] aaff;
reg [mantissa + 10:1] ccff;
wire [mantissa:1] fracnode;
wire [mantissa:1] fractional;
wire [10:1] expnode;
wire [10:1] exponent;
wire expmaxnode;
wire mannonzeronode;
wire satnode;
wire zipnode;
wire nannode;
reg satff;
reg zipff;
reg nanff;

  // ieee754: sign (32), 8 exponent (31:24), 23 mantissa (23:1)
  // x format: (signx5,!sign,mantissa XOR sign, sign(xx.xx)), exponent(10:1) 
  // multiplier : (SIGN)('1')(23:1)sign(xx.xx), exponent(10:1) 
  // divider : "01"(23:1) (00..00),exponent(10:1) (lower mantissa bits ignored by fpdiv1x)
  genvar k;
  generate if (roundconvert == 1) begin : gza
	for (k=1; k <= mantissa - 1; k = k + 1) begin : gzb
		assign zerovec[k] = 1'b0;
	end
  end
  endgenerate

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
        aaff <= 32'b0;
    end else begin
      if((enable == 1'b 1)) begin
        aaff <= aa;
      end
    end
  end

  generate if (((target == 0 && outputpipe == 1) || (target == 1 && outputpipe == 1))) begin : gro
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin : grp
		   integer j;
        for (j=1; j <= mantissa + 10; j = j + 1) begin 
          ccff[j] <= 1'b 0;
        end
        satff <= 1'b 0;
        zipff <= 1'b 0;
        nanff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          ccff <= {fractional,exponent};
          satff <= satnode;
          zipff <= zipnode;
          nanff <= nannode;
        end
      end
    end

  end
  endgenerate
  // if exponent = 255 => saturate, if 0 => 0
  assign expmaxnode = aaff[31] & aaff[30] & aaff[29] & aaff[28] & aaff[27] & aaff[26] & aaff[25] & aaff[24];
  assign zipnode =  ~((aaff[31] | aaff[30] | aaff[29] | aaff[28] | aaff[27] | aaff[26] | aaff[25] | aaff[24]));
  assign mannonzeronode =  aaff[23] | aaff[22] | aaff[21] | aaff[20] | aaff[19] | aaff[18] | aaff[17] | aaff[16] |
  						  aaff[15] | aaff[14] | aaff[13] | aaff[12] | aaff[11] | aaff[10] | aaff[9] | aaff[8] |
  						  aaff[7] | aaff[6] | aaff[5] | aaff[4] | aaff[3] | aaff[2] | aaff[1];

  assign satnode = expmaxnode &  ~((mannonzeronode));
  assign nannode = expmaxnode & mannonzeronode;

  generate for (k=1; k <= 8; k = k + 1) begin : gexpa
      assign expnode[k] = ((aaff[k + 23] | expmaxnode)) &  ~((zipnode));
  end
  endgenerate
  assign expnode[9] = 1'b 0;
  assign expnode[10] = 1'b 0;
  //*** internal format ***
  generate if ((target == 0)) begin : gxa
      assign fracnode[mantissa] = aaff[32];
    assign fracnode[mantissa - 1] = aaff[32];
    assign fracnode[mantissa - 2] = aaff[32];
    assign fracnode[mantissa - 3] = aaff[32];
    assign fracnode[mantissa - 4] = aaff[32];
    assign fracnode[mantissa - 5] =  ~((aaff[32]));
    // '1' XOR sign
    for (k=1; k <= 23; k = k + 1) begin : gxb
          assign fracnode[mantissa - 29 + k] = (aaff[k] ^ aaff[32]); 
    end

    for (k=1; k <= mantissa - 29; k = k + 1) begin : gxc 
          assign fracnode[k] = aaff[32];
            // '0' XOR sign
    end

    if ((roundconvert == 0)) begin : gxd
          assign fractional = fracnode;
    end

    if ((roundconvert == 1)) begin : gxe
          assign fractional = fracnode + ({zerovec[mantissa - 1],aaff[32]}); 
    end

    assign exponent = expnode;
  end
  endgenerate
  //*** direct to multiplier ***
  generate if ((target == 1)) begin : gma
      assign fracnode[mantissa] = aaff[32];
    assign fracnode[mantissa - 1] =  ~((aaff[32]));
    // '1' XOR sign
    for (k=1; k <= 23; k = k + 1) begin : gmb
          assign fracnode[mantissa - 25 + k] = (aaff[k] ^ aaff[32]); 
    end

    for (k=1; k <= mantissa - 25; k = k + 1) begin : gmc 
          assign fracnode[k] = aaff[32];
            // '0' XOR sign
    end

    if ((roundconvert == 0)) begin : gmd
          assign fractional = fracnode;
    end

    if ((roundconvert == 1)) begin : gme
          assign fractional = fracnode + ({zerovec[mantissa - 1],aaff[32]}); 
    end

    //***??? adjust ???
    assign exponent = expnode;
  end
  endgenerate
  // never register output
  //*** direct to divider ***
  generate if ((target == 2)) begin : gda
      assign fracnode[mantissa] = aaff[32];
    assign fracnode[mantissa - 1] = 1'b 1;
    assign fracnode[mantissa - 2:mantissa - 24] = aaff[23:1];
    for (k=1; k <= mantissa - 25; k = k + 1) begin : gdb 
          assign fracnode[k] = 1'b 0;
    end

    assign fractional = fracnode;
    //***??? adjust ???
    assign exponent = expnode;
  end
  endgenerate
  //*** OUTPUTS ***
  generate if (((target == 0 && outputpipe == 1) || (target == 1 && outputpipe == 1))) begin : goa
      assign cc = ccff;
    assign ccsat = satff;
    assign cczip = zipff;
    assign ccnan = nanff;
  end
  endgenerate
  generate if (((target == 0 && outputpipe == 0) || (target == 1 && outputpipe == 0) || (target == 2))) begin : gob
      assign cc = {fractional,exponent};
    assign ccsat = satnode;
    assign cczip = zipnode;
    assign ccnan = nannode;
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_RSFTCOMB36.V                          ***
//***                                             ***
//***   Function: Combinatorial arithmetic right  ***
//***             shift for a 36 bit number       ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_rsftcomb36(
inbus,
shift,
outbus
);

input [36:1] inbus;
input [6:1] shift;
output [36:1] outbus;

wire [36:1] inbus;
wire [6:1] shift;
wire [36:1] outbus;


wire [36:1] levzip; wire [36:1] levone; wire [36:1] levtwo; wire [36:1] levthr; 

  assign levzip = inbus;
  // shift by 0,1,2,3
  genvar k;
  generate for (k=1; k <= 33; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k + 1] &  ~((shift[2])) & shift[1])) | ((levzip[k + 2] & shift[2] &  ~((shift[1])))) | ((levzip[k + 3] & shift[2] & shift[1]));
  end
  endgenerate
  assign levone[34] = ((levzip[34] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[35] &  ~((shift[2])) & shift[1])) | ((levzip[36] & shift[2]));
  assign levone[35] = ((levzip[35] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[36] & ((((shift[2])) | shift[1]))));
  assign levone[36] = levzip[36];
  // shift by 0,4,8,12

  generate for (k=1; k <= 24; k = k + 1) begin : gba
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[k + 12] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=25; k <= 28; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[36] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=29; k <= 32; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[36] & shift[4]));
  end
  endgenerate

  generate for (k=33; k <= 35; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[36] & ((shift[4] | shift[3]))));
  end
  endgenerate
  assign levtwo[36] = levone[36];

  generate for (k=1; k <= 4; k = k + 1) begin : gca
      assign levthr[k] = ((levtwo[k] &  ~((shift[6])) &  ~((shift[5])))) | ((levtwo[k + 16] &  ~((shift[6])) & shift[5])) | ((levtwo[k + 32] & shift[6]));
  end
  endgenerate

  generate for (k=5; k <= 20; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwo[k] &  ~((shift[6])) &  ~((shift[5])))) | ((levtwo[k + 16] &  ~((shift[6])) & shift[5])) | ((levtwo[36] & shift[6]));
  end
  endgenerate

  generate for (k=21; k <= 35; k = k + 1) begin : gcc
      assign levthr[k] = ((levtwo[k] &  ~((shift[6])) &  ~((shift[5])))) | ((levtwo[36] & ((shift[6] | shift[5]))));
  end
  endgenerate
  assign levthr[36] = levtwo[36];
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_RSFTCOMB32.V                          ***
//***                                             ***
//***   Function: Combinatorial arithmetic right  ***
//***             shift for a 32 bit number       ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_rsftcomb32(
inbus,
shift,
outbus
);

input [32:1] inbus;
input [5:1] shift;
output [32:1] outbus;

wire [32:1] inbus;
wire [5:1] shift;
wire [32:1] outbus;


wire [32:1] levzip; wire [32:1] levone; wire [32:1] levtwo; wire [32:1] levthr; 

  assign levzip = inbus;
  // shift by 0,1,2,3
  genvar k;
  generate for (k=1; k <= 29; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k + 1] &  ~((shift[2])) & shift[1])) | ((levzip[k + 2] & shift[2] &  ~((shift[1])))) | ((levzip[k + 3] & shift[2] & shift[1]));
  end
  endgenerate
  assign levone[30] = ((levzip[30] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[31] &  ~((shift[2])) & shift[1])) | ((levzip[32] & shift[2]));
  assign levone[31] = ((levzip[31] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[32] & ((((shift[2])) | shift[1]))));
  assign levone[32] = levzip[32];
  // shift by 0,4,8,12

  generate for (k=1; k <= 20; k = k + 1) begin : gba
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[k + 12] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=21; k <= 24; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[32] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=25; k <= 28; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[32] & shift[4]));
  end
  endgenerate

  generate for (k=29; k <= 31; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[32] & ((shift[4] | shift[3]))));
  end
  endgenerate
  assign levtwo[32] = levone[32];

  generate for (k=1; k <= 16; k = k + 1) begin : gca
      assign levthr[k] = ((levtwo[k] &  ~((shift[5])))) | ((levtwo[k + 16] & shift[5]));
  end
  endgenerate

  generate for (k=17; k <= 31; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwo[k] &  ~((shift[5])))) | ((levtwo[32] & shift[5]));
  end
  endgenerate
  assign levthr[32] = levtwo[32];
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_RSFTPIPE36.V                          ***
//***                                             ***
//***   Function: Pipelined arithmetic right      ***
//***             shift for a 36 bit number       ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_rsftpipe36(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [36:1] inbus;
input [6:1] shift;
output [36:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [36:1] inbus;
wire [6:1] shift;
wire [36:1] outbus;


wire [36:1] levzip; wire [36:1] levone; wire [36:1] levtwo; wire [36:1] levthr; 
reg [2:1] shiftff;
reg [36:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  genvar k;
  generate for (k=1; k <= 33; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k + 1] &  ~((shift[2])) & shift[1])) | ((levzip[k + 2] & shift[2] &  ~((shift[1])))) | ((levzip[k + 3] & shift[2] & shift[1]));
  end
  endgenerate
  assign levone[34] = ((levzip[34] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[35] &  ~((shift[2])) & shift[1])) | ((levzip[36] & shift[2]));
  assign levone[35] = ((levzip[35] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[36] & ((((shift[2])) | shift[1]))));
  assign levone[36] = levzip[36];
  // shift by 0,4,8,12

  generate for (k=1; k <= 24; k = k + 1) begin : gba
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[k + 12] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=25; k <= 28; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[36] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=29; k <= 32; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[36] & shift[4]));
  end
  endgenerate

  generate for (k=33; k <= 35; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[36] & ((shift[4] | shift[3]))));
  end
  endgenerate
  assign levtwo[36] = levone[36];
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      shiftff <= 2'b 00;
      levtwoff <= 36'b0;
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[6:5];
        levtwoff <= levtwo;
      end
    end
  end


  generate for (k=1; k <= 4; k = k + 1) begin : gca
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[k + 16] &  ~((shiftff[2])) & shiftff[1])) | ((levtwoff[k + 32] & shiftff[2]));
  end
  endgenerate

  generate for (k=5; k <= 20; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[k + 16] &  ~((shiftff[2])) & shiftff[1])) | ((levtwoff[36] & shiftff[2]));
  end
  endgenerate

  generate for (k=21; k <= 35; k = k + 1) begin : gcc
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[36] & ((shiftff[2] | shiftff[1]))));
  end
  endgenerate
  assign levthr[36] = levtwoff[36];
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_RSFTPIPE32.V                          ***
//***                                             ***
//***   Function: Pipelined arithmetic right      ***
//***             shift for a 32 bit number       ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_rsftpipe32(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [32:1] inbus;
input [5:1] shift;
output [32:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [32:1] inbus;
wire [5:1] shift;
wire [32:1] outbus;


wire [32:1] levzip; wire [32:1] levone; wire [32:1] levtwo; wire [32:1] levthr; 
reg shiftff;
reg [32:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  genvar k;
  generate for (k=1; k <= 29; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k + 1] &  ~((shift[2])) & shift[1])) | ((levzip[k + 2] & shift[2] &  ~((shift[1])))) | ((levzip[k + 3] & shift[2] & shift[1]));
  end
  endgenerate
  assign levone[30] = ((levzip[30] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[31] &  ~((shift[2])) & shift[1])) | ((levzip[32] & shift[2]));
  assign levone[31] = ((levzip[31] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[32] & ((((shift[2])) | shift[1]))));
  assign levone[32] = levzip[32];
  // shift by 0,4,8,12

  generate for (k=1; k <= 20; k = k + 1) begin : gba
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[k + 12] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=21; k <= 24; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[32] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=25; k <= 28; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[32] & shift[4]));
  end
  endgenerate

  generate for (k=29; k <= 31; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[32] & ((shift[4] | shift[3]))));
  end
  endgenerate
  assign levtwo[32] = levone[32];
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      shiftff <= 1'b 0;
      levtwoff <= 32'b0;
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[5];
        levtwoff <= levtwo;
      end
    end
  end


  generate for (k=1; k <= 16; k = k + 1) begin : gca
      assign levthr[k] = (levtwoff[k] &  ~((shiftff))) | ((levtwoff[k + 16] & shiftff));
  end
  endgenerate

  generate for (k=17; k <= 31; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff)))) | ((levtwoff[32] & shiftff));
  end
  endgenerate

  assign levthr[32] = levtwoff[32];
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_ALUFP1_DOT.V                          ***
//***                                             ***
//***   Function: Single Precision Floating Point ***
//***             Adder                           ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_alufp1_dot(
sysclk,
reset,
enable,
addsub,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] shiftspeed=0;
parameter [31:0] outputpipe=1;
input sysclk;
input reset;
input enable;
input addsub;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
input [mantissa + 10:1] bb;
input bbsat, bbzip, bbnan;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire addsub;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


//type expbasefftype IS ARRAY (3+shiftspeed DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1);
//type aluleftdelfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (mantissa DOWNTO 1);
wire [mantissa - 1:1] zerovec;
reg aasignff; reg bbsignff;
reg [mantissa:1] aamantissaff; reg [mantissa:1] bbmantissaff;
reg [10:1] aaexponentff; reg [10:1] bbexponentff;
reg aasatff; reg aazipff; reg bbsatff; reg bbzipff;
reg aananff; reg bbnanff; reg addsubff;
wire aasignnode; wire bbsignnode;
wire [mantissa:1] aamantissanode; wire [mantissa:1] bbmantissanode;
wire [10:1] aaexponentnode; wire [10:1] bbexponentnode;
wire aasatnode; wire aazipnode; wire bbsatnode; wire bbzipnode; wire aanannode; wire bbnannode; wire addsubnode;
reg [mantissa:1] mantissaleftff; reg [mantissa:1] mantissarightff; reg [mantissa:1] mantissaleftdelayff;
reg [10:1] exponentshiftff;
reg [10:1] exponentbaseff [(3 + shiftspeed):1];
reg [2 + shiftspeed:1] invertleftff; reg [2 + shiftspeed:1] invertrightff;
reg shiftcheckff; reg shiftcheckdelayff;
reg [mantissa:1] aluleftff; reg [mantissa:1] alurightff; reg [mantissa:1] aluff;
reg [3 + shiftspeed:1] ccsatff; reg [3 + shiftspeed:1] cczipff; reg [3 + shiftspeed:1] ccnanff;
wire [mantissa:1] mantissaleftnode;
wire zeroaluright;
wire [mantissa:1] aluleftnode; wire [mantissa:1] alurightnode;
wire alucarrybitnode;
wire [10:1] subexponentone; wire [10:1] subexponenttwo;
wire switch;
wire [10:1] shiftcheck;
wire shiftcheckbit;
wire [mantissa:1] shiftbusnode;  //signal expbaseff : expbasefftype;
// debug section

  integer k;
  genvar j;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aasignff <= 1'b 0;
      bbsignff <= 1'b 0;
      for (k=1; k <= mantissa; k = k + 1) begin
        aamantissaff[k] <= 1'b 0;
        bbmantissaff[k] <= 1'b 0;
      end
      for (k=1; k <= 10; k = k + 1) begin
        aaexponentff[k] <= 1'b 0;
        bbexponentff[k] <= 1'b 0;
      end
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      addsubff <= 1'b 0;
    end else begin
      k=0;
      if((enable == 1'b 1)) begin
        //*** LEVEL 1 ***
        aasignff <= aa[mantissa+10];
        bbsignff <= bb[mantissa+10];
        aamantissaff <= {1'b 0,aa[mantissa+9:11]};
        bbmantissaff <= {1'b 0,bb[mantissa+9:11]};
        aaexponentff <= aa[10:1];
        bbexponentff <= bb[10:1];
        aasatff <= aasat;
        bbsatff <= bbsat;
        aazipff <= aazip;
        bbzipff <= bbzip;
        aananff <= aanan;
        bbnanff <= bbnan;
        addsubff <= addsub;
      end
    end
  end

        //*** LEVEL 2 ***
  generate if ((outputpipe == 1)) begin : gina
        assign aasignnode = aasignff;
        assign bbsignnode = bbsignff;
        assign aamantissanode = aamantissaff;
        assign bbmantissanode = bbmantissaff;
        assign aaexponentnode = aaexponentff;
        assign bbexponentnode = bbexponentff;
        assign aasatnode = aasatff;
        assign bbsatnode = bbsatff;
        assign aazipnode = aazipff;
        assign bbzipnode = bbzipff;
        assign aanannode = aananff;
        assign bbnannode = bbnanff;
        assign addsubnode = addsubff;
    end
  endgenerate

  generate if ((outputpipe == 0)) begin : ginb
        assign aasignnode = aa[mantissa+10];
        assign bbsignnode = bb[mantissa+10];
        assign aamantissanode = {1'b 0,aa[mantissa+9:11]};
        assign bbmantissanode = {1'b 0,bb[mantissa+9:11]};
        assign aaexponentnode = aa[10:1];
        assign bbexponentnode = bb[10:1];
        assign aasatnode = aasat;
        assign bbsatnode = bbsat;
        assign aazipnode = aazip;
        assign bbzipnode = bbzip;
        assign aanannode = aanan;
        assign bbnannode = bbnan;
        assign addsubnode = addsub;
    end
  endgenerate

      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 2+shiftspeed; k = k + 1) begin
          invertleftff[k] <= 1'b 0;
          invertrightff[k] <= 1'b 0;
        end
        for (k=1; k <= mantissa; k = k + 1) begin
          mantissaleftff[k] <= 1'b 0;
          mantissarightff[k] <= 1'b 0;
          mantissaleftdelayff[k] <= 1'b 0;
          aluleftff[k] <= 1'b 0;
          alurightff[k] <= 1'b 0;
          aluff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin
          exponentshiftff[k] <= 1'b 0;
        end
        for (k=1; k <= 3; k = k + 1) begin
          exponentbaseff[k] <= 10'b 0;
        end
        shiftcheckff <= 1'b 0;
        shiftcheckdelayff <= 1'b 0;
        for (k=1; k <= 3+shiftspeed; k = k + 1) begin
          ccsatff[k] <= 1'b 0;
          cczipff[k] <= 1'b 0;
          ccnanff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
        for (k=1; k <= mantissa; k = k + 1) begin
          mantissaleftff[k] <= (aamantissanode[k] & ~((switch))) | (bbmantissanode[k] & (switch));
          mantissarightff[k] <= (bbmantissanode[k] & ~((switch))) | (aamantissanode[k] & (switch));
        end
        mantissaleftdelayff <= mantissaleftff;
        for (k=1; k <= 10; k = k + 1) begin
          exponentshiftff[k] <= (subexponentone[k] & ~((switch))) | (subexponenttwo[k] & (switch));
          exponentbaseff[1][k] <= (aaexponentnode[k] & ~((switch))) | (bbexponentnode[k] & (switch));
        end
        for (k=2; k <= 3 + shiftspeed; k = k + 1) begin
          exponentbaseff[k][10:1] <= exponentbaseff[k-1][10:1];
        end
        invertleftff[1] <= (aasignnode & (~((switch)))) | (bbsignnode & switch) ^ (addsubnode & switch);
        invertrightff[1] <= (bbsignnode & (~((switch)))) | (aasignnode & switch) ^ (addsubnode & switch);
        for (k=2; k <= 2 + shiftspeed; k = k + 1) begin
          invertleftff[k] <= invertleftff[k - 1];
          invertrightff[k] <= invertrightff[k - 1];
        end
        shiftcheckff <= shiftcheckbit;
        shiftcheckdelayff <= shiftcheckff;
        aluleftff <= mantissaleftnode;
        alurightff <= shiftbusnode;
        aluff <= aluleftnode + alurightnode + alucarrybitnode;

        ccsatff[1] <= aasatnode | bbsatnode;
        cczipff[1] <= aazipnode & bbzipnode;
        ccnanff[1] <= aanannode | bbnannode | aasatnode | bbsatnode;
        for (k=2; k <= 3 + shiftspeed; k = k + 1) begin
          ccsatff[k] <= ccsatff[k - 1];
          cczipff[k] <= cczipff[k - 1];
          ccnanff[k] <= ccnanff[k - 1];
        end
      end
    end
  end

  generate if ((shiftspeed == 0)) begin : gmsa
    assign mantissaleftnode = mantissaleftff;
    assign zeroaluright = shiftcheckff;
  end
  endgenerate

  generate if ((shiftspeed == 1)) begin : gmsb
    assign mantissaleftnode = mantissaleftdelayff;
    assign zeroaluright = shiftcheckdelayff;
  end
  endgenerate

  generate for (j=1; j <= mantissa; j = j + 1) begin : gma
    assign aluleftnode[j] = aluleftff[j] ^ invertleftff[2+shiftspeed];
    assign alurightnode[j] = (alurightff[j] ^ invertrightff[2+shiftspeed]) & ~((zeroaluright));
  end
  endgenerate

  assign alucarrybitnode = invertleftff[2+shiftspeed];
  assign subexponentone = aaexponentnode[10:1] - bbexponentnode[10:1];
  assign subexponenttwo = bbexponentnode[10:1] - aaexponentnode[10:1];
  assign switch = subexponentone[10];

  generate if ((mantissa == 32)) begin : gsa
      assign shiftcheck = 10'b 0000000000;
      assign shiftcheckbit = exponentshiftff[10] | exponentshiftff[9] | exponentshiftff[8] | exponentshiftff[7] | exponentshiftff[6];
    // 31 ok, 32 not
    if ((shiftspeed == 0)) begin
          hcc_rsftcomb32 shiftone(
              .inbus(mantissarightff),
        .shift(exponentshiftff[5:1]),
        .outbus(shiftbusnode));

    end
    if ((shiftspeed == 1)) begin
          hcc_rsftpipe32 shifttwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(mantissarightff),
        .shift(exponentshiftff[5:1]),
        .outbus(shiftbusnode));

    end
  end
  endgenerate
  generate if ((mantissa == 36)) begin : gsd
      assign shiftcheck = exponentshiftff - 10'b 0000100100;
      assign shiftcheckbit = ~((shiftcheck[10]));

    if ((shiftspeed == 0)) begin
          hcc_rsftcomb36 shiftone(
              .inbus(mantissarightff),
        .shift(exponentshiftff[6:1]),
        .outbus(shiftbusnode));

    end
    if ((shiftspeed == 1)) begin
          hcc_rsftpipe36 shifttwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(mantissarightff),
        .shift(exponentshiftff[6:1]),
        .outbus(shiftbusnode));

    end
  end
  endgenerate
  //*** OUTPUT ***
  assign cc = {aluff,exponentbaseff[(3 + shiftspeed)][10:1]}; 
  assign ccsat = ccsatff[3 + shiftspeed];
  assign cczip = cczipff[3 + shiftspeed];
  assign ccnan = ccnanff[3 + shiftspeed];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_ALUFP1X.V                             ***
//***                                             ***
//***   Function: Single Precision Floating Point ***
//***             Adder                           ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_alufp1x(
sysclk,
reset,
enable,
addsub,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] shiftspeed=0;
parameter [31:0] outputpipe=1;
input sysclk;
input reset;
input enable;
input addsub;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
input [mantissa + 10:1] bb;
input bbsat, bbzip, bbnan;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire addsub;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


//type expbasefftype IS ARRAY (3+shiftspeed DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1);
//type aluleftdelfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (mantissa DOWNTO 1);
wire [mantissa - 1:1] zerovec;
reg [mantissa + 10:1] aaff; reg [mantissa + 10:1] bbff;
reg aasatff; reg aazipff; reg bbsatff; reg bbzipff;
reg aananff; reg bbnanff; reg addsubff;
wire [mantissa+10:1] aanode; wire [mantissa+10:1] bbnode;
wire aasatnode; wire aazipnode; wire bbsatnode; wire bbzipnode; wire aanannode; wire bbnannode; wire addsubnode;
reg [3 + shiftspeed:1] addsubctlff;
reg [mantissa:1] mantissaleftff; reg [mantissa:1] mantissarightff; reg [mantissa:1] mantissaleftdelayff;
reg [10:1] exponentshiftff;
reg [10:1] exponentbaseff [(3 + shiftspeed):1];
reg [2 + shiftspeed:1] invertleftff; reg [2 + shiftspeed:1] invertrightff;
reg shiftcheckff; reg shiftcheckdelayff;
reg [mantissa:1] aluleftff; reg [mantissa:1] alurightff; reg [mantissa:1] aluff;
reg [3 + shiftspeed:1] ccsatff; reg [3 + shiftspeed:1] cczipff; reg [3 + shiftspeed:1] ccnanff;
wire [mantissa:1] mantissaleftnode;
wire zeroaluright;
wire [mantissa:1] aluleftnode; wire [mantissa:1] alurightnode;
wire alucarrybitnode;
wire [10:1] subexponentone; wire [10:1] subexponenttwo;
wire switch;
wire [10:1] shiftcheck;
wire shiftcheckbit;
wire [mantissa:1] shiftbusnode;  //signal expbaseff : expbasefftype;

  integer k;
  genvar j;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      for (k=1; k <= mantissa + 10; k = k + 1) begin
        aaff[k] <= 1'b 0;
        bbff[k] <= 1'b 0;
      end
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      addsubff <= 1'b 0;
    end else begin
      k=0;
      if((enable == 1'b 1)) begin
        //*** LEVEL 1 ***
        aaff <= aa;
        bbff <= bb;
        aasatff <= aasat;
        bbsatff <= bbsat;
        aazipff <= aazip;
        bbzipff <= bbzip;
        aananff <= aanan;
        bbnanff <= bbnan;
        addsubff <= addsub;
      end
    end
  end

        //*** LEVEL 2 ***
  generate if ((outputpipe == 1)) begin : gina
        assign aanode = aaff;
        assign bbnode = bbff;
        assign aasatnode = aasatff;
        assign bbsatnode = bbsatff;
        assign aazipnode = aazipff;
        assign bbzipnode = bbzipff;
        assign aanannode = aananff;
        assign bbnannode = bbnanff;
        assign addsubnode = addsubff;
    end
  endgenerate

  generate if ((outputpipe == 0)) begin : ginb
        assign aanode = aa;
        assign bbnode = bb;
        assign aasatnode = aasat;
        assign bbsatnode = bbsat;
        assign aazipnode = aazip;
        assign bbzipnode = bbzip;
        assign aanannode = aanan;
        assign bbnannode = bbnan;
        assign addsubnode = addsub;
    end
  endgenerate

      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= 2+shiftspeed; k = k + 1) begin
          addsubctlff[k] <= 1'b 0;
          invertleftff[k] <= 1'b 0;
          invertrightff[k] <= 1'b 0;
        end
        for (k=1; k <= mantissa; k = k + 1) begin
          mantissaleftff[k] <= 1'b 0;
          mantissarightff[k] <= 1'b 0;
          mantissaleftdelayff[k] <= 1'b 0;
          aluleftff[k] <= 1'b 0;
          alurightff[k] <= 1'b 0;
          aluff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin
          exponentshiftff[k] <= 1'b 0;
        end
        for (k=1; k <= 3; k = k + 1) begin
          exponentbaseff[k] <= 10'b 0;
        end
        shiftcheckff <= 1'b 0;
        shiftcheckdelayff <= 1'b 0;
        for (k=1; k <= 3+shiftspeed; k = k + 1) begin
          ccsatff[k] <= 1'b 0;
          cczipff[k] <= 1'b 0;
          ccnanff[k] <= 1'b 0;
        end
      end else begin
        if((enable == 1'b 1)) begin
        addsubctlff[1] <= addsubnode;
        for (k=2; k <= 2+shiftspeed; k = k + 1) begin
          addsubctlff[k] <= addsubctlff[k - 1]; 
        end
        for (k=1; k <= mantissa; k = k + 1) begin
          mantissaleftff[k] <= (aanode[k + 10] & ~((switch))) | (bbnode[k + 10] & (switch));
          mantissarightff[k] <= (bbnode[k + 10] & ~((switch))) | (aanode[k + 10] & (switch));
        end
        mantissaleftdelayff <= mantissaleftff;
        for (k=1; k <= 10; k = k + 1) begin
          exponentshiftff[k] <= (subexponentone[k] & ~((switch))) | (subexponenttwo[k] & (switch));
          exponentbaseff[1][k] <= (aanode[k] & ~((switch))) | (bbnode[k] & (switch));
        end
        for (k=2; k <= 3 + shiftspeed; k = k + 1) begin
          exponentbaseff[k][10:1] <= exponentbaseff[k-1][10:1];
        end
        invertleftff[1] <= addsubnode & switch;
        invertrightff[1] <= addsubnode &  ~((switch));
        for (k=2; k <= 2 + shiftspeed; k = k + 1) begin
          invertleftff[k] <= invertleftff[k - 1];
          invertrightff[k] <= invertrightff[k - 1];
        end
        shiftcheckff <= shiftcheckbit;
        shiftcheckdelayff <= shiftcheckff;
        aluleftff <= mantissaleftnode;
        alurightff <= shiftbusnode;
        aluff <= aluleftnode + alurightnode + alucarrybitnode;

        ccsatff[1] <= aasatnode | bbsatnode;
        cczipff[1] <= aazipnode & bbzipnode;
        ccnanff[1] <= aanannode | bbnannode | aasatnode | bbsatnode;
        for (k=2; k <= 3 + shiftspeed; k = k + 1) begin
          ccsatff[k] <= ccsatff[k - 1];
          cczipff[k] <= cczipff[k - 1];
          ccnanff[k] <= ccnanff[k - 1];
        end
      end
    end
  end

  generate if ((shiftspeed == 0)) begin : gmsa
    assign mantissaleftnode = mantissaleftff;
    assign zeroaluright = shiftcheckff;
  end
  endgenerate

  generate if ((shiftspeed == 1)) begin : gmsb
    assign mantissaleftnode = mantissaleftdelayff;
    assign zeroaluright = shiftcheckdelayff;
  end
  endgenerate

  generate for (j=1; j <= mantissa; j = j + 1) begin : gma
    assign aluleftnode[j] = aluleftff[j] ^ invertleftff[2+shiftspeed];
    assign alurightnode[j] = (alurightff[j] ^ invertrightff[2+shiftspeed]) & ~((zeroaluright));
  end
  endgenerate

  assign alucarrybitnode = addsubctlff[2+shiftspeed];
  assign subexponentone = aanode[10:1] - bbnode[10:1];
  assign subexponenttwo = bbnode[10:1] - aanode[10:1];
  assign switch = subexponentone[10];

  generate if ((mantissa == 32)) begin : gsa
      assign shiftcheck = 10'b 0000000000;
      assign shiftcheckbit = exponentshiftff[10] | exponentshiftff[9] | exponentshiftff[8] | exponentshiftff[7] | exponentshiftff[6];
    // 31 ok, 32 not
    if ((shiftspeed == 0)) begin
          hcc_rsftcomb32 shiftone(
              .inbus(mantissarightff),
        .shift(exponentshiftff[5:1]),
        .outbus(shiftbusnode));

    end
    if ((shiftspeed == 1)) begin
          hcc_rsftpipe32 shifttwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(mantissarightff),
        .shift(exponentshiftff[5:1]),
        .outbus(shiftbusnode));

    end
  end
  endgenerate
  generate if ((mantissa == 36)) begin : gsd
      assign shiftcheck = exponentshiftff - 10'b 0000100100;
      assign shiftcheckbit = ~((shiftcheck[10]));

    if ((shiftspeed == 0)) begin
          hcc_rsftcomb36 shiftone(
              .inbus(mantissarightff),
        .shift(exponentshiftff[6:1]),
        .outbus(shiftbusnode));

    end
    if ((shiftspeed == 1)) begin
          hcc_rsftpipe36 shifttwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .inbus(mantissarightff),
        .shift(exponentshiftff[6:1]),
        .outbus(shiftbusnode));

    end
  end
  endgenerate
  //*** OUTPUT ***
  assign cc = {aluff,exponentbaseff[(3 + shiftspeed)][10:1]}; 
  assign ccsat = ccsatff[3 + shiftspeed];
  assign cczip = cczipff[3 + shiftspeed];
  assign ccnan = ccnanff[3 + shiftspeed];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULFPPN3236.V                         ***
//***                                             ***
//***   Function: Single precision multiplier     ***
//***             core function, with post-norm   ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mulfppn3236(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] synthesize=0;
input sysclk;
input reset;
input enable;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
input [mantissa + 10:1] bb;
input bbsat, bbzip, bbnan;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


parameter normtype = 0;  //type expfftype IS ARRAY (3 DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1);
wire [mantissa:1] aaman; wire [mantissa:1] bbman;
wire [10:1] aaexp; wire [10:1] bbexp;
wire [2 * mantissa:1] mulout;
reg [mantissa:1] aamanff; reg [mantissa:1] bbmanff;
reg [mantissa:1] manoutff;
reg [10:1] aaexpff; reg [10:1] bbexpff;  //signal expff : expfftype; 
reg [10:1] expff_1;
reg [10:1] expff_2;
reg [10:1] expff_3;
reg aasatff; reg aazipff; reg aananff; reg bbsatff; reg bbzipff; reg bbnanff;
reg [3:1] ccsatff; reg [3:1] cczipff; reg [3:1] ccnanff;
wire [4:1] aapos; wire [4:1] aaneg; wire [4:1] bbpos; wire [4:1] bbneg;
reg [4:1] aanumff; reg [4:1] bbnumff;
wire [3:1] selnode;
wire [4:1] sel; reg [4:1] selff;
reg [4:1] expadjff;
wire [10:1] expadjnode;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // normalization or scale turns it into
  // [S ][1 ][M...M][U..U]
  // [32][31][30..8][7..1]
  // multiplier outputs (result < 2)
  // [S....S][1 ][M*M...][U*U]
  // [64..62][61][60..15][14....1]
  // multiplier outputs (result >= 2)
  // [S....S][1 ][M*M...][U*U.....]
  // [64..63][62][61..16][15.....1]
  // assume that result > 2
  // if output likely in [62..59] shift 0, if in [58..55] shift 4, 
  // if in [54..51] shift 8, else shift 12 (adjust exponent accordingly) 
  assign aaman = aa[mantissa + 10:11];
  assign bbman = bb[mantissa + 10:11];
  assign aaexp = aa[10:1];
  assign bbexp = bb[10:1];
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aamanff <= {mantissa{1'b 0}};
      bbmanff <= {mantissa{1'b 0}};
      aaexpff <= 10'b 0000000000;
      bbexpff <= 10'b 0000000000;
      expff_1[10:1] <= 10'b 0000000000;
      expff_2[10:1] <= 10'b 0000000000;
      expff_3[10:1] <= 10'b 0000000000;
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      bbsatff <= 1'b 0;
      bbzipff <= 1'b 0;
      bbnanff <= 1'b 0;
      ccsatff <= 3'b 000;
      cczipff <= 3'b 000;
      ccnanff <= 3'b 000;
      aanumff <= 4'b 0000;
      bbnumff <= 4'b 0000;
      selff <= 4'b 0000;
      expadjff <= 4'b 0000;
      manoutff <= {mantissa{1'b 0}};
    end else begin : gza
	  integer k;
      if((enable == 1'b 1)) begin
        aamanff <= aaman;
        bbmanff <= bbman;
        aasatff <= aasat;
        aazipff <= aazip;
        aananff <= aanan;
        bbsatff <= bbsat;
        bbzipff <= bbzip;
        bbnanff <= bbnan;
        ccsatff[1] <= aasatff | bbsatff;
        ccsatff[2] <= ccsatff[1];
        ccsatff[3] <= ccsatff[2];
        cczipff[1] <= aazipff | bbzipff;
        cczipff[2] <= cczipff[1];
        cczipff[3] <= cczipff[2];
        ccnanff[1] <= aananff | bbnanff | (aazipff & bbsatff) | (bbzipff & aasatff);
        ccnanff[2] <= ccnanff[1];
        ccnanff[3] <= ccnanff[2];

        aaexpff <= aaexp;
        bbexpff <= bbexp;
        expff_1[10:1] <= aaexpff + bbexpff - 10'b 0001111111;
        for (k=1; k <= 10; k = k + 1) begin
          expff_2[k] <= ((expff_1[k] | ccsatff[1])) &  ~((cczipff[1]));
        end
        expff_3[10:1] <= expff_2[10:1] + expadjnode;
        for (k=1; k <= 4; k = k + 1) begin
          aanumff[k] <= ((aapos[k] &  ~((aa[32])))) | ((aaneg[k] & aa[32])); 
          bbnumff[k] <= ((bbpos[k] &  ~((bb[32])))) | ((bbneg[k] & bb[32])); 
        end
        selff <= sel;
        // "0" when sel(1), "4" when sel(2), "8" when sel(3), "12" when sel(4)
        // don't adjust during a saturate or zero condition
        expadjff[2:1] <= 2'b 00;
        expadjff[3] <= ((sel[2] | sel[4])) &  ~((ccsatff[1] | cczipff[1]));
        expadjff[4] <= ((sel[3] | sel[4])) &  ~((ccsatff[1] | cczipff[1]));
        // output left shift
        // mulpipe is [64..1], 44 bit output is in [62..19] for 32 bit 
        // mulpipe is [72..1], 44 bit output is in [70..27] for 36 bits
        for (k=mantissa; k >= 1; k = k - 1) begin
          manoutff[k] <= ((mulout[k + mantissa - 2] & selff[1])) | ((mulout[k + mantissa - 6] & selff[2])) | ((mulout[k + mantissa - 10] & selff[3])) | ((mulout[k + mantissa - 14] & selff[4]));
        end
      end
    end
  end

  generate if ((synthesize == 0)) begin
      hcc_mul3236b #(
          .width(mantissa))
    bmult(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(aaman),
      .bb(bbman),
      .cc(mulout));

  end
  endgenerate
  generate if ((synthesize == 1)) begin
      hcc_mul3236s #(
          .width(mantissa))
    smult(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));

  end
  endgenerate
  assign aapos[1] = aamanff[mantissa - 1] | aamanff[mantissa - 2] | aamanff[mantissa - 3] | aamanff[mantissa - 4];
  assign aapos[2] = aamanff[mantissa - 5] | aamanff[mantissa - 6] | aamanff[mantissa - 7] | aamanff[mantissa - 8];
  assign aapos[3] = aamanff[mantissa - 9] | aamanff[mantissa - 10] | aamanff[mantissa - 11] | aamanff[mantissa - 12];
  assign aapos[4] = aamanff[mantissa - 13] | aamanff[mantissa - 14] | aamanff[mantissa - 15] | aamanff[mantissa - 16];
  assign bbpos[1] = bbmanff[mantissa - 1] | bbmanff[mantissa - 2] | bbmanff[mantissa - 3] | bbmanff[mantissa - 4];
  assign bbpos[2] = bbmanff[mantissa - 5] | bbmanff[mantissa - 6] | bbmanff[mantissa - 7] | bbmanff[mantissa - 8];
  assign bbpos[3] = bbmanff[mantissa - 9] | bbmanff[mantissa - 10] | bbmanff[mantissa - 11] | bbmanff[mantissa - 12];
  assign bbpos[4] = bbmanff[mantissa - 13] | bbmanff[mantissa - 14] | bbmanff[mantissa - 15] | bbmanff[mantissa - 16];
  assign aaneg[1] = aamanff[mantissa - 1] & aamanff[mantissa - 2] & aamanff[mantissa - 3] & aamanff[mantissa - 4];
  assign aaneg[2] = aamanff[mantissa - 5] & aamanff[mantissa - 6] & aamanff[mantissa - 7] & aamanff[mantissa - 8];
  assign aaneg[3] = aamanff[mantissa - 9] & aamanff[mantissa - 10] & aamanff[mantissa - 11] & aamanff[mantissa - 12];
  assign aaneg[4] = aamanff[mantissa - 13] & aamanff[mantissa - 14] & aamanff[mantissa - 15] & aamanff[mantissa - 16];
  assign bbneg[1] = bbmanff[mantissa - 1] & bbmanff[mantissa - 2] & bbmanff[mantissa - 3] & bbmanff[mantissa - 4];
  assign bbneg[2] = bbmanff[mantissa - 5] & bbmanff[mantissa - 6] & bbmanff[mantissa - 7] & bbmanff[mantissa - 8];
  assign bbneg[3] = bbmanff[mantissa - 9] & bbmanff[mantissa - 10] & bbmanff[mantissa - 11] & bbmanff[mantissa - 12];
  assign bbneg[4] = bbmanff[mantissa - 13] & bbmanff[mantissa - 14] & bbmanff[mantissa - 15] & bbmanff[mantissa - 16];
  assign selnode[1] = aanumff[1] & bbnumff[1];
  assign selnode[2] = ((aanumff[1] & bbnumff[2])) | ((aanumff[2] & bbnumff[1]));
  assign selnode[3] = ((aanumff[2] & bbnumff[2])) | ((aanumff[1] & bbnumff[3])) | ((aanumff[3] & bbnumff[1]));
  assign sel[1] = selnode[1];
  // shift 0
  assign sel[2] =  ~((selnode[1])) & selnode[2];
  // shift 4
  assign sel[3] =  ~((selnode[1])) &  ~((selnode[2])) & selnode[3];
  // shift 8
  assign sel[4] =  ~((selnode[1])) &  ~((selnode[2])) &  ~((selnode[3]));
  // shift 12
  assign expadjnode = {6'b 000000,expadjff};
  //***************
  //*** OUTPUTS ***
  //***************
  assign cc = {manoutff[mantissa],manoutff[mantissa],manoutff[mantissa:3],expff_3[10:1]}; 
  assign ccsat = ccsatff[3];
  assign cczip = cczipff[3];
  assign ccnan = ccnanff[3];

endmodule


//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MUL2727S.V                            ***
//***                                             ***
//***   Function: 2 pipeline stage signed 27 bit  ***
//***             SV(behavioral/synthesizable)    ***
//***                                             ***
//***   30/10/10 ML                               ***
//***                                             ***
//***   (c) 2010 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul2727s (
	  sysclk,
	  reset,
	  enable,
	  aa,
	  bb,
	  cc);

parameter [31:0] width = 32;

   input sysclk;
   input reset;
   input enable;
	  input [width : 1] aa;
	  input [width : 1] bb;

	  output [2*width : 1] cc;

   wire sysclk;
   wire reset;
   wire enable;
	  wire [width : 1] aa;
	  wire [width : 1] bb;
   reg [width : 1] aaff;
   reg [width : 1] bbff;
   reg [2*width : 1] multiplyff;
	  wire [2*width : 1] cc;

  integer k;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      for (k=1; k <= width; k = k + 1) begin
        aaff[k] <= 1'b 0;
        bbff[k] <= 1'b 0;
      end
      for (k=1; k <= 2*width; k = k + 1) begin
        multiplyff[k] <= 1'b 0;
      end
    end else begin : pma
      k=0;
      if((enable == 1'b 1)) begin
        aaff <= aa;
        bbff <= bb;
        multiplyff <= aaff * bbff;
      end
    end
  end


  assign cc = multiplyff;

endmodule

//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULFP3236.V                           ***
//***                                             ***
//***   Function: Single precision multiplier     ***
//***             core function                   ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mulfp3236(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] synthesize=0;
input sysclk;
input reset;
input enable;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
input [mantissa + 10:1] bb;
input bbsat, bbzip, bbnan;
output [mantissa + 10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


parameter normtype = 0;  //type expfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (10 DOWNTO 1);
wire [mantissa:1] aaman; wire [mantissa:1] bbman;
wire [10:1] aaexp; wire [10:1] bbexp;
wire [2 * mantissa:1] mulout;
reg [10:1] aaexpff; reg [10:1] bbexpff;  //signal expff : expfftype; 
reg [10:1] expff_1;
reg [10:1] expff_2;
reg aasatff; reg aazipff; reg bbsatff; reg bbzipff; reg aananff; reg bbnanff;
reg [2:1] ccsatff; reg [2:1] cczipff; reg [2:1] ccnanff;

  // for single 32 bit mantissa
  // [S ][O....O][1 ][M...M][RGS]
  // [32][31..28][27][26..4][321] - NB underflow can run into RGS
  // normalization or scale turns it into
  // [S ][1 ][M...M][U..U]
  // [32][31][30..8][7..1]
  // multiplier outputs (result < 2)
  // [S....S][1 ][M*M...][U*U]
  // [64..62][61][60..15][14....1]
  // multiplier outputs (result >= 2)
  // [S....S][1 ][M*M...][U*U.....]
  // [64..63][62][61..16][15.....1]
  // output (if destination not a multiplier)
  // right shift 2
  // [S ][S ][SSS1..XX]
  // [64][64][64....35]
  // result "SSSSS1XXX" if result <2, "SSSS1XXXX" if result >= 2 
  assign aaman = aa[mantissa + 10:11];
  assign bbman = bb[mantissa + 10:11];
  assign aaexp = aa[10:1];
  assign bbexp = bb[10:1];
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaexpff <= 10'b 0000000000;
      bbexpff <= 10'b 0000000000;
      expff_1[10:1] <= 10'b 0000000000;
      expff_2[10:1] <= 10'b 0000000000;
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      bbsatff <= 1'b 0;
      bbzipff <= 1'b 0;
      bbnanff <= 1'b 0;
      ccsatff <= 2'b 00;
      cczipff <= 2'b 00;
      ccnanff <= 2'b 00;
    end else begin : gza
	  integer k;
      if((enable == 1'b 1)) begin
        aasatff <= aasat;
        aazipff <= aazip;
        aananff <= aanan;
        bbsatff <= bbsat;
        bbzipff <= bbzip;
        bbnanff <= bbnan;
        ccsatff[1] <= aasatff | bbsatff;
        ccsatff[2] <= ccsatff[1];
        cczipff[1] <= aazipff | bbzipff;
        cczipff[2] <= cczipff[1];
        ccnanff[1] <= aananff | bbnanff | ( aazipff & bbsatff ) | ( bbzipff & aasatff );
        ccnanff[2] <= ccnanff[1];
        aaexpff <= aaexp;
        bbexpff <= bbexp;
        expff_1[10:1] <= aaexpff + bbexpff - 10'b 0001111111;
        for (k=1; k <= 10; k = k + 1) begin
          expff_2[k] <= ((expff_1[k] | ccsatff[1])) &  ~((cczipff[1]));
        end
      end
    end
  end

  generate if ((synthesize == 0)) begin
      hcc_mul3236b #(
          .width(mantissa))
    bmult(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(aaman),
      .bb(bbman),
      .cc(mulout));

  end
  endgenerate
  generate if ((synthesize == 1)) begin
      hcc_mul3236s #(
          .width(mantissa))
    smult(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));

  end
  endgenerate
  //***************
  //*** OUTPUTS ***
  //***************
  assign cc = {mulout[2 * mantissa],mulout[2 * mantissa],mulout[2 * mantissa:mantissa + 3],expff_2[10:1]};
  assign ccsat = ccsatff[2];
  assign cczip = cczipff[2];
  assign ccnan = ccnanff[2];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MUL3236S.V                            ***
//***                                             ***
//***   Function: 3 pipeline stage unsigned 32 or ***
//***             36 bit multiplier (synth'able)  ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul3236s(
sysclk,
reset,
enable,
mulaa,
mulbb,
mulcc
);

parameter [31:0] width=32;
input sysclk;
input reset;
input enable;
input [width:1] mulaa, mulbb;
output [2 * width:1] mulcc;

wire sysclk;
wire reset;
wire enable;
wire [width:1] mulaa;
wire [width:1] mulbb;
wire [2 * width:1] mulcc;



  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("SIGNED"),
    .representation_b("SIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(width),
    .width_b(width),
    .width_result(2 * width))
  ALTMULT_ADD_component(
      .dataa(mulaa),
    .datab(mulbb),
    .datac(22'b0),
    .coefsel0(3'b0),
    .coefsel1(3'b0),
    .coefsel2(3'b0),
    .coefsel3(3'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulcc),.scanina (),
.scaninb (),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);


endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULFP1X.V                             ***
//***                                             ***
//***   Function: Single precision multiplier     ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mulfp1x(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] ieeeoutput=0;
parameter [31:0] xoutput=1;
parameter [31:0] multoutput=0;
parameter [31:0] divoutput=0;
parameter [31:0] mantissa=32;
parameter [31:0] outputscale=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [mantissa + 10:1] aa;
input aasat, aazip, aanan;
input [mantissa + 10:1] bb;
input bbsat, bbzip, bbnan;
output [32*ieeeoutput+(mantissa+10)*(xoutput+multoutput+divoutput):1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [mantissa + 10:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [mantissa + 10:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [32*ieeeoutput+(mantissa+10)*(xoutput+multoutput+divoutput):1] cc;
wire ccsat;
wire cczip;
wire ccnan;


wire [mantissa + 10:1] mulinaa; wire [mantissa + 10:1] mulinbb;
wire mulinaasat; wire mulinaazip; wire mulinaanan; wire mulinbbsat; wire mulinbbzip; wire mulinbbnan;
wire [mantissa + 10:1] ccnode;  //signal aaexp, bbexp, ccexp : STD_LOGIC_VECTOR (10 DOWNTO 1);
wire ccsatnode; wire cczipnode; wire ccnannode;
wire [10:1] aaexp; wire [10:1] bbexp; wire [10:1] ccexp; wire [mantissa:1] aaman; wire [mantissa:1] bbman; wire [mantissa:1] ccman;
//signal aaman, bbman, ccman : STD_LOGIC_VECTOR (mantissa DOWNTO 1); 
wire [mantissa:1] mantissanode;
wire [mantissa:1] divmantissa; wire [mantissa:1] divposmantissa;
wire [mantissa - 3:1] normmantissa;
wire normshiftbit;
reg ccsatff; reg cczipff; reg ccnanff;
reg [mantissa:1] manmultff;
reg [10:1] expmultff;

wire [mantissa - 3:1] absnode; wire [mantissa - 3:1] absolute;
reg [mantissa - 3:1] absoluteff;
reg [23:1] manoutff; reg [10:1] expshiftff; reg [8:1] expoutff; reg [2:1] signoutff;
wire roundbit; wire expmax; wire expzero;
wire [26:1] manroundnode; wire [24:1] overflownode; wire [10:1] expplusnode;
wire manoutzero; wire manoutmax; wire expoutzero; wire expoutmax;

  //************************************************** 
  //***                                            *** 
  //*** Input Section                              *** 
  //***                                            *** 
  //************************************************** 
  //******************************************************** 
  //*** ieee754 input when multiplier input is from cast *** 
  //*** cast now creates different                       *** 
  //*** formats for multiplier, divider, and alu         *** 
  //*** multiplier format [S][1][mantissa....]           *** 
  //******************************************************** 
  assign mulinaa = aa;
  assign mulinbb = bb;
  assign mulinaasat = aasat;
  assign mulinaazip = aazip;
  assign mulinaanan = aanan;
  assign mulinbbsat = bbsat;
  assign mulinbbzip = bbzip;
  assign mulinbbnan = bbnan;
  //**************************
  //*** Multiplier Section ***
  //**************************
  // multiplier input in this form
  // [S ][1 ][M...M][U..U]
  // [32][31][30..8][7..1]
  generate if ((outputscale == 0)) begin
      hcc_mulfp3236 #(
          .mantissa(mantissa),
      .synthesize(synthesize))
    mulone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(mulinaa),
      .aasat(mulinaasat),
      .aazip(mulinaazip),
      .aanan(mulinaanan),
      .bb(mulinbb),
      .bbsat(mulinbbsat),
      .bbzip(mulinbbzip),
      .bbnan(mulinbbnan),
      .cc(ccnode),
      .ccsat(ccsatnode),
      .cczip(cczipnode),
      .ccnan(ccnannode));

  end
  endgenerate
  generate if ((outputscale == 1)) begin
      hcc_mulfppn3236 #(
          .mantissa(mantissa),
      .synthesize(synthesize))
    multwo(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(mulinaa),
      .aasat(mulinaasat),
      .aazip(mulinaazip),
      .aanan(mulinaanan),
      .bb(mulinbb),
      .bbsat(mulinbbsat),
      .bbzip(mulinbbzip),
      .bbnan(mulinbbnan),
      .cc(ccnode),
      .ccsat(ccsatnode),
      .cczip(cczipnode),
      .ccnan(ccnannode));

  end
  endgenerate
  //*** INTERNAL FORMAT ***
  generate if (xoutput == 1) begin : gxo
    assign cc = ccnode;
    assign ccsat = ccsatnode;
    assign cczip = cczipnode;
    assign ccnan = ccnannode;
  end
  endgenerate

  genvar j;
  integer k;

  //*** ANOTHER SINGLE PRECISION MULTIPLIER ***
  generate if (multoutput == 1) begin : gmo
    assign mantissanode = ccnode[mantissa + 10:11];
    for (j=1; j <= mantissa - 3; j = j + 1) begin : gna
        assign normmantissa[j] = (((mantissanode[j] & ~((mantissanode[mantissa - 4]))) | (mantissanode[j + 1] &  (mantissanode[mantissa - 4]))) &  ~((mantissanode[mantissa])))
        							| (((mantissanode[j] & (mantissanode[mantissa - 4])) | (mantissanode[j + 1] &  ~((mantissanode[mantissa - 4])))) &  (mantissanode[mantissa]));
    end

    assign normshiftbit = (mantissanode[mantissa - 4] & ~((mantissanode[mantissa]))) | (~((mantissanode[mantissa - 4])) & (mantissanode[mantissa]));

      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= mantissa; k = k + 1) begin 
          manmultff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin 
          expmultff[k] <= 1'b 0;
        end
        ccsatff <= 1'b 0;
        cczipff <= 1'b 0;
        ccnanff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          manmultff <= {normmantissa[mantissa - 4:1],4'b 0000};
          expmultff <= ccnode[10:1] + normshiftbit;
          ccsatff <= ccsatnode;
          cczipff <= cczipnode;
          ccnanff <= ccnannode;
        end
      end
    end

    assign cc[mantissa + 10:11] = manmultff;
    assign cc[10:1] = expmultff;
    assign ccsat = ccsatff;
    assign cczip = cczipff;
    assign ccnan = ccnanff;
  end
  endgenerate

  //*** A SINGLE PRECISION DIVIDER ***
  generate if (divoutput == 1) begin : gdo
    assign mantissanode = ccnode[mantissa + 10:11];
    for (j=1; j <= mantissa - 3; j = j + 1) begin : gda
        assign normmantissa[j] = (((mantissanode[j] & ~((mantissanode[mantissa - 4]))) | (mantissanode[j + 1] &  (mantissanode[mantissa - 4]))) &  ~((mantissanode[mantissa])))
        							| (((mantissanode[j] & (mantissanode[mantissa - 4])) | (mantissanode[j + 1] &  ~((mantissanode[mantissa - 4])))) &  (mantissanode[mantissa]));
    end

    assign divmantissa = {normmantissa[mantissa - 4:1], 4'b 0000};
    for (j=1; j <= mantissa - 1; j = j + 1) begin : gdb
      assign divposmantissa[j] = divmantissa[j] ^ mantissanode[mantissa];
    end
    assign divposmantissa[mantissa] = mantissanode[mantissa];
    assign normshiftbit = (mantissanode[mantissa - 4] & ~((mantissanode[mantissa]))) | (~((mantissanode[mantissa - 4])) & mantissanode[mantissa]);

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= mantissa; k = k + 1) begin 
          manmultff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin 
          expmultff[k] <= 1'b 0;
        end
        ccsatff <= 1'b 0;
        cczipff <= 1'b 0;
        ccnanff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          manmultff <= divposmantissa + mantissanode[mantissa];
          expmultff <= ccnode[10:1] + normshiftbit;
          ccsatff <= ccsatnode;
          cczipff <= cczipnode;
          ccnanff <= ccnannode;
        end
      end
    end

    assign cc[mantissa + 10:11] = manmultff;
    assign cc[10:1] = expmultff;
    assign ccsat = ccsatff;
    assign cczip = cczipff;
    assign ccnan = ccnanff;
  end
  endgenerate

  //*** IEEE754 Output ***
  generate if (ieeeoutput == 1) begin : gio
    assign mantissanode = ccnode[mantissa + 10:11];
    for (j=1; j <= mantissa - 3; j = j + 1) begin : gna
        assign normmantissa[j] = (((mantissanode[j] & ~((mantissanode[mantissa - 4]))) | (mantissanode[j + 1] &  (mantissanode[mantissa - 4]))) &  ~((mantissanode[mantissa])))
        							| (((mantissanode[j] & (mantissanode[mantissa - 4])) | (mantissanode[j + 1] &  ~((mantissanode[mantissa - 4])))) &  (mantissanode[mantissa]));
    end

    assign normshiftbit = (mantissanode[mantissa - 4] & ~((mantissanode[mantissa]))) | (~((mantissanode[mantissa - 4])) & mantissanode[mantissa]);

    for (j=1; j <= mantissa - 3; j = j + 1) begin : gaa
      assign absnode[j] = normmantissa[j] ^ normmantissa[mantissa - 3];
    end
    assign absolute = absnode[mantissa - 3:1] + normmantissa[mantissa - 3];

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        for (k=1; k <= mantissa - 3; k = k + 1) begin 
          absoluteff[k] <= 1'b 0;
        end
        for (k=1; k <= 23; k = k + 1) begin 
          manoutff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin 
          expshiftff[k] <= 1'b 0;
        end
        for (k=1; k <= 8; k = k + 1) begin 
          expoutff[k] <= 1'b 0;
        end
        signoutff <= 2'b 00;
        ccsatff <= 1'b 0;
        cczipff <= 1'b 0;
        ccnanff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          absoluteff <= absolute;
          expshiftff <= ccnode[10:1] + normshiftbit;
          ccsatff <= ccsatnode;
          cczipff <= cczipnode;
          ccnanff <= ccnannode;
          for (k=1; k <= 23; k = k + 1) begin 
            manoutff[k] <= (manroundnode[k] & ~((manoutzero))) | manoutmax;
          end
          for (k=1; k <= 8; k = k + 1) begin 
            expoutff[k] <= (expplusnode[k] & ~((expoutzero))) | expoutmax;
          end
          signoutff[1] <= normmantissa[mantissa-4];
          signoutff[2] <= signoutff[1];
        end
      end
    end

    assign roundbit = absoluteff[mantissa-29];
    assign manroundnode = absoluteff[mantissa-3:mantissa-28] + roundbit;
    assign overflownode[1] = roundbit;
    for (j=2; j <= 24; j = j + 1) begin : gova
      assign overflownode[j] = (overflownode[j - 1] & absoluteff[mantissa - 30 + j]);
    end
    assign expplusnode = expshiftff + {9'b 000000000,overflownode[24]};

    assign expmax = expplusnode[8] & expplusnode[7] & expplusnode[6] & expplusnode[5] & expplusnode[4] & expplusnode[3] & expplusnode[2] & expplusnode[1];
    assign expzero = ~((expplusnode[8] | expplusnode[7] | expplusnode[6] | expplusnode[5] | expplusnode[4] | expplusnode[3] | expplusnode[2] | expplusnode[1]));
    assign manoutzero = ccsatff & cczipff & expmax & expzero & expshiftff[10] & expshiftff[9];
    assign manoutmax = ccnanff;
    assign expoutzero = cczipff | expzero | expshiftff[10];
    assign expoutmax = expmax | expshiftff[9] | ccnanff;

    assign cc[32] = signoutff[2];
    assign cc[31:24] = expoutff;
    assign cc[23:1] = manoutff;
    assign ccsat = 1'b 0;
    assign cczip = 1'b 0;
    assign ccnan = 1'b 0;
  end
  endgenerate

endmodule

//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULFP1X_DOT                           ***
//***                                             ***
//***   Function: Single precision multiplier     ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mulfp1_dot(
sysclk,
reset,
enable,
aa,
bb,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] mantissa=32;
parameter [31:0] device=2;
parameter [31:0] optimization=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [32:1] aa;
input [32:1] bb;
output [mantissa+10:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [32:1] aa;
wire [32:1] bb;
wire [mantissa + 10:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


wire [10:1] biasvalue;
reg [8:1] aaexponentff; reg [8:1] bbexponentff;
reg [10:1] exponentff_1; reg [10:1] exponentff_2; reg [10:1] exponentff_3;
reg aasignff; reg bbsignff; reg [3:1] signff; reg [mantissa:1] mantissaff;
wire [27:1] aamantissa; wire [27:1] bbmantissa; wire [54:1] multiply; wire [mantissa:1] normalize; wire [mantissa:1] premantissa;
wire twos_complement_carry;
wire normalize_bit_older; wire normalize_bit_newer;
wire aaexponentzero; wire bbexponentzero;
wire aaexponentmax; wire bbexponentmax;
reg aamantissabitff; reg bbmantissabitff;
reg [3:1] ccsatff; reg [3:1] cczipff; reg [3:1] ccnanff;

wire aazero; wire aainfinity; wire aanan;
wire bbzero; wire bbinfinity; wire bbnan;
wire [8:1] aaexp; wire [8:1] bbexp;
wire [23:1] aaman; wire [23:1] bbman;
wire [10:1] ccexp; wire [mantissa:1] ccman;

  generate if (optimization == 1 || optimization == 2) begin: gen_bias_norm
    assign biasvalue = 10'b 0001111111;
  end
  endgenerate
  generate if (optimization == 3) begin: gen_bias_scale
    assign biasvalue = 10'b 0001111110;
  end
  endgenerate

	//--*********************
	//--*** INPUT SECTION ***
	//--*********************
  integer k;

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
        for (k=1; k <= 8; k = k + 1) begin 
          aaexponentff[k] <= 1'b 0;
          bbexponentff[k] <= 1'b 0;
        end
        for (k=1; k <= 10; k = k + 1) begin 
          exponentff_1[k] <= 1'b 0;
          exponentff_2[k] <= 1'b 0;
          exponentff_3[k] <= 1'b 0;
        end
        aasignff <= 1'b 0;
        bbsignff <= 1'b 0;
        signff <= 3'b 000;
        for (k=1; k <= mantissa; k = k + 1) begin 
          mantissaff[k] <= 1'b 0;
        end
    end else begin
        k=0;
        if((enable == 1'b 1)) begin
          aaexponentff <= aa[31:24];
          bbexponentff <= bb[31:24];
          exponentff_1[10:1] <= {2'b 0,aaexponentff} + {2'b 0,bbexponentff} - biasvalue;
          exponentff_2[10:1] <= exponentff_1[10:1] + normalize_bit_newer;
          exponentff_3[10:1] <= exponentff_2[10:1] + normalize_bit_older;

          aasignff <= aa[32];
          bbsignff <= bb[32];
          signff[1] <= aasignff ^ bbsignff;
          signff[2] <= signff[1];
          signff[3] <= signff[2];
          mantissaff <= premantissa + twos_complement_carry;
        end
    end
  end

  generate if ((device < 2) & (optimization == 1)) begin : gen_twos_one
    assign twos_complement_carry = signff[2];
    assign normalize_bit_newer = 1'b 0;
    assign normalize_bit_older = multiply[52];

    end
  endgenerate

  generate if ((device == 2) & (optimization == 1)) begin : gen_twos_two
    assign twos_complement_carry = signff[1];
    assign normalize_bit_older = 1'b 0;
    assign normalize_bit_newer = multiply[52];

    end
  endgenerate

  generate if ((device < 2) & (optimization == 2)) begin : gen_twos_thr
    assign twos_complement_carry = 1'b 0;
    assign normalize_bit_newer = 1'b 0;
    assign normalize_bit_older = multiply[52];

    end
  endgenerate

  generate if ((device == 2) & (optimization == 2)) begin : gen_twos_for
    assign twos_complement_carry = 1'b 0;
    assign normalize_bit_older = 1'b 0;
    assign normalize_bit_newer = multiply[52];

    end
  endgenerate

  generate if ((optimization == 3)) begin : gen_twos_other
    assign twos_complement_carry = 1'b 0;
    assign normalize_bit_newer = 1'b 0;
    assign normalize_bit_older = 1'b 0;

    end
  endgenerate

  //*** Multiplier Section ***
  assign aamantissa = {2'b 01,aa[23:1],2'b 0};
  assign bbmantissa = {2'b 01,bb[23:1],2'b 0};

  generate if ((device < 2) & (synthesize == 0)) begin : gen_mul_one
    hcc_mul3236b #(
          .width(27))
        bmult(
          .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(aamantissa),
          .bb(bbmantissa),
          .cc(multiply));

    end
  endgenerate

  generate if ((device < 2) & (synthesize == 1)) begin : gen_mul_two
    hcc_mul3236s #(
          .width(27))
        smult(
          .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .mulaa(aamantissa),
          .mulbb(bbmantissa),
          .mulcc(multiply));

    end
  endgenerate

  generate if ((device == 2)) begin : gen_mul_thr
    hcc_mul2727s #(
          .width(27))
        bmult5(
          .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(aamantissa),
          .bb(bbmantissa),
          .cc(multiply));

    end
  endgenerate

  assign normalize[mantissa:mantissa-2] = 3'b 000;
	 genvar j;
  generate for (j=1; j <= mantissa - 3; j = j + 1) begin : gnma
    assign normalize[j] = (multiply[57-mantissa+j] & multiply[52]) | (multiply[56-mantissa+j] & ~((multiply[52])));
  end
  endgenerate
  generate for (j=1; j <= mantissa; j = j + 1) begin :gpma
    assign premantissa[j] = normalize[j] ^ twos_complement_carry;
  end
  endgenerate

	//--*********************
	//--*** EXCEPTIONS    ***
	//--*********************
  assign aaexponentzero = ~((aaexponentff[8] | aaexponentff[7] | aaexponentff[6] | aaexponentff[5] | aaexponentff[4] | aaexponentff[3] | aaexponentff[2] | aaexponentff[1]));
  assign bbexponentzero = ~((bbexponentff[8] | bbexponentff[7] | bbexponentff[6] | bbexponentff[5] | bbexponentff[4] | bbexponentff[3] | bbexponentff[2] | bbexponentff[1]));
  assign aaexponentmax = aaexponentff[8] & aaexponentff[7] & aaexponentff[6] & aaexponentff[5] & aaexponentff[4] & aaexponentff[3] & aaexponentff[2] & aaexponentff[1];
  assign bbexponentmax = bbexponentff[8] & bbexponentff[7] & bbexponentff[6] & bbexponentff[5] & bbexponentff[4] & bbexponentff[3] & bbexponentff[2] & bbexponentff[1];

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aamantissabitff <= 1'b 0;
      bbmantissabitff <= 1'b 0;
      cczipff <= 3'b 0;
      ccsatff <= 3'b 0;
      ccnanff <= 3'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        aamantissabitff <= aa[23];
        bbmantissabitff <= bb[23];
        cczipff[1] <= (aazero & ~((bbexponentmax))) | (bbexponentzero & ~((aaexponentmax)));
        cczipff[2] <= cczipff[1];
        cczipff[3] <= cczipff[2];

        ccsatff[1] <= (~((aazero)) & ~((aaexponentmax)) & bbinfinity) | (~((bbzero)) & ~((bbexponentmax)) & aainfinity);
        ccsatff[2] <= ccsatff[1];
        ccsatff[3] <= ccsatff[2];

        ccnanff[1] <= (aazero & bbinfinity) | (bbzero & aainfinity) | aanan | bbnan;
        ccnanff[2] <= ccnanff[1];
        ccnanff[3] <= ccnanff[2];

      end
    end
  end

  assign aazero = aaexponentzero;
  assign aainfinity = aaexponentmax & ~((aamantissabitff));
  assign aanan = aaexponentmax & aamantissabitff;
  assign bbzero = bbexponentzero;
  assign bbinfinity = bbexponentmax & ~((bbmantissabitff));
  assign bbnan = bbexponentmax & bbmantissabitff;

	//--*********************
	//--*** OUTPUTS       ***
	//--*********************
  generate if (device < 2 & optimization == 1) begin : gen_out_older_one
    assign cc[mantissa+10:11] = mantissaff;
    assign cc[10:1] = exponentff_3[10:1];
    assign ccsat = ccsatff[3];
    assign cczip = cczipff[3];
    assign ccnan = ccnanff[3];

    end
  endgenerate

  generate if (device < 2 & optimization == 2) begin : gen_out_older_two
    assign cc[mantissa+10] = signff[3];
    assign cc[mantissa+9:11] = mantissaff[mantissa-1:1];
    assign cc[10:1] = exponentff_3[10:1];
    assign ccsat = ccsatff[3];
    assign cczip = cczipff[3];
    assign ccnan = ccnanff[3];

    end
  endgenerate

  generate if (device < 2 & optimization == 3) begin : gen_out_older_thr
    assign cc[mantissa+10] = signff[2];
    assign cc[mantissa+9:11] = {2'b 00,multiply[54:58-mantissa]};
    assign cc[10:1] = exponentff_2[10:1];
    assign ccsat = ccsatff[2];
    assign cczip = cczipff[2];
    assign ccnan = ccnanff[2];

    end
  endgenerate

  generate if (device == 2 & optimization == 1) begin : gen_out_newer_one
    assign cc[mantissa+10:11] = mantissaff;
    assign cc[10:1] = exponentff_2[10:1];
    assign ccsat = ccsatff[2];
    assign cczip = cczipff[2];
    assign ccnan = ccnanff[2];

    end
  endgenerate

  generate if (device == 2 & optimization == 2) begin : gen_out_newer_two
    assign cc[mantissa+10] = signff[2];
    assign cc[mantissa+9:11] = mantissaff[mantissa-1:1];
    assign cc[10:1] = exponentff_2[10:1];
    assign ccsat = ccsatff[2];
    assign cczip = cczipff[2];
    assign ccnan = ccnanff[2];

    end
  endgenerate

  generate if (device == 2 & optimization == 3) begin : gen_out_newer_thr
    assign cc[mantissa+10] = signff[1];
    assign cc[mantissa+9:11] = {2'b 00,multiply[54:58-mantissa]};
    assign cc[10:1] = exponentff_1[10:1];
    assign ccsat = ccsatff[1];
    assign cczip = cczipff[1];
    assign ccnan = ccnanff[1];

    end
  endgenerate

endmodule



//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   FP_MUL3618SUM.V                             ***
//***                                             ***
//***   Function: Single precision multiplier     ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps
module fp_mul3618sum(
sysclk,
enable,
aaone,
aatwo,
bbone,
bbtwo,
cc
);

input sysclk;
input enable;
input [17:0] aaone;
input [17:0] aatwo;
input [35:0] bbone;
input [35:0] bbtwo;
output [54:0] cc;

wire sysclk;
wire enable;
wire [17:0] aaone;
wire [17:0] aatwo;
wire [35:0] bbone;
wire [35:0] bbtwo;
wire [54:0] cc;


wire [54:0] sub_wire0;
wire [17:0] sub_wire1;
wire [35:0] sub_wire2;
wire [17:0] sub_wire3;
wire [35:0] sub_wire4;
wire [71:0] sub_wire5;
wire [35:0] sub_wire6;

  assign sub_wire6 = bbtwo[35:0];
  assign sub_wire3 = aatwo[17:0];
  assign cc = sub_wire0[54:0];
  assign sub_wire1 = aaone[17:0];
  assign sub_wire2 = {sub_wire3[17:0],sub_wire1[17:0]};
  assign sub_wire4 = bbone[35:0];
  assign sub_wire5 = {sub_wire6[35:0],sub_wire4[35:0]};
  altmult_add #(
      .accumulator("NO"),
    .addnsub_multiplier_aclr1("UNUSED"),
    .addnsub_multiplier_pipeline_aclr1("UNUSED"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .chainout_adder("NO"),
    .chainout_register("UNREGISTERED"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("UNUSED"),
    .input_aclr_a1("UNUSED"),
    .input_aclr_b0("UNUSED"),
    .input_aclr_b1("UNUSED"),
    .input_register_a0("CLOCK0"),
    .input_register_a1("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_register_b1("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_a1("DATAA"),
    .input_source_b0("DATAB"),
    .input_source_b1("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("UNUSED"),
    .multiplier_aclr1("UNUSED"),
    .multiplier_register0("CLOCK0"),
    .multiplier_register1("CLOCK0"),
    .number_of_multipliers(2),
    .output_aclr("UNUSED"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("UNUSED"),
    .signed_aclr_b("UNUSED"),
    .signed_pipeline_aclr_a("UNUSED"),
    .signed_pipeline_aclr_b("UNUSED"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(18),
    .width_b(36),
    .width_chainin(1),
    .width_result(55),
    .zero_chainout_output_aclr("UNUSED"),
    .zero_chainout_output_register("CLOCK0"),
    .zero_loopback_aclr("UNUSED"),
    .zero_loopback_output_aclr("UNUSED"),
    .zero_loopback_output_register("CLOCK0"),
    .zero_loopback_pipeline_aclr("UNUSED"),
    .zero_loopback_pipeline_register("CLOCK0"),
    .zero_loopback_register("CLOCK0"))
  ALTMULT_ADD_component(
      .dataa(sub_wire2),
    .datab(sub_wire5),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .ena0(enable),
    .result(sub_wire0),.aclr3(1'b0),.scanina ({18{1'b0}}),
.scaninb ({36{1'b0}}),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);


endmodule

`timescale 1 ps / 1 ps
module fp_mul3636us(
sysclk,
enable,
aa,
bb,
cc
);

input sysclk;
input enable;
input [35:0] aa;
input [35:0] bb;
output [71:0] cc;

wire sysclk;
wire enable;
wire [35:0] aa;
wire [35:0] bb;
wire [71:0] cc;


wire [71:0] sub_wire0;

  assign cc = sub_wire0[71:0];
  altmult_add #(
      .accumulator("NO"),
    .addnsub_multiplier_aclr1("UNUSED"),
    .addnsub_multiplier_pipeline_aclr1("UNUSED"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .chainout_adder("NO"),
    .chainout_register("UNREGISTERED"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("UNUSED"),
    .input_aclr_b0("UNUSED"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("UNUSED"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("UNUSED"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("UNUSED"),
    .signed_aclr_b("UNUSED"),
    .signed_pipeline_aclr_a("UNUSED"),
    .signed_pipeline_aclr_b("UNUSED"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(36),
    .width_b(36),
    .width_chainin(1),
    .width_result(72),
    .zero_chainout_output_aclr("UNUSED"),
    .zero_chainout_output_register("CLOCK0"),
    .zero_loopback_aclr("UNUSED"),
    .zero_loopback_output_aclr("UNUSED"),
    .zero_loopback_output_register("CLOCK0"),
    .zero_loopback_pipeline_aclr("UNUSED"),
    .zero_loopback_pipeline_register("CLOCK0"),
    .zero_loopback_register("CLOCK0"))
  ALTMULT_ADD_component(
      .dataa(aa),
    .datab(bb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .ena0(enable),
    .result(sub_wire0),.aclr3(1'b0),.scanina ({36{1'b0}}),
.scaninb ({36{1'b0}}),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);


endmodule
//***************************************************
//***                                             ***
//***   DOUBLE PRECISION CORE LIBRARY             ***
//***                                             ***
//***   DP_ADDS.V                                 ***
//***                                             ***
//***   Function: Synthesizable Fixed Point Adder ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module dp_adds(
sysclk,
reset,
enable,
aa,
bb,
carryin,
cc
);

parameter [31:0] width=64;
parameter [31:0] pipes=1;
input sysclk;
input reset;
input enable;
input [width:1] aa, bb;
input carryin;
output [width:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [width:1] aa;
wire [width:1] bb;
wire carryin;
wire [width:1] cc;



  lpm_add_sub #(
      .lpm_direction("ADD"),
    .lpm_hint("ONE_INPUT_IS_CONSTANT=NO,CIN_USED=YES"),
    .lpm_pipeline(pipes),
    .lpm_type("LPM_ADD_SUB"),
    .lpm_width(width))
  addtwo(
      .dataa(aa),
    .datab(bb),
    .cin(carryin),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(cc),.add_sub(),.cout(),.overflow());


endmodule
//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_MUL5454_8MS3S.V                        ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   54x54b input, 72b output, 5/6 pipes       ***
//***                                             ***
//***   06/01/09 ML                               ***
//***                                             ***
//***   (c) 2009 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
//***************************************************
//*** SIII specific, 8 18x18 multiplier version   ***
//***************************************************
`timescale 1 ps / 1 ps

module fp_mul5454_8ms3s(
sysclk,
reset,
enable,
dataaa,
databb,
result
);

parameter [31:0] pipes=5;
input sysclk;
input reset;
input enable;
input [54:1] dataaa;
input [54:1] databb;
output [72:1] result;

wire sysclk;
wire reset;
wire enable;
wire [54:1] dataaa;
wire [54:1] databb;
wire [72:1] result;


wire [35:1] zerovec;
wire [72:1] multonenode;
wire [55:1] multtwonode;
wire [72:1] multonevector;
wire [72:1] multtwovector;
wire gnd_w;

  assign gnd_w = 1'b 0;
  assign zerovec = 35'b 0;

  fp_mul3636us multone(
      .sysclk(sysclk),
    .enable(enable),
    .aa(dataaa[54:19]),
    .bb(databb[54:19]),
    .cc(multonenode));

  fp_mul3618sum multtwo(
      .sysclk(sysclk),
    .enable(enable),
    .aaone(dataaa[18:1]),
    .aatwo(databb[18:1]),
    .bbone(databb[54:19]),
    .bbtwo(dataaa[54:19]),
    .cc(multtwonode));

  assign multonevector = multonenode;
  assign multtwovector = {zerovec,multtwonode[55:19]}; 
  dp_adds #(
      .width(72),
    .pipes(pipes - 3))
  adder(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .aa(multonevector),
    .bb(multtwovector),
    .carryin(gnd_w),
    .cc(result));


endmodule
//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_FXADD.V                                ***
//***                                             ***
//***   Function: Generic Fixed Point Adder       ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module dp_fxadd(
sysclk,
reset,
enable,
aa,
bb,
carryin,
cc
);

parameter [31:0] width=64;
parameter [31:0] pipes=1;
parameter [31:0] synthesize=0;
input sysclk;
input reset;
input enable;
input [width:1] aa, bb;
input carryin;
output [width:1] cc;

wire sysclk;
wire reset;
wire enable;
wire [width:1] aa;
wire [width:1] bb;
wire carryin;
wire [width:1] cc;



  generate if ((synthesize == 0)) begin
      dp_addb #(
          .width(width),
      .pipes(pipes))
    addone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(aa),
      .bb(bb),
      .carryin(carryin),
      .cc(cc));

  end
  endgenerate
  generate if ((synthesize == 1)) begin
      dp_adds #(
          .width(width),
      .pipes(pipes))
    addtwo(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(aa),
      .bb(bb),
      .carryin(carryin),
      .cc(cc));

  end
  endgenerate

endmodule

//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_MUL54US_29S.V                          ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   18-36 bit inputs, 3 pipes                 ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module fp_mul54us_29s(
sysclk,
reset,
enable,
mulaa,
mulbb,
mulcc
);

parameter [31:0] latency=5;
input sysclk;
input reset;
input enable;
input [54:1] mulaa;
input [54:1] mulbb;
output [72:1] mulcc;

wire sysclk;
wire reset;
wire enable;
wire [54:1] mulaa;
wire [54:1] mulbb;
wire [72:1] mulcc;


wire [36:1] muloneaa,mulonebb;
wire [18:1] multwoaa, multwobb, multhraa, multhrbb;
wire [18:1] mulforaa, mulforbb, mulfivaa, mulfivbb;
wire [18:1] mulsixaa, mulsixbb;
wire [72:1] muloneout;
wire [36:1] multwoout, multhrout, mulforout, mulfivout, mulsixout;

wire [72:1] vecone, vectwo, vecthr, vecfor, vecfiv;
wire [72:1] vecsix, vecsev, vecegt, vecnin, vecten;
wire [72:1] sumvecone, carvecone;
wire [72:1] sumvectwo, carvectwo;
wire [72:1] sumvecthr, carvecthr;
reg [72:1] sumoneff, caroneff;
reg [72:1] sumtwoff, cartwoff;
wire [72:1] resultnode;

wire [36:1] zerovec;

	 genvar k;
  integer j;

    generate for (k=1; k <= 36; k = k + 1) begin : gza
          assign zerovec[k] = 1'b 0;
    end
    endgenerate

  assign muloneaa =  mulaa[36:1];
  assign mulonebb =  mulbb[36:1];

  assign multwoaa =  mulaa[54:37];
  assign multwobb =  mulbb[18:1];
  assign multhraa =  mulaa[54:37];
  assign multhrbb =  mulbb[36:19];

  assign mulforaa =  mulbb[54:37];
  assign mulforbb =  mulaa[18:1];
  assign mulfivaa =  mulbb[54:37];
  assign mulfivbb =  mulaa[36:19];

  assign mulsixaa =  mulbb[54:37];
  assign mulsixbb =  mulaa[54:37];

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(36),
    .width_b(36),
    .width_result(72))
  mulone(
      .dataa(muloneaa),
    .datab(mulonebb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(muloneout));

  hcc_mul18usus multwo(
      .dataa_0(multwoaa),
    .datab_0(multwobb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multwoout));

  hcc_mul18usus multhr(
      .dataa_0(multhraa),
    .datab_0(multhrbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multhrout));

  hcc_mul18usus mulfor(
      .dataa_0(mulforaa),
    .datab_0(mulforbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulforout));

  hcc_mul18usus mulfiv(
      .dataa_0(mulfivaa),
    .datab_0(mulfivbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulfivout));

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(18),
    .width_b(18),
    .width_result(36))
  mulsix(
      .dataa(mulsixaa),
    .datab(mulsixbb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulsixout));

  assign vecone =  {zerovec[36:1],multwoout};
  assign vectwo =  {zerovec[18:1],multhrout,zerovec[18:1]};
  assign vecthr =  {zerovec[36:1],mulforout};
  assign vecfor =  {zerovec[18:1],mulfivout,zerovec[18:1]};

    generate for (k=1; k <= 72; k = k + 1) begin : gva
       assign sumvecone[k] = vecone[k] ^ vectwo[k] ^ vecthr[k];
       assign carvecone[k] = (vecone[k] & vectwo[k]) | (vectwo[k] & vecthr[k]) | (vecone[k] & vecthr[k]);
    end
    endgenerate

  assign vecfiv =  vecfor;
  assign vecsix =  sumvecone;
  assign vecsev =  {carvecone[71:1],1'b 0};

    generate for (k=1; k <= 72; k = k + 1) begin : gvb
       assign sumvectwo[k] = vecfiv[k] ^ vecsix[k] ^ vecsev[k];
       assign carvectwo[k] = (vecfiv[k] & vecsix[k]) | (vecsix[k] & vecsev[k]) | (vecfiv[k] & vecsev[k]);
    end
    endgenerate

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      for (j=1; j <= 72; j = j + 1) begin
        sumoneff[j] <= 1'b 0;
        caroneff[j] <= 1'b 0;
        sumtwoff[j] <= 1'b 0;
        cartwoff[j] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        sumoneff <= sumvectwo;
        caroneff <= {carvectwo[71:1],1'b 0};
        sumtwoff <= sumvecthr;
        cartwoff <= {carvecthr[71:1],1'b 0};
      end
    end
  end

  assign vecegt =  sumoneff;
  assign vecnin =  caroneff;
  assign vecten =  {mulsixout,muloneout[72:37]};

    generate for (k=1; k <= 72; k = k + 1) begin : gvc
       assign sumvecthr[k] = vecegt[k] ^ vecnin[k] ^ vecten[k];
       assign carvecthr[k] = (vecegt[k] & vecnin[k]) | (vecnin[k] & vecten[k]) | (vecegt[k] & vecten[k]);
    end
    endgenerate

  lpm_add_sub #(
      .lpm_direction("ADD"),
    .lpm_hint("ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO"), 
    .lpm_pipeline(latency-4),
    .lpm_type("LPM_ADD_SUB"),
    .lpm_width(72))
  adder(
      .dataa(sumtwoff[72:1]),
    .datab(cartwoff[72:1]),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(resultnode));

  assign mulcc = resultnode;

endmodule

//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   HCC_MUL54US_29S.V                         ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   18-36 bit inputs, 3 pipes                 ***
//***                                             ***
//***   21/04/09 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul54us_29s(
sysclk,
reset,
enable,
mulaa,
mulbb,
mulcc
);

input sysclk;
input reset;
input enable;
input [54:1] mulaa;
input [54:1] mulbb;
output [64:1] mulcc;

wire sysclk;
wire reset;
wire enable;
wire [54:1] mulaa;
wire [54:1] mulbb;
wire [64:1] mulcc;


wire [36:1] muloneaa,mulonebb;
wire [18:1] multwoaa, multwobb, multhraa, multhrbb;
wire [18:1] mulforaa, mulforbb, mulfivaa, mulfivbb;
wire [18:1] mulsixaa, mulsixbb;
wire [72:1] muloneout;
wire [36:1] multwoout, multhrout, mulforout, mulfivout, mulsixout;

wire [72:1] vecone, vectwo, vecthr, vecfor, vecfiv;
wire [72:1] vecsix, vecsev, vecegt, vecnin, vecten;
wire [72:1] sumvecone, carvecone;
wire [72:1] sumvectwo, carvectwo;
wire [72:1] sumvecthr, carvecthr;
reg [72:1] sumoneff, caroneff;
reg [72:1] sumtwoff, cartwoff;
wire [64:1] resultnode;

wire [36:1] zerovec;

	genvar k;
	integer j;

    generate for (k=1; k <= 36; k = k + 1) begin : gza
          assign zerovec[k] = 1'b 0;
    end
    endgenerate

  assign muloneaa =  mulaa[36:1];
  assign mulonebb =  mulbb[36:1];

  assign multwoaa =  mulaa[54:37];
  assign multwobb =  mulbb[18:1];
  assign multhraa =  mulaa[54:37];
  assign multhrbb =  mulbb[36:19];

  assign mulforaa =  mulbb[54:37];
  assign mulforbb =  mulaa[18:1];
  assign mulfivaa =  mulbb[54:37];
  assign mulfivbb =  mulaa[36:19];

  assign mulsixaa =  mulbb[54:37];
  assign mulsixbb =  mulaa[54:37];

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(36),
    .width_b(36),
    .width_result(72))
  mulone(
      .dataa(muloneaa),
    .datab(mulonebb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(muloneout));

  hcc_mul18usus multwo(
      .dataa_0(multwoaa),
    .datab_0(multwobb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multwoout));

  hcc_mul18usus multhr(
      .dataa_0(multhraa),
    .datab_0(multhrbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multhrout));

  hcc_mul18usus mulfor(
      .dataa_0(mulforaa),
    .datab_0(mulforbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulforout));

  hcc_mul18usus mulfiv(
      .dataa_0(mulfivaa),
    .datab_0(mulfivbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulfivout));

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(18),
    .width_b(18),
    .width_result(36))
  mulsix(
      .dataa(mulsixaa),
    .datab(mulsixbb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulsixout));

  assign vecone =  {zerovec[36:1],multwoout};
  assign vectwo =  {zerovec[18:1],multhrout,zerovec[18:1]};
  assign vecthr =  {zerovec[36:1],mulforout};
  assign vecfor =  {zerovec[18:1],mulfivout,zerovec[18:1]};

    generate for (k=1; k <= 72; k = k + 1) begin : gva
       assign sumvecone[k] = vecone[k] ^ vectwo[k] ^ vecthr[k];
       assign carvecone[k] = (vecone[k] & vectwo[k]) | (vectwo[k] & vecthr[k]) | (vecone[k] & vecthr[k]);
    end
    endgenerate

  assign vecfiv =  vecfor;
  assign vecsix =  sumvecone;
  assign vecsev =  {carvecone[71:1],1'b 0};

    generate for (k=1; k <= 72; k = k + 1) begin : gvb
       assign sumvectwo[k] = vecfiv[k] ^ vecsix[k] ^ vecsev[k];
       assign carvectwo[k] = (vecfiv[k] & vecsix[k]) | (vecsix[k] & vecsev[k]) | (vecfiv[k] & vecsev[k]);
    end
    endgenerate

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      for (j=1; j <= 72; j = j + 1) begin
        sumoneff[j] <= 1'b 0;
        caroneff[j] <= 1'b 0;
        sumtwoff[j] <= 1'b 0;
        cartwoff[j] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        sumoneff <= sumvectwo;
        caroneff <= {carvectwo[71:1],1'b 0};
        sumtwoff <= sumvecthr;
        cartwoff <= {carvecthr[71:1],1'b 0};
      end
    end
  end

  assign vecegt =  sumoneff;
  assign vecnin =  caroneff;
  assign vecten =  {mulsixout,muloneout[72:37]};

    generate for (k=1; k <= 72; k = k + 1) begin : gvc
       assign sumvecthr[k] = vecegt[k] ^ vecnin[k] ^ vecten[k];
       assign carvecthr[k] = (vecegt[k] & vecnin[k]) | (vecnin[k] & vecten[k]) | (vecegt[k] & vecten[k]);
    end
    endgenerate

  lpm_add_sub #(
      .lpm_direction("ADD"),
    .lpm_hint("ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO"), 
    .lpm_pipeline(2),
    .lpm_type("LPM_ADD_SUB"),
    .lpm_width(64))
  adder(
      .dataa(sumtwoff[72:9]),
    .datab(cartwoff[72:9]),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(resultnode));

  assign mulcc = resultnode;

endmodule

//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   HCC_MUL54US_3XS.V                         ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   3XS: Stratix 3, 10 18x18, synthesizeable  ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul54us_3xs(
sysclk,
reset,
enable,
mulaa,
mulbb,
mulcc
);

input sysclk;
input reset;
input enable;
input [54:1] mulaa;
input [54:1] mulbb;
output [64:1] mulcc;

wire sysclk;
wire reset;
wire enable;
wire [54:1] mulaa;
wire [54:1] mulbb;
wire [64:1] mulcc;

  lpm_mult #(
      .lpm_hint("MAXIMIZE_SPEED=5"),
    .lpm_pipeline(4),
    .lpm_representation("UNSIGNED"),
    .lpm_type("LPM_MULT"),
    .lpm_widtha(54),
    .lpm_widthb(54),
    .lpm_widthp(64))
  lpm_mult_component(
      .dataa(mulaa),
    .datab(mulbb),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(mulcc));

endmodule

//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_MUL3S.V                                ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   18-36 bit inputs, 3 pipes                 ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module fp_mul3s(
sysclk,
reset,
enable,
dataaa,
databb,
result
);

parameter [31:0] widthaa=18;
parameter [31:0] widthbb=18;
parameter [31:0] widthcc=36;
input sysclk;
input reset;
input enable;
input [widthaa:1] dataaa;
input [widthbb:1] databb;
output [widthcc:1] result;

wire sysclk;
wire reset;
wire enable;
wire [widthaa:1] dataaa;
wire [widthbb:1] databb;
wire [widthcc:1] result;


wire [widthaa + widthbb:1] resultnode;

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(widthaa),
    .width_b(widthbb),
    .width_result(widthaa + widthbb))
  mulone(
      .dataa(dataaa),
    .datab(databb),
    .datac(22'b0),
    .coefsel0(3'b0),
    .coefsel1(3'b0),
    .coefsel2(3'b0),
    .coefsel3(3'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(resultnode),.scanina (),
.scaninb (),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);

  assign result = resultnode[widthaa + widthbb:widthaa + widthbb - widthcc + 1];

endmodule
//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_MUL2S.V                                ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   18-36 bit inputs, 2 pipes                 ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module fp_mul2s(
sysclk,
reset,
enable,
dataaa,
databb,
result
);

parameter [31:0] widthaa=18;
parameter [31:0] widthbb=18;
parameter [31:0] widthcc=36;
input sysclk;
input reset;
input enable;
input [widthaa:1] dataaa;
input [widthbb:1] databb;
output [widthcc:1] result;

wire sysclk;
wire reset;
wire enable;
wire [widthaa:1] dataaa;
wire [widthbb:1] databb;
wire [widthcc:1] result;


wire [widthaa + widthbb:1] resultnode;

  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_register("UNREGISTERED"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(widthaa),
    .width_b(widthbb),
    .width_result(widthaa + widthbb))
  ALTMULT_ADD_component(
      .dataa(dataaa),
    .datab(databb),
    .datac(22'b0),
    .coefsel0(3'b0),
    .coefsel1(3'b0),
    .coefsel2(3'b0),
    .coefsel3(3'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(resultnode),.scanina (),
.scaninb (),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);

  assign result = resultnode[widthaa + widthbb:widthaa + widthbb - widthcc + 1];

endmodule
//***************************************************
//***                                             ***
//***   FLOATING POINT CORE LIBRARY               ***
//***                                             ***
//***   FP_MUL5454_8MS2S.V                        ***
//***                                             ***
//***   Function: Fixed Point Multiplier          ***
//***                                             ***
//***   54x54b input, 72b output, 5/6 pipes       ***
//***                                             ***
//***   31/01/08 ML                               ***
//***                                             ***
//***   (c) 2008 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
//***************************************************
//*** SII specific, 8 18x18 multiplier version    ***
//***************************************************
`timescale 1 ps / 1 ps

module fp_mul5454_8ms2s(
sysclk,
reset,
enable,
dataaa,
databb,
result
);

parameter [31:0] synthesize=0;
parameter [31:0] pipes=2;
input sysclk;
input reset;
input enable;
input [54:1] dataaa;
input [54:1] databb;
output [72:1] result;

wire sysclk;
wire reset;
wire enable;
wire [54:1] dataaa;
wire [54:1] databb;
wire [72:1] result;


wire [34:1] zerovec;
wire [72:1] muloneout;
wire [36:1] multwoout; wire [36:1] multhrout;
wire [36:1] mulforout; wire [36:1] mulfivout;
wire [36:1] vecone; wire [36:1] vectwo; wire [36:1] vecthr;
wire [36:1] sumone; wire [36:1] carone;
wire [37:1] vecfor; wire [37:1] vecfiv; wire [37:1] vecsix;
wire [37:1] sumtwo; wire [37:1] cartwo;
reg [38:1] sumtwoff; reg [38:1] cartwoff;
wire [72:1] vecsev; wire [72:1] vecegt; wire [72:1] vecnin;
wire [72:1] sumthr; wire [72:1] carthr;
reg [72:1] sumthrff; reg [72:1] carthrff;
//wire gnd_w;

  //assign gnd_w = 1'b 0;
  //ABC x
  //DEF
  //------
  //ABDE
  //  AF
  //   BF
  //  DC
  //   EC
  //
  // add topgether 72 MSBs
  genvar k;
  generate for (k=1; k <= 34; k = k + 1) begin : gza
      assign zerovec[k] = 1'b 0;
  end
  endgenerate
  fp_mul3s #(
      .widthaa(36),
    .widthbb(36),
    .widthcc(72))
  mulone(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .dataaa(dataaa[54:19]),
    .databb(databb[54:19]),
    .result(muloneout));

  fp_mul2s #(
      .widthaa(18),
    .widthbb(18),
    .widthcc(36))
  multwo(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .dataaa(dataaa[54:37]),
    .databb(databb[18:1]),
    .result(multwoout));

  fp_mul2s #(
      .widthaa(18),
    .widthbb(18),
    .widthcc(36))
  multhr(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .dataaa(dataaa[36:19]),
    .databb(databb[18:1]),
    .result(multhrout));

  fp_mul2s #(
      .widthaa(18),
    .widthbb(18),
    .widthcc(36))
  mulfor(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .dataaa(databb[54:37]),
    .databb(dataaa[18:1]),
    .result(mulforout));

  fp_mul2s #(
      .widthaa(18),
    .widthbb(18),
    .widthcc(36))
  mulfiv(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .dataaa(databb[36:19]),
    .databb(dataaa[18:1]),
    .result(mulfivout));

  assign vecone = multwoout;
  assign vectwo = {zerovec[18:1],multhrout[36:19]};
  assign vecthr = mulforout;

  generate for (k=1; k <= 36; k = k + 1) begin : gca
      assign sumone[k] = vecone[k] ^ vectwo[k] ^ vecthr[k];
    assign carone[k] = ((vecone[k] & vectwo[k])) | ((vecone[k] & vecthr[k])) | ((vectwo[k] & vecthr[k]));
  end
  endgenerate
  assign vecfor = {1'b 0,sumone};
  assign vecfiv = {carone,1'b 0};
  assign vecsix = {zerovec[19:1],mulfivout[36:19]};

  generate for (k=1; k <= 37; k = k + 1) begin : gcb
      assign sumtwo[k] = vecfor[k] ^ vecfiv[k] ^ vecsix[k];
    assign cartwo[k] = ((vecfor[k] & vecfiv[k])) | ((vecfor[k] & vecsix[k])) | ((vecfiv[k] & vecsix[k]));
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
        sumtwoff <= 38'b 0;
        cartwoff <= 38'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        sumtwoff <= {1'b 0,sumtwo};
        cartwoff <= {cartwo,1'b 0};
      end
    end
  end

  assign vecsev = {zerovec[34:1],sumtwoff};
  assign vecegt = {zerovec[34:1],cartwoff};
  assign vecnin = muloneout;

  generate for (k=1; k <= 72; k = k + 1) begin : gcc
      assign sumthr[k] = vecsev[k] ^ vecegt[k] ^ vecnin[k];
    assign carthr[k] = ((vecsev[k] & vecegt[k])) | ((vecsev[k] & vecnin[k])) | ((vecegt[k] & vecnin[k]));
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
        sumthrff <= 72'b 0;
        carthrff <= 72'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        sumthrff <= sumthr;
        carthrff <= {carthr[71:1],1'b 0};
      end
    end
  end

  dp_fxadd #(
      .width(72),
    .pipes(pipes - 4),
    .synthesize(synthesize))
  adder(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .aa(sumthrff),
    .bb(carthrff),
    .carryin(1'b 0),
    .cc(result));


endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULUFP54.V                            ***
//***                                             ***
//***   Function: Double precision multiplier     ***
//***             core (unsigned mantissa)        ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mulufp54(
sysclk,
reset,
enable,
aaman,
aaexp,
aasat,
aazip,
aanan,
bbman,
bbexp,
bbsat,
bbzip,
bbnan,
ccman,
ccexp,
ccsat,
cczip,
ccnan
);

parameter [31:0] doubleaccuracy=0;
parameter [31:0] device=0;
parameter [31:0] synthesize=1;
// 0 = behavioral, 1 = instantiated
input sysclk;
input reset;
input enable;
input [54:1] aaman;
input [13:1] aaexp;
input aasat, aazip, aanan;
input [54:1] bbman;
input [13:1] bbexp;
input bbsat, bbzip, bbnan;
output [64:1] ccman;
output [13:1] ccexp;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [54:1] aaman;
wire [13:1] aaexp;
wire aasat;
wire aazip;
wire aanan;
wire [54:1] bbman;
wire [13:1] bbexp;
wire bbsat;
wire bbzip;
wire bbnan;
wire [64:1] ccman;
wire [13:1] ccexp;
wire ccsat;
wire cczip;
wire ccnan;


parameter normtype = 0;  //type expfftype IS ARRAY (5 DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
parameter pipedepth = 5 - 2*device;  //type expfftype IS ARRAY (5 DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
wire [64:1] mulout;
reg [13:1] aaexpff; reg [13:1] bbexpff;  //signal expff : expfftype; 
reg [13:1] expff [pipedepth:1];
//reg [13:1] expff_2;
//reg [13:1] expff_3;
//reg [13:1] expff_4;
//reg [13:1] expff_5;
reg aasatff; reg aazipff; reg aananff; reg bbsatff; reg bbzipff; reg bbnanff;
reg [pipedepth:1] ccsatff; reg [pipedepth:1] cczipff; reg [pipedepth:1] ccnanff;

  // 54 bit mantissa, signed normalized input
  // [S ][1 ][M...M]
  // [54][53][52..1]
  // multiplier outputs (result < 2)
  // [S....S][1 ][M*M...][X...X]
  // [72..70][69][68..17][16..1]
  // multiplier outputs (result >= 2)
  // [S....S][1 ][M*M...][X...X]
  // [72..71][70][69..18][17..1]
  // assume that result > 2
  // output [71..8] for 64 bit mantissa out
integer k;
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaexpff <= 13'b 0000000000000;
      bbexpff <= 13'b 0000000000000;
      //FOR k IN 1 TO pipedepth LOOP
      for (k=1; k <= pipedepth; k = k + 1) begin
        expff[k] <= 13'b 0;
      end
      //END LOOP;
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      bbsatff <= 1'b 0;
      bbzipff <= 1'b 0;
      bbnanff <= 1'b 0;
      ccsatff <= 5'b 00000;
      cczipff <= 5'b 00000;
      ccnanff <= 5'b 00000;
    end else begin
      if((enable == 1'b 1)) begin
        aasatff <= aasat;
        aazipff <= aazip;
        aananff <= aanan;
        bbsatff <= bbsat;
        bbzipff <= bbzip;
        bbnanff <= bbnan;
        ccsatff[1] <= aasatff | bbsatff;
        for (k=2; k <= pipedepth; k = k + 1) begin
          ccsatff[k] <= ccsatff[k - 1];
        end
        cczipff[1] <= aazipff | bbzipff;
        for (k=2; k <= pipedepth; k = k + 1) begin
          cczipff[k] <= cczipff[k - 1];
        end
        ccnanff[1] <= aananff | bbnanff | (aazipff & bbsatff) | (bbzipff & aasatff);
        for (k=2; k <= pipedepth; k = k + 1) begin
          ccnanff[k] <= ccnanff[k - 1];
        end
        aaexpff <= aaexp;
        bbexpff <= bbexp;
        expff[1][13:1] <= aaexpff + bbexpff - 13'b 0001111111111; 
        expff[2][13:1] <= ((expff[1][13:1] | ccsatff[1])) &  ~((cczipff[1]));
        //FOR k IN 3 TO pipedepth LOOP
        for (k=3; k <= pipedepth; k = k + 1) begin
          expff[k][13:1] <= expff[k-1][13:1];
        end
        //END LOOP;
      end
    end
  end

  generate if ((synthesize == 0)) begin
      hcc_mul54usb #(
          .doubleaccuracy(doubleaccuracy),
      .device(device))
    bmult(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .aa(aaman),
      .bb(bbman),
      .cc(mulout));

  end
  endgenerate
  generate if ((synthesize == 1)) begin : gsb
    if (device == 0 & doubleaccuracy == 0) begin
      hcc_mul54us_28s smone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));
    end

    if (device == 0 & doubleaccuracy == 1) begin
      hcc_mul54us_29s smone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));
    end

    if (device == 1 & doubleaccuracy == 0) begin
      hcc_mul54us_38s smone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));
    end

    if (device == 1 & doubleaccuracy == 1) begin
      hcc_mul54us_3xs smone(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .mulaa(aaman),
      .mulbb(bbman),
      .mulcc(mulout));
    end

  end
  endgenerate
  //***************
  //*** OUTPUTS ***
  //***************
  assign ccman = mulout;
  assign ccexp = expff[pipedepth][13:1];
  assign ccsat = ccsatff[pipedepth];
  assign cczip = cczipff[pipedepth];
  assign ccnan = ccnanff[pipedepth];

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MUL54USS.V                            ***
//***                                             ***
//***   Function: 6 pipeline stage unsigned 54    ***
//***             bit multiplier (synthesizable)  ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul54uss(
sysclk,
reset,
enable,
mulaa,
mulbb,
mulcc
);

input sysclk;
input reset;
input enable;
input [54:1] mulaa, mulbb;
output [64:1] mulcc;

wire sysclk;
wire reset;
wire enable;
wire [54:1] mulaa;
wire [54:1] mulbb;
wire [64:1] mulcc;


wire [36:1] muloneaa; wire [36:1] mulonebb;
wire [18:1] multwoaa; wire [18:1] multwobb; wire [18:1] multhraa; wire [18:1] multhrbb; 
wire [18:1] mulforaa; wire [18:1] mulforbb; wire [18:1] mulfivaa; wire [18:1] mulfivbb; 
wire [18:1] mulsixaa; wire [18:1] mulsixbb;
wire [72:1] muloneout;
wire [36:1] multwoout; wire [36:1] multhrout; wire [36:1] mulforout; wire [36:1] mulfivout; wire [36:1] mulsixout;
wire [72:1] vecone; wire [72:1] vectwo; wire [72:1] vecthr; wire [72:1] vecfor; wire [72:1] vecfiv; 
wire [72:1] vecsix; wire [72:1] vecsev; wire [72:1] vecegt; wire [72:1] vecnin; wire [72:1] vecten; 
wire [72:1] sumvecone; wire [72:1] carvecone;
wire [72:1] sumvectwo; wire [72:1] carvectwo;
wire [72:1] sumvecthr; wire [72:1] carvecthr;
reg [72:1] sumoneff; reg [72:1] caroneff;
reg [72:1] sumtwoff; reg [72:1] cartwoff;
wire [64:1] resultnode;
wire [36:1] zerovec;
// identical component to that above, but fixed at 18x18, latency 2
// mul18usus generated by Quartus

  genvar k;
  assign zerovec = 36'b 0;
  assign muloneaa = mulaa[36:1];
  assign mulonebb = mulbb[36:1];
  assign multwoaa = mulaa[54:37];
  assign multwobb = mulbb[18:1];
  assign multhraa = mulaa[54:37];
  assign multhrbb = mulbb[36:19];
  assign mulforaa = mulbb[54:37];
  assign mulforbb = mulaa[18:1];
  assign mulfivaa = mulbb[54:37];
  assign mulfivbb = mulaa[36:19];
  assign mulsixaa = mulbb[54:37];
  assign mulsixbb = mulaa[54:37];
  // {C,A) * {D,B}
  // CAA
  // DBB
  // AA*BB 36x36=72, latency 3
  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(36),
    .width_b(36),
    .width_result(72))
  mulone(
      .dataa(muloneaa),
    .datab(mulonebb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(muloneout),.scanina ({36{1'b0}}),
.scaninb ({36{1'b0}}),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);

  //	Blo*C 18*18 = 36, latency = 2
  hcc_mul18usus multwo(
      .dataa_0(multwoaa),
    .datab_0(multwobb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multwoout));

  //	Bhi*C 18*18 = 36, latency = 2
  hcc_mul18usus multhr(
      .dataa_0(multhraa),
    .datab_0(multhrbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(multhrout));

  //	Alo*D 18*18 = 36, latency = 2
  hcc_mul18usus mulfor(
      .dataa_0(mulforaa),
    .datab_0(mulforbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulforout));

  //	Ahi*D 18*18 = 36, latency = 2
  hcc_mul18usus mulfiv(
      .dataa_0(mulfivaa),
    .datab_0(mulfivbb),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulfivout));

  //	C*D 18*18 = 36, latency = 3
  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_aclr("ACLR3"),
    .output_register("CLOCK0"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(18),
    .width_b(18),
    .width_result(36))
  mulsix(
      .dataa(mulsixaa),
    .datab(mulsixbb),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(sysclk),
    .aclr3(reset),
    .ena0(enable),
    .result(mulsixout),.scanina ({18{1'b0}}),
.scaninb ({18{1'b0}}),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);

  assign vecone = {zerovec[36:1],multwoout};
  assign vectwo = {zerovec[18:1],multhrout,zerovec[18:1]}; 
  assign vecthr = {zerovec[36:1],mulforout};
  assign vecfor = {zerovec[18:1],mulfivout,zerovec[18:1]}; 

  generate for (k=1; k <= 72; k = k + 1) begin : gva
      assign sumvecone[k] = vecone[k] ^ vectwo[k] ^ vecthr[k]; 
    assign carvecone[k] = ((vecone[k] & vectwo[k])) | ((vectwo[k] & vecthr[k])) | ((vecone[k] & vecthr[k]));
  end
  endgenerate
  assign vecfiv = vecfor;
  assign vecsix = sumvecone;
  assign vecsev = {carvecone[71:1],1'b 0};

  generate for (k=1; k <= 72; k = k + 1) begin : gvb
      assign sumvectwo[k] = vecfiv[k] ^ vecsix[k] ^ vecsev[k]; 
    assign carvectwo[k] = ((vecfiv[k] & vecsix[k])) | ((vecsix[k] & vecsev[k])) | ((vecfiv[k] & vecsev[k]));
  end
  endgenerate
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      sumoneff <= 72'b 0;
      caroneff <= 72'b 0;
      sumtwoff <= 72'b 0;
      cartwoff <= 72'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        sumoneff <= sumvectwo;
        caroneff <= {carvectwo[71:1],1'b 0};
        sumtwoff <= sumvecthr;
        cartwoff <= {carvecthr[71:1],1'b 0};
      end
    end
  end

  assign vecegt = sumoneff;
  assign vecnin = caroneff;
  assign vecten = {mulsixout,muloneout[72:37]};

  generate for (k=1; k <= 72; k = k + 1) begin : gvc
      assign sumvecthr[k] = vecegt[k] ^ vecnin[k] ^ vecten[k]; 
    assign carvecthr[k] = ((vecegt[k] & vecnin[k])) | ((vecnin[k] & vecten[k])) | ((vecegt[k] & vecten[k]));
  end
  endgenerate
  // according to marcel, 2 pipes = 1 pipe in middle, on on output 
  lpm_add_sub #(
      .lpm_direction("ADD"),
    .lpm_hint("ONE_INPUT_IS_CONSTANT=NO,CIN_USED=NO"), 
    .lpm_pipeline(2),
    .lpm_type("LPM_ADD_SUB"),
    .lpm_width(64))
  adder(
      .dataa(sumtwoff[72:9]),
    .datab(cartwoff[72:9]),
    .clken(enable),
    .aclr(reset),
    .clock(sysclk),
    .result(resultnode),.cin(),.add_sub(),.cout(),.overflow());

  assign mulcc = resultnode;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MUL18USUS.V                           ***
//***                                             ***
//***   Function: 3 pipeline stage unsigned 18    ***
//***             bit multiplier                  ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_mul18usus(
aclr3,
clock0,
dataa_0,
datab_0,
ena0,
result
);

input aclr3;
//  := '0';
input clock0;
//  := '1';
input [17:0] dataa_0;
// :=  (OTHERS => '0');
input [17:0] datab_0;
// :=  (OTHERS => '0');
input ena0;
//  := '1';
output [35:0] result;

wire aclr3;
wire clock0;
wire [17:0] dataa_0;
wire [17:0] datab_0;
wire ena0;
wire [35:0] result;


wire [35:0] sub_wire0;

  assign result = sub_wire0[35:0];
  altmult_add #(
      .addnsub_multiplier_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_aclr1("ACLR3"),
    .addnsub_multiplier_pipeline_register1("CLOCK0"),
    .addnsub_multiplier_register1("CLOCK0"),
    .dedicated_multiplier_circuitry("AUTO"),
    .input_aclr_a0("ACLR3"),
    .input_aclr_b0("ACLR3"),
    .input_register_a0("CLOCK0"),
    .input_register_b0("CLOCK0"),
    .input_source_a0("DATAA"),
    .input_source_b0("DATAB"),
    .intended_device_family("Stratix III"),
    .lpm_type("altmult_add"),
    .multiplier1_direction("ADD"),
    .multiplier_aclr0("ACLR3"),
    .multiplier_register0("CLOCK0"),
    .number_of_multipliers(1),
    .output_register("UNREGISTERED"),
    .port_addnsub1("PORT_UNUSED"),
    .port_signa("PORT_UNUSED"),
    .port_signb("PORT_UNUSED"),
    .representation_a("UNSIGNED"),
    .representation_b("UNSIGNED"),
    .signed_aclr_a("ACLR3"),
    .signed_aclr_b("ACLR3"),
    .signed_pipeline_aclr_a("ACLR3"),
    .signed_pipeline_aclr_b("ACLR3"),
    .signed_pipeline_register_a("CLOCK0"),
    .signed_pipeline_register_b("CLOCK0"),
    .signed_register_a("CLOCK0"),
    .signed_register_b("CLOCK0"),
    .width_a(18),
    .width_b(18),
    .width_result(36))
  ALTMULT_ADD_component(
      .dataa(dataa_0),
    .datab(datab_0),
    .datac(1'b0),
    .coefsel0(1'b0),
    .coefsel1(1'b0),
    .coefsel2(1'b0),
    .coefsel3(1'b0),
    .clock0(clock0),
    .aclr3(aclr3),
    .ena0(ena0),
    .result(sub_wire0),.scanina ({18{1'b0}}),
.scaninb ({18{1'b0}}),

.sourcea (),
.sourceb (),
.clock3 (1'b1),
.clock2 (1'b1),
.clock1 (1'b1),
.aclr2 (1'b0),
.aclr1 (1'b0),
.aclr0 (1'b0),
.ena3 (1'b1),
.ena2 (1'b1),
.ena1 (1'b1),
.signa (1'b0),
.signb (1'b0),
.addnsub1 (1'b1),
.addnsub3 (1'b1),
.scanouta (),
.scanoutb (),
.mult01_round (1'b0),
.mult23_round (1'b0),
.mult01_saturation (1'b0),
.mult23_saturation (1'b0),
.addnsub1_round (1'b0),
.addnsub3_round (1'b0),
.mult0_is_saturated (),
.mult1_is_saturated (),
.mult2_is_saturated (),
.mult3_is_saturated (),
.output_round (1'b0),
.chainout_round (1'b0),
.output_saturate (1'b0),
.chainout_saturate (1'b0),
.overflow (),
.chainout_sat_overflow (),
.chainin (1'b0),
.zero_chainout (1'b0),
.rotate (1'b0),
.shift_right (1'b0),
.zero_loopback (1'b0),
.accum_sload (1'b0)
);


endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_MULFP2X.V                             ***
//***                                             ***
//***   Function: Double precision multiplier     ***
//***             (unsigned mantissa)             ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***   28/01/08 - see below                      ***
//***                                             ***
//***                                             ***
//***************************************************
// 28/01/08 - correct manoverflow for ieee output, effects of mantissa shift 
// for both ieee and mult output, test output widths, also reversed exp and man 
// order in ieee output
// 31/08/08 - behavioral and synth mults both now return "001X" (> 2) OR "0001X" (<2) 
// change xoutput to 1 bit less right shift (behavioral mult changed)
`timescale 1 ps / 1 ps

module hcc_mulfp2x(
sysclk,
reset,
enable,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] ieeeoutput=0;
parameter [31:0] xoutput=1;
parameter [31:0] multoutput=0;
parameter [31:0] roundconvert=0;
parameter [31:0] roundnormalize=0;
parameter [31:0] doublespeed=1;
parameter [31:0] outputpipe=0;
parameter [31:0] doubleaccuracy=0;
parameter [31:0] device=0;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input [67:1] aa;
input aasat, aazip, aanan;
input [67:1] bb;
input bbsat, bbzip, bbnan;
output [64 + 13 * xoutput + 3 * multoutput:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire [67:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [67:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [64 + 13 * xoutput + 3 * multoutput:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


parameter signdepth = 5 - 2*device;
//type ccxexpdelfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1); 
//type cceexpdelfftype IS ARRAY (2 DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1); 
wire [64:1] zerovec;  // multiplier core interface
wire [54:1] mulinaaman; wire [54:1] mulinbbman;
wire [13:1] mulinaaexp; wire [13:1] mulinbbexp;
wire mulinaasat; wire mulinaazip; wire mulinaanan;
wire mulinbbsat; wire mulinbbzip; wire mulinbbnan;
wire mulinaasign; wire mulinbbsign;
reg mulinaasignff; reg mulinbbsignff;
reg [signdepth:1] mulsignff;
wire [64:1] ccmannode;
wire [13:1] ccexpnode;
wire ccsatnode; wire cczipnode; wire ccnannode; // output section (x out) 
wire [64:1] ccmanshiftnode; wire [64:1] signedccxmannode;
wire [64:1] ccxroundnode;
reg [64:1] ccxroundff;
reg [13:1] ccxexpff;
reg ccxsatff; reg ccxzipff; reg ccxnanff; //signal ccxexpdelff : ccxexpdelfftype; 
reg [13:1] ccxexpdelff_1;
reg [13:1] ccxexpdelff_2;
reg [2:1] ccxsatdelff; reg [2:1] ccxzipdelff; reg [2:1] ccxnandelff; // output section (ieeeout) 
wire shiftroundbit;
wire [55:1] cceroundnode;
wire [54:1] cceround;
wire [54:1] cceroundcarry;
wire [52:1] ccemannode;
reg [52:1] ccemanoutff;
reg [11:1] cceexpoutff;
reg ccesignbitff;
reg [54:1] cceroundff;
reg [13:1] cceexpff;
reg ccesatff; reg ccezipff; reg ccenanff;
reg [2:1] ccesignff;  //signal cceexpdelff : cceexpdelfftype;
reg [13:1] cceexpdelff_1;
reg [13:1] cceexpdelff_2;
reg [2:1] ccesatdelff; reg [2:1] ccezipdelff; reg [2:1] ccenandelff;
reg [3:1] ccesigndelff;
wire [13:1] cceexpbase; wire [13:1] cceexpplus;
wire ccesatbase; wire ccezipbase; wire ccenanbase;
wire cceexpmax; wire cceexpzero;
wire manoutzero; wire manoutmax; wire expoutzero; wire expoutmax;
wire manoverflow;  // output section (multout)
wire shiftmanbit;
wire [54:1] manshiftnode;
reg [54:1] manshiftff;
reg [13:1] ccexpdelff;
reg ccsatdelff; reg cczipdelff; reg ccnandelff;
reg muloutsignff;  // debug
wire [13:1] aaexp; wire [13:1] bbexp; wire [11 + 2*multoutput + 2*xoutput:1] ccexp;
wire [54:1] aaman; wire [54:1] bbman;
wire [54+10*xoutput:1] ccman;

  genvar k;
  integer j;

  assign zerovec = 64'b 0;
  //************************************************** 
  //***                                            *** 
  //*** Input Section - Normalization, if required *** 
  //***                                            *** 
  //************************************************** 
  //******************************************************** 
  //*** NOTE THAT IN ALL CASES SIGN BIT IS PACKED IN MSB *** 
  //*** OF UNSIGNED MULTIPLIER                           *** 
  //******************************************************** 
  //*** ieee754 input when multiplier input is from cast *** 
  //*** cast now creates different                       *** 
  //*** formats for multiplier, divider, and alu         *** 
  //*** multiplier format [S][1][mantissa....]           *** 
  //******************************************************** 
  //******************************************************** 
  //*** if input from another double multiplier (special *** 
  //*** output mode normalizes to 54 bit mantissa and    *** 
  //*** 13 bit exponent                                  *** 
  //*** multiplier format [S][1][mantissa....]           *** 
  //******************************************************** 
  //******************************************************** 
  //*** if input from internal format, must be normed    *** 
  //*** by normfp2x first, creates [S][1][mantissa...]   *** 
  //******************************************************** 
  assign mulinaaman = {1'b 0,aa[66:14]};
  assign mulinaaexp = aa[13:1];
  assign mulinbbman = {1'b 0,bb[66:14]};
  assign mulinbbexp = bb[13:1];
  assign mulinaasat = aasat;
  assign mulinaazip = aazip;
  assign mulinaanan = aanan;
  assign mulinbbsat = bbsat;
  assign mulinbbzip = bbzip;
  assign mulinbbnan = bbnan;
  // signbits packed in MSB of mantissas
  assign mulinaasign = aa[67];
  assign mulinbbsign = bb[67];
  //************************************************** 
  //***                                            *** 
  //*** Multiplier Section                         *** 
  //***                                            *** 
  //************************************************** 
  hcc_mulufp54 #(
      .doubleaccuracy(doubleaccuracy),
      .device(device),
      .synthesize(synthesize))
  mult(
      .sysclk(sysclk),
    .reset(reset),
    .enable(enable),
    .aaman(mulinaaman),
    .aaexp(mulinaaexp),
    .aasat(mulinaasat),
    .aazip(mulinaazip),
    .aanan(mulinaanan),
    .bbman(mulinbbman),
    .bbexp(mulinbbexp),
    .bbsat(mulinbbsat),
    .bbzip(mulinbbzip),
    .bbnan(mulinbbnan),
    .ccman(ccmannode),
    .ccexp(ccexpnode),
    .ccsat(ccsatnode),
    .cczip(cczipnode),
    .ccnan(ccnannode));

  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      mulinaasignff <= 1'b 0;
      mulinbbsignff <= 1'b 0;
      for (j=1; j <= signdepth; j = j + 1) begin
        mulsignff[j] <= 1'b 0;
      end
    end else begin
      if((enable == 1'b 1)) begin
        mulinaasignff <= mulinaasign;
        mulinbbsignff <= mulinbbsign;
        mulsignff[1] <= mulinaasignff ^ mulinbbsignff; 
        for (j=2; j <= signdepth; j = j + 1) begin
          mulsignff[j] <= mulsignff[j - 1];
        end
      end
    end
  end

  //************************************************** 
  //***                                            *** 
  //*** Output Section                             *** 
  //***                                            *** 
  //************************************************** 
  //******************************************************** 
  //*** internal format output, convert back to signed   *** 
  //*** no need for fine normalization                   *** 
  //******************************************************** 
  generate if ((xoutput == 1)) begin
      // result will be "001X" (>2) or "0001X" (<2)
    // Y is SSSSS1 (<2) - therefore right shift 2 bits 
    // 31/08/08 - behavioral mult changed to be same as synth one
    assign ccmanshiftnode = {2'b 00,ccmannode[64:3]};
    for (k=1; k <= 64; k = k + 1) begin : goxb
          assign signedccxmannode[k] = ccmanshiftnode[k] ^ mulsignff[signdepth]; 
    end

    if ((roundconvert == 0 && outputpipe == 0)) begin
          //*** OUTPUTS ***
      assign cc[77:14] = signedccxmannode;
      assign cc[13:1] = ccexpnode;
      assign ccsat = ccsatnode;
      assign cczip = cczipnode;
      assign ccnan = ccnannode;
    end

    if (((roundconvert == 0 && outputpipe == 1) || (roundconvert == 1 && doublespeed == 0))) begin
      if ((roundconvert == 0)) begin
              assign ccxroundnode = signedccxmannode;
      end

      if ((roundconvert == 1)) begin
              assign ccxroundnode = signedccxmannode + ({zerovec[63:1],mulsignff[5]});
      end

      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          ccxroundff <= 64'b 0;
          ccxexpff <= 13'b 0;
          ccxsatff <= 1'b 0;
          ccxzipff <= 1'b 0;
          ccxnanff <= 1'b 0;
        end else begin
          if((enable == 1'b 1)) begin
            ccxroundff <= ccxroundnode;
            ccxexpff <= ccexpnode;
            ccxsatff <= ccsatnode;
            ccxzipff <= cczipnode;
            ccxnanff <= ccnannode;
          end
        end
      end

      //*** OUTPUTS ***
      assign cc[77:14] = ccxroundff;
      assign cc[13:1] = ccxexpff[13:1];
      assign ccsat = ccxsatff;
      assign cczip = ccxzipff;
      assign ccnan = ccxnanff;
    end

    if ((roundconvert == 1 && doublespeed == 1)) begin 
          always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          ccxexpdelff_1 <= 13'b 0;
          ccxexpdelff_2 <= 13'b 0;
          ccxsatdelff <= 2'b 00;
          ccxzipdelff <= 2'b 00;
          ccxnandelff <= 2'b 00;
        end else begin
          if((enable == 1'b 1)) begin
            ccxexpdelff_1[13:1] <= ccexpnode;
            ccxexpdelff_2[13:1] <= ccxexpdelff_1[13:1];
            ccxsatdelff[1] <= ccsatnode;
            ccxsatdelff[2] <= ccxsatdelff[1];
            ccxzipdelff[1] <= cczipnode;
            ccxzipdelff[2] <= ccxzipdelff[1];
            ccxnandelff[1] <= ccnannode;
            ccxnandelff[2] <= ccxnandelff[1];
          end
        end
      end

      if ((synthesize == 0)) begin
              hcc_addpipeb #(
                  .width(64),
          .pipes(2))
        addone(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(signedccxmannode),
          .bb(zerovec[64:1]),
          .carryin(mulsignff[5]),
          .cc(ccxroundnode));

      end

      if ((synthesize == 1)) begin
              hcc_addpipes #(
                  .width(64),
          .pipes(2))
        addtwo(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(signedccxmannode),
          .bb(zerovec[64:1]),
          .carryin(mulsignff[5]),
          .cc(ccxroundnode));

      end

      //*** OUTPUTS ***
      assign cc[77:14] = ccxroundnode;
      assign cc[13:1] = ccxexpdelff_2[13:1];
      assign ccsat = ccxsatdelff[2];
      assign cczip = ccxzipdelff[2];
      assign ccnan = ccxnandelff[2];
    end

  end
  endgenerate
  //******************************************************** 
  //*** if output directly out of datapath, convert here *** 
  //*** input to multiplier always "01XXX" format, so    *** 
  //*** just 1 bit normalization required                *** 
  //******************************************************** 
  generate if ((ieeeoutput == 1)) begin
      // ieee754 out of datapath, do conversion
    // output either "0001XXXX.." (<2) or "001XXXX.." (>=2), need to make output
    // 01XXXX
    assign shiftroundbit =  ~((ccmannode[62]));
    for (k=1; k <= 55; k = k + 1) begin : goeb
          // format "01"[52..1]R
      assign cceroundnode[k] = ((ccmannode[k + 7] & shiftroundbit)) | ((ccmannode[k + 8] &  ~((shiftroundbit))));
    end

    if ((roundconvert == 0)) begin
          assign ccemannode = cceroundnode[53:2];
      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          ccemanoutff <= 52'b 0;
          cceexpoutff <= 11'b 0;
          ccesignbitff <= 1'b 0;
        end else begin
          if((enable == 1'b 1)) begin
            for (j=1; j <= 52; j = j + 1) begin
              ccemanoutff[j] <= (ccemannode[j] &  ~((manoutzero))) | manoutmax;
            end
            for (j=1; j <= 11; j = j + 1) begin
              cceexpoutff[j] <= (cceexpplus[j]  &  ~((expoutzero))) | manoutmax; 
            end
            ccesignbitff <= mulsignff[signdepth];
          end
        end
      end

      assign cceexpplus = ccexpnode + ({zerovec[12:1], ~((shiftroundbit))}); 
      // change 28/01/08
      assign ccesatbase = ccsatnode;
      assign ccezipbase = cczipnode;
      assign ccenanbase = ccnannode;
      assign manoverflow = 1'b 0;
      // change 28/01/08
      //*** OUTPUTS ***
      assign cc[64] = ccesignbitff;
      // change 28/01/08
      assign cc[63:53] = cceexpoutff;
      assign cc[52:1] = ccemanoutff;
    end

    if ((roundconvert == 1 && doublespeed == 0)) begin 
          assign cceroundcarry = {zerovec[53:1],cceroundnode[1]};
      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          cceroundff <= 54'b 0;
          cceexpff <= 13'b 0;
          ccesatff <= 1'b 0;
          ccezipff <= 1'b 0;
          ccenanff <= 1'b 0;
          ccemanoutff <= 52'b 0;
          cceexpoutff <= 11'b 0;
          ccesignff <= 2'b 00;
        end else begin
          if((enable == 1'b 1)) begin
            cceroundff <= cceroundnode[55:2] + cceroundcarry;
            // change 28/01/08
            cceexpff[13:1] <= ccexpnode + ({zerovec[12:1], ~((shiftroundbit))});
            ccesatff <= ccsatnode;
            ccezipff <= cczipnode;
            ccenanff <= ccnannode;
            for (j=1; j <= 52; j = j + 1) begin
              ccemanoutff[j] <= (cceroundff[j] &  ~((manoutzero))) | manoutmax;
            end
            for (j=1; j <= 11; j = j + 1) begin
              cceexpoutff[j] <= (cceexpplus[j] & ~((expoutzero))) | expoutmax; 
            end
            ccesignff[1] <= mulsignff[signdepth];
            ccesignff[2] <= ccesignff[1];
          end
        end
      end

      assign manoverflow = cceroundff[54];
      assign cceexpbase = cceexpff[13:1];
      assign ccesatbase = ccesatff;
      assign ccezipbase = ccezipff;
      assign ccenanbase = ccenanff;
      assign cceexpplus = cceexpbase + ({12'b 000000000000,cceroundff[54]}); 
      //*** OUTPUTS ***
      assign cc[64] = ccesignff[2];
      // change 28/01/08
      assign cc[63:53] = cceexpoutff;
      assign cc[52:1] = ccemanoutff;
    end

    if ((roundconvert == 1 && doublespeed == 1)) begin 
          assign cceroundcarry = {zerovec[53:1],cceroundnode[1]};
      if ((synthesize == 0)) begin
              hcc_addpipeb #(
                  .width(54),
          .pipes(2))
        addone(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(cceroundnode[55:2]),
          .bb(zerovec[54:1]),
          .carryin(cceroundnode[1]),
          .cc(cceroundnode));

      end

      if ((synthesize == 1)) begin
              hcc_addpipes #(
                  .width(54),
          .pipes(2))
        addtwo(
                  .sysclk(sysclk),
          .reset(reset),
          .enable(enable),
          .aa(cceroundnode[55:2]),
          .bb(zerovec[54:1]),
          .carryin(cceroundnode[1]),
          .cc(cceroundnode));

      end

      always @(posedge sysclk or posedge reset) begin
        if((reset == 1'b 1)) begin
          cceexpdelff_1 <= 13'b 0;
          cceexpdelff_2 <= 13'b 0;
          ccesatdelff <= 2'b 00;
          ccezipdelff <= 2'b 00;
          ccenandelff <= 2'b 00;
          ccemanoutff <= 52'b 0;
          cceexpoutff <= 11'b 0;
          ccesigndelff <= 3'b 000;
        end else begin
          if((enable == 1'b 1)) begin
            // change 28/01/08
            cceexpdelff_1[13:1] <= ccexpnode + ({zerovec[12:1], ~((shiftroundbit))}); 
            cceexpdelff_2[13:1] <= cceexpdelff_1[13:1];
            ccesatdelff[1] <= ccsatnode;
            ccesatdelff[2] <= ccesatdelff[1];
            ccezipdelff[1] <= cczipnode;
            ccezipdelff[2] <= ccezipdelff[1];
            ccenandelff[1] <= ccnannode;
            ccenandelff[2] <= ccenandelff[1];
            for (j=1; j <= 52; j = j + 1) begin
              ccemanoutff[j] <= (cceround[j] &  ~((manoutzero))) | manoutmax;
            end
            for (j=1; j <= 11; j = j + 1) begin
              cceexpoutff[j] <= (cceexpplus[j] & ~((expoutzero))) | expoutmax; 
            end
            ccesigndelff[1] <= mulsignff[signdepth];
            ccesigndelff[2] <= ccesigndelff[1];
            ccesigndelff[3] <= ccesigndelff[2];
          end
        end
      end

      assign manoverflow = cceroundnode[54];
      assign cceexpbase = cceexpdelff_2[13:1];
      assign ccesatbase = ccesatdelff[2];
      assign ccezipbase = ccezipdelff[2];
      assign ccenanbase = ccenandelff[2];
      assign cceexpplus = cceexpbase + ({12'b 000000000000,cceroundnode[54]});  
      //*** OUTPUTS ***
      assign cc[64] = ccesigndelff[3];
      // change 28/01/08
      assign cc[63:53] = cceexpoutff;
      assign cc[52:1] = ccemanoutff;
    end

    assign cceexpmax = cceexpplus[11] & cceexpplus[10] & cceexpplus[9] & cceexpplus[8] & cceexpplus[7] & cceexpplus[6] & cceexpplus[5] & cceexpplus[4] & cceexpplus[3] & cceexpplus[2] & cceexpplus[1];
    assign cceexpzero =  ~((cceexpplus[11] | cceexpplus[10] | cceexpplus[9] | cceexpplus[8] | cceexpplus[7] | cceexpplus[6] | cceexpplus[5] | cceexpplus[4] | cceexpplus[3] | cceexpplus[2] | cceexpplus[1]));
    // any special condition turns mantissa zero
    assign manoutzero = ccesatbase | ccezipbase | cceexpmax | cceexpzero | cceexpplus[13] | cceexpplus[12] | manoverflow;
    assign manoutmax = ccenanbase;
    assign expoutzero = ccezipbase | cceexpzero | cceexpplus[13];
    assign expoutmax = cceexpmax | cceexpplus[12] | ccenanbase;
    // dummy only
    assign ccsat = 1'b 0;
    assign cczip = 1'b 0;
    assign ccnan = 1'b 0;
  end
  endgenerate
  //******************************************************** 
  //*** if output directly into DP mult, convert here    *** 
  //*** input to multiplier always "01XXX" format, so    *** 
  //*** just 1 bit normalization required, no round      *** 
  //******************************************************** 
  generate if ((multoutput == 1)) begin
      // to another multiplier
    // output either "0001XXXX.." (<2) or "001XXXX.." (>=2), need to make output
    // 01XXXX
    assign shiftmanbit =  ~((ccmannode[62]));
    for (k=1; k <= 54; k = k + 1) begin : gomb
          // format "01"[52..1]
      assign manshiftnode[k] = ((ccmannode[k + 8] & shiftmanbit)) | ((ccmannode[k + 9] &  ~((shiftmanbit))));
    end

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        manshiftff <= 54'b 0;
        ccexpdelff <= 13'b 0;
        ccsatdelff <= 1'b 0;
        cczipdelff <= 1'b 0;
        ccnandelff <= 1'b 0;
        muloutsignff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          manshiftff <= manshiftnode;
          // change 28/01/08
          ccexpdelff[13:1] <= ccexpnode + ({zerovec[12:1], ~((shiftmanbit))});  
          ccsatdelff <= ccsatnode;
          cczipdelff <= cczipnode;
          ccnandelff <= ccnannode;
          muloutsignff <= mulsignff[signdepth];
        end
      end
    end

    assign cc[67] = muloutsignff;
    assign cc[66:14] = manshiftff[53:1];
    assign cc[13:1] = ccexpdelff[13:1];
    assign ccsat = ccsatdelff;
    assign cczip = cczipdelff;
    assign ccnan = ccnandelff;
  end
  endgenerate
    //*** DEBUG SECTION ***
  assign aaexp = aa[13:1];
  assign bbexp = bb[13:1];
  assign aaman = aa[67:14];
  assign bbman = bb[67:14];
  //
  generate if ((xoutput == 1)) begin
    if ((roundconvert == 0 && outputpipe == 0)) begin 
      assign ccman = signedccxmannode;
      assign ccexp = ccexpnode;
    end
  
    if ((roundconvert == 0 && outputpipe == 1) || (roundconvert == 1 && doublespeed == 0)) begin
      assign ccman = ccxroundff;
      assign ccexp = ccxexpff[13:1];
    end
  
    if ((roundconvert == 1 && doublespeed == 1)) begin
      assign ccman = ccxroundnode;
      assign ccexp = ccxexpdelff_2[13:1];
    end
  //
  // -- change 28/01/08
    if (ieeeoutput == 1) begin
      assign ccexp = cceexpoutff;
      assign ccman = {2'b 01,ccemanoutff};
    end
  // -- change 28/01/08
    if (multoutput == 1) begin
      assign ccexp = ccexpdelff[13:1];
      assign ccman = {1'b 0,manshiftff[53:1]};
    end
  end
  endgenerate

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_RSFTPIPE64.V                          ***
//***                                             ***
//***   Function: Pipelined arithmetic right      ***
//***             shift for a 64 bit number       ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_rsftpipe64(
sysclk,
reset,
enable,
inbus,
shift,
outbus
);

input sysclk;
input reset;
input enable;
input [64:1] inbus;
input [6:1] shift;
output [64:1] outbus;

wire sysclk;
wire reset;
wire enable;
wire [64:1] inbus;
wire [6:1] shift;
wire [64:1] outbus;


wire [64:1] levzip; wire [64:1] levone; wire [64:1] levtwo; wire [64:1] levthr; 
reg [2:1] shiftff;
reg [64:1] levtwoff;

  assign levzip = inbus;
  // shift by 0,1,2,3
  genvar k;
  generate for (k=1; k <= 61; k = k + 1) begin : gaa
      assign levone[k] = ((levzip[k] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[k + 1] &  ~((shift[2])) & shift[1])) | ((levzip[k + 2] & shift[2] &  ~((shift[1])))) | ((levzip[k + 3] & shift[2] & shift[1]));
  end
  endgenerate
  assign levone[62] = ((levzip[62] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[63] &  ~((shift[2])) & shift[1])) | ((levzip[64] & shift[2]));
  assign levone[63] = ((levzip[63] &  ~((shift[2])) &  ~((shift[1])))) | ((levzip[64] & ((((shift[2])) | shift[1]))));
  assign levone[64] = levzip[64];
  // shift by 0,4,8,12

  generate for (k=1; k <= 52; k = k + 1) begin : gba
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[k + 12] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=53; k <= 56; k = k + 1) begin : gbb
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[k + 8] & shift[4] &  ~((shift[3])))) | ((levone[64] & shift[4] & shift[3]));
  end
  endgenerate

  generate for (k=57; k <= 60; k = k + 1) begin : gbc
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[k + 4] &  ~((shift[4])) & shift[3])) | ((levone[64] & shift[4]));
  end
  endgenerate

  generate for (k=61; k <= 63; k = k + 1) begin : gbd
      assign levtwo[k] = ((levone[k] &  ~((shift[4])) &  ~((shift[3])))) | ((levone[64] & ((shift[4] | shift[3]))));
  end
  endgenerate
  assign levtwo[64] = levone[64];
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      shiftff <= 2'b 00;
      levtwoff <= 64'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        shiftff <= shift[6:5];
        levtwoff <= levtwo;
      end
    end
  end


  generate for (k=1; k <= 16; k = k + 1) begin : gca
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[k + 16] &  ~((shiftff[2])) & shiftff[1])) | ((levtwoff[k + 32] & shiftff[2] &  ~((shiftff[1])))) | ((levtwoff[k + 48] & shiftff[2] & shiftff[1]));
  end
  endgenerate

  generate for (k=17; k <= 32; k = k + 1) begin : gcb
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[k + 16] &  ~((shiftff[2])) & shiftff[1])) | ((levtwoff[k + 32] & shiftff[2] &  ~((shiftff[1])))) | ((levtwoff[64] & shiftff[2] & shiftff[1]));
  end
  endgenerate

  generate for (k=33; k <= 48; k = k + 1) begin : gcc
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[k + 16] &  ~((shiftff[2])) & shiftff[1])) | ((levtwoff[64] & shiftff[2]));
  end
  endgenerate

  generate for (k=49; k <= 63; k = k + 1) begin : gcd
      assign levthr[k] = ((levtwoff[k] &  ~((shiftff[2])) &  ~((shiftff[1])))) | ((levtwoff[64] & ((shiftff[2] | shiftff[1]))));
  end
  endgenerate
  assign levthr[64] = levtwoff[64];
  assign outbus = levthr;

endmodule
//***************************************************
//***                                             ***
//***   ALTERA FLOATING POINT DATAPATH COMPILER   ***
//***                                             ***
//***   HCC_ALUFP2X.V                             ***
//***                                             ***
//***   Function: Double Precision Floating Point ***
//***             Adder                           ***
//***                                             ***
//***   14/07/07 ML                               ***
//***                                             ***
//***   (c) 2007 Altera Corporation               ***
//***                                             ***
//***   Change History                            ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***                                             ***
//***************************************************
`timescale 1 ps / 1 ps

module hcc_alufp2x(
sysclk,
reset,
enable,
addsub,
aa,
aasat,
aazip,
aanan,
bb,
bbsat,
bbzip,
bbnan,
cc,
ccsat,
cczip,
ccnan
);

parameter [31:0] shiftspeed=1;
parameter [31:0] doublespeed=1;
parameter [31:0] synthesize=1;
input sysclk;
input reset;
input enable;
input addsub;
input [77:1] aa;
input aasat, aazip, aanan;
input [77:1] bb;
input bbsat, bbzip, bbnan;
output [77:1] cc;
output ccsat, cczip, ccnan;

wire sysclk;
wire reset;
wire enable;
wire addsub;
wire [77:1] aa;
wire aasat;
wire aazip;
wire aanan;
wire [77:1] bb;
wire bbsat;
wire bbzip;
wire bbnan;
wire [77:1] cc;
wire ccsat;
wire cczip;
wire ccnan;


//type expbasefftype IS ARRAY (3+shiftspeed+doublespeed DOWNTO 1) OF STD_LOGIC_VECTOR (13 DOWNTO 1);
//type manfftype IS ARRAY (3 DOWNTO 1) OF STD_LOGIC_VECTOR (64 DOWNTO 1);
reg [77:1] aaff; reg [77:1] bbff;
reg aasatff; reg aazipff; reg bbsatff; reg bbzipff; reg aananff; reg bbnanff;
reg [64:1] manleftff; reg [64:1] manrightff;
reg [64:1] manleftdelff; reg [64:1] manleftdeldelff;
reg [64:1] manalignff;  //signal expbaseff : expbasefftype;
reg [13:1] expbaseff [(3 + shiftspeed + doublespeed):1] ;
reg [13:1] expshiftff;
wire [13:1] subexpone; wire [13:1] subexptwo;
wire switch;
wire [13:1] expzerochk;
reg expzerochkff;
reg [3 + shiftspeed:1] addsubff;
reg [3 + shiftspeed + doublespeed:1] ccsatff; reg [3 + shiftspeed + doublespeed:1] cczipff; reg [3 + shiftspeed + doublespeed:1] ccnanff;
reg invertleftff; reg invertrightff;
reg invertleftdelff; reg invertrightdelff;
wire [64:1] shiftbusnode;
wire [64:1] aluleftnode; wire [64:1] alurightnode;
wire [64:1] alunode; reg [64:1] aluff;  //signal aaexp, bbexp, ccexp : STD_LOGIC_VECTOR (13 DOWNTO 1);
wire [13:1] aaexp; wire [13:1] bbexp; wire [13:1] ccexp;
wire [64:1] aaman; wire [64:1] bbman; wire [64:1] ccman;
//signal aaman, bbman, ccman : STD_LOGIC_VECTOR (64 DOWNTO 1); 
integer k;
  always @(posedge sysclk or posedge reset) begin
    if((reset == 1'b 1)) begin
      aaff <= 77'b 0;
      bbff <= 77'b 0;
      manleftff <= 64'b 0;
      manrightff <= 64'b 0;
      for (k=1; k <= (3 + shiftspeed + doublespeed); k = k + 1) begin
        //FOR j IN 1 TO 3+shiftspeed+doublespeed LOOP
        expbaseff[k] <= 13'b 0;
      end
      expshiftff <= 13'b 0;
      for (k=1; k <= 3 + shiftspeed; k = k + 1) begin
        addsubff[k] <= 1'b 0;
      end
      aasatff <= 1'b 0;
      aazipff <= 1'b 0;
      aananff <= 1'b 0;
      for (k=1; k <= 3 + shiftspeed + doublespeed; k = k + 1) begin
        ccsatff[k] <= 1'b 0;
        cczipff[k] <= 1'b 0;
        ccnanff[k] <= 1'b 0;
      end
      invertleftff <= 1'b 0;
      invertrightff <= 1'b 0;
    end else begin
      if((enable == 1'b 1)) begin
        //*** LEVEL 1 ***
        aaff <= aa;
        bbff <= bb;
        aasatff <= aasat;
        bbsatff <= bbsat;
        aazipff <= aazip;
        bbzipff <= bbzip;
        aananff <= aanan;
        bbnanff <= bbnan;
        addsubff[1] <= addsub;
        for (k=2; k <= 3 + shiftspeed; k = k + 1) begin
          addsubff[k] <= addsubff[k - 1];
        end
        //*** LEVEL 2 ***
        for (k=1; k <= 64; k = k + 1) begin
          manleftff[k] <= ((aaff[k + 13] &  ~((switch)))) | ((bbff[k + 13] & switch));
          manrightff[k] <= ((bbff[k + 13] &  ~((switch)))) | ((aaff[k + 13] & switch)); 
        end
        for (k=1; k <= 13; k = k + 1) begin
          expbaseff[1][k] <= ((aaff[k] &  ~((switch)))) | ((bbff[k] & switch)); 
        end
        for (k=2; k <= (3 + shiftspeed + doublespeed); k = k + 1) begin
          expbaseff[k] <= expbaseff[(k - 1)];
          // level 3 to 4/5/6
        end
        for (k=1; k <= 13; k = k + 1) begin
          expshiftff[k] <= ((subexpone[k] &  ~((switch)))) | ((subexptwo[k] & switch)); 
        end
        invertleftff <= addsubff[1] & switch;
        invertrightff <= addsubff[1] &  ~((switch));
        ccsatff[1] <= aasatff | bbsatff;
        // once through add/sub, output can only be ieee754"0" if both inputs are ieee754"0"
        cczipff[1] <= aazipff & bbzipff;
        ccnanff[1] <= aananff | bbnanff | aasatff | bbsatff;
        for (k=2; k <= (3 + shiftspeed + doublespeed); k = k + 1) begin
          ccsatff[k] <= ccsatff[k - 1];
          // level 3 to 4/5/6
          cczipff[k] <= cczipff[k - 1];
          ccnanff[k] <= ccnanff[k - 1];
          // level 3 to 4/5/6
        end
      end
    end
  end

  assign subexpone = aaff[13:1] - bbff[13:1];
  assign subexptwo = bbff[13:1] - aaff[13:1];
  assign switch = subexpone[13];
  assign expzerochk = expshiftff - 13'b 0000001000000; 
  // 63 ok, 64 not
  generate if ((shiftspeed == 0)) begin
      hcc_rsftcomb64 sftslow(
          .inbus(manrightff),
      .shift(expshiftff[6:1]),
      .outbus(shiftbusnode));

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
          manleftdelff <= 64'b 0;
          manalignff <= 64'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          //*** LEVEL 3 ***
          for (k=1; k <= 64; k = k + 1) begin
            manleftdelff[k] <= manleftff[k] ^ invertleftff;
            manalignff[k] <= ((shiftbusnode[k] ^ invertrightff)) & expzerochk[13];
          end
        end
      end
    end

    assign aluleftnode = manleftdelff;
    assign alurightnode = manalignff;
  end
  endgenerate
  generate if ((shiftspeed == 1)) begin
      hcc_rsftpipe64 sftfast(
          .sysclk(sysclk),
      .reset(reset),
      .enable(enable),
      .inbus(manrightff),
      .shift(expshiftff[6:1]),
      .outbus(shiftbusnode));

    always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
        manleftdelff <= 64'b 0;
        manleftdeldelff <= 64'b 0;
        manalignff <= 64'b 0;
        invertleftdelff <= 1'b 0;
        invertrightdelff <= 1'b 0;
        expzerochkff <= 1'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          //*** LEVEL 3 ***
          manleftdelff <= manleftff;
          invertleftdelff <= invertleftff;
          invertrightdelff <= invertrightff;
          expzerochkff <= expzerochk[13];
          //*** LEVEL 4 ***
          for (k=1; k <= 64; k = k + 1) begin
            manleftdeldelff[k] <= manleftdelff[k] ^ invertleftdelff; 
            manalignff[k] <= ((shiftbusnode[k] ^ invertrightdelff)) & expzerochkff; 
          end
        end
      end
    end

    assign aluleftnode = manleftdeldelff;
    assign alurightnode = manalignff;
  end
  endgenerate
  generate if ((doublespeed == 0)) begin
      always @(posedge sysclk or posedge reset) begin
      if((reset == 1'b 1)) begin
          aluff <= 64'b 0;
      end else begin
        if((enable == 1'b 1)) begin
          aluff <= aluleftnode + alurightnode + addsubff[3 + shiftspeed];
        end
      end
    end

    assign alunode = aluff;
    //*** OUTPUTS ***
    assign cc = {alunode,expbaseff[(3 + shiftspeed)]}; 
    assign ccsat = ccsatff[3 + shiftspeed];
    assign cczip = cczipff[3 + shiftspeed];
    assign ccnan = ccnanff[3 + shiftspeed];
  end
  endgenerate
  generate if ((doublespeed == 1)) begin
      if ((synthesize == 0)) begin
          hcc_addpipeb #(
              .width(64),
        .pipes(2))
      addone(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(aluleftnode),
        .bb(alurightnode),
        .carryin(addsubff[3 + shiftspeed]),
        .cc(alunode));

    end

    if ((synthesize == 1)) begin
          hcc_addpipes #(
              .width(64),
        .pipes(2))
      addtwo(
              .sysclk(sysclk),
        .reset(reset),
        .enable(enable),
        .aa(aluleftnode),
        .bb(alurightnode),
        .carryin(addsubff[3 + shiftspeed]),
        .cc(alunode));

    end

    assign cc = {alunode,expbaseff[(4 + shiftspeed)]}; 
    assign ccsat = ccsatff[4 + shiftspeed];
    assign cczip = cczipff[4 + shiftspeed];
    assign ccnan = ccnanff[4 + shiftspeed];
  end
  endgenerate
    //*** DEBUG SECTION ***
  assign aaexp = aa[13:1];
  assign bbexp = bb[13:1];
  assign ccexp = expbaseff[(3+shiftspeed+doublespeed)][13:1];
  assign aaman = aa[77:14];
  assign bbman = bb[77:14];
  assign ccman = alunode;

endmodule

