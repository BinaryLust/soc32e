onerror {resume}
quietly virtual function -install /BeMicro_soc_tb/dut/sound/soundCore -env /BeMicro_soc_tb/dut/sound/soundCore { &{/BeMicro_soc_tb/dut/sound/soundCore/clk, /BeMicro_soc_tb/dut/sound/soundCore/reset, /BeMicro_soc_tb/dut/sound/soundCore/bufferDataIn, /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycleIn, /BeMicro_soc_tb/dut/sound/soundCore/soundIreIn, /BeMicro_soc_tb/dut/sound/soundCore/bufferLoadEn, /BeMicro_soc_tb/dut/sound/soundCore/configLoadEn, /BeMicro_soc_tb/dut/sound/soundCore/wordCount, /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycle, /BeMicro_soc_tb/dut/sound/soundCore/soundIre, /BeMicro_soc_tb/dut/sound/soundCore/pwmOut, /BeMicro_soc_tb/dut/sound/soundCore/readReq, /BeMicro_soc_tb/dut/sound/soundCore/bufferDataOut }} soundCore
quietly WaveActivateNextPane {} 0
add wave -noupdate -group soc /BeMicro_soc_tb/dut/clk
add wave -noupdate -group soc /BeMicro_soc_tb/dut/reset
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioOut
add wave -noupdate -group soc /BeMicro_soc_tb/dut/rx
add wave -noupdate -group soc /BeMicro_soc_tb/dut/tx
add wave -noupdate -group soc /BeMicro_soc_tb/dut/miso
add wave -noupdate -group soc /BeMicro_soc_tb/dut/mosi
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sclk
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ss
add wave -noupdate -group soc /BeMicro_soc_tb/dut/pwmOut
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramBa
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramCas
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramCke
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramClk
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramCs
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramDq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramDqm
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramRas
add wave -noupdate -group soc /BeMicro_soc_tb/dut/externalSdramWe
add wave -noupdate -group soc /BeMicro_soc_tb/dut/pllLocked
add wave -noupdate -group soc /BeMicro_soc_tb/dut/clk100
add wave -noupdate -group soc /BeMicro_soc_tb/dut/clk10
add wave -noupdate -group soc /BeMicro_soc_tb/dut/reset100
add wave -noupdate -group soc /BeMicro_soc_tb/dut/waitRequest
add wave -noupdate -group soc /BeMicro_soc_tb/dut/readValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/interruptRequest
add wave -noupdate -group soc /BeMicro_soc_tb/dut/interruptIn
add wave -noupdate -group soc /BeMicro_soc_tb/dut/dataIn
add wave -noupdate -group soc /BeMicro_soc_tb/dut/interruptAcknowledge
add wave -noupdate -group soc /BeMicro_soc_tb/dut/interruptOut
add wave -noupdate -group soc /BeMicro_soc_tb/dut/read
add wave -noupdate -group soc /BeMicro_soc_tb/dut/write
add wave -noupdate -group soc /BeMicro_soc_tb/dut/bwe
add wave -noupdate -group soc /BeMicro_soc_tb/dut/dataOut
add wave -noupdate -group soc /BeMicro_soc_tb/dut/address
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ramData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/randomChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/randomRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/randomWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/randomValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/randomData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/uartData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramWaitRequest
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sdramData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sequencerData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/sampleData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/ioData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundChipEnable
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundRead
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundWrite
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundAddress
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundValid
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundData
add wave -noupdate -group soc /BeMicro_soc_tb/dut/triggerInterrupt
add wave -noupdate -group soc /BeMicro_soc_tb/dut/rxIrq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/txIrq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/timerIrq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiReceiveIrq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/spiTransmitIrq
add wave -noupdate -group soc /BeMicro_soc_tb/dut/soundIrq
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/clk
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/reset
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/chipEnable
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/read
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/write
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/bwe
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/address
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/dataIn
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/waitRequest
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/readValid
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/dataOut
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramAddress
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramBa
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramCas
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramCke
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramCs
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramDq
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramDqm
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramRas
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/externalSdramWe
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/wordCount
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/readCount
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/bweMux
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/dataInMux
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/readDataReg
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/sdramWaitRequest
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/sdramValid
add wave -noupdate -group sdram /BeMicro_soc_tb/dut/sdram/sdramData
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/clk
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/reset
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/read
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/write
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/address
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/dataIn
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/readValid
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/dataOut
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitIrq
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveIrq
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/miso
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/mosi
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/sclk
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/ss
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/dataInReg
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/readReg
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/writeReg
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/addressReg
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/readMux
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitDataLoadEn
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/configLoadEn
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitData
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveData
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveValid
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitReady
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/clocksPerCycle
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/clockPolarity
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/clockPhase
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/dataDirection
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveIre
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitIre
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveDataWire
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitReadyWire
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/transmitDataValid
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveDataValid
add wave -noupdate -group spi /BeMicro_soc_tb/dut/spi/receiveDataReadReq
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clk
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/reset
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitDataIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clocksPerCycleIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clockPolarityIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clockPhaseIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/dataDirectionIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveIreIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitIreIn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitDataLoadEn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/configLoadEn
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveDataReadReq
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitData
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveData
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveValid
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitReady
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clocksPerCycle
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clockPolarity
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/clockPhase
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/dataDirection
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveIre
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitIre
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitIrq
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveIrq
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/miso
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/mosi
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/sclk
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/ss
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitReadyWire
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveDataValid
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/receiveDataWire
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitDataValid
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitIrePre
add wave -noupdate -group SpiCore /BeMicro_soc_tb/dut/spi/spiCore/transmitDataValidPre
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/clk
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/reset
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/clocksPerCycle
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/clockPolarity
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/clockPhase
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/dataDirection
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/transmitValid
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/dataRegIn
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/dataReg
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/transmitReady
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/receiveValid
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/miso
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/mosi
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/sclk
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/ss
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/state
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/nextState
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/cycleCounter
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/cycleCounterValue
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/bitCounter
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/bitCounterValue
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/dataRegNext
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/cycleDone
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/bitsDone
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/mosiReg
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/misoReg
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/mosiNext
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/misoNext
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/sclkNext
add wave -noupdate -group SpiUnit /BeMicro_soc_tb/dut/spi/spiCore/spiUnit/ssNext
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/clk
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/reset
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/read
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/write
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/address
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/dataIn
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/readValid
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/dataOut
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/soundIrq
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/pwmOut
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/dataInReg
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/readReg
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/writeReg
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/addressReg
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/readMux
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/bufferLoadEn
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/configLoadEn
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/wordCount
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/clocksPerCycle
add wave -noupdate -group sound /BeMicro_soc_tb/dut/sound/soundIre
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/bufferDataIn
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/bufferDataOut
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/bufferLoadEn
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/clk
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycle
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/clocksPerCycleIn
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/configLoadEn
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/pwmOut
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/readReq
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/reset
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/soundIre
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/soundIreIn
add wave -noupdate -expand -group soundCore /BeMicro_soc_tb/dut/sound/soundCore/wordCount
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/clk
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/reset
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/writeEn
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/readReq
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/dataIn
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/dataOut
add wave -noupdate -expand -group buffer -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/buffer/wordCount
add wave -noupdate -expand -group buffer /BeMicro_soc_tb/dut/sound/soundCore/buffer/dataOutWire
add wave -noupdate -expand -group buffer -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/buffer/writePointer
add wave -noupdate -expand -group buffer -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/buffer/readPointer
add wave -noupdate -expand -group SigmaDeltaUnit /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/clk
add wave -noupdate -expand -group SigmaDeltaUnit /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/reset
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/clocksPerCycle
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/dataIn
add wave -noupdate -expand -group SigmaDeltaUnit /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/pwmOut
add wave -noupdate -expand -group SigmaDeltaUnit /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/readReq
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/accumulator
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/accumulatorNext
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/bitCount
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/bitCountNext
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/cycleCounter
add wave -noupdate -expand -group SigmaDeltaUnit -radix unsigned /BeMicro_soc_tb/dut/sound/soundCore/sigmaDeltaUnit/cycleCounterValue
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {36234047 ps} 0} {{Cursor 2} {137715000 ps} 0}
quietly wave cursor active 2
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
WaveRestoreZoom {0 ps} {224256375 ps}
