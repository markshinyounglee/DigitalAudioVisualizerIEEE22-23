module labThree(clock, speedButton, onOffButton, resetButton, timeOut5, timeOut4, timeOut3, timeOut2, timeOut1, timeOut0);
	input clock, speedButton, onOffButton, resetButton;
	output[7:0] timeOut5, timeOut4, timeOut3, timeOut2, timeOut1, timeOut0;
// output is 8*6 = 48
// We need 3 buttons: reset button, start/pause button, speedup switch


// IMPORTANT NOTE: if button is pressed, it is 0; if it is not pressed, it is 1
	reg[1:0] state = 0; // there are three states so we need 2 bits
	reg[19:0] currTime = 0; // need 20 bits to store 99 min 99 sec 99 centisec (=604,000cs = (10010011011101100000)_2)
	wire[1:0] nextState;
	reg newClock; // clock to track cs (centiseconds)
	reg newClockCheckButton; // clock to track button pressing (ensure you don't press the button for too long; need longer clock cycle)
	// now note that the caveat is that if the clock cycle is too long, it may not recognize the button press. There are many tricks to get around this,
	// including taking multiple readings and averaging them out.
	
	// int currMin = 0, currSec = 0, currCentSec = 0;
	
	always_comb begin // this is where we perform the calculations needed
		case(state)
			2'd0: // reset state
				begin
					if(!onOffButton) begin // if onOffButton is pressed
						nextState = 1;
					end
					else begin 
						nextState = state;
					end
				end
			2'd1: // running state
				begin
					if(!resetButton) begin
						nextState = 0;
					end
					else if(!onOffButton) begin
						nextState = 2;
					end
					else begin 
						nextState = state;
					end
				end
			2'd2: // paused state
				begin
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
		endcase
	end
	
	// instantiate clockDivider here, similar to what you did in the test module
	clockDivider clkdiv(clock, speedButton, newClock);
	
	always @(posedge newClock) begin // should be newclock // this is where we modify the actual state of the machine
		state = nextState;
		
		case(state)
			2'd0: // reset state
				currTime = 0; 
			2'd1: // running state // leave as is
				currTime = currTime +  1;
			2'd2: // paused state
				;
		endcase
	end
	
	/*
	sevenSegDigit dig0(dispDigit0, timeOut[7:0]); // instantiations should come outside of always block
	sevenSegDigit dig1(dispDigit1, timeOut[15:8]);
	sevenSegDigit dig2(dispDigit2, timeOut[23:16]);
	sevenSegDigit dig3(dispDigit3, timeOut[31:24]);
	sevenSegDigit dig4(dispDigit4, timeOut[39:32]);
	sevenSegDigit dig5(dispDigit5, timeOut[47:40]);
	*/
	
	timeSegDisp disp(currTime, timeOut5, timeOut4, timeOut3, timeOut2, timeOut1, timeOut0);
	
endmodule