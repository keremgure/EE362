`timescale 1ns / 1ps
module state_machine(btn, clk, ledOut, rst);
input btn, clk, rst;
output reg [2:0] ledOut;

reg [2:0] ledOutNxt;
//////////for clean input
//reg prevBtn;
//wire posedgeBtn;
//assign posedgeBtn = ~prevBtn & btn;


wire dbBtn;
wire validClean;
reg validReg;
assign dbBtn = validClean &!validReg;

debounce db(btn,clk,validClean,rst);
//////////

reg [1:0] state,stateNxt = 0;

always@(posedge clk) begin
//	prevBtn <= #1 btn; 					//for clean input
	ledOut  <= #1 ledOutNxt;
	state <= #1 stateNxt;
	validReg   <= #1 validClean;
end
always@(*)begin
	stateNxt = state;
	ledOutNxt = ledOut;
	
	if(rst)begin
		ledOutNxt = 3'b001;
		stateNxt = 0;
	end
	else begin
		case(state)
			0:begin
				if(dbBtn)begin
					stateNxt = state + 1;
					ledOutNxt = 3'b010;
				end 
			end
			1: begin
				if(dbBtn)begin
					stateNxt = state + 1;
					ledOutNxt = 3'b11;
				end 
			end
			2: begin
				if(dbBtn)begin
					stateNxt = state + 1;
					ledOutNxt = 3'b100;
				end 
			end
			3: begin
				if(dbBtn)begin
					stateNxt = 0;
					ledOutNxt = 3'b001;
				end 
			end
		endcase
	end
end
		
endmodule
