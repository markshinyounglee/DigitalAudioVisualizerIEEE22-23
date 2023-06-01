module timeSegDisp(value, dig5, dig4, dig3, dig2, dig1, dig0);
	input [19:0] value; 
	output [7:0] dig5, dig4, dig3, dig2, dig1, dig0; // 5 to 0 are the 6 displays on the board from left to right
	reg [3:0] input5, input4, input3, input2, input1, input0; //You will need more of these 
	
	int currMin = 0, currSec = 0, currCentSec = 0;
	
	always_comb begin
		begin
			currMin <= value/6000;
			currSec <= (value%6000)/100;
			currCentSec <= (value%6000)%100;
			
			input0 = currCentSec%10;
			input1 = currCentSec/10;
			input2 = currSec%10;
			input3 = currSec/10;
			input4 = currMin%10;
			input5 = currMin/10;
		end
	end
	
	sevenSegDigit digit5(.decimalNum(input5), .dispBits(dig5)); //Instantiation of the leftmost seven-seg display
	sevenSegDigit digit4(.decimalNum(input4), .dispBits(dig4));
	sevenSegDigit digit3(.decimalNum(input3), .dispBits(dig3));
	sevenSegDigit digit2(.decimalNum(input2), .dispBits(dig2));
	sevenSegDigit digit1(.decimalNum(input1), .dispBits(dig1));
	sevenSegDigit digit0(.decimalNum(input0), .dispBits(dig0));
	
endmodule
