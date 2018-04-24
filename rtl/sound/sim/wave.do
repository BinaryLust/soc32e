onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /pwmUnit_tb/dut/clk
add wave -noupdate /pwmUnit_tb/dut/reset
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/clocksPerCycle
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/dataIn
add wave -noupdate /pwmUnit_tb/dut/pwmOut
add wave -noupdate /pwmUnit_tb/dut/readReq
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/pwmCount
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/pwmCountNext
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/pwmLimit
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/pwmLimitNext
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/cycleCounter
add wave -noupdate -radix unsigned /pwmUnit_tb/dut/cycleCounterValue
add wave -noupdate /pwmUnit_tb/dut/pwmOutNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {117800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {0 ps} {1001 ns}
