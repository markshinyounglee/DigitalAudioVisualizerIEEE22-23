module sevenSegDisp(value, {dig5, dig4, dig3, dig2, dig1, dig0}, pow);
	input [19:0] value; 
	input pow;
	output [7:0] dig5, dig4, dig3, dig2, dig1, dig0; // 5 to 0 are the 6 displays on the board from left to right
	reg [3:0] input5, input4, input3, input2, input1, input0; //You will need more of these 
	
	/*
	assign input0 = 4'b0000;
	assign input1 = 4'b0001;
	assign input2 = 4'b0110;
	assign input3 = 4'b0111;
	assign input4 = 4'b1000;
	assign input5 = 4'b1001;
	*/
	
	// we can use simpler logic using modulo operator
	always_comb begin
		input5 = (value / 100000) % 10;
		input4 = (value / 10000) % 10;
		input3 = (value / 1000) % 10;
		input2 = (value / 100) % 10;
		input1 = (value / 10) % 10;
		input0 = value % 10;
	end

	/*
	int i;
	int number[6]; // should store {0, 0, 0, 6, 4, 5}
	int total = 0;
	int divider = 100000;
	int multiplier = 1;
	
	always_comb begin
		for(i = 0; i < 19; i++) begin // 000111000...101
			total += multiplier * value[i];
			multiplier *= 2;
		end
		multiplier = 1;
		
		for(i = 5; i >= 0; i--) begin
			number[i] = total / divider;
			total = total % divider;
			divider /= 10;
		end
		divider = 1;
		// number[6] should store {0, 0, 0, 6, 4, 5}
		
		input5 = number[5];
		input4 = number[4];
		input3 = number[3];
		input2 = number[2];
		input1 = number[1];
		input0 = number[0];
		
	end
	*/
	
	

	/* 
	----------PART THREE----------
	Instantiate six of the sevenSegDigit modules that you wrote, one corresponding to each physical display
	*/
	
	
	// you cannot instantiate module in conditionals
	/*
	if(power == 0) begin
		dig5 = 8'b11111111;
		dig4 = 8'b11111111;
		dig3 = 8'b11111111;
		dig2 = 8'b11111111;
		dig1 = 8'b11111111;
		dig0 = 8'b11111111;
	end
	else begin
	*/
	sevenSegDigit digit5(.decimalNum(input5), .dispBits(dig5), .onOff(pow)); //Instantiation of the leftmost seven-seg display
	sevenSegDigit digit4(.decimalNum(input4), .dispBits(dig4), .onOff(pow));
	sevenSegDigit digit3(.decimalNum(input3), .dispBits(dig3), .onOff(pow));
	sevenSegDigit digit2(.decimalNum(input2), .dispBits(dig2), .onOff(pow));
	sevenSegDigit digit1(.decimalNum(input1), .dispBits(dig1), .onOff(pow));
	sevenSegDigit digit0(.decimalNum(input0), .dispBits(dig0), .onOff(pow));
	// end
	
	/*

	Next, you should write logic to convert the 20 bit value into 6 different 4 bit inputs for each of your displays.
	For example, if your value is 146, you want the three leftmost digits to get 0, dig2 to get input 1, dig1 to get input 4, and dig0 to get input 6.
	You will likely need to use the division and mod operators to convert from binary to base10.

	Please wrap your logic in an always_comb block to ensure combinational logic only.
	----------PART THREE----------
	*/
endmodule
