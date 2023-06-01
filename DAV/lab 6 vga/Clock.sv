module Clock(clk, op);
	input clk;
	output reg op = 0;
	
	always @(posedge clk) begin
		op <= ~op; // divide by 2
	end
endmodule