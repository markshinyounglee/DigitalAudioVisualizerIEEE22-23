`timescale 1ns/1ns


// how to do block design in Questa: https://docs.xilinx.com/r/2021.2-English/ug994-vivado-ip-subsystems/Adding-RTL-Modules-to-the-Block-Design
module tb_labTwo(output [19:0] result);
	//This testbench should encapsulate miniALU since you will only use this testbench to test miniALU
	reg [3:0] inA, inB;
	reg operation;
	reg power;
	integer i, j, k; //these are for the for loop to know how many iterations to go through. Integers are essentially 32 bit signed regs.

	//instantiate your miniALU with the inputs/outputs from above.
	miniALU alu(.inVal({inA, inB, operation}), .outVal(result)); // function we want to test
	// more on module instantiations at: https://www.chipverify.com/verilog/verilog-module-instantiations
	
	 
	initial begin
		 for(i = 0; i < 16; i = i+1) begin //Looping through all possible inA values (4 bit values -> 0 through 15)
			  inA = i;
			  for(j = 0; j < 16; j = j+1) begin
					#5 // have 5 ns delay here
					inB = j;
					operation = 0;
					assert(result == inA + inB);
					#5 // have 5 ns delay here
					operation = 1;
					assert(result == inA << inB);
			  end
			  /*
			  --------TO DO--------
			  1. You should loop through all possible 4 bit values using j.
					2. Within the for loop, in each iteration you should:
						 3. Have a 5ns delay before doing anything 
						 4. Set inB to j and the operation to 0
						 5. Have another 5ns delay
						 6. set operation to 1
			  --------TO DO--------
			  */
		 end
	end

endmodule