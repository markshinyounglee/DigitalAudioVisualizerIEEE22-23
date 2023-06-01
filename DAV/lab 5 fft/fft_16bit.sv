`define w_0_4 16'h7f00 // twiddle 2.1 // w_n = exp(-1j*2*pi*k/n);
`define w_1_4 16'h007f// twiddle 2.2 // left-shift 00 01 by 7 bits to compensate truncation (but the nearest big number is 7f and not ff because ff is translated as a negative number
`define w_0_2 16'h7f00 // twiddle 1 // left-shift 01 00 by 7 bits to compensate truncation (nearest big number is 7F because FF is a negative value)

module fft_16bit(clk, reset, start, in0, in1, in2, in3, out0, out1, out2, out3, done);
    input clk;
    input reset;
    input[31:0] in0, in1, in2, in3;
    input start;

    output reg[15:0] out0=0, out1=0, out2=0, out3=0;
    output reg done=0;

    reg[1:0] state = 2'b0; // stage 1 and 2 // log_2(n) where n is the number of inputs. Since n = 4, log_2(4) = 2 so we have 2 layers
    
    reg[15:0] butterfly_1_in0;
    reg[15:0] butterfly_1_in1;
    reg[15:0] butterfly_2_in0;
    reg[15:0] butterfly_2_in1;
    reg[15:0] butterfly_1_out0;
    reg[15:0] butterfly_1_out1;
    reg[15:0] butterfly_2_out0;
    reg[15:0] butterfly_2_out1;
    reg[15:0] w1;
	 reg[15:0] w2;
    
	 localparam RESET = 0; // states
	 localparam STAGE1 = 1;
	 localparam STAGE2 = 2;
	 localparam DONE = 3;
	 localparam HIGH = 1;
	 localparam LOW = 0;

    butterfly #(16) b1(.w(w1), .inA(butterfly_1_in0), .inB(butterfly_1_in1), .outA(butterfly_1_out0), .outB(butterfly_1_out1));
    butterfly #(16) b2(.w(w2), .inA(butterfly_2_in0), .inB(butterfly_2_in1), .outA(butterfly_2_out0), .outB(butterfly_2_out1));

    always@(posedge clk) 
	 begin   // should be sequential because the output from stage 1 must be put in a register
        if (state == RESET) 
		  begin // if all two stages are finished, output the result
            done <= 0;
				if(start == 1)
				begin
					state <= STAGE1;
				end
        end
        else if (state == STAGE1) 
		  begin
            butterfly_1_in0 <= in0;
            butterfly_1_in1 <= in2;
            butterfly_2_in0 <= in1;
            butterfly_2_in1 <= in3;
				w1 <= `w_0_2;
				w2 <= `w_0_2;
				if(start == 0 || reset == 1)
				begin
					state <= RESET;
				end
				else 
				begin
					state <= STAGE2;
				end
        end
        else if(state == STAGE2) 
		  begin
            butterfly_1_in0 <= butterfly_1_out0;
            butterfly_1_in1 <= butterfly_2_out0;
            butterfly_2_in0 <= butterfly_1_out1;
            butterfly_2_in1 <= butterfly_2_out1;
				w1 <= `w_0_4;
				w2 <= `w_1_4;
				if(start == 0 || reset == 1)
				begin
					state <= RESET;
				end
				else
				begin
					state <= DONE;
					done <= HIGH;
				end
        end
        else begin // state == DONE
            done <= HIGH;
            out0 <= butterfly_1_out0;
            out1 <= butterfly_1_out1;
            out2 <= butterfly_2_out0;
            out3 <= butterfly_2_out1;
            if(start == 0 || reset == 1) 
				begin
					state <= RESET;
					done <= LOW;
            end
        end
    end
endmodule