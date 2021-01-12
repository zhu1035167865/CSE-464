onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /testbench/dut/controller0/C
add wave -noupdate /testbench/dut/controller0/CLB
add wave -noupdate /testbench/dut/controller0/clk
add wave -noupdate /testbench/dut/controller0/IncPC
add wave -noupdate /testbench/dut/controller0/LoadAcc
add wave -noupdate /testbench/dut/controller0/LoadIR
add wave -noupdate /testbench/dut/controller0/LoadPC
add wave -noupdate /testbench/dut/controller0/LoadReg
add wave -noupdate /testbench/dut/controller0/Opcode
add wave -noupdate /testbench/dut/controller0/SelAcc
add wave -noupdate /testbench/dut/controller0/SelALU
add wave -noupdate /testbench/dut/controller0/SelPC
add wave -noupdate /testbench/dut/controller0/Z
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {29692 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {48095 ps}
