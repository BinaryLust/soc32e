onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /ethernetSmiUnit_tb/dut/clk
add wave -noupdate /ethernetSmiUnit_tb/dut/reset
add wave -noupdate -radix hexadecimal /ethernetSmiUnit_tb/dut/transmitData
add wave -noupdate -radix hexadecimal /ethernetSmiUnit_tb/dut/receiveData
add wave -noupdate /ethernetSmiUnit_tb/dut/finalCycle
add wave -noupdate /ethernetSmiUnit_tb/dut/transmitValid
add wave -noupdate /ethernetSmiUnit_tb/dut/transmitReady
add wave -noupdate /ethernetSmiUnit_tb/dut/receiveValid
add wave -noupdate /ethernetSmiUnit_tb/dut/busy
add wave -noupdate /ethernetSmiUnit_tb/dut/mdc
add wave -noupdate /ethernetSmiUnit_tb/dut/mdio
add wave -noupdate /ethernetSmiUnit_tb/dut/state
add wave -noupdate /ethernetSmiUnit_tb/dut/nextState
add wave -noupdate -radix unsigned /ethernetSmiUnit_tb/dut/bitCounter
add wave -noupdate -radix unsigned /ethernetSmiUnit_tb/dut/bitCounterNext
add wave -noupdate /ethernetSmiUnit_tb/dut/upperDataReg
add wave -noupdate /ethernetSmiUnit_tb/dut/upperDataRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/lowerDataReg
add wave -noupdate /ethernetSmiUnit_tb/dut/lowerDataRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/opcodeReg
add wave -noupdate /ethernetSmiUnit_tb/dut/opcodeRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/transmitReadyReg
add wave -noupdate /ethernetSmiUnit_tb/dut/transmitReadyRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/receiveValidReg
add wave -noupdate /ethernetSmiUnit_tb/dut/receiveValidRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/mdcNext
add wave -noupdate /ethernetSmiUnit_tb/dut/mdioIn
add wave -noupdate /ethernetSmiUnit_tb/dut/mdioOutReg
add wave -noupdate /ethernetSmiUnit_tb/dut/mdioOutRegNext
add wave -noupdate /ethernetSmiUnit_tb/dut/mdioOutEnReg
add wave -noupdate /ethernetSmiUnit_tb/dut/mdioOutEnRegNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {74684800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 285
configure wave -valuecolwidth 200
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
WaveRestoreZoom {8452200 ps} {140917400 ps}
