module labThree_partTwo(clock, onOffButton, resetButton, initTime, timeOut5, timeOut4, timeOut3, timeOut2, timeOut1, timeOut0, beepSound);

// pseudocode:
/*
	

*/

	input clock, onOffButton, resetButton;
	input[9:0] initTime; // get the time in seconds
	output[7:0] timeOut5, timeOut4, timeOut3, timeOut2, timeOut1, timeOut0;
	output beepSound;
// output is 8*6 = 48
// We need 3 buttons: reset button, start/pause button, speedup switch


// IMPORTANT NOTE: if button is pressed, it is 0; if it is not pressed, it is 1. Buttons and displays are active low on FPGA board
	reg[7:0] timeOut5old, timeOut4old, timeOut3old, timeOut2old, timeOut1old, timeOut0old; 
	reg[1:0] state = 0; // there are four states so we need 2 bits
	reg[1:0] nextState = 0; // there are now four states: 00 (reset), 01 (run), 10 (pause), 11 (beep)
	reg[19:0] counter_d; // origTime
	reg[19:0] counter; // tracks current time // convert into centiseconds to pass to timeSegDisp
	reg beep = 0; // if beep == 0, no beep; if beep == 1, the beep rings following the clock signal
	reg[7:0] flash;
	reg newClock, newClock2; // clock to track cs (centiseconds)
	reg newClockCheckButton; // clock to track button pressing (ensure you don't press the button for too long; need longer clock cycle)
	// now note that the caveat is that if the clock cycle is too long, it may not recognize the button press. There are many tricks to get around this,
	// including taking multiple readings and averaging them out.
	
	// instantiate clockDivider here, similar to what you did in the test module
	clockDivider clkdiv(clock, 0, newClock); // no speedup modes here
	clockDivider2 clkdiv2(clock, newClock2); // this has way less frequency to see the flashing
	
	always @(posedge newClock) begin // this runs only when posedge is encountered // this is where we use wire (nextState, counter_d) (although it is declared as a reg) to set the value of register (state, counter) (also declared as reg)
		state <= nextState;
		counter <= counter_d; // we set counter here (we need two different registers)
	end
	// we separated always@ block and always_comb block because combinational logic executes all the time whereas the block above is sequential
	
	always_comb begin // this runs all the time
		beep = 0;
		case(state)
			2'd0: // reset state
				begin
					counter_d = 100 * initTime;
					if(!onOffButton) begin // if onOffButton is pressed
						nextState = 1;
					end
					else begin 
						nextState = state;
					end
				end
			2'd1: // running state
				begin
					if(counter <= 0) begin // account for overflow if counter == 0 from beginning
						nextState = 3;
					end
					else if(!resetButton) begin
						nextState = 0;
					end
					else if(!onOffButton) begin
						nextState = 2;
					end
					else begin 
						nextState = state;
					end
					counter_d = counter - 1; // we set counter_d with the value in counter
				end
			2'd2: // paused state
				begin
					counter_d = counter;
					if(!resetButton) begin
						nextState = 0;
					end
					else if(!onOffButton) begin
						nextState = 1;
					end
					else begin 
						nextState = state;
					end
				end
			2'd3: // beeping state
				begin
					counter_d = 0;
					beep = 1; // overwrites beep = 0
					if(!resetButton) begin
						nextState = 0;
						beep = 0;
					end
					else begin
						nextState = state;
					end
				end
		endcase
	
		flash = {8{beep & newClock2}};
		beepSound = beep & newClock; // beeper turns on only when beep = 1
		
		timeOut5 = timeOut5old | flash; // bit masking // active low
		timeOut4 = timeOut4old | flash;
		timeOut3 = timeOut3old | flash;
		timeOut2 = timeOut2old | flash;
		timeOut1 = timeOut1old | flash;
		timeOut0 = timeOut0old | flash;
	end
	
	timeSegDisp disp(counter, timeOut5old, timeOut4old, timeOut3old, timeOut2old, timeOut1old, timeOut0old);
	
endmodule