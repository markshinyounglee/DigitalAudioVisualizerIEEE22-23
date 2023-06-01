module tb_vga(r, g, b);
	
	reg clk=0;           //input pixel clock: how fast should this be? // megaclock / 2
	reg reset=1'b0;              //synchronous reset
	logic hs;			//horizontal sync out
	logic vs;			//vertical sync out
	output reg [3:0] r;	//red vga output
	output reg [3:0] g; //green vga output
	output reg [3:0] b;
	reg [4:0] counter=4'b0;
	
	vga UUT1(.vgaclk(clk),           //input pixel clock: how fast should this be? // megaclock / 2
		.rst(reset),              //synchronous reset
		.hsync(hs),			//horizontal sync out
		.vsync(vs),			//vertical sync out
		.red(r),	//red vga output
		.green(g), //green vga output
		.blue(b)	//blue vga output);
	);
	
	always
	begin 
		#5 
		clk = ~clk;
		//counter=counter+1;
	end

	/*
	initial
	begin
		if(counter >= 4'b1111) begin
			reset = 1'b1;
			#10
			reset = 1'b0;
			counter = 4'b0;
		end
	end
	*/
	
endmodule
