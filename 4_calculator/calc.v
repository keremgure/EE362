`timescale 1ns / 1ps
module calc(clk, rst, validIn, dataIn, ledOut);
input clk, rst, validIn;
input  [7:0] dataIn;
output reg [7:0] ledOut;

reg [1:0] state, stateNxt;
reg [7:0] number, numberNxt, ledOutNxt;
reg [2:0] operator, operatorNxt;

////////////////// for clean validIn
wire valid;
wire validClean;
reg validReg;
assign valid = validClean &!validReg; 
///////////////////
debounce dbc (.clk(clk), .rst(rst), .in(validIn), .out(validClean)); //instantination
///////////////////
always @(posedge clk) begin
	validReg   <= #1 validClean;    // for clean validIn
	state      <= #1 stateNxt;
	number     <= #1 numberNxt;
	operator   <= #1 operatorNxt;
	ledOut     <= #1 ledOutNxt;
end

always @(*) begin
	stateNxt    = state;
	numberNxt   = number;
	operatorNxt = operator;
	ledOutNxt   = ledOut;
	if(rst) begin
		stateNxt    = 0;
		numberNxt   = 0;
		operatorNxt = 0;
		ledOutNxt   = 0;
	end else begin
		case(state)
			0: begin
				if(valid)begin
					numberNxt = dataIn;
					stateNxt = state+1;
					ledOutNxt = numberNxt;
				end
				else begin
					stateNxt = 0;
					ledOutNxt = ledOut;
				end
			end
			1: begin
				if(valid)begin
					operatorNxt = dataIn[2:0];
					if(operatorNxt == 3 || operatorNxt == 4 || operatorNxt == 5)begin
						stateNxt = 0;
						case(operatorNxt)
                            3: ledOutNxt = number * number;
                            4: ledOutNxt = number+1;
                            5: ledOutNxt = number-1;
                        endcase
					end
                    else begin
                        stateNxt = state + 1;
                        ledOutNxt = operatorNxt;
                    end
				end
			end
			2: begin
                if(valid)begin
                    numberNxt = dataIn;
                    case(operator)
                        0: ledOutNxt = number * numberNxt;
                        1: ledOutNxt = number + numberNxt;
                        2: ledOutNxt = number - numberNxt;
                    endcase
                    stateNxt = 0;
                end
			end	
		endcase
	end
end
endmodule
