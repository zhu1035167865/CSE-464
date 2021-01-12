
module Controller_FSM(
output wire LoadIR,
output wire IncPC,
output wire SelPC,
output wire LoadPC,
output wire LoadReg,
output wire LoadAcc,
output wire [1:0] SelAcc,
output wire [3:0] SelALU, 

input wire Z,
input wire C,
input wire [3:0] Opcode,

input wire clk,
input wire CLB
);


reg rLoadIR;
reg rIncPC;
reg rSelPC;
reg rLoadPC;
reg rLoadReg;
reg rLoadAcc;
reg [1:0] rSelAcc;
reg [3:0] rSelALU;

assign LoadIR = rLoadIR;
assign IncPC = rIncPC;
assign SelPC = rSelPC;
assign LoadPC = rLoadPC;
assign LoadReg = rLoadReg;
assign LoadAcc = rLoadAcc;
assign SelAcc = rSelAcc;
assign SelALU = rSelALU;


always @(posedge clk or CLB) 
begin
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

	4'b1110: begin// NO CONTENT
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
endmodule


