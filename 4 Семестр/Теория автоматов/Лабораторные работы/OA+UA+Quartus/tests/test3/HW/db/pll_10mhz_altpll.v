//altpll bandwidth_type="AUTO" CBX_DECLARE_ALL_CONNECTED_PORTS="OFF" clk0_divide_by=5 clk0_duty_cycle=50 clk0_multiply_by=2 clk0_phase_shift="0" compensate_clock="CLK0" device_family="Cyclone III" inclk0_input_frequency=40000 intended_device_family="Cyclone III" operation_mode="normal" pll_type="FAST" port_clk0="PORT_USED" port_clk1="PORT_UNUSED" port_clk2="PORT_UNUSED" port_clk3="PORT_UNUSED" port_clk4="PORT_UNUSED" port_clk5="PORT_UNUSED" port_phasecounterselect="PORT_UNUSED" width_clock=5 width_phasecounterselect=4 clk inclk
//VERSION_BEGIN 8.1 cbx_altpll 2008:08:20:10:33:49:SJ cbx_cycloneii 2008:05:19:10:57:37:SJ cbx_mgl 2008:08:08:15:16:18:SJ cbx_stratixii 2008:08:07:13:54:47:SJ cbx_util_mgl 2008:07:18:09:58:54:SJ  VERSION_END
//CBXI_INSTANCE_NAME="test3_pll_10mhz_inst25_altpll_altpll_component"
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 1991-2008 Altera Corporation
//  Your use of Altera Corporation's design tools, logic functions 
//  and other software and tools, and its AMPP partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Altera Program License 
//  Subscription Agreement, Altera MegaCore Function License 
//  Agreement, or other applicable license agreement, including, 
//  without limitation, that your use is for the sole purpose of 
//  programming logic devices manufactured by Altera and sold by 
//  Altera or its authorized distributors.  Please refer to the 
//  applicable agreement for further details.



//synthesis_resources = cycloneiii_pll 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  pll_10mhz_altpll
	( 
	clk,
	inclk) /* synthesis synthesis_clearbox=1 */;
	output   [4:0]  clk;
	input   [1:0]  inclk;

	wire  [4:0]   wire_pll1_clk;
	wire  wire_pll1_fbout;

	cycloneiii_pll   pll1
	( 
	.activeclock(),
	.clk(wire_pll1_clk),
	.clkbad(),
	.fbin(wire_pll1_fbout),
	.fbout(wire_pll1_fbout),
	.inclk(inclk),
	.locked(),
	.phasedone(),
	.scandataout(),
	.scandone(),
	.vcooverrange(),
	.vcounderrange()
	`ifdef FORMAL_VERIFICATION
	`else
	// synopsys translate_off
	`endif
	,
	.areset(1'b0),
	.clkswitch(1'b0),
	.configupdate(1'b0),
	.pfdena(1'b1),
	.phasecounterselect({3{1'b0}}),
	.phasestep(1'b0),
	.phaseupdown(1'b0),
	.scanclk(1'b0),
	.scanclkena(1'b1),
	.scandata(1'b0)
	`ifdef FORMAL_VERIFICATION
	`else
	// synopsys translate_on
	`endif
	);
	defparam
		pll1.bandwidth_type = "auto",
		pll1.clk0_divide_by = 5,
		pll1.clk0_duty_cycle = 50,
		pll1.clk0_multiply_by = 2,
		pll1.clk0_phase_shift = "0",
		pll1.compensate_clock = "clk0",
		pll1.inclk0_input_frequency = 40000,
		pll1.operation_mode = "normal",
		pll1.pll_type = "auto",
		pll1.lpm_type = "cycloneiii_pll";
	assign
		clk = wire_pll1_clk;
endmodule //pll_10mhz_altpll
//VALID FILE
