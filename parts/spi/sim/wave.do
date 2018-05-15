onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spiUnit_tb/dut/clk
add wave -noupdate /spiUnit_tb/dut/reset
add wave -noupdate /spiUnit_tb/dut/clocksPerCycle
add wave -noupdate /spiUnit_tb/dut/clockPolarity
add wave -noupdate /spiUnit_tb/dut/clockPhase
add wave -noupdate /spiUnit_tb/dut/dataDirection
add wave -noupdate /spiUnit_tb/dut/transmitValid
add wave -noupdate -radix hexadecimal /spiUnit_tb/dut/dataRegIn
add wave -noupdate -radix hexadecimal /spiUnit_tb/dut/dataReg
add wave -noupdate /spiUnit_tb/dut/transmitReady
add wave -noupdate /spiUnit_tb/dut/receiveValid
add wave -noupdate /spiUnit_tb/dut/miso
add wave -noupdate /spiUnit_tb/dut/mosi
add wave -noupdate /spiUnit_tb/dut/sclk
add wave -noupdate /spiUnit_tb/dut/ss
add wave -noupdate /spiUnit_tb/dut/state
add wave -noupdate /spiUnit_tb/dut/nextState
add wave -noupdate -radix unsigned /spiUnit_tb/dut/cycleCounter
add wave -noupdate -radix unsigned /spiUnit_tb/dut/cycleCounterValue
add wave -noupdate -radix unsigned /spiUnit_tb/dut/bitCounter
add wave -noupdate -radix unsigned /spiUnit_tb/dut/bitCounterValue
add wave -noupdate /spiUnit_tb/dut/dataRegNext
add wave -noupdate /spiUnit_tb/dut/cycleDone
add wave -noupdate /spiUnit_tb/dut/bitsDone
add wave -noupdate /spiUnit_tb/dut/mosiReg
add wave -noupdate /spiUnit_tb/dut/misoReg
add wave -noupdate /spiUnit_tb/dut/mosiNext
add wave -noupdate /spiUnit_tb/dut/misoNext
add wave -noupdate /spiUnit_tb/dut/sclkNext
add wave -noupdate /spiUnit_tb/dut/ssNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {17590600 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
configure wave -valuecolwidth 150
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
WaveRestoreZoom {16314 ns} {18926 ns}
