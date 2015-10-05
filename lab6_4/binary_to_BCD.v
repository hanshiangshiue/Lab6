`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:05:01 08/28/2015 
// Design Name: 
// Module Name:    binary_to_BCD 
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
module binary_to_BCD(
    in,
	 ones,
	 tens
	 );


input [7:0] in;
output [3:0] ones;
output [3:0] tens;
wire [3:0] out1, out2, out3, out4, out5, out6, out7;
reg [3:0] ones, tens; 
reg [3:0] in1, in2, in3, in4, in5, in6, in7;

always @*
begin
  in1 = {1'b0, in[7:5]};
  in2 = {out1[2:0], in[4]};
  in3 = {out2[2:0], in[3]};
  in4 = {out3[2:0], in[2]};
  in5 = {out4[2:0], in[1]};
  in6 = {1'b0, out1[3], out2[3],out3[3]};
  in7 = {out6[2:0], out4[3]};
end

always @*
begin
  ones = {out5[2:0], in[0]};
  tens = {out7[2:0], out5[3]};
end




add3 a1_add(
  .in(in1),
  .out(out1)
);

add3 a2_add(
  .in(in2),
  .out(out2)
);

add3 a3_add(
  .in(in3),
  .out(out3)
);

add3 a4_add(
  .in(in4),
  .out(out4)
);

add3 a5_add(
  .in(in5),
  .out(out5)
);

add3 a6_add(
  .in(in6),
  .out(out6)
);

add3 a7_add(
  .in(in7),
  .out(out7)
);



endmodule
