`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:28:31 08/25/2015 
// Design Name: 
// Module Name:    cal_fsm 
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
module cal_fsm(
    clk,
	 rst_n,
	 in1,//+
	 in2,//-
	 state
	 );


input clk;
input rst_n;
input in1;
input in2;
output [1:0] state;
reg [1:0] state;
reg [1:0] next_state;




always@(*)
begin
	case(state)
	2'b00://reset®É
	begin
		if(in1)
		begin
			next_state=2'b01;
		end
		else if(in2)
		begin
			next_state=2'b01;
		end
		else
		begin
			next_state=2'b00;
		end
	end
	2'b01://reset -> +  or  reset -> -
	begin
		if(in1)
		begin
			next_state=2'b10;
		end
		else if(in2)
		begin
			next_state=2'b11;
		end
		else
		begin
			next_state=2'b01;
		end
	end
	2'b10://+ -> =
	begin
		if(in1)//pause and push button -> jump to start
		begin
			next_state=2'b01;
		end
		else
		begin
			next_state=2'b10;
		end
	end
	2'b11://- ->=
	begin
		if(in2)
		begin
			next_state=2'b01;
		end
		else
		begin
			next_state=2'b11;
		end
	end
	default:
	begin
		next_state=2'b00;
	end
	endcase
end





always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		state<=2'b00;
	else
		state<=next_state;
end


endmodule
