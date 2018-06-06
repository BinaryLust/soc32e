onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/clk
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/reset
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/read
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/write
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/address
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/dataIn
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/readValid
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/dataOut
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/mdc
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/mdio
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/dataInReg
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/readReg
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/writeReg
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/addressReg
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/readMux
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/transmitDataLoadEn
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/receiveData
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/receiveAck
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/receiveValid
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/transmitReady
add wave -noupdate -expand -group TOP /ethernetSmi_tb/dut/receiveDataReadReq
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/clk
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/reset
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/transmitDataIn
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/transmitDataLoadEn
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/receiveDataReadReq
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/receiveData
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/receiveValid
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/transmitReady
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/mdc
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/mdio
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/finalCycle
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/transmitReadyWire
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/receiveValidWire
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/receiveDataWire
add wave -noupdate -expand -group CORE /ethernetSmi_tb/dut/ethernetSmiCore/transmitData
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/clk
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/reset
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/transmitData
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/receiveData
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/finalCycle
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/transmitValid
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/transmitReady
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/receiveValid
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/busy
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdc
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdio
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/state
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/nextState
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/bitCounter
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/bitCounterNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/upperDataReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/upperDataRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/lowerDataReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/lowerDataRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/opcodeReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/opcodeRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/transmitReadyReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/transmitReadyRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/receiveValidReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/receiveValidRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdcNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdioIn
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdioOutReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdioOutRegNext
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdioOutEnReg
add wave -noupdate -expand -group UNIT /ethernetSmi_tb/dut/ethernetSmiCore/ethernetSmiUnit/mdioOutEnRegNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {49689960000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 450
configure wave -valuecolwidth 210
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
WaveRestoreZoom {0 ps} {64155567 ns}
