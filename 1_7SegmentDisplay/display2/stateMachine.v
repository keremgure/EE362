`timescale 1ns / 1ps

module stateMachine(clk, rst, en, state);

input clk, rst, en;
output reg [2:0] state;

reg [2:0] stateNxt;

always @(posedge clk) begin
	state <= #1 stateNxt;
end

always @(*) begin
	stateNxt = state;
	if(rst)
		stateNxt = 0;
	else begin
		if(en)
			stateNxt = state+1;
	end
	// Fill in here.
	// state transitions: 0 -> 1 -> 2-> ... -> 6 -> 0 -> ...
end

endmodule
