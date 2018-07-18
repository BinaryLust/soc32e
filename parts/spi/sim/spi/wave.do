onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spiUnit_tb/dut/clk
add wave -noupdate /spiUnit_tb/dut/reset
add wave -noupdate /spiUnit_tb/dut/clockPolarity
add wave -noupdate /spiUnit_tb/dut/clockPhase
add wave -noupdate /spiUnit_tb/dut/dataDirection
add wave -noupdate /spiUnit_tb/dut/finalCycle
add wave -noupdate /spiUnit_tb/dut/dataRegIn
add wave -noupdate /spiUnit_tb/dut/dataReg
add wave -noupdate /spiUnit_tb/dut/transmitReady
add wave -noupdate /spiUnit_tb/dut/coreWrite
add wave -noupdate /spiUnit_tb/dut/coreRead
add wave -noupdate /spiUnit_tb/dut/idle
add wave -noupdate /spiUnit_tb/dut/miso
add wave -noupdate /spiUnit_tb/dut/mosi
add wave -noupdate /spiUnit_tb/dut/sclk
add wave -noupdate /spiUnit_tb/dut/state
add wave -noupdate /spiUnit_tb/dut/nextState
add wave -noupdate /spiUnit_tb/dut/bitCounter
add wave -noupdate /spiUnit_tb/dut/bitCounterValue
add wave -noupdate /spiUnit_tb/dut/dataRegNext
add wave -noupdate /spiUnit_tb/dut/finalBit
add wave -noupdate /spiUnit_tb/dut/mosiNext
add wave -noupdate /spiUnit_tb/dut/sclkNext
add wave -noupdate /spiUnit_tb/dut/coreReadNext
add wave -noupdate /spiUnit_tb/dut/coreWriteNext
add wave -noupdate /spiUnit_tb/dut/idleNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {161819300 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 207
configure wave -valuecolwidth 67
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
WaveRestoreZoom {157275 ns} {184575 ns}
