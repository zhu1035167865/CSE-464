// 8-bit microprocessor testbench
`timescale 1ns/1ps
module testbench
();

reg [23:0] memory[23:0];
reg clk;
reg [4:0] address;
reg CLB;
wire [7:0] PC;
wire [7:0] ACC;
wire [7:0] INST;
wire [15:0] expected;
reg counter; 

assign INST = memory[address][23:16];
assign expected = memory[address][15:0];
//assign ACCEx = memory[address][7:0];

initial
begin
	$readmemh("testbench.txt",memory);
	clk = 0;
	CLB = 0;
	counter = 0;
	address = 0;
	#10 CLB = 1;
	#500 $stop;
end

always begin
	#5 clk = ~clk;
end

always @(posedge clk) begin
	if (CLB) begin
		if (counter == 1) begin
			address <= address + 1;
			if(expected !== {PC, ACC} || expected === 16'bx) begin
				$error("INST = %h, expected = %h, recieved = %h\n", INST, expected, {PC, ACC});
			end
			else begin
				$display($time, " correct results INST = %h, result = %h", INST, {PC, ACC});
			end
		end
		counter <= ~counter;
	end
end

processor dut(
	// Outputs
	.PC (PC),
	.ACC (ACC),
	// Inputs
	.INST (INST),
	.clk (clk),
	.CLB (CLB)
);

endmodule
