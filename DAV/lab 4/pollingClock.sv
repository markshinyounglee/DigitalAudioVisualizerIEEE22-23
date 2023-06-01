module pollingClock(rawSignal, modSignal);
// this clock should be 50MHz --> 100Hz so scaling factor = 1/50000
	input rawSignal;
	output reg modSignal;
	// find the clock divider pin (50MHz), which is your input\
	
	reg[15:0] counter; // need to store up to 50000
	
	always @(posedge rawSignal) begin
		if(counter >= 16'd50000) begin
			modSignal = ~modSignal;
			counter <= 0;
		end
	end
endmodule	

// https://www.fpga4student.com/2017/08/verilog-code-for-clock-divider-on-fpga.html#:~:text=The%20Verilog%20clock%20divider%20is%20simulated%20and%20verified,the%20Verilog%20code.%20F%20%28clock_out%29%20%3D%20F%20%28clock_in%29%2FDIVISOR