// apparently you don't need a testbench. There are specific cases where it could be helpful
/*
`timescale 1ns/1ns

module tb_labThree();
	input button1, button2, switch1;
	output[48:0] outputTm;
	
	labThree timer(.inA(button1), .inB(button2), .inC(switch1), .result(out));
	
endmodule
*/