
#**************************************************************
# Create Clock
#**************************************************************

create_clock -period 20 [get_ports OSC_50_B3B]
create_clock -period 20 [get_ports OSC_50_B4A]
create_clock -period 20 [get_ports OSC_50_B5B]
create_clock -period 20 [get_ports OSC_50_B8A]


#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks


#**************************************************************
# Set Clock Latency
#**************************************************************


#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************

#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
##**************************************************************

#**************************************************************
# Set False Path
#**************************************************************

set CLKLIST   {OSC_50_B3B \
u1|mem_if_ddr3_emif_0|pll0|pll_afi_clk \
u1|mem_if_ddr3_emif_0|pll0|pll_afi_half_clk \
c_pll|pll_inst|altera_pll_i|general[0].gpll~PLL_OUTPUT_COUNTER|divclk \
c_pll|pll_inst|altera_pll_i|general[1].gpll~PLL_OUTPUT_COUNTER|divclk \
c_pll|pll_inst|altera_pll_i|general[2].gpll~PLL_OUTPUT_COUNTER|divclk \
c_pll|pll_inst|altera_pll_i|general[3].gpll~PLL_OUTPUT_COUNTER|divclk \
c_pll|pll_inst|altera_pll_i|general[4].gpll~PLL_OUTPUT_COUNTER|divclk \
c_pll|pll_inst|altera_pll_i|general[5].gpll~PLL_OUTPUT_COUNTER|divclk \
}
foreach i $CLKLIST {
    foreach j $CLKLIST {
        if { $i != $j } {
            set_false_path -from [get_clocks $i] -to [get_clocks $j]
        }
    }
}


#**************************************************************
# Set Multicycle Path
#**************************************************************

#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************





