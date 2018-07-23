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
add wave -noupdate -expand -group spi /spi_tb/dut/txIrq
add wave -noupdate -expand -group spi /spi_tb/dut/rxIrq
add wave -noupdate -expand -group spi /spi_tb/dut/miso
add wave -noupdate -expand -group spi /spi_tb/dut/mosi
add wave -noupdate -expand -group spi /spi_tb/dut/sclk
add wave -noupdate -expand -group spi /spi_tb/dut/ss
add wave -noupdate -expand -group spi /spi_tb/dut/dataInReg
add wave -noupdate -expand -group spi /spi_tb/dut/readReg
add wave -noupdate -expand -group spi /spi_tb/dut/writeReg
add wave -noupdate -expand -group spi /spi_tb/dut/addressReg
add wave -noupdate -expand -group spi /spi_tb/dut/readMux
add wave -noupdate -expand -group spi /spi_tb/dut/txDataLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/configLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/txAlmostFullCountLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/rxAlmostEmptyCountLoadEn
add wave -noupdate -expand -group spi /spi_tb/dut/rxData
add wave -noupdate -expand -group spi /spi_tb/dut/idle
add wave -noupdate -expand -group spi /spi_tb/dut/txFull
add wave -noupdate -expand -group spi /spi_tb/dut/txAlmostFull
add wave -noupdate -expand -group spi /spi_tb/dut/rxEmpty
add wave -noupdate -expand -group spi /spi_tb/dut/rxAlmostEmpty
add wave -noupdate -expand -group spi /spi_tb/dut/txAlmostFullCount
add wave -noupdate -expand -group spi /spi_tb/dut/rxAlmostEmptyCount
add wave -noupdate -expand -group spi /spi_tb/dut/txCount
add wave -noupdate -expand -group spi /spi_tb/dut/rxCount
add wave -noupdate -expand -group spi /spi_tb/dut/clocksPerCycle
add wave -noupdate -expand -group spi /spi_tb/dut/clockPolarity
add wave -noupdate -expand -group spi /spi_tb/dut/clockPhase
add wave -noupdate -expand -group spi /spi_tb/dut/dataDirection
add wave -noupdate -expand -group spi /spi_tb/dut/ssEnable
add wave -noupdate -expand -group spi /spi_tb/dut/ssNumber
add wave -noupdate -expand -group spi /spi_tb/dut/rxIre
add wave -noupdate -expand -group spi /spi_tb/dut/txIre
add wave -noupdate -expand -group spi /spi_tb/dut/rxDataReadReq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clk
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/reset
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txDataIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txAlmostFullCountIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxAlmostEmptyCountIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clocksPerCycleIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPolarityIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPhaseIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/dataDirectionIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssEnableIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNumberIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxIreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txIreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txDataLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txAlmostFullCountLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxAlmostEmptyCountLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/configLoadEn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxDataReadReq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxData
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txAlmostFullCount
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxAlmostEmptyCount
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txCount
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxCount
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txFull
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txAlmostFull
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxEmpty
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxAlmostEmpty
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/idle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clocksPerCycle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPolarity
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/clockPhase
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/dataDirection
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssEnable
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNumber
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxIre
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txIre
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/txIrq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/rxIrq
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/miso
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/mosi
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/sclk
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ss
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreIn
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreOut
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreRead
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreWrite
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/coreTxEmpty
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/finalCycle
add wave -noupdate -expand -group spiCore /spi_tb/dut/spiCore/ssNext
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/clk
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/reset
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/clocksPerCycle
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/finalCycle
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/cycleCounter
add wave -noupdate -expand -group spiClockUnit /spi_tb/dut/spiCore/spiClockUnit/cycleCounterValue
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/clk
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/reset
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/clockPolarity
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/clockPhase
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/dataDirection
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/finalCycle
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/dataIn
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/dataOut
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/coreTxEmpty
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/coreWrite
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/coreRead
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/idle
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/miso
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/mosi
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/sclk
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/state
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/nextState
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/bitCounter
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/bitCounterValue
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/dataOutNext
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/finalBit
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/mosiNext
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/sclkNext
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/coreReadNext
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/coreWriteNext
add wave -noupdate -expand -group spiController /spi_tb/dut/spiCore/spiController/idleNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/clk
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/reset
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataIn
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataOut
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataWrite
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRead
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxAlmostFullCount
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxAlmostEmptyCount
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxCount
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxCount
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxFull
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxAlmostFull
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxEmpty
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxAlmostEmpty
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreIn
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreOut
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreWrite
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreRead
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreTxEmpty
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataWritePointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataWritePointerNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataReadPointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataReadPointerNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxCountNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxCountNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataPointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxFullNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataTxAlmostFullNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxEmptyNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/dataRxAlmostEmptyNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreWritePointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreWritePointerNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreReadPointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreReadPointerNext
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/corePointer
add wave -noupdate -expand -group spiCircularBuffer /spi_tb/dut/spiCore/spiCircularBuffer/coreTxEmptyNext
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/clk
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/writeEnA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/dataInA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/addressA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/dataOutA
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/writeEnB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/dataInB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/addressB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/dataOutB
add wave -noupdate -expand -group trueDualPortMemory /spi_tb/dut/spiCore/spiCircularBuffer/trueDualPortMemory/memoryBlock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
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
WaveRestoreZoom {0 ps} {3084396 ns}
