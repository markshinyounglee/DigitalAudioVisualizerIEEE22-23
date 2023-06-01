module butterfly #(parameter WIDTH = 32)(w, inA, inB, outA, outB); // implement the butterfly module // WIDTH can be 32 bits or 16 bits
	localparam half_width = WIDTH/2; // 16
	input signed[WIDTH-1:0] w; // twiddle factor
	input signed[WIDTH-1:0] inA, inB; // first 16 bits are real; second 16 bits are imaginary
	output reg signed[WIDTH-1:0] outA; // add inA with truncated value of w*inB
	output reg signed[WIDTH-1:0] outB; // subtract inA from truncated value of w*inB
	
	wire [half_width-1:0] real_A;
	assign real_A[half_width-1:0] = inA[WIDTH-1:half_width];  
	wire [half_width-1:0] im_A;
   assign im_A[half_width-1:0]= inA[half_width-1:0];
	wire [half_width-1:0] real_B;
	assign real_B = inB[WIDTH-1:half_width]; 
	wire [half_width-1:0] im_B; 
	assign im_B = inB[half_width-1:0];
	
	wire [WIDTH-1:0] shifted_rB;
	assign shifted_rB = real_B << 15; // multiply by 2^15 to compensate for later truncating w*B
	wire [WIDTH-1:0] shifted_iB;
	assign shifted_iB= im_B << 15; 
	wire rw;
	assign rw = w[WIDTH-1:half_width]; // real component
	wire iw;
	assign iw = w[half_width-1:0]; // imaginary component
	
	// remember that since both B and w are complex numbers, after splitting them into imaginary and real components, we should do FOIL
	// B = real_B + j * im_B; w = rw + j * iw;
	// B * w  = (real_B*rw - im_B*iw) + j * (real_B*iw + im_B*rw) // slide 36
	// but at the same time, we have to make sure the result is 16 bit for both real and imaginary components
	// so we have to truncate real_B*rw, im_B*iw, real_B*iw, and im_B*rw
	// but in order to compensate with 15 bit truncation, we should multiply real_B and im_B in advance
	
	wire [WIDTH-1:0] tmp_r;
	assign tmp_r= (shifted_rB*rw) - (shifted_iB*iw);
	wire [WIDTH-1:0] tmp_i;
	assign tmp_i = (shifted_rB*iw) + (shifted_rB*iw); 
	
	always@(*) begin
		outA[WIDTH-1:half_width] <= real_A + tmp_r[WIDTH-1:half_width]; // real component
		outA[half_width-1:0] <= im_A + tmp_i[half_width-1:0]; // imaginary component
		outB[WIDTH-1:half_width] <= real_A - tmp_r[WIDTH-1:half_width];
		outB[half_width-1:0] <= im_A - tmp_i[half_width-1:0];
	end
endmodule