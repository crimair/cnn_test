//synopsys translate_off
`default_nettype none
//synopsys translate_on
`timescale 1ns/1ps

module zcnn_gen_3x3_line
(/*AUTOARG*/
// Outputs
ren, rxf, rxl, rdat_p, rdat_c, rdat_n,
// Inputs
resb, clk, read_xsize, read_ysize, vp_in, en_in, ven_in, d_in
);

input wire         resb;
input wire         clk;
input wire [11:0]  read_xsize;
input wire [11:0]  read_ysize;
input wire         vp_in;
input wire         en_in;
input wire         ven_in;
input wire [17:0]  d_in;
output wire        ren;
output wire        rxf;
output wire        rxl;
output wire [17:0] rdat_p;
output wire [17:0] rdat_c;
output wire [17:0] rdat_n;

reg [11:0]         xcnt;
reg [ 1:0]         mwcnt;
reg [ 1:0]         pmwcnt;
reg [11:0]         ycnt;
wire [11:0]        xcnt_max;
wire [11:0]        ycnt_max;
wire [11:0]        ycnt_max_p1;
assign xcnt_max    = read_xsize[11:0] - 1;
assign ycnt_max    = read_ysize[11:0] - 1;
assign ycnt_max_p1 = read_ysize[11:0];
reg [2:0]  mcs;
reg        men;
reg [10:0] madr;
reg [17:0] mwdat;
wire [17:0] mrdat0;
wire [17:0] mrdat1;
wire [17:0] mrdat2;

reg        oe;
reg        xf;
reg        xl;
reg        cen;
reg  [1:0] cenno;
reg        cenf0;
reg        cenf1;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        xcnt   <= 0;
        ycnt   <= 0;
        mwcnt  <= 0;
        pmwcnt <= 0;
        mcs    <= 0;
        men    <= 0;
        madr   <= 0;
        mwdat  <= 0;
        cen    <= 0;
        oe     <= 0;
        xf     <= 0;
        xl     <= 0;
        cenno  <= 0;
        cenf0  <= 0;
        cenf1  <= 0;
    end // if (!resb)
    else begin
        if (vp_in) begin
            xcnt   <= 0;
            ycnt   <= 0;
            mwcnt  <= 0;
            pmwcnt <= 0;
            mcs    <= 0;
            men    <= 0;
            madr   <= 0;
            mwdat  <= 0;
            cen    <= 0;
            oe     <= 0;
            xf     <= 0;
            xl     <= 0;
            cenno  <= 0;
            cenf0  <= 0;
            cenf1  <= 0;
        end // if (vp_in)
        else begin
            if (en_in || (ycnt==ycnt_max_p1 && ven_in) ) begin
                if (xcnt>=xcnt_max) begin
                    xcnt <= 0;
                    ycnt <= ycnt + 1;
                    if (mwcnt==2) begin
                        mwcnt <= 0;
                    end
                    else begin
                        mwcnt <= mwcnt + 1;
                    end
                    pmwcnt <= mwcnt;
                end // if (xcnt>=xcnt_max)
                else begin
                    xcnt <= xcnt + 1;
                end // else: !if(xcnt>=xcnt_max)
                if (ycnt>=1 && ycnt<=ycnt_max_p1) begin
                    cen   <= 1;
                    cenno <= pmwcnt;
                    cenf0 <= (ycnt>=1 && ycnt<=ycnt_max);    //111110
                    cenf1 <= (ycnt>=2 && ycnt<=ycnt_max_p1); //011111
                    xf    <= (xcnt==0);
                    xl    <= (xcnt==xcnt_max);
                end
                else begin
                    cen  <= 0;
                end // else: !if(ycnt>=1 && ycnt<=ycnt_max_p1)
                if (ycnt>=0 && ycnt<=ycnt_max_p1) begin
                    if (ycnt<ycnt_max_p1) begin
                        mcs[0] <= (mwcnt==0);
                        mcs[1] <= (mwcnt==1);
                        mcs[2] <= (mwcnt==2);
                        mwdat  <= d_in;
                    end
                    else begin
                        mcs <= 0;
                    end
                    men    <= 1;
                    madr   <= xcnt;
                end // if (ycnt>=0 && ycnt<=ycnt_max_p1)
                else begin
                    men   <= 0;
                end // else: !if(ycnt>=0 && ycnt<=ycnt_max_p1)
            end // if (en_in || (ycnt==ycnt_max_p1 && ven_in) )
            else begin
                cen <= 0;
                men <= 0;
            end // else: !if(en_in || (ycnt==ycnt_max_p1 && ven_in) )
        end // else: !if(vp_in)
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)

sp_18x2048 mem0(
.address (madr),
.clock   (clk),
.data    (mwdat),
.rden    (men),
.wren    (men && mcs[0]),
.q       (mrdat0 )
);
sp_18x2048 mem1(
.address (madr),
.clock   (clk),
.data    (mwdat),
.rden    (men),
.wren    (men && mcs[1]),
.q       (mrdat1 )
);
sp_18x2048 mem2(
.address (madr),
.clock   (clk),
.data    (mwdat),
.rden    (men),
.wren    (men && mcs[2]),
.q       (mrdat2 )
);

wire [17:0] mrdat_d1_sel_c;
wire [17:0] mrdat_d1_sel_p;


reg        cen_d1;
reg        cenf0_d1;
reg        cenf1_d1;
reg [ 1:0] cenno_d1;
reg [17:0] mwdat_d1;
reg        xf_d1;
reg        xl_d1;
reg        cen_d2;
reg        xf_d2;
reg        xl_d2;
reg [17:0] pd;
reg [17:0] cd;
reg [17:0] nd;

assign mrdat_d1_sel_c = (cenno_d1==0) ? mrdat0 :
                        (cenno_d1==1) ? mrdat1 :
                        (cenno_d1==2) ? mrdat2 : 0;
assign mrdat_d1_sel_p = (cenno_d1==0) ? mrdat2 :
                        (cenno_d1==1) ? mrdat0 :
                        (cenno_d1==2) ? mrdat1 : 0;
always @ (posedge clk or negedge resb) begin
    if (!resb) begin
        cen_d1   <= 0;
        cenf0_d1 <= 0;
        cenf1_d1 <= 0;
        xf_d1    <= 0;
        xl_d1    <= 0;
        cenno_d1 <= 0;
        mwdat_d1 <= 0;
        cen_d2   <= 0;
        xf_d2    <= 0;
        xl_d2    <= 0;
        pd       <= 0;
        cd       <= 0;
        nd       <= 0;
    end // if (!resb)
    else begin
        cen_d1   <= cen;
        cenf0_d1 <= cenf0;
        cenf1_d1 <= cenf1;
        xf_d1    <= xf;
        xl_d1    <= xl;
        cenno_d1 <= cenno;
        mwdat_d1 <= mwdat;
        cen_d2   <= cen_d1;
        xf_d2    <= xf_d1;
        xl_d2    <= xl_d1;
        if (cen_d1) begin
            pd <= (cenf0_d1 && !cenf1_d1) ? mrdat_d1_sel_c : mrdat_d1_sel_p;
            cd <= mrdat_d1_sel_c;
            nd <= (!cenf0_d1 && cenf1_d1) ? mrdat_d1_sel_c : mwdat_d1;
        end
        else begin
            pd <= 0;
            cd <= 0;
            nd <= 0;
        end
    end // else: !if(!resb)
end // always @ (posedge clk or negedge resb)
assign ren      = cen_d2;
assign rxf      = xf_d2;
assign rxl      = xl_d2;
assign rdat_p   = pd;
assign rdat_c   = cd;
assign rdat_n   = nd;

endmodule // zcnn_gen_3x3_line
//synopsys translate_off
`default_nettype wire
//synopsys translate_on

