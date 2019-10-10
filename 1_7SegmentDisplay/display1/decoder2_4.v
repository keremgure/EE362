`timescale 1ns / 1ps
module decoder2_4(in,out,rst);

input rst;
input [1:0] in;
output reg [3:0] out;

always@(*)begin
    if(rst)
        out = 4'b1111;
    else begin
        case(in)
            2'b00: out = 4'b1110;
            2'b01: out = 4'b1101;
            2'b10: out = 4'b1011;
            2'b11: out = 4'b0111;
        endcase
    end
end


endmodule
