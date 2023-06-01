module clockDivider2(input clock, output reg newClock);
	// for input, we use 50MHz clock
	reg[24:0] counter = 0; // log2(10000000)
	
	initial begin // needed for the purpose of simulation only; shouldn't matter in hardware
		newClock = 1'b0;
	end
	
	always@(posedge clock) begin // make into 5Hz
		counter = counter + 1;
		if (counter >= 10000000) begin // you should flip twice per period because period = time it takes for one posedge ~ next posedge
			newClock = ~newClock;
			counter = 0;
		end
	end
endmodule