onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group spi /spi_tb/dut/clk
add wave -noupdate -expand -group spi /spi_tb/dut/reset
add wave -noupdate -expand -group spi /spi_tb/dut/read
add wave -noupdate -expand -group spi /spi_tb/dut/write
add wave -noupdate -expand -group spi /spi_tb/dut/address
add wave -noupdate -expand -group spi /spi_tb/dut/dataIn
add wave -noupdate -expand -group spi /spi_tb/dut/readValid
add wave -noupdate -expand -group spi /spi_tb/dut/dataOut
add wave -noupdate -expand -group spi /spi_tb/dut/transmitIrq
add wave -noupdate -expand -group spi /spi_tb/dut/receiveIrq
add wave -noupdate -expand -group spi /spi_tb/dut/miso
add wave -noupdate -expand -group spi /spi_tb/dut/mosi
add wave -noupdate -expand -group spi /spi_tb/dut/sclk
add wave -noupdate -expand -group spi /spi_tb/dut/ss
add wave -noupdate -expand -group spi /spi_tb/dut/dataInReg
add wave -noupdate -expand -group spi /spi_tb/dut/readReg
add wave -noupdate -expand -group spi /spi_tb/dut/writeReg
add wave -noupdate -expand -group spi /spi_tb/dut/addressReg
add wave -noupdate -expand -group spi /spi_tb/dut/readMux
add wave -noupdate -expand -group spi /spi_tb/dut/transmitDataLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/configLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/receiveData
add wave -noupdate -expand -group spi /spi_tb/dut/idle
add wave -noupdate -expand -group spi /spi_tb/dut/receiveValid
add wave -noupdate -expand -group spi /spi_tb/dut/transmitReady
add wave -noupdate -expand -group spi /spi_tb/dut/clocksPerCycle
add wave -noupdate -expand -group spi /spi_tb/dut/clockPolarity
add wave -noupdate -expand -group spi /spi_tb/dut/clockPhase
add wave -noupdate -expand -group spi /spi_tb/dut/dataDirection
add wave -noupdate -expand -group spi /spi_tb/dut/ssEnable
add wave -noupdate -expand -group spi /spi_tb/dut/ssNumber
add wave -noupdate -expand -group spi /spi_tb/dut/receiveIre
add wave -noupdate -expand -group spi /spi_tb/dut/transmitIre
add wave -noupdate -expand -group spi /spi_tb/dut/receiveDataReadReq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clk
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/reset
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitDataIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clocksPerCycleIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPolarityIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPhaseIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/dataDirectionIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssEnableIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNumberIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveIreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitIreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitDataLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/configLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveDataReadReq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveData
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveValid
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitReady
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/idle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clocksPerCycle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPolarity
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPhase
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/dataDirection
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssEnable
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNumber
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveIre
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitIre
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitIrq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/receiveIrq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/miso
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/mosi
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/sclk
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ss
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreOut
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreRead
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreWrite
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/transmitDataReady
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/finalCycle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNext
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/clk
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/reset
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/clocksPerCycle
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/finalCycle
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/cycleCounter
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/cycleCounterValue
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/clk
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/reset
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/clockPolarity
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/clockPhase
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/dataDirection
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/finalCycle
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/dataRegIn
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/dataReg
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/transmitReady
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/coreWrite
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/coreRead
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/idle
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/miso
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/mosi
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/sclk
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/state
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/nextState
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/bitCounter
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/bitCounterValue
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/dataRegNext
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/finalBit
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/mosiNext
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/sclkNext
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/coreReadNext
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/coreWriteNext
add wave -noupdate -expand -group spiUnit /spi_tb/dut/spiCore/spiUnit/idleNext
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/clk
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/reset
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataIn
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataOut
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataWrite
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataRead
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataWordCount
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/transmitReady
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/receiveValid
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreIn
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreOut
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreWrite
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreRead
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreWordCount
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/transmitDataReady
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataWritePointer
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataReadPointer
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/dataPointer
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreWritePointer
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/coreReadPointer
add wave -noupdate -expand -group spiRingBuffer /spi_tb/dut/spiCore/spiRingBuffer/corePointer
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/clk
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/writeEnA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/dataInA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/addressA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/dataOutA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/writeEnB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/dataInB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/addressB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/dataOutB
add wave -noupdate -expand -group trueDualPortMemory -expand /spi_tb/dut/spiCore/spiRingBuffer/trueDualPortMemory/memoryBlock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {148438400 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 395
configure wave -valuecolwidth 195
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
WaveRestoreZoom {0 ps} {249407600 ps}
