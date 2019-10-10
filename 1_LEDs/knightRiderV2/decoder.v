`timescale 1ns / 1ps
module decoder(enc_dataIn,dataOut,counter);

//get the state if you want blinking features!!
parameter COUNT = 22'h3FFFFF;
input [23:0] counter;

input [2:0] enc_dataIn;
output reg [7:0] dataOut;


always@(*)begin
	dataOut = 0;
	if(counter == COUNT -1)begin
		case(enc_dataIn)
			3'b000: dataOut = 8'b0000_0001;
			3'b001: dataOut = 8'b0000_0010;
			3'b010: dataOut = 8'b0000_0100;
			3'b011: dataOut = 8'b0000_1000;
			3'b100: dataOut = 8'b0001_0000;
			3'b101: dataOut = 8'b0010_0000;
			3'b110: dataOut = 8'b0100_0000;
			3'b111: dataOut = 8'b1000_0000;
		endcase
	end
end

endmodule
