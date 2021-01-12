//-----------------------------------------------------
// This is my second Verilog Design
// Design Name : first_counter
// File Name : first_counter.v
// Function : This is a 4 bit up-counter with
// Synchronous active high reset and
// with active high enable signal
//-----------------------------------------------------
`timescale 1ns/1ps

module first_counter (
clock , // Clock input of the design
reset , // active high, synchronous Reset input
enable , // Active high enable signal for counter
count_up, // 4 bit vector output of the incrementer
count_down, // 4 bit vector output for the decrementer
z_flag
); // End of port list
//-------------Input Ports-----------------------------
input clock ;
input reset ;
input enable ;
//-------------Output Ports----------------------------
output [3:0] count_up ;
output [3:0] count_down;
output z_flag ;
//-------------Input ports Data Type-------------------
// By rule all the input ports should be wires   
wire clock ;
wire reset ;
wire enable ;
//-------------Output Ports Data Type------------------
// Output port can be a storage element (reg) or a wire
reg [3:0] count_up, count_down ;
wire z_flag;
reg z_reg;

//------------Code Starts Here-------------------------
// Since this counter is a positive edge trigged one,
// We trigger the below block with respect to positive
// edge of the clock.

always @ (posedge clock)
begin : COUNT_up // Block Name
  // At every rising edge of clock we check if reset is active
  // If active, we load the counter output with 4'b0000
  if (reset == 1'b1) begin
    count_up <= 4'b0000;
    z_reg <= 0;
  end
  // If enable is active, then we increment the counter
  else if (enable == 1'b1) begin
    count_up <= count_up + 1;
    z_reg <= (count_up == 4'b0000)?1:0;
  end 
end // End of Block COUNTER UPv

always @ (posedge clock)
begin : COUNT_DOWN// Block Name
  // At every rising edge of clock we check if reset is active
  // If active, we load the counter output with 4'b0000
  if (reset == 1'b1) begin
    count_down <= 4'b0000;
  end
  // If enable is active, then we decrement the counter
  else if (enable == 1'b1) begin
    count_down <= count_down - 1;
  end
end // End of Block COUNTER DOWN




assign z_flag = (count_up == 4'b0000)?1:0;

endmodule // End of Module counter