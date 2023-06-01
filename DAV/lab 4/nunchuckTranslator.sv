module nunchuckTranslator(data_in, stick_x, stick_y, accel_x, accel_y, accel_z, z, c);
	input[7:0] data_in [0:5]; 		//6 bytes of data in
	output[7:0] stick_x, stick_y; 		// x and y axis values from the nunchuk stick
	output[9:0] accel_x, accel_y, accel_z; // x, y, z axis values from the accelerometer
	output z, c; 				//the two buttons (hint: ACTIVE LOW)
	
	always_comb begin
		stick_x <= data_in[0];
		stick_y <= data_in[1];
		accel_x <= {data_in[2], data_in[5][3:2]};
		accel_y <= {data_in[3], data_in[5][4:5]};
		accel_z <= {data_in[4], data_in[5][6:7]};
		c <= data_in[5][6];
		z <= data_in[5][7];
	end
	
endmodule