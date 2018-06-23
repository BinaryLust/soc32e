onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i2sMasterClockUnit_tb/dut/synthClk
add wave -noupdate /i2sMasterClockUnit_tb/dut/synthReset
add wave -noupdate /i2sMasterClockUnit_tb/loadEn
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/mclkDivider
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/bclkDivider
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/wclkDivider
add wave -noupdate /i2sMasterClockUnit_tb/dut/mclk
add wave -noupdate /i2sMasterClockUnit_tb/dut/bclk
add wave -noupdate /i2sMasterClockUnit_tb/dut/wclk
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/mclkCounter
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/mclkCounterNext
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/bclkCounter
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/bclkCounterNext
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/wclkCounter
add wave -noupdate -radix unsigned /i2sMasterClockUnit_tb/dut/wclkCounterNext
add wave -noupdate /i2sMasterClockUnit_tb/dut/mclkNext
add wave -noupdate /i2sMasterClockUnit_tb/dut/bclkNext
add wave -noupdate /i2sMasterClockUnit_tb/dut/wclkNext
add wave -noupdate /i2sMasterClockUnit_tb/dut/mclkFinal
add wave -noupdate /i2sMasterClockUnit_tb/dut/bclkFinal
add wave -noupdate /i2sMasterClockUnit_tb/dut/wclkFinal
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5888800 ps} 0} {{Cursor 2} {7318700 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
configure wave -valuecolwidth 40
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
WaveRestoreZoom {0 ps} {16512 ns}
