onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i2cUnit_tb/dut/clk
add wave -noupdate /i2cUnit_tb/dut/reset
add wave -noupdate /i2cUnit_tb/dut/i2cCommand
add wave -noupdate /i2cUnit_tb/dut/i2cWriteData
add wave -noupdate /i2cUnit_tb/dut/i2cReadData
add wave -noupdate /i2cUnit_tb/dut/cycleDone
add wave -noupdate /i2cUnit_tb/dut/i2cTransactionValid
add wave -noupdate /i2cUnit_tb/dut/i2cBusy
add wave -noupdate /i2cUnit_tb/dut/i2cWriteAck
add wave -noupdate /i2cUnit_tb/dut/i2cReadDataValid
add wave -noupdate /i2cUnit_tb/dut/i2cScl
add wave -noupdate /i2cUnit_tb/dut/i2cSda
add wave -noupdate /i2cUnit_tb/dut/state
add wave -noupdate /i2cUnit_tb/dut/nextState
add wave -noupdate /i2cUnit_tb/dut/bitCounter
add wave -noupdate /i2cUnit_tb/dut/bitCounterNext
add wave -noupdate /i2cUnit_tb/dut/bitsDone
add wave -noupdate /i2cUnit_tb/dut/dataReg
add wave -noupdate /i2cUnit_tb/dut/dataRegNext
add wave -noupdate /i2cUnit_tb/dut/sclOutNext
add wave -noupdate /i2cUnit_tb/dut/sclOut
add wave -noupdate /i2cUnit_tb/dut/sclIn
add wave -noupdate /i2cUnit_tb/dut/sdaOutNext
add wave -noupdate /i2cUnit_tb/dut/sdaOut
add wave -noupdate /i2cUnit_tb/dut/sdaIn
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1302000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
configure wave -valuecolwidth 82
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
WaveRestoreZoom {0 ps} {4772 ns}
