// miniALU system verilog file
module miniALU(input [8:0] inVal, output reg[19:0] outVal);
	// long version for inA, inB calculation
	/*
	int inA = 0;
	for(i = 0; i < 4; i++) begin
		inA += switches[i] * multiplier;
		multiplier *= 2;
	end
	
	int inB = 0;
	multiplier = 1;
	for(i = 5; i < 8; i++) begin
		inB += switches[i] * multiplier;
		multiplier *= 2;
	end
	*/
	
	// ALU logic
	// 1. extract the numeric value from first 4 bits (1st input)
	// 2. extract the numeric value from second 4 bits
	// 3. according to the conditional bit, apply the operations using if and else
	
	always_comb begin
		if(inVal[0] == 0) begin
			outVal = inVal[8:5] + inVal[4:1]; // A + B
		end
		else begin
			outVal = inVal[8:5] << inVal[4:1]; // A << B
		end
	end
	
endmodule