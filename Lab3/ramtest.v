`timescale 1ns/1ps

module ramtop();


reg clk, we, oe, cs;
parameter DATA_WIDTH = 8 ;
parameter ADDR_WIDTH = 4 ;
parameter RAM_DEPTH = 1 << ADDR_WIDTH;

reg [ADDR_WIDTH-1:0] address;
reg [DATA_WIDTH-1:0] data_in;
wire [DATA_WIDTH-1:0] data;


initial begin
we = 1;
oe = 1;
cs = 1;
clk = 0;
data_in = 0;
address = 0;
#105 we = 0;
#200 oe = 0;
end


always begin
#5 clk <= ~clk;
end

ram_sp_sr_sw ram1(
.clk(clk), 
.address(address), 
.data(data),
.cs(cs), 
.we(we), 
.oe(oe)       
);


always @(posedge clk) 
begin
	data_in <= data_in + 1;
	address <= address + 1;
end

assign data = (we) ? data_in : 8'bz;

endmodule
