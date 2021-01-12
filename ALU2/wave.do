onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /test_ALU/dut/a
add wave -noupdate /test_ALU/dut/b
add wave -noupdate /test_ALU/dut/ALU_sel
add wave -noupdate /test_ALU/dut/load_shift
add wave -noupdate /test_ALU/dut/result
add wave -noupdate /test_ALU/dut/cout
add wave -noupdate /test_ALU/dut/zout
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {133 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
configure wave -timelineunits ps
update
WaveRestoreZoom {150737 ps} {150842 ps}
