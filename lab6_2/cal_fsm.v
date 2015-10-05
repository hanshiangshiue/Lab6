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
	 in,
	 //en_A,
	 //en_B,
	 //count_en
	 state////////
	 );


input clk;
input rst_n;
input in;
//output en_A;
//output en_B;
//output count_en;
//reg en_A;
//reg en_B;
//reg count_en;
output [1:0] state;/////////////
reg [1:0] state;
reg [1:0] next_state;


/*always@(*)
begin
	case(state)
	1'b0://reset
	begin
		if(in)//reset -> +
		begin
			next_state=1'b1;
			en_A=1'b0;
			en_B=1'b1;//key傳進B
			count_en=1'b0;
		end
		else
		begin
			next_state=1'b0;
			en_A=1'b1;//key傳進A
			en_B=1'b0;
			count_en=1'b0;
		end
	end
	1'b1://+
	begin
		if(in)//+ -> =
		begin
			next_state=1'b0;
			en_A=1'b1;
			en_B=1'b0;
			count_en=1'b1;
		end
		else
		begin
			next_state=1'b1;
			en_A=1'b0;
			en_B=1'b1;
			count_en=1'b0;
		end
	end
	endcase
end*/



always@(*)
begin
	case(state)
	2'b00://reset時
	begin
		if(in)
		begin
			next_state=2'b01;
		end
		else
		begin
			next_state=2'b00;
		end
	end
	2'b01://reset -> +
	begin
		if(in)//calculating and push button -> jump to pause
		begin
			next_state=2'b10;
		end
		else
		begin
			next_state=2'b01;
		end
	end
	2'b10://+ -> =
	begin
		if(in)//pause and push button -> jump to start
		begin
			next_state=2'b01;
		end
		else
		begin
			next_state=2'b10;
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
