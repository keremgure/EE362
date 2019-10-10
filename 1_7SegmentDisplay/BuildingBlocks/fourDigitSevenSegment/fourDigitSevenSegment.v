`timescale 1ns / 1ps

module fourDigitSevenSegment(clk, sw, an, seg,rst);

input clk;
input rst;
input [7:0] sw;
output reg [3:0] an;
output reg [7:0] seg;

reg [21:0] counter, counterNxt;
parameter COUNT = 22'h0FFFF;//28'b1000111100001101000110000001; // 22'h3FFFFF;

reg [3:0] anNxt;
reg [1:0] segmentDecimal, segmentDecimalNxt;
reg [1:0] state, stateNxt;

always@(posedge clk) begin
	segmentDecimal <= #1 segmentDecimalNxt;
	state <= #1 stateNxt;
	an <= #1 anNxt;
	counter <= #1 counterNxt;
end

always@(*) begin
	counterNxt = counter+1;
	anNxt = an;
	stateNxt = state;
	segmentDecimalNxt = segmentDecimal;
	// seg = 8'b11111111;
	if(rst)begin
		counterNxt = 0;
		anNxt = 4'b1110;
		segmentDecimalNxt = sw[1:0];
		stateNxt = 0;
		seg = 8'b00000000;
	end
	else if(counter == COUNT - 1)begin
		stateNxt = state + 1;
		counterNxt = 0;

		case(state)
			0: begin anNxt = 4'b0111;segmentDecimalNxt = sw[1:0];end
			1: begin anNxt = 4'b1011;segmentDecimalNxt = sw[3:2];end
			2: begin anNxt = 4'b1101;segmentDecimalNxt = sw[5:4];end
			3: begin anNxt = 4'b1110;segmentDecimalNxt = sw[7:6];end
		endcase
				
		case(segmentDecimal)
			0: seg = 8'b01000000;  //0
			1: seg = 8'b01111001;  //1
			2: seg = 8'b00100100;  //2
			3: seg = 8'b00110000;  //3
			default: seg = 8'b11111111;  //default
		endcase

	end
end

endmodule
