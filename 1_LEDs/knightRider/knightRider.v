`timescale 1ns / 1ps
module knightRider(clk, rst, dataOut);

input clk, rst;
output reg [7:0] dataOut;

reg [24:0] counter, counterNext;
reg [ 7:0] dataOutNext;
reg flag,flagNxt;
parameter COUNT = 22'h3FFFFF; // 22'h3FFFFF;

// registers
always @(posedge clk) begin
	counter <= #1 counterNext;
	dataOut <= #1 dataOutNext;
	flag <= #1 flagNxt;
end

always @(*) begin
	dataOutNext = dataOut;
	counterNext = counter +1;
	flagNxt = flag;
	if(rst) begin
		dataOutNext = 8'b0000_0001;
		counterNext = 0;
		flagNxt = 0;
	end else if(counter == COUNT -1) begin
		case(flag)
			0: dataOutNext = dataOut << 1;
			1: dataOutNext = dataOut >> 1;
		endcase
	end else begin
		if(dataOut== 8'b1000_0000)
			flagNxt = 1;
		else if (dataOut == 8'b000_0001)
			flagNxt = 0;
			
	end
	
end
endmodule

