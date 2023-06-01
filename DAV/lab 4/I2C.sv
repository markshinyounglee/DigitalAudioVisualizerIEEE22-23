module I2C(i2c_clock, reset, deviceAddr, addr, numBytes, dataIn, dataOut, write, start, done, SCLpin, SDApin);
// one master, many slaves [peripherals]
	input reset;
	input [6:0] deviceAddr; // address of slave
	input reg[7:0] addr;
	input numBytes; // x-bit value based on parameter
	input reg[47:0] dataIn; // data to write // 6 bytes
	output[47:0] dataOut; // data bus output // 6 bytes
	input write; // read/write byte // 0 = write; 1 = read
	input start;
	output done;
	inout SCLpin; // serial clock line
	inout SDApin; // serial data line // tristate buffer
	reg[7:0] state;
	
	IOBuffer UUT0(.in());
	
	localparam IDLE_STATE = 0; // idle state
	localparam STATE_START = 1;
	localparam ACK_RECEIVED = 2;
	localparam HANDSHAKE1 = 3; 
	localparam HANDSHAKE2 = 4; 
	localparam PREP_WRITE = 5;
	localparam READ_SIX_BUTTONS = 6;
	localparam STATE_STOP = 7;
	
	// clear START signal : SDA kept low while SCL pushed high
	// --> clarify what device to communicate to : 
	// --> send/receive data byte by byte : 
	// clear STOP signal : 
	
	// don't change SDA when SCL is high
	// if SDA goes H/L when SCL is high, that is START
	// if SDA is L/H when SCL is high, that is STOP
	// SDA changing when SCL is high corresponds to control signal (determined by I2C designers)
	
	// there are two addresses: data address and register address
	// we can specify writing but cannot reading
	
	
	always @(posedge i2c_clock) begin
		state = IDLE_STATE;
		
		// handshake 1
		
	
		if(start) begin // we start the loop
			case (state):
				IDLE_STATE:
					begin
					end
				STATE_START:
					begin
					end
				ACK_RECEIVED:
					begin
					end
				HANDSHAKE1:
					begin
						deviceAddr <= 8'h52; // address of slave
						addr <= 8'hF0; // The register address we want to write to
						numBytes <= 1; // The number of bytes to read/write
						write	<= 0; // Whether or not to read/write
						dataIn[0] <= 8'h55; // data to write
					end
				HANDSHAKE2: 
					begin
						deviceAddr <= 8'h52; // address of slave
						addr = 8'hF0; // The register address we want to write to
						numBytes	= 1; // The number of bytes to read/write
						write	= 0; // Whether or not to read/write
						dataIn[0] <= 8'h55; // data to write
					end
				STATE_STOP:
					begin
					end	
			endcase
		
		end
	end
	
	
endmodule