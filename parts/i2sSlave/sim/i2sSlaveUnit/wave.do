onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /i2sSlaveUnit_tb/dut/clk
add wave -noupdate /i2sSlaveUnit_tb/dut/reset
add wave -noupdate /i2sSlaveUnit_tb/dut/sampleSize
add wave -noupdate /i2sSlaveUnit_tb/dut/stereoMode
add wave -noupdate /i2sSlaveUnit_tb/dut/playback
add wave -noupdate /i2sSlaveUnit_tb/dut/sampleData
add wave -noupdate /i2sSlaveUnit_tb/dut/readReq
add wave -noupdate /i2sSlaveUnit_tb/dut/sdin
add wave -noupdate /i2sSlaveUnit_tb/dut/state
add wave -noupdate /i2sSlaveUnit_tb/dut/nextState
add wave -noupdate /i2sSlaveUnit_tb/dut/sample
add wave -noupdate /i2sSlaveUnit_tb/dut/sampleNext
add wave -noupdate /i2sSlaveUnit_tb/dut/sampleCounter
add wave -noupdate /i2sSlaveUnit_tb/dut/sampleCounterNext
add wave -noupdate /i2sSlaveUnit_tb/dut/bitCounter
add wave -noupdate /i2sSlaveUnit_tb/dut/bitCounterNext
add wave -noupdate /i2sSlaveUnit_tb/dut/wclk
add wave -noupdate /i2sSlaveUnit_tb/dut/wclkReg
add wave -noupdate /i2sSlaveUnit_tb/dut/wclkPrevReg
add wave -noupdate /i2sSlaveUnit_tb/dut/wclkRose
add wave -noupdate /i2sSlaveUnit_tb/dut/wclkFell
add wave -noupdate /i2sSlaveUnit_tb/dut/syncBclk
add wave -noupdate /i2sSlaveUnit_tb/dut/sdout
add wave -noupdate /i2sSlaveUnit_tb/dut/bclk
add wave -noupdate /i2sSlaveUnit_tb/dut/bclkReg
add wave -noupdate /i2sSlaveUnit_tb/dut/bclkPrevReg
add wave -noupdate /i2sSlaveUnit_tb/dut/bclkRose
add wave -noupdate /i2sSlaveUnit_tb/dut/bclkFell
add wave -noupdate /i2sSlaveUnit_tb/dut/sdoutNext
add wave -noupdate /i2sSlaveUnit_tb/dut/readReqReg
add wave -noupdate /i2sSlaveUnit_tb/dut/readReqRegNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1122801500 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 235
configure wave -valuecolwidth 201
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
WaveRestoreZoom {0 ps} {29858201600 ps}
