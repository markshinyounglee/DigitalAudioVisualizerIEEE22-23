module labTwo(input [9:0] switches, output [47:0] leds, output [9:0] indicators);
	//since this is the top level, it should include all of your IO as ports
	//Inputs: switches ==> 10 in total
	//Outputs: leds, 6 seven segment signals (dig5, dig4, dig3, dig2, dig1, dig0) that are 8 bits each ==> 58 in total
	//Other reg/wires:
	reg [3:0] input5, input4, input3, input2, input1, input0; //These are inputs for your six seven-seg displays 
	reg [19:0] decimalValue;
	reg[3:0] pow;
	reg [7:0] dig5, dig4, dig3, dig2, dig1, dig0; // new to test the LEDs

	int i;
	 

	/*
	----------PART ONE----------
	Assign your LED pin outs based on your switch inputs. 
	This should be very simple (assign statements) and can go directly in the top level
	----------PART ONE----------
	*/
	
	always_comb begin
		for(i = 0; i < 10; i++) begin
			 indicators[i] = switches[i];
		end
		
		/*
		// miniALU code // just put it here and adopt it
		if(switches[1] == 0) begin
			decimalValue = switches[9:6] + switches[5:2]; // A + B
		end
		else begin
			decimalValue = switches[9:6] << switches[5:2]; // A << B
		end
		
		// sevenSegDisp code // just put here
		input5 = (decimalValue / 100000) % 10;
		input4 = (decimalValue / 10000) % 10;
		input3 = (decimalValue / 1000) % 10;
		input2 = (decimalValue / 100) % 10;
		input1 = (decimalValue / 10) % 10;
		input0 = decimalValue % 10;
		// inputs have values between 1-9
		
		// no problem here
		power = {4{~switches[0]}}; // create a bit mask // 1111 if switch[0] or 0000 if switch[1]
		input5 = input5 | power;
		input4 = input4 | power;
		input3 = input3 | power;
		input2 = input2 | power;
		input1 = input1 | power;
		input0 = input0 | power;
		
		$display("input 5: %d\n", input5);
		$display("input 4: %d\n", input4);
		
		
		dig5 = leds[47:40];
		dig4 = leds[39:32];
		dig3 = leds[31:24];
		dig2 = leds[23:16];
		dig1 = leds[15:8];
		dig0 = leds[7:0];
		*/
		
		/*
		if (switches[0] == 1) begin // on/off switch
			sevenSegDigit dig0(10, leds[47:40]);
			sevenSegDigit dig1(10, leds[39:32]);
			sevenSegDigit dig2(10, leds[31:24]);
			sevenSegDigit dig3(10, leds[23:16]);
			sevenSegDigit dig4(10, leds[15:8]);
			sevenSegDigit dig5(10, leds[7:0]);	
		end
		*/
	end
	
	/*
	sevenSegDigit digit5(.decimalNum(input5), .dispBits(dig5)); //Instantiation of the leftmost seven-seg display
	sevenSegDigit digit4(.decimalNum(input4), .dispBits(dig4));
	sevenSegDigit digit3(.decimalNum(input3), .dispBits(dig3));
	sevenSegDigit digit2(.decimalNum(input2), .dispBits(dig2));
	sevenSegDigit digit1(.decimalNum(input1), .dispBits(dig1));
	sevenSegDigit digit0(.decimalNum(input0), .dispBits(dig0));
	*/
	
	// instead of instantiating alu and sevenSegDisp, pulled the code directly into always block
	// this shouldn't be in always block
	miniALU alu(switches[9:1], decimalValue);
	// what we have: dig0, ..., dig5 (8'b1111_1111 if off, something else if on)
	// also we have decimalValue after passing into miniALU
	sevenSegDisp display(decimalValue, leds[47:40], leds[39:32], leds[31:24], leds[23:16], leds[15:8], leds[7:0], switches[0]);	
	
	/*
	always_comb begin
		for(int i = 0; i < 10; i++) begin
			leds[i] = switches[i]; // rightmost input
		end
	end
	*/
	
	/*
	
	wire[3:0] led5, led4, led3, led2, led1, led0;
	
	assign led5 = input5;
	assign led4 = input4;
	assign led3 = input3;
	assign led2 = input2;
	assign led1 = input1;
	assign led0 = input0;
	*/

	/*
	----------PART TWO----------
	First, fill out the code for the sevenSegDigit module.

	Instantiate 6 copies of sevenSegDigit, using the dig5, dig4, etc as inputs like so:
	sevenSegDigit digit5(input5, dig5); //Instantiation of the leftmost seven-seg display. Note that dig5 should be connected to the pins corresponding to the leftmost display

	In an always_comb block, you can set inputs to these digits to numbers you want to check!

	After finishing part two, comment out these 6 instantiations and the logic to set the inputs so that it does not interfere with part three
	----------PART TWO----------
	*/
	

	/*
	----------PART FOUR----------
	First, fill out the code for the sevenSegDisp module.
	Instantiate the sevenSegDisp module using decimalValue as the input, and connecting the outputs to the six 8-bit seven segment display signal pins in your top level
	Instantiate miniALU with the appropriate signals from the switch inputs as inputs (based on the spec) and decimalValue as the output.
	----------PART FOUR----------
	*/
	


	/*
	----------PART FIVE----------
	We've used 8 of the switches for inputs A and B that are four bits each. One switch is the operation.
	Now, the last switch will act as an enable for the display. If the last switch is high, the display should work as intended.
	If the last switch is low, the display should be blank regardless of the math in part four. 
	We want to add a step between the output for sevenSegDisp and the actual output that goes to the display that sets the actual output to drive a blank display if the switch is low.
	----------PART FIVE----------
	*/

endmodule