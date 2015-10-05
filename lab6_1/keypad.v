`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:21:50 08/25/2015 
// Design Name: 
// Module Name:    keypad 
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
module keypad(
    clk,
	 rst_n,
	 col_n,
	 row_n,
	 display,
	 ftsd_ctl,
	 pressed,//LED
	 row_out,//LED
	 col_out//LED
	 );



input clk;
input rst_n;
input [3:0] col_n;
output [3:0] row_n;
output [14:0] display;
output [3:0] ftsd_ctl;
output pressed;
output [3:0] row_out;
output [3:0] col_out;



wire clk_150;
wire [1:0] clk_ctl;
wire [3:0] key;
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
	 .col_n(col_n),//pressed column index
	 .row_n(row_n),//scanned row index
	 .key(key),//returned pressed key
	 .pressed(pressed)//whether key pressed(1) or not(0)
	 );


scan_ctl s1(
	.ftsd_ctl(ftsd_ctl), // ftsd display control signal 
	.ftsd_in(ftsd_in), // output to ftsd display
	.in0(4'b0000), // 1st input
	.in1(4'b0000), // 2nd input
	.in2(4'b0000), // 3rd input
	.in3(key), // 4th input
	.ftsd_ctl_en(clk_ctl) // divided clock for scan control
    );


bcd2ftsegdec b1(
	.display(display), // 14-segment display output
	.bcd(ftsd_in) // BCD input
    );



endmodule
