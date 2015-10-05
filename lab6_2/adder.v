`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:49:03 08/25/2015 
// Design Name: 
// Module Name:    adder 
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
module adder(
    clk,
	 rst_n,
	 button,
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
input button;
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
wire out_pulse;
wire en_A;
wire en_B;
wire count_en;
wire [3:0] key;
wire [3:0] A;
wire [3:0] B;
wire co;
wire [3:0] s;
wire [3:0] ftsd_in;
wire [1:0] state;//////////////



assign row_out=~row_n;
assign col_out=~col_n;


freq_div f1(
	.clk_ctl(clk_ctl), // divided clock output
	.clk(clk), // global clock input
	.clk_150(clk_150)
	);




debounce d1(
	.clk_150(clk_150),
	.rst_n(rst_n),
	.pb_in(button),
	.pb_debounced(pb_debounced)
	);


one_pulse o1(
	.clk(clk),
	.rst_n(rst_n),
	.in_trig(pb_debounced),
	.out_pulse(out_pulse)
	);



cal_fsm cfs1 (
    .clk(clk),
	 .rst_n(rst_n),
	 .in(out_pulse),
	 //.en_A(en_A),
	 //.en_B(en_B),
	 //.count_en(count_en)
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



singledigit_dec_adder sin1(
    .clk(clk),
	 .rst_n(rst_n),
	 .key(key),
	 //.en_A(en_A),
	 //.en_B(en_B),
	 //.count_en(count_en),
	 .state(state),/////////////
	 .pressed(pressed),///////////
	 .A(A),
	 .B(B),
    .s(s),
    .co(co)
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
