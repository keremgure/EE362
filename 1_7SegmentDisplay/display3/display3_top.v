`timescale 1ns / 1ps
module display3_top(clk, rst, enter, dataIn, sevenSeg, anode,ledOut,rotControl);

input clk, rst, enter;
input [3:0] dataIn;
output [3:0] anode;
output [7:0] sevenSeg;
output[3:0] ledOut;
output rotControl;

parameter SCWIDTH = 15;
parameter RCWIDTH = 25;

wire [4:0] seg0, seg1, seg2, seg3;
wire en, enterDB,rotationBegin;
wire [2:0] state;
wire [4:0] seg0wr, seg1wr, seg2wr, seg3wr;

debounce debounce0(.rst(rst), .clk(clk), .noisy(enter), .clean(enterDB));
wrLogic wrLogic0(.clk(clk), .rst(rst), .enter(enterDB), .sw(dataIn), .seg0wr(seg0wr), .seg1wr(seg1wr), .seg2wr(seg2wr), .seg3wr(seg3wr),.led(ledOut),.rot(rotationBegin),.rotC(rotControl));
timer #(RCWIDTH) timer0(.clk(clk), .rst(rst), .en(en));
stateMachine stateMachine0(.clk(clk), .rst(rst), .en(en), .state(state),.rot(rotationBegin));
SevenSegFourDigwithEnable #(SCWIDTH) SevenSegFourDigwithEnable0(.clk(clk), .rst(rst), .in({seg3, seg2, seg1, seg0}), .sevenSeg(sevenSeg), .anode(anode));
rotateDigit rotateDigit0(.in0(seg0wr), 
								 .in1(seg1wr), 
								 .in2(seg2wr), 
								 .in3(seg3wr), 
								 .in4(5'b10000), 
								 .in5(5'b10000), 
								 .in6(5'b10000), 
								 .state(state), 
								 .seg0(seg0), 
								 .seg1(seg1), 
								 .seg2(seg2), 
								 .seg3(seg3));

endmodule
