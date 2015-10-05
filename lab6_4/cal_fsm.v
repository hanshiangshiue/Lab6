`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:18 08/28/2015 
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
	 key,
	 pressed,///////////////////
	 state
	 );


input clk;
input rst_n;
input [3:0] key;
input pressed;////////////////
output [2:0] state;

reg [2:0] state;
reg [2:0] next_state;



always@(*)
begin
	case(state)
	3'b000://reset®É
	begin
		if(pressed==1'b1 && key==4'b1010)//A    reset -> +
		begin
			next_state=3'b001;
		end
		else if(pressed==1'b1 && key==4'b1101)//D   reset -> -
		begin
			next_state=3'b010;
		end
		else if(pressed==1'b1 && key==4'b1011)//B    reset -> *
		begin
			next_state=3'b011;
		end
		else
		begin
			next_state=3'b000;
		end
	end
	3'b001://  + -> =
	begin
		if(pressed==1'b1 && key==4'b1110)//E
		begin
			next_state=3'b100;
		end
		else
		begin
			next_state=3'b001;
		end
	end
	3'b010:// - -> =
	begin
		if(pressed==1'b1 && key==4'b1110)
		begin
			next_state=3'b100;
		end
		else
		begin
			next_state=3'b010;
		end
	end
	3'b011:// * -> =
	begin
		if(pressed==1'b1 &&key==4'b1110)
		begin
			next_state=3'b100;
		end
		else
		begin
			next_state=3'b011;
		end
	end
	3'b100:
	begin
		if(pressed==1'b1 && key==4'b1110)
		begin
			next_state=3'b100;
		end
		else
		begin
			next_state=3'b100;
		end
	end
	default:
		next_state=3'b000;
	endcase
end



always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		state<=3'b000;
	else
		state<=next_state;
end


endmodule
