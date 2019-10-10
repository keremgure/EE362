`timescale 1ns / 1ps
module rider(clk,sw,rst,dataOut,dir,counter,state);

parameter COUNT = 22'h3FFFFF;
input [23:0] counter;


input clk,rst,dir,state;
input [7:0] sw;


output reg [2:0] dataOut;
reg [2:0] dataOutNxt;
reg returning,returningNxt = 0;


always @(posedge clk)begin
	dataOut <= #1 dataOutNxt;
	returning <= #1 returningNxt;
end


always@(*)begin
	dataOutNxt = dataOut;
	returningNxt = returning;
	if(rst)begin
		dataOutNxt = (dir ? 0 : 7);
		returningNxt = 0;
	end
	else if(counter == COUNT -1)begin
		case(state)
			0: begin
				if(!returning)begin
					case(dataOut)
						7:returningNxt = dir || sw[7];
						6:returningNxt = sw[6];
						5:returningNxt = sw[5];
						4:returningNxt = sw[4];
						3:returningNxt = sw[3];
						2:returningNxt = sw[2];
						1:returningNxt = sw[1];
						0:returningNxt = !dir || sw[0];
					endcase //dataOut
				end else if(dataOut == 0 && dir)
					returningNxt = 0;
				else if(dataOut == 7 && !dir)
					returningNxt = 0;
			end //state:0
			
			1: begin
				case(returning)
					0: dataOutNxt = (dir ? dataOut + 1 : dataOut - 1);
					1: dataOutNxt = (dir ? dataOut - 1 : dataOut + 1);
				endcase	//returning		
			end //state:1
		endcase //state
	end //else if
end //always

endmodule
