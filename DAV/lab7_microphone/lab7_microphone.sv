module lab7_microphone(rst, clk, led);
// ADC_IN5 // one value of 12-bits
	input reg rst;
	input reg clk;
	output reg led[9:0]; // 10 LEDs; put into pin planner
	wire[11:0] ADC_IN5; // need to specify // originally [11:0]
	wire[11:0] adjusted_ADC;
	adc_microphone UUT(.RESET(~rst), .CH0(ADC_IN5), .CLOCK(clk));
	// CH0 is built-in so it has a place in the pin. It is in analog0 pin and there is no pin planner
	
	// range: 0 - 2^12-1 (4095)
	// value dependent on decibels (intensity) and not frequency
	
	always_comb begin
		adjusted_ADC <= ADC_IN5 - 12'b010000000000; // downgrade this because the thing is greater than 2^10
		led[9] = (adjusted_ADC > 12'b011111111111); 
		led[8] = (adjusted_ADC > 12'b011011001111);
		led[7] = (adjusted_ADC > 12'b011000110101);
		led[6] = (adjusted_ADC > 12'b010110011011); // stop here
		led[5] = (adjusted_ADC > 12'b010100000001); // 1127 + 154 = 1281
		led[4] = (adjusted_ADC > 12'b010001100111);
		led[3] = (adjusted_ADC > 12'b001111001101);
		led[2] = (adjusted_ADC > 12'b001100110011);
		led[1] = (adjusted_ADC > 12'b001010011001); // add 1536/10 = 8'b10011010
		led[0] = (adjusted_ADC > 12'b000111111111);
	end
	/*
	always@(posedge clk) begin
		if(ADC_IN5 > 12'b011111111111) begin
			led[9] <= 1;
		end
		else
		begin
			led[9] <= 0;
		end
		if(ADC_IN5 > 12'b001111111111) begin
			led[8] <= 1;
		end
		else
		begin
			led[8] <= 0;
		end
		if(ADC_IN5 > 12'b000111111111) begin
			led[7] <= 1;
		end
		else
		begin
			led[7] <= 0;
		end
		if(ADC_IN5 > 8'b11111111) begin
			led[6] <= 1;
		end
		else
		begin
			led[6] <= 0;
		end
		if(ADC_IN5 > 7'b1111111) begin
			led[5] <= 1;
		end
		else
		begin
			led[5] <= 0;
		end
		 if(ADC_IN5 > 6'b111111) begin
			led[4] <= 1;
		end
		else
		begin
			led[4] <= 0;
		end
		if(ADC_IN5 > 5'b11111) begin
			led[3] <= 1;
		end
		else
		begin
			led[3] <= 0;
		end
		if(ADC_IN5 > 3'b111) begin
			led[2] <= 1;
		end
		else
		begin
			led[2] <= 0;
		end
		if(ADC_IN5 > 2'b11) begin
			led[1] <= 1;
		end
		else
		begin
			led[1] <= 0;
		end
		if(ADC_IN5 > 2'b0) begin
			led[0] <= 1;
		end
		else
		begin
			led[0] <= 0;
		end
	end
	*/
endmodule