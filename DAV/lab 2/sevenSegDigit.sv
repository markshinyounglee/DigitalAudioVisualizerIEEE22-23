module sevenSegDigit(input [3:0] decimalNum, output reg [7:0] dispBits, input onOff);
	//Note that it is legal to do input/output and bitwidth declarations within the port list like above!

	always_comb begin 
		//Remember we can only use reg logic in always blocks. 
		//always_comb is similar to always@(*) but it is a compiler directive that will cause a compilation error if the logic inside is not actually combinational. 
		//As such, when we want to use combinational logic, it is better practice to use always_comb to catch errors!
		/*
		----------PART TWO----------
		Your logic to convert decimal number to the bits corresponding to a seven-seg goes here.
		4 bit input -> values from 0 to 15. We can only display 0 to 9 but you should still deal with cases where 10-15 are passed in. In this case, set it so the display is just blank.
		We reccomend a case statement. Make sure all of the cases have outputs assigned.
		----------PART TWO----------
		*/
		case (decimalNum) 
			4'b0000: dispBits = 8'b11000000; // 0 // reversed [7:0] because the first bit is dig0[7] and last bit is dig0[0]
			4'b0001: dispBits = 8'b11111001; // 1 // reversed
			4'b0010: dispBits = 8'b10100100; // 2 
			4'b0011: dispBits = 8'b10110000; // 3 
			4'b0100: dispBits = 8'b10011001; // 4
			4'b0101: dispBits = 8'b10010010; // 5
			4'b0110: dispBits = 8'b10000010; // 6
			4'b0111: dispBits = 8'b11111000; // 7
			4'b1000: dispBits = 8'b10000000; // 8
			4'b1001: dispBits = 8'b10010000; // 9
			default: dispBits = 8'b11111111; // error // all off
		endcase
		
		if (onOff == 0) begin
			dispBits = 8'b11111111; // all off
		end
	end

endmodule