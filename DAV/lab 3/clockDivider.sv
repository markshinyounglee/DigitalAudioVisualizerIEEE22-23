// clock divider module
module clockDivider(input clock, input speedButton, output reg newClock);
	// for input, we use 50MHz clock
	reg[18:0] counter = 0;
	
	initial begin // needed for the purpose of simulation only; shouldn't matter in hardware
		newClock = 1'b0;
	end
	
	always@(posedge clock) begin
		counter = counter + 1;
		
		if(speedButton == 1) begin // clock is 200Hz
			if (counter >= 125000) begin // you should flip twice per period because period = time it takes for one posedge ~ next posedge
				newClock = ~newClock;
				counter = 0;
			end
		end
		
		else begin // when speed is low so the clock should be 100Hz
			if(counter >= 250000) begin
				newClock = ~newClock;
				counter = 0;
			end
		end
	end
endmodule