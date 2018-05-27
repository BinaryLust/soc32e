onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu32e2_tb/instructionStr
add wave -noupdate -childformat {{/cpu32e2_tb/model.regfile -radix hexadecimal} {/cpu32e2_tb/model.nextPC -radix hexadecimal} {/cpu32e2_tb/model.cause -radix unsigned} {/cpu32e2_tb/model.systemCall -radix unsigned} {/cpu32e2_tb/model.isrBaseAddress -radix hexadecimal} {/cpu32e2_tb/model.memory -radix hexadecimal} {/cpu32e2_tb/model.operandA -radix hexadecimal} {/cpu32e2_tb/model.operandB -radix hexadecimal} {/cpu32e2_tb/model.resultLow -radix hexadecimal} {/cpu32e2_tb/model.resultHigh -radix hexadecimal} {/cpu32e2_tb/model.memoryData -radix hexadecimal} {/cpu32e2_tb/model.address -radix hexadecimal} {/cpu32e2_tb/model.commitType -radix unsigned} {/cpu32e2_tb/model.opcode -radix unsigned} {/cpu32e2_tb/model.rcode -radix unsigned} {/cpu32e2_tb/model.drl -radix unsigned} {/cpu32e2_tb/model.drh -radix unsigned} {/cpu32e2_tb/model.sra -radix unsigned} {/cpu32e2_tb/model.srb -radix unsigned} {/cpu32e2_tb/model.imm16a -radix hexadecimal} {/cpu32e2_tb/model.imm16b -radix hexadecimal} {/cpu32e2_tb/model.imm16c -radix hexadecimal} {/cpu32e2_tb/model.imm21a -radix hexadecimal} {/cpu32e2_tb/model.imm21b -radix hexadecimal} {/cpu32e2_tb/model.imm21c -radix hexadecimal} {/cpu32e2_tb/model.imm5 -radix hexadecimal} {/cpu32e2_tb/model.imm19 -radix hexadecimal} {/cpu32e2_tb/model.imm24 -radix hexadecimal}} -expand -subitemconfig {/cpu32e2_tb/model.regfile {-radix hexadecimal} /cpu32e2_tb/model.nextPC {-radix hexadecimal} /cpu32e2_tb/model.cause {-radix unsigned} /cpu32e2_tb/model.systemCall {-radix unsigned} /cpu32e2_tb/model.isrBaseAddress {-radix hexadecimal} /cpu32e2_tb/model.memory {-radix hexadecimal} /cpu32e2_tb/model.operandA {-radix hexadecimal} /cpu32e2_tb/model.operandB {-radix hexadecimal} /cpu32e2_tb/model.resultLow {-radix hexadecimal} /cpu32e2_tb/model.resultHigh {-radix hexadecimal} /cpu32e2_tb/model.memoryData {-radix hexadecimal} /cpu32e2_tb/model.address {-radix hexadecimal} /cpu32e2_tb/model.commitType {-radix unsigned} /cpu32e2_tb/model.opcode {-radix unsigned} /cpu32e2_tb/model.rcode {-radix unsigned} /cpu32e2_tb/model.drl {-radix unsigned} /cpu32e2_tb/model.drh {-radix unsigned} /cpu32e2_tb/model.sra {-radix unsigned} /cpu32e2_tb/model.srb {-radix unsigned} /cpu32e2_tb/model.imm16a {-radix hexadecimal} /cpu32e2_tb/model.imm16b {-radix hexadecimal} /cpu32e2_tb/model.imm16c {-radix hexadecimal} /cpu32e2_tb/model.imm21a {-radix hexadecimal} /cpu32e2_tb/model.imm21b {-radix hexadecimal} /cpu32e2_tb/model.imm21c {-radix hexadecimal} /cpu32e2_tb/model.imm5 {-radix hexadecimal} /cpu32e2_tb/model.imm19 {-radix hexadecimal} /cpu32e2_tb/model.imm24 {-radix hexadecimal}} /cpu32e2_tb/model
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/clk
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/reset
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/waitRequest
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/readValid
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptRequest
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/interruptIn
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/dataIn
add wave -noupdate -expand -group CPU -childformat {{/cpu32e2_tb/dut/debugOut.regfileState -radix hexadecimal} {/cpu32e2_tb/dut/debugOut.nextPCState -radix hexadecimal} {/cpu32e2_tb/dut/debugOut.flagsState -radix hexadecimal} {/cpu32e2_tb/dut/debugOut.systemCallState -radix unsigned} {/cpu32e2_tb/dut/debugOut.isrBaseAddressState -radix hexadecimal} {/cpu32e2_tb/dut/debugOut.exceptionMaskState -radix hexadecimal} {/cpu32e2_tb/dut/debugOut.causeState -radix unsigned}} -subitemconfig {/cpu32e2_tb/dut/debugOut.regfileState {-radix hexadecimal} /cpu32e2_tb/dut/debugOut.nextPCState {-radix hexadecimal} /cpu32e2_tb/dut/debugOut.flagsState {-radix hexadecimal} /cpu32e2_tb/dut/debugOut.systemCallState {-radix unsigned} /cpu32e2_tb/dut/debugOut.isrBaseAddressState {-radix hexadecimal} /cpu32e2_tb/dut/debugOut.exceptionMaskState {-radix hexadecimal} /cpu32e2_tb/dut/debugOut.causeState {-radix unsigned}} /cpu32e2_tb/dut/debugOut
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptAcknowledge
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/interruptOut
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/read
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/write
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/bwe
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/dataOut
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/address
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
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/nextPC
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/registerFileA
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/registerFileB
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/aRegister
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/bRegister
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dataSelectBits
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/calculatedAddress
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/instructionReg
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/dataInReg
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/isrBaseAddress
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/resultFlags
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/cause
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/interruptEnable
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/exceptionMask
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/systemRegister
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/flags
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/resultLow
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/resultHigh
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/multiplierResultHigh
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/multiplierResultLow
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/dividerQuotient
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/dividerRemainder
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/dividerError
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/aluResult
add wave -noupdate -expand -group CPU -radix hexadecimal /cpu32e2_tb/dut/shifterResult
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
add wave -noupdate -expand -group CPU -radix hexadecimal -childformat {{{/cpu32e2_tb/dut/regfileState[31]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[30]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[29]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[28]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[27]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[26]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[25]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[24]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[23]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[22]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[21]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[20]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[19]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[18]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[17]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[16]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[15]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[14]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[13]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[12]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[11]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[10]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[9]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[8]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[7]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[6]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[5]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[4]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[3]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[2]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[1]} -radix hexadecimal} {{/cpu32e2_tb/dut/regfileState[0]} -radix hexadecimal}} -expand -subitemconfig {{/cpu32e2_tb/dut/regfileState[31]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[30]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[29]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[28]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[27]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[26]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[25]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[24]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[23]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[22]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[21]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[20]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[19]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[18]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[17]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[16]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[15]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[14]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[13]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[12]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[11]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[10]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[9]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[8]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[7]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[6]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[5]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[4]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[3]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[2]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[1]} {-radix hexadecimal} {/cpu32e2_tb/dut/regfileState[0]} {-radix hexadecimal}} /cpu32e2_tb/dut/regfileState
add wave -noupdate -expand -group CPU -radix unsigned /cpu32e2_tb/dut/systemCallState
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/opcode
add wave -noupdate -expand -group CPU /cpu32e2_tb/dut/condition
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/clk
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/reset
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/we
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/address
add wave -noupdate -expand -group RAM /cpu32e2_tb/testRam/bwe
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/d
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/q
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/ramState
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/ram
add wave -noupdate -expand -group RAM -radix hexadecimal /cpu32e2_tb/testRam/qReg
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {18424605 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 273
configure wave -valuecolwidth 256
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
WaveRestoreZoom {17799687 ps} {18988447 ps}
