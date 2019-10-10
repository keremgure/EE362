`timescale 1ns / 1ps
module knightRiderV2(clk, rst,sw, dataOut);

input clk, rst;
input [7:0] sw;
output reg [7:0] dataOut;
reg [7:0] dataOutNxt;

reg [23:0] counter, counterNxt;
parameter COUNT = 24'hFFFFFF; // 22'h3FFFFF;

wire [2:0] enc_dataOutLeft,enc_dataOutRight;
wire [7:0] dataOutLeft,dataOutRight;

wire zero = 0;
wire one = 1;

reg state,stateNxt;

rider #(COUNT) Rider1(clk,sw,rst,enc_dataOutLeft,zero,counter,state);
rider #(COUNT) Rider2(clk,sw,rst,enc_dataOutRight,one,counter,state);

decoder #(COUNT) rider1Decoder(enc_dataOutLeft,dataOutLeft,counter);
decoder #(COUNT) rider2Decoder(enc_dataOutRight,dataOutRight,counter);


// registers
always @(posedge clk) begin
	counter <= #1 counterNxt;
	dataOut <= #1 dataOutNxt;
	state <= #1 stateNxt;
end

always @(*) begin
	counterNxt = counter +1;
	stateNxt = state;
	dataOutNxt = dataOut;
	if(rst) begin
		counterNxt = 0;
		dataOutNxt = 0;
		stateNxt = 0;
	end
	else if(counter == COUNT -1) begin
		stateNxt = state +1;
		dataOutNxt = dataOutLeft | dataOutRight;
	end

end



endmodule
