onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/clk
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/reset
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/read
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/write
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/address
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/dataIn
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/readValid
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/dataOut
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/soundIrq
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/wclk
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/bclk
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/sdin
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/sdout
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/dataInReg
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/readReg
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/writeReg
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/addressReg
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/readMux
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/bufferLoadEn
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/configLoadEn
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/wordCount
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/full
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/sampleSize
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/stereoMode
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/playback
add wave -noupdate -expand -group i2sSlave /i2sSlave_tb/dut/soundIre
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/clk
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/reset
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/bufferDataIn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/sampleSizeIn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/stereoModeIn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/playbackIn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/soundIreIn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/bufferLoadEn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/configLoadEn
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/wordCount
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/full
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/sampleSize
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/stereoMode
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/playback
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/soundIre
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/soundIrq
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/wclk
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/bclk
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/sdin
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/sdout
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/readReq
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/bufferDataOut
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/wordCountP1
add wave -noupdate -expand -group i2sSlaveCore /i2sSlave_tb/dut/i2sSlaveCore/wordCountP2
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/clk
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/reset
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sampleSize
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/stereoMode
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/playback
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sampleData
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/readReq
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/wclk
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bclk
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sdin
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sdout
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/state
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/nextState
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sample
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sampleNext
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sampleCounter
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sampleCounterNext
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bitCounter
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bitCounterNext
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/wclkReg
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/wclkPrevReg
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/wclkRose
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/wclkFell
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/syncBclk
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bclkReg
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bclkPrevReg
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bclkRose
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/bclkFell
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/sdoutNext
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/readReqReg
add wave -noupdate -expand -group i2sSlaveUnit /i2sSlave_tb/dut/i2sSlaveCore/i2sSlaveUnit/readReqRegNext
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/clk
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/reset
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/writeEn
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/readReq
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/dataIn
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/dataOut
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/wordCount
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/empty
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/full
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/writePointer
add wave -noupdate -expand -group singleClockFifo /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/readPointer
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/clk
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/writeEn
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/dataIn
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/readAddress
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/writeAddress
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/dataOut
add wave -noupdate -expand -group singleClockFifo -expand -group simpleDualPortMemory -expand /i2sSlave_tb/dut/i2sSlaveCore/singleClockFifo/simpleDualPortMemory/memoryBlock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {273800 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 484
configure wave -valuecolwidth 208
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
WaveRestoreZoom {0 ps} {5127600 ps}
