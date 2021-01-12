
module processor(
output wire [7:0] PC,
output wire [7:0] ACC,

input wire [7:0] INST,
input wire clk,
input wire CLB

);


wire wLoadIR;
wire wIncPC;
wire wSelPC;
wire wLoadPC;
wire wLoadReg;
wire wLoadAcc;
wire [1:0] wSelAcc;
wire [3:0] wSelALU;
wire [7:0] wI;
wire [7:0] wReg;
wire wZ;
wire wC;
wire [7:0] wALU_out;

controller1 controller0(
	.LoadIR (wLoadIR),
	.IncPC (wIncPC),
	.SelPC (wSelPC),
	.LoadPC (wLoadPC),
	.LoadReg (wLoadReg),
	.LoadAcc (wLoadAcc),
	.SelAcc (wSelAcc),
	.SelALU (wSelALU),
	.Z (wZ),
	.C (wC),
	.Opcode (wI[7:4]),
	.clk (clk),
	.CLB (CLB)
);

IR IR0(
	.I (wI),
	.clk (clk),
	.CLB (CLB),
	.LoadIR (wLoadIR),
	.Instruction (INST)
);

program_counter program_counter0(
	.address (PC),
	.regIn (wReg),
	.imm (wI[3:0]), 
	.CLB (CLB),
	.clk (clk),
	.IncPC (wIncPC),
	.LoadPC (wLoadPC),
	.selPC (wSelPC)
);

accumalator ACC0(
	.acc_out(ACC),
	.ALU(wALU_out),
	.reg_file(wReg),
	.imm(wI[3:0]),
	.SelAcc(wSelAcc),
	.loadAcc(wLoadAcc),
	.clk(clk),
	.CLB(CLB)
);

ALU ALU0(
	.a(ACC),
	.b(wReg),
	.ALU_sel(wSelALU[3:2]),
	.load_shift(wSelALU[1:0]),
	.result(wALU_out),
	.cout(wC),
	.zout(wZ)

);

reg_file reg_file0(
	.reg_out (wReg),
	.reg_in (ACC),
	.RegAddr (wI[3:0]),
	.clk (clk),
	.CLB (CLB),
	.LoadReg (wLoadReg)
);

endmodule
