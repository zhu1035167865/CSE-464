
module acc(

output wire[7:0] acc_out, 

input wire[7:0] ALU,
input wire[7:0] reg_file,
input wire[3:0] imm,
input wire [1:0] SelAcc,
input wire loadAcc,
input wire clk,
input wire CLB

);

reg [7:0] r_acc_out;
assign acc_out = r_acc_out;

always @ (posedge clk or CLB) begin

   if(loadAcc == 1) begin
	case(SelAcc)
		2'b00: r_acc_out <= ALU;
		2'b01: r_acc_out <= reg_file;
		2'b10: r_acc_out <= {4'b0,imm};
	endcase
   end

end 
endmodule
