`timescale 1ns / 1ps

module stateMachine(clk, rst, en, state,rot);

input clk, rst, en,rot;
output reg [2:0] state;

reg [2:0] stateNxt;

always @(posedge clk) begin
	state <= #1 stateNxt;
end

always @(*) begin
	if(rst)
		stateNxt = 0;
	else if(rot && en)
		stateNxt = state+1;
	else
		stateNxt = state;
end

endmodule
