module nunch_trans(data_in, stick_x, stick_y, accel_x, accel_y, accel_z);
	input[7:0] data_in [5:0]; 		//6 bytes of data in
	output[7:0] stick_x, stick_y; 		// x and y axis values from the nunchuk stick
	output[9:0] accel_x, accel_y, accel_z; // x, y, z axis values from the accelerometer
	output z, c; 	

endmodule