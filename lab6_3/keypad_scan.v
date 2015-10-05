`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:30 08/24/2015 
// Design Name: 
// Module Name:    keypad_scan 
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
module keypad_scan(
    clk,
	 rst_n,
	 col_n,//pressed column index
	 row_n,//scanned row index
	 key,//returned pressed key
	 pressed//whether key pressed(1) or not(0)
	 );


input clk;
input rst_n;
input [3:0] col_n;
output [3:0] row_n;
output [3:0] key;
output pressed;


reg [1:0] sel,sel_next;
reg [3:0] row_n;
reg [3:0] key;
reg [3:0] key_detected;
reg [3:0] key_next;
reg keypad_state,keypad_state_next;
reg [3:0] pause_delay,pause_delay_next;////////////////////bits?
reg pressed_detected;
reg pressed_next;
reg pressed;



always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		sel<=2'b00;
	else
		sel<=sel_next;
end



always@(*)
	sel_next=sel+1'b1;



always@(*)
begin
	case(sel)
		2'd0: row_n=4'b0111;
		2'd1: row_n=4'b1011;
		2'd2: row_n=4'b1101;
		2'd3: row_n=4'b1110;
		default: row_n=4'b1111;
	endcase
end



always@(*)
begin
	case({row_n,col_n})
		8'b0111_0111: 
		begin
			key_detected = 4'b1111;  // F
			pressed_detected=1'b1;
		end
		8'b0111_1011: 
		begin
			key_detected = 4'b1110;  // E
			pressed_detected=1'b1;
		end
		8'b0111_1101: 
		begin
			key_detected = 4'b1101;  // D
			pressed_detected=1'b1;
		end
		8'b0111_1110: 
		begin
			key_detected = 4'b1100;  // C
			pressed_detected=1'b1;
		end
		8'b1011_0111: 
		begin
			key_detected = 4'b1011;  // B
			pressed_detected=1'b1;
		end
		8'b1011_1011: 
		begin
			key_detected = 4'b0011;  // 3
			pressed_detected=1'b1;
		end
		8'b1011_1101: 
		begin
			key_detected = 4'b0110;  // 6
			pressed_detected=1'b1;
		end
		8'b1011_1110: 
		begin
			key_detected = 4'b1001;  // 9
			pressed_detected=1'b1;
		end
		8'b1101_0111: 
		begin
			key_detected = 4'b1010;  // A
			pressed_detected=1'b1;
		end
		8'b1101_1011: 
		begin
			key_detected = 4'b0010;  // 2
			pressed_detected=1'b1;
		end
		8'b1101_1101: 
		begin
			key_detected = 4'b0101;  // 5
			pressed_detected=1'b1;
		end
		8'b1101_1110: 
		begin
			key_detected = 4'b1000;  // 8
			pressed_detected=1'b1;
		end
		8'b1110_0111: 
		begin
			key_detected = 4'b0000;  // 0
			pressed_detected=1'b1;
		end
		8'b1110_1011: 
		begin
			key_detected = 4'b0001;  // 1
			pressed_detected=1'b1;
		end
		8'b1110_1101: 
		begin
			key_detected = 4'b0100;  // 4
			pressed_detected=1'b1;
		end
		8'b1110_1110: 
		begin
			key_detected = 4'b0111;  // 7
			pressed_detected=1'b1;
		end
		default: 
		begin
			key_detected = 4'b0000;       // 0
			pressed_detected=1'b0;
		end
	endcase
end




//////////////////FSM
always@(*)
begin
	case(keypad_state)
		1'b0://pause
		begin
			if(pause_delay==4'b1111)//in this column the button isn't pressed
			begin
				keypad_state_next=1'b1;//scan
				pressed_next=1'b0;//keypad not pressed
				pause_delay_next=4'b0000;
				key_next=key;
			end
			else
			begin
				keypad_state_next=1'b0;//pause
				pressed_next=1'b1;//keypad pressed
				pause_delay_next=pause_delay+1'b1;
				key_next=key;
			end
		end
		1'b1://scan
		begin
			if(pressed_detected==1'b1)
			begin
				keypad_state_next=1'b0;//pause
				pressed_next=1'b1;//keypad pressed
				pause_delay_next=4'b0000;
				key_next=key_detected;
			end
			else
			begin
				keypad_state_next=1'b1;//scan
				pressed_next=1'b0;//keypad not pressed
				pause_delay_next=4'b0000;
				key_next=key;
			end
		end
		default:
		begin
			keypad_state_next=1'b1;//scan
			pressed_next=1'b0;//keypad not pressed
			pause_delay_next=4'b0000;
			key_next=key;
		end
	endcase
	
end



//FSM state
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		keypad_state<=1'b0;
	else
		keypad_state<=keypad_state_next;
end



//keypad pause state counter
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		pause_delay<=4'b0000;
	else
		pause_delay<=pause_delay_next;
end



//pressed indicator
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		pressed<=1'b0;
	else
		pressed<=pressed_next;
end


//pressed key indicator
always@(posedge clk or negedge rst_n)
begin
	if(~rst_n)
		key<=4'b0000;
	else
		key<=key_next;
end




endmodule
