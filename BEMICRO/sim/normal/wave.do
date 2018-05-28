onerror {resume}
quietly virtual function -install /BeMicro_soc_tb/dut/sound/soundCore -env /BeMicro_soc_tb/dut/sound/soundCore { &{/BeMicro_soc_tb/dut/sound/soundCore/clk, /BeMicro_soc_tb/dut/sound/soundCore/reset, /BeMicro_soc_tb/dut/sound/soundCore/bufferDataIn, /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycleIn, /BeMicro_soc_tb/dut/sound/soundCore/soundIreIn, /BeMicro_soc_tb/dut/sound/soundCore/bufferLoadEn, /BeMicro_soc_tb/dut/sound/soundCore/configLoadEn, /BeMicro_soc_tb/dut/sound/soundCore/wordCount, /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycle, /BeMicro_soc_tb/dut/sound/soundCore/soundIre, /BeMicro_soc_tb/dut/sound/soundCore/pwmOut, /BeMicro_soc_tb/dut/sound/soundCore/readReq, /BeMicro_soc_tb/dut/sound/soundCore/bufferDataOut }} soundCore
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/clk
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/reset
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/waitRequest
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/readValid
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptRequest
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptIn
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dataIn
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/debugOut
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptAcknowledge
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptOut
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/read
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/write
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/bwe
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dataOut
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/address
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/transactionControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/addressControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dataControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/programCounterControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/systemControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/regfileAControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/regfileBControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/resultControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/resultFlagsControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/executeControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/loadControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/exceptionControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/exceptionTriggerControl
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/nextPC
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/registerFileA
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/registerFileB
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/aRegister
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/bRegister
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dataSelectBits
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/calculatedAddress
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/instructionReg
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dataInReg
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/isrBaseAddress
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/resultFlags
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/cause
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptEnable
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/exceptionMask
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/systemRegister
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/flags
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/resultLow
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/resultHigh
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/multiplierResultHigh
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/multiplierResultLow
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dividerQuotient
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dividerRemainder
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dividerError
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/aluResult
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/shifterResult
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/aluCarry
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/shifterCarry
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/aluOverflow
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/aluDone
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/overflowException
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/shifterDone
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/multiplierDone
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/dividerDone
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/triggerException
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/exceptionPending
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/interruptPending
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/fetchCycle
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/machineCycleDone
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/regfileState
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/systemCallState
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/opcode
add wave -noupdate -expand -group CPU /BeMicro_soc_tb/dut/cpu32e2/condition
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/clk
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/reset
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ioOut
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/rx
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/tx
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacMiso
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacMosi
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSclk
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSs
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardMiso
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardMosi
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSclk
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSs
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/scl
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sda
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/pwmOut
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramBa
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramCas
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramCke
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramClk
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramCs
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramDq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramDqm
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramRas
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/externalSdramWe
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/horizontalSync
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/verticalSync
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/red
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/green
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/blue
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/pllLocked
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/clk100
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/clk10
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/clk25
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/reset100
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/reset25
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/waitRequest
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/readValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/interruptRequest
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/interruptIn
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dataIn
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/interruptAcknowledge
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/interruptOut
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/read
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/write
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/bwe
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dataOut
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/address
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ramRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ramWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ramAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ramValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ramData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/randomRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/randomWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/randomValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/randomData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/uartRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/uartWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/uartAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/uartValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/uartData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramWaitRequest
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdramData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sequencerRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sequencerWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sequencerAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sequencerValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sequencerData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sampleRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sampleWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sampleAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sampleValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sampleData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ioRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ioWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ioValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/ioData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/i2cRead
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/i2cWrite
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/i2cAddress
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/i2cValid
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/i2cData
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/triggerInterrupt
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/rxIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/txIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/timerIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiReceiveIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/dacSpiTransmitIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/soundIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiReceiveIrq
add wave -noupdate -group SOC /BeMicro_soc_tb/dut/sdCardSpiTransmitIrq
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {26538302 ps} 0} {{Cursor 2} {0 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 378
configure wave -valuecolwidth 206
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
WaveRestoreZoom {0 ps} {239133300 ps}
