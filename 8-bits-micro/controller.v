module controller(
input wire Z, C, CLK, CLB,
input wire [3:0]Opcode,
output reg LoadIR, IncPC, SelPC, LoadPC, LoadReg, LoadAcc,
output reg [1:0] SelAcc,
output reg [3:0] SelALU
);

reg rLoadIR;
reg rIncPC;
reg rSelPC;
reg rLoadPC;
reg rLoadReg;
reg rLoadAcc;
reg [1:0] rSelAcc;
reg [3:0] rSelALU;
reg [1:0] state;

assign LoadIR = rLoadIR;
assign IncPC = rIncPC;
assign SelPC = rSelPC;
assign LoadPC = rLoadPC;
assign LoadReg = rLoadReg;
assign LoadAcc = rLoadAcc;
assign SelAcc = rSelAcc;
assign SelALU = rSelALU;

always @(posedge clk or CLB) begin 
	if(CLB == 1'b0)
	     state <= 2'b00;
	else begin
	    case(state) 
		2'b00: begin 
			state <= 2'b01;
			rLoadIR <= 2'b1;
		end
		2'b01: begin 
			state <= 2'b10;
			rLoadIR <= 1'b0;
		end
		2'b10: begin 
			state <= 2'b01;
			rLoadIR <=1'b1;
		end
	    endcase	
	end

end

always @(*) begin
    case (state) 
	2'b00: begin
		 rSelALU <= 4'b0000;
		 rSelAcc <= 2'b00;
		 rLoadAcc <= 1'b0;
		 rLoadReg <= 1'b0;
		 rLoadPC <= 1'b0;
		 rSelPC <= 1'b0;
		 rIncPC <= 1'b0;
		 rLoadIR <= 1'b0;
	end
	2'b01: begin
	    case(Opcode)
		4'b0000: begin//DO NOTHING
		end
		4'b0001: begin rSelALU <= 4'b1000; //ADD 
			 rSelAcc <= 2'b00;
			 rLoadAcc <= 1'b1;
			 rLoadReg <= 1'b0;
			 rLoadPC <= 1'b0;
			 rSelPC <= 1'b0;
			 rIncPC <= 1'b1;

		end
		4'b0010: begin rSelALU <= 4'b1100; //SUB 
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end
		4'b0011: begin rSelALU <= 4'b0100; //NOR 
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end
		4'b0100: begin rSelALU <= 4'b0000; // Move rs 
		 	rSelAcc <= 2'b01;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end
		4'b0101: begin rSelALU <= 4'b0000;// Move rd
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b1;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end
		4'b0110: begin if(Z == 1'b1) begin // Jump if zero to reg value
		 	rSelALU <= 4'b0000;
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b1;
		 	rSelPC <= 1'b1;
		 	rIncPC <= 1'b0;

		        end   
		end
		4'b0111: begin if(Z == 1'b1) begin // Jump if zero to immediate
		 	rSelALU <= 4'b0000;
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b1;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b0;

		       end
		end
		4'b1000: begin if(C == 1'b1) begin // Jump if Carry to reg value
		 	rSelALU <= 4'b0000;
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b1;
		 	rSelPC <= 1'b1;
		 	rIncPC <= 1'b0;

		       end
		end
		4'b1001: begin // NO CONTENT
		end
		4'b1010: begin if(C == 1'b1) begin // Jump if carry to immediate
		 	rSelALU <= 4'b0000;
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b1;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b0;

		       end
		end
		4'b1011: begin rSelALU <= 4'b0001; // Shift left
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end
		4'b1100: begin rSelALU <= 4'b0011; // Shift right
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;

		end 
		4'b1101: begin rSelALU <= 4'b0000; // Load immediate to accumulator
		 	rSelAcc <= 2'b10;
		 	rLoadAcc <= 1'b1;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b1;
	
		end
		4'b1110: begin
		end
		4'b1111: begin rSelALU <= 4'b0000; // HALT
		 	rSelAcc <= 2'b00;
		 	rLoadAcc <= 1'b0;
		 	rLoadReg <= 1'b0;
		 	rLoadPC <= 1'b0;
		 	rSelPC <= 1'b0;
		 	rIncPC <= 1'b0;

		end
        	endcase

	end
	2'b10: begin

	   rLoadReg <= 1'b0;
	   rLoadAcc <= 1'b0;
	   rLoadPC <= 1'b0;
	   rIncPC <= 1'b0;
	   rSelALU <= 4'b0010;
	end
    endcase
end

endmodule


