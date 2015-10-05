`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:43:03 08/26/2015 
// Design Name: 
// Module Name:    adder_2digit 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module adder_2digit(
    clk,
	 rst_n,
	 button_plus,
	 button_sub,
	 col_n,
	 ftsd_ctl,
	 display,
	 pressed,
	 row_n,
	 row_out,
	 col_out
	 );


input clk;
input rst_n;
input button_plus;
input button_sub;
input [3:0] col_n;
output [3:0] ftsd_ctl;
output [14:0] display;
output pressed;
output [3:0] row_n;
output [3:0] row_out;
output [3:0] col_out;


wire [1:0] clk_ctl;
wire clk_150;
wire pb_debounced;
wire pb_debounced_sub;
wire out_pulse;
wire out_pulse_sub;
wire [1:0] state;
wire [3:0] key;
wire pressed;
wire [3:0] c1;
wire [3:0] c0;
wire [3:0] s1;
wire [3:0] s0;
wire [3:0] ftsd_in;
wire pressed_ctl;

assign row_out=~row_n;
assign col_out=~col_n;




freq_div f1(
	.clk_ctl(clk_ctl), // divided clock output for scan freq
	.clk_150(clk_150),
	.clk(clk) // global clock input
	);



debounce d1(
    .clk_150(clk_150),
	 .rst_n(rst_n),
	 .pb_in(button_plus),
	 .pb_debounced(pb_debounced)
	 );
	 

debounce d2(
    .clk_150(clk_150),
	 .rst_n(rst_n),
	 .pb_in(button_sub),
	 .pb_debounced(pb_debounced_sub)
	 );



	 
one_pulse o1(
    .clk(clk),
	 .rst_n(rst_n),
	 .in_trig(pb_debounced),
	 .out_pulse(out_pulse)
	 );	 
	 


one_pulse o2(
    .clk(clk),
	 .rst_n(rst_n),
	 .in_trig(pb_debounced_sub),
	 .out_pulse(out_pulse_sub)
	 );	 





cal_fsm cfs1(
    .clk(clk),
	 .rst_n(rst_n),
	 .in1(out_pulse),
	 .in2(out_pulse_sub),
	 .state(state)
	 );


keypad_scan k1(
    .clk(clk_150),
	 .rst_n(rst_n),
	 .col_n(col_n),//pressed column index
	 .row_n(row_n),//scanned row index
	 .key(key),//returned pressed key
	 .pressed(pressed)//whether key pressed(1) or not(0)
	 );


one_pulse ok1(
    .clk(clk),
	 .rst_n(rst_n),
	 .in_trig(pressed),
	 .out_pulse(pressed_ctl)
	 );	 



decimal_adder_2digit deca1(
    .clk(clk),
	 .rst_n(rst_n),
	 .key(key),
	 .state(state),
	 .pressed(pressed_ctl),
	 .c1(c1),
	 .c0(c0),
	 .s1(s1),
	 .s0(s0)
	 );




scan_ctl sc1(
	.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
	.ftsd_in(ftsd_in), // output to ftsd display
	.in0(c1), // 1st input
	.in1(c0), // 2nd input
	.in2(s1), // 3rd input
	.in3(s0), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
    );



bcd2ftsegdec b1(
	.display(display), // 14-segment display output
	.bcd(ftsd_in) // BCD input
    );





endmodule
