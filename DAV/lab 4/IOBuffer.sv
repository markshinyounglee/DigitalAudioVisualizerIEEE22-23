module IOBuffer (input in, input we, output out, inout SDApin); 
	assign SDApin = (we) ? in : 1'bz;
	assign out = (we) ? 1'b0 : SDApin;
	
 endmodule 