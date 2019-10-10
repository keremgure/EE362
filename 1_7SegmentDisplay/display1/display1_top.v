`timescale 1ns / 1ps
module display1(clk, rst, dataIn, sevenSeg, anode);
input clk,rst;
input [7:0] dataIn;
output [3:0] anode;
output [7:0] sevenSeg;

parameter SCWIDTH = 15;

reg [15:0] count,countNext;
reg [3:0] number;

SevenSegOneDig sSeg(number,sevenSeg);
decoder2_4 dec(count[SCWIDTH:SCWIDTH-1],anode,rst);

 
always@(posedge clk) begin
	count <= countNext;
end

always @ (*)begin
	if(rst) begin
		countNext = 0;
		// anode  	  = 4'b1111;
		number    = 0;
	end 
	else begin
		countNext = count +1;
		case(count[SCWIDTH:SCWIDTH-1]) //Leftmost 2 bits
			2'b00: begin 
					number = {2'b00,dataIn[1:0]};
				end
			2'b01: begin 
					number = {2'b00,dataIn[3:2]};
				end
			2'b10: begin 
					number = {2'b00,dataIn[5:4]};
				end
			2'b11: begin 
					number = {2'b00,dataIn[7:6]};
				end
		endcase
	end
end
endmodule
