onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/clk
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/reset
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/we
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/address
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/bwe
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/d
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/q
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/qReg
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/ramState
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/ram
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/clk
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/reset
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/waitRequest
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/readValid
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptRequest
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptIn
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataIn
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/debugOut
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptAcknowledge
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptOut
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/read
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/write
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/bwe
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataOut
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/address
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/transactionControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/addressControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/programCounterControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/systemControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/regfileAControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/regfileBControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultFlagsControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/executeControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/loadControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/exceptionControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/exceptionTriggerControl
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/nextPC
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/registerFileA
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/registerFileB
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/aRegister
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/bRegister
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataSelectBits
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/calculatedAddress
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/instructionReg
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataInReg
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/isrBaseAddress
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultFlags
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/cause
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptEnable
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/exceptionMask
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/systemRegister
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/flags
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultLow
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultHigh
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/multiplierResultHigh
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/multiplierResultLow
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dividerQuotient
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dividerRemainder
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dividerError
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/aluResult
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/shifterResult
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/aluCarry
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/shifterCarry
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/aluOverflow
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/aluDone
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/overflowException
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/shifterDone
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/multiplierDone
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dividerDone
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/triggerException
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/exceptionPending
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptPending
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/fetchCycle
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/machineCycleDone
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/regfileState
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/systemCallState
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/opcode
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/condition
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 218
configure wave -valuecolwidth 229
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
WaveRestoreZoom {4456288 ps} {4459724 ps}
