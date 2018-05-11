onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2c /i2c_tb/dut/clk
add wave -noupdate -expand -group i2c /i2c_tb/dut/reset
add wave -noupdate -expand -group i2c /i2c_tb/dut/read
add wave -noupdate -expand -group i2c /i2c_tb/dut/write
add wave -noupdate -expand -group i2c /i2c_tb/dut/address
add wave -noupdate -expand -group i2c /i2c_tb/dut/dataIn
add wave -noupdate -expand -group i2c /i2c_tb/dut/readValid
add wave -noupdate -expand -group i2c /i2c_tb/dut/dataOut
add wave -noupdate -expand -group i2c /i2c_tb/dut/scl
add wave -noupdate -expand -group i2c /i2c_tb/dut/sda
add wave -noupdate -expand -group i2c /i2c_tb/dut/dataInReg
add wave -noupdate -expand -group i2c /i2c_tb/dut/readReg
add wave -noupdate -expand -group i2c /i2c_tb/dut/writeReg
add wave -noupdate -expand -group i2c /i2c_tb/dut/addressReg
add wave -noupdate -expand -group i2c /i2c_tb/dut/readMux
add wave -noupdate -expand -group i2c /i2c_tb/dut/transmitDataLoadEn
add wave -noupdate -expand -group i2c /i2c_tb/dut/transmitData
add wave -noupdate -expand -group i2c /i2c_tb/dut/receiveData
add wave -noupdate -expand -group i2c /i2c_tb/dut/receiveAck
add wave -noupdate -expand -group i2c /i2c_tb/dut/receiveValid
add wave -noupdate -expand -group i2c /i2c_tb/dut/transmitReady
add wave -noupdate -expand -group i2c /i2c_tb/dut/receiveDataReadReq
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/clk
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/reset
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/commandIn
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitDataIn
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitAckIn
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitDataLoadEn
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveDataReadReq
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveData
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveAck
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveValid
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitReady
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/scl
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/sda
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/cycleDone
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitReadyWire
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveValidWire
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveDataWire
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/receiveAckWire
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/command
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitData
add wave -noupdate -expand -group i2cCore /i2c_tb/dut/i2cCore/transmitAck
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/A0
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/A1
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/A2
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/WP
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SDA
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SCL
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/RESET
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SDA_DO
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SDA_OE
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SDA_DriveEnable
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/SDA_DriveEnableDlyd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/BitCounter
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/START_Rcvd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/STOP_Rcvd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/CTRL_Rcvd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/ADDR_Rcvd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MACK_Rcvd
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/WrCycle
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/RdCycle
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/ShiftRegister
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/ControlByte
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/RdWrBit
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/StartAddress
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/PageAddress
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/WrDataByte
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/RdDataByte
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/WrCounter
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/RdPointer
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/WriteActive
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryBlock
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/tAA
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/tWC
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte00
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte01
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte02
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte03
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte04
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte05
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte06
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte07
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte08
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte09
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0A
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0B
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0C
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0D
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0E
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/MemoryByte0F
add wave -noupdate -expand -group EEPROM /i2c_tb/eeprom/TimingCheckEnable
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {6560000 ps} 0}
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
WaveRestoreZoom {962354650 ps} {1002107650 ps}
