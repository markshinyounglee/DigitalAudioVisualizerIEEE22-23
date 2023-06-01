module pollingClock(rawSignal, modSignal);
// this clock should be 50MHz --> 100Hz so scaling factor = 1/50000
	input rawSignal;
	output reg modSignal;
	// find the clock divider pin (50MHz), which is your input
	
	
	reg[15:0] counter; // need to store up to 50000
	
	always @(posedge rawSignal) begin
		if(counter >= 16'd50000) begin
			modSignal = ~modSignal;
			counter <= 0;
		end
	end
endmodule