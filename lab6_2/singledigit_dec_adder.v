`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:54:25 08/17/2015 
// Design Name: 
// Module Name:    singledigit_dec_adder 
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
module singledigit_dec_adder(
	 clk,
	 rst_n,
    key,
	 //en_A,
	 //en_B,
	 //count_en,
	 state,////////////
	 pressed,///////////
	 A,
	 B,
    s,
    co
    );


input clk;
input rst_n;
input [3:0] key;
//input en_A;
//input en_B;
//input count_en;
input [1:0] state;////////////
input pressed;
output [3:0] A;
output [3:0] B;
output [3:0] s;
output co;

reg [3:0] A;
reg [3:0] B;
reg co;
reg [3:0] s;
reg k;
reg [3:0] z;




always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		A<=4'd0;
		B<=4'd0;
		k<=1'd0;
		z<=4'd0;
	end
	else
	begin
		if(state==2'b00 && pressed==1'b1)
		begin
			A<=key;
			B<=4'd0;
		end
		else if(state==2'b01 && pressed==1'b1)
		begin
			A<=A;
			B<=key;
		end
		else if(state==2'b10)
		begin
			A<=A;
			B<=B;
			{k,z}<=A+B;
		end
		else
		begin
			A<=A;
			B<=B;
		end
	end
end



always@(k or z)
begin
	if({k,z}>9)
		{co,s}={k,z}+5'b00110;
	else
		{co,s}={k,z};
end

	
endmodule
