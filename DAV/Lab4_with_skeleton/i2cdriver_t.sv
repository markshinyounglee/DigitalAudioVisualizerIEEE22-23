`timescale 1ns/1ns

module i2cdriver_t(clk, rst, sda, scl);
	output reg clk = 1;
	output scl; 
	output reg rst = 0;
	inout sda;
	
	wire[7:0] stickx, sticky; 
	wire[9:0] accelx, accely, accelz;
	wire z, c;
	nunchuckDriver UUT1(.clock(clk), .SDApin(sda), .SCLpin(scl), .stick_x(stickx), .stick_y(sticky), .accel_x(accelx), .accel_y(accely), .accel_z(accelz), .z(z), .c(c), .rst(rst)); 
	
	
	always begin
		#1
		clk = ~clk;
		
	end
	
endmodule