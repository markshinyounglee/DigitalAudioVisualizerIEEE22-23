// tb_clockDivider // clockDivider testbench
`timescale 1ns/1ns

module tb_clockDivider(clk, spd, nclk);
	output reg clk = 0;
	output reg spd;
	output reg nclk;
	
	clockDivider UUT(.clock(clk), .speedButton(spd), .newClock(nclk));
	
	always begin // works only for simulation; can't do this is regular .sv files that we mount on hardware
		#1; // should be put first
		clk = ~clk; 
	end
	
	initial begin
		spd = 1;
	end

endmodule
