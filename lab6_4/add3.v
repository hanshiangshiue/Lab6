`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:06:28 08/28/2015 
// Design Name: 
// Module Name:    add3 
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
module add3(
    in,
	 out
	 );



input [3:0] in;
output [3:0] out;
reg [3:0] out;

always @*
  case (in)
    4'd0: out = 4'd0;
	 4'd1: out = 4'd1;
	 4'd2: out = 4'd2;
	 4'd3: out = 4'd3;
	 4'd4: out = 4'd4;
	 4'd5: out = 4'd5 + 4'd3;
	 4'd6: out = 4'd6 + 4'd3;
	 4'd7: out = 4'd7 + 4'd3;
	 4'd8: out = 4'd8 + 4'd3;
	 4'd9: out = 4'd9 + 4'd3;
	 default: out = 4'd0;
  endcase



endmodule


