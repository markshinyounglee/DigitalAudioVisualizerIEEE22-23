module IOBuffer(in, out, write_enable, sda_port);
	inout reg sda_port;
	input reg in;
	input reg write_enable;
	output reg out;
	//TODO: complete IOBuffer as described in the lab spec.

	always_comb begin
	
		if(write_enable == 1'b1) begin // write mode or send-data mode
			assign sda_port = in;
			assign out = 1'b0;
		end else begin // read mode or receive-data mode
			assign sda_port = 1'bz;
			assign out = sda_port;
		end
	end
	
endmodule