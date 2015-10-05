`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:26:54 08/28/2015 
// Design Name: 
// Module Name:    calculate 
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
module calculate(
    clk,
	 rst_n,
	 key,
	 state,
	 pressed,
	 A,
	 B,
	 co,
	 s
	 );


input clk;
input rst_n;
input [3:0] key;
input [2:0] state;
input pressed;
output [3:0] A;
output [3:0] B;
output [3:0] co;
output [3:0] s;

reg [3:0] A;
reg [3:0] B;
reg [3:0] co;
reg [3:0] s;

reg [3:0] k;
reg [3:0] z;

reg [2:0] pre_state;
reg [7:0] mul;
wire [3:0] ones;
wire [3:0] tens;


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		A<=4'd0;
		B<=4'd0;
		k<=4'd0;
		z<=4'd0;
	end
	else if(state==3'b000 && pressed==1'b1 && key<4'd10)
	begin
		A<=key;
		B<=4'd0;
		pre_state<=3'b000;
	end
	else if(state==3'b001 && pressed==1'b1 && key<4'd10)
	begin
		A<=A;
		B<=key;
		pre_state<=3'b001;
	end
	else if(state==3'b010 && pressed==1'b1 && key<4'd10)
	begin
		A<=A;
		B<=key;
		pre_state<=3'b010;
	end
	else if(state==3'b011 && pressed==1'b1 && key<4'd10)
	begin
		A<=A;
		B<=key;
		pre_state<=3'b011;
	end
	else if(state==3'b100)
	begin
		if(pre_state==3'b001)//+
		begin
			A<=A;
			B<=B;
			{k,z}<=A+B;
		end
		else if(pre_state==3'b010)//-
		begin
			A<=A;
			B<=B;
			{k,z}<=A-B;
		end
		else//pre_state==3'b011   *
		begin
			A<=A;
			B<=B;
			mul<=A*B;
		end
	end
	else
	begin
		A<=A;
		B<=B;
	end
end




binary_to_BCD binBCD1(
    .in(mul),
	 .ones(ones),
	 .tens(tens)
	 );



always@(k or z)
begin
	if(pre_state==3'b011)
	begin
		if(state==3'b100)
			{co,s}={tens,ones};
		else
			{co,s}=8'b0000_0000;
	end
	else
	begin
		if({k,z}>8'd9)
			{co,s}={k,z}+8'b0000_0110;
		else
			{co,s}={k,z};
	end
end



endmodule
