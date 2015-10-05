`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:51:22 08/28/2015 
// Design Name: 
// Module Name:    calculator 
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
module calculator(
    clk,
	 rst_n,
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
input [3:0] col_n;
output [3:0] ftsd_ctl;
output [14:0] display;
output pressed;
output [3:0] row_n;
output [3:0] row_out;
output [3:0] col_out;

wire [1:0] clk_ctl;
wire clk_150;
wire [3:0] key;
wire [2:0] state;
wire pressed_ctl;
wire [3:0] A;
wire [3:0] B;
wire [3:0] co;
wire [3:0] s;
wire [3:0] ftsd_in;



assign row_out=~row_n;
assign col_out=~col_n;





freq_div f1(
	.clk_ctl(clk_ctl),
	.clk_150(clk_150),
	.clk(clk)
	);



keypad_scan k1(
    .clk(clk_150),
	 .rst_n(rst_n),
	 .col_n(col_n),
	 .row_n(row_n),
	 .key(key),
	 .pressed(pressed)
	 );


one_pulse ok1(
    .clk(clk),
	 .rst_n(rst_n),
	 .in_trig(pressed),
	 .out_pulse(pressed_ctl)
	 );



cal_fsm cfs1(
    .clk(clk),
	 .rst_n(rst_n),
	 .key(key),
	 .pressed(pressed_ctl),
	 .state(state)
	 );




calculate cal1(
    .clk(clk),
	 .rst_n(rst_n),
	 .key(key),
	 .state(state),
	 .pressed(pressed_ctl),
	 .A(A),
	 .B(B),
	 .co(co),
	 .s(s)
	 );



scan_ctl sc1(
	.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
	.ftsd_in(ftsd_in), // output to ftsd display
	.in0(A), // 1st input
	.in1(B), // 2nd input
	.in2(co), // 3rd input
	.in3(s), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
    );


bcd2ftsegdec b1(
	.display(display), // 14-segment display output
	.bcd(ftsd_in) // BCD input
    );



endmodule
