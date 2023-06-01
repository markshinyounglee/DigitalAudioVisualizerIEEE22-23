module nunchukDriver(clock, SDApin, SCLpin, stick_x, stick_y, accel_x, accel_y, accel_z, z, c, reset);
	input clock; // 50MHz input
	output SDApin, SCLpin, stick_x, stick_y, accel_x, accel_y, accel_z, z, c;
	input reset;
	
	reg polling_clock;
	reg i2c_clock;
	
	pollingClock LowClk(.rawSignal(clock), .modSignal(polling_clock));
	i2c_clock HighClk(.inclk0(clock), .c0(i2c_clock));
	
	I2C UUT(i2c_clock, reset, deviceAddr, addr, numBytes, dataIn, dataOut, write, start, done, SCLpin, SDApin);
	
endmodule