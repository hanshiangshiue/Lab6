`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:31:39 08/26/2015 
// Design Name: 
// Module Name:    decimal_adder_2digit 
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
module decimal_adder_2digit(
    clk,
	 rst_n,
	 key,
	 state,
	 pressed,
	 c1,
	 c0,
	 s1,
	 s0
	 );



input clk;
input rst_n;
input [3:0] key;
input [1:0] state;
input pressed;
output [3:0] c1;
output [3:0] c0;
output [3:0] s1;
output [3:0] s0;

reg [3:0] c1;
reg [3:0] c0;
reg [3:0] s1;
reg [3:0] s0;

reg [3:0] A1;
reg [3:0] A0;
reg [3:0] B1;
reg [3:0] B0;

reg [3:0] k1;
reg [3:0] k0;
reg [3:0] z1;
reg [3:0] z0;


always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
	begin
		A1<=4'd0;
		A0<=4'd0;
		B1<=4'd0;
		B0<=4'd0;
	end
	else if(state==2'b00 && pressed==1'b1)
	begin
		A1<=A0;
		A0<=key;
	end
	else if(state==2'b01 && pressed==1'b1)
	begin
		B1<=B0;
		B0<=key;
	end
	else if(state==2'b10)
	begin
		{k1,k0,z1,z0}<={A1,A0}+{B1,B0};
	end
	else if(state==2'b11)
	begin
		if(A0>B0)
		begin
			{k1,k0,z1,z0}<={A1,A0}-{B1,B0};
		end
		else
		begin
			{k1,k0,z1,z0}<={(A1-4'd1),(A0+4'b1010)}-{B1,B0};
		end
	end
	else
	begin
		A1<=A1;
		A0<=A0;
		B1<=B1;
		B0<=B0;
	end
end




always@(*)
begin
	if(state==2'b00)
	begin
		{c1,c0,s1,s0}={A1,A0,B1,B0};
	end
	else if(state==2'b01)
	begin
		{c1,c0,s1,s0}={A1,A0,B1,B0};
	end
	else if(state==2'b10)
	begin
		if({k1,k0,z1,z0}>8'b1001_1001)
		begin
			{c1,c0,s1,s0}={k1,k0,z1,z0}+9'b0_0110_0110;
		end
		else if({k1,k0,z1,z0}>4'b1001 && {k1,k0,z1,z0}<8'b1001_1001)
		begin
			{c1,c0,s1,s0}={k1,k0,z1,z0}+5'b0_0110;
		end
		else
		begin
			{c1,c0,s1,s0}={k1,k0,z1,z0};
		end
	end
	else//state==2'b11
	begin
		{c1,c0,s1,s0}={k1,k0,z1,z0};
	end



end



endmodule
