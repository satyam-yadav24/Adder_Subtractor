module alu #(parameter DATA_WIDTH=4)(
	input logic 						rst,
	input logic 						clk,
	input logic 						en,
	input logic 						control,
	input logic 	[DATA_WIDTH-1:0] 	data1,
	input logic 	[DATA_WIDTH-1:0] 	data2,
	output logic 	[DATA_WIDTH:0] 	    y_out
);


always @(posedge clk) begin 
	if(!rst) begin
		y_out <= 0;
	end 
	else 
		if (en) begin
			if(control == 1) begin
				y_out = data1 + data2;
			end 
			else begin
				y_out = data1 - data2;

			end
 		end
 	end
			


endmodule
			