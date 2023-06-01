module display(clk, vga_r, vga_g, vga_b, hsync, vsync, rst); // top-level module where everything meets
		input clk, rst;
		output hsync, vsync;
		output [3:0] vga_r, vga_g, vga_b;
		wire adjclk;
		
		Clock UUT1(.clk(clk), .op(adjclk));
		// reset button is active low so you must flip it to trigger if button is pressed
		vga UUT2(.vgaclk(adjclk), .rst(~rst), .hsync(hsync), 
			.vsync(vsync),	.red(vga_r), .green(vga_g), .blue(vga_b));
		
		
endmodule