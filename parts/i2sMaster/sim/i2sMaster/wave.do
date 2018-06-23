onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/clk
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/reset
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/synthClk
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/synthReset
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/read
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/write
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/address
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/dataIn
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/readValid
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/dataOut
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/soundIrq
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/mclk
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/wclk
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/bclk
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/sdin
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/sdout
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/dataInReg
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/readReg
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/writeReg
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/addressReg
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/readMux
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/bufferLoadEn
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/configLoadEn
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/dividerLoadEn
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/wordCount
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/full
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/sampleSize
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/stereoMode
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/playback
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/soundIre
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/mclkDivider
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/bclkDivider
add wave -noupdate -expand -group i2sMaster /i2sMaster_tb/dut/wclkDivider
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/clk
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/reset
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/synthClk
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/synthReset
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bufferDataIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/sampleSizeIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/stereoModeIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/playbackIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/soundIreIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/mclkDividerIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bclkDividerIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wclkDividerIn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bufferLoadEn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/configLoadEn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/dividerLoadEn
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wordCount
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/full
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/sampleSize
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/stereoMode
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/playback
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/soundIre
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/mclkDivider
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bclkDivider
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wclkDivider
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/soundIrq
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/mclk
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wclk
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bclk
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/sdin
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/sdout
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/readReq
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/bufferDataOut
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wordCountP1
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/wordCountP2
add wave -noupdate -expand -group i2sMasterCore /i2sMaster_tb/dut/i2sMasterCore/dividerLoadEn2
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/synthClk
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/synthReset
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/loadEn
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclkDivider
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclkDivider
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclkDivider
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclk
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclk
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclk
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclkCounter
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclkCounterNext
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclkCounter
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclkCounterNext
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclkCounter
add wave -noupdate -expand -group i2sMasterClockUnit -radix unsigned /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclkCounterNext
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclkNext
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclkNext
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclkNext
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/mclkFinal
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/bclkFinal
add wave -noupdate -expand -group i2sMasterClockUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterClockUnit/wclkFinal
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/reset1
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/enAck
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/enIn
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/en1
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/en1Next
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/reset2
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/enOut
add wave -noupdate -expand -group crossDomainEn /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/en2
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/clk
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/reset
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/in
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/out
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/outRose
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/syncReg1
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/syncReg2
add wave -noupdate -expand -group syncEdgeClk1ToClk2 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk1toClk2SyncEdge/pulseReg
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/clk
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/reset
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/in
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/out
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/outRose
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/syncReg1
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/syncReg2
add wave -noupdate -expand -group syncEdgeClk2ToClk1 /i2sMaster_tb/dut/i2sMasterCore/crossDomainEn/clk2toClk1SyncEdge/pulseReg
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/clk
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/reset
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sampleSize
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/stereoMode
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/playback
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sampleData
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/readReq
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/wclk
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bclk
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sdin
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sdout
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/state
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/nextState
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sample
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sampleNext
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sampleCounter
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sampleCounterNext
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bitCounter
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bitCounterNext
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/wclkReg
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/wclkPrevReg
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/wclkRose
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/wclkFell
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/syncBclk
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bclkReg
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bclkRose
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/bclkFell
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/sdoutNext
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/readReqReg
add wave -noupdate -expand -group i2sMasterUnit /i2sMaster_tb/dut/i2sMasterCore/i2sMasterUnit/readReqRegNext
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/clk
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/reset
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/writeEn
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/readReq
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/dataIn
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/dataOut
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/wordCount
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/empty
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/full
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/writePointer
add wave -noupdate -expand -group singleClockFifo /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/readPointer
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/clk
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/writeEn
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/dataIn
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/readAddress
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/writeAddress
add wave -noupdate -expand -group simpleDualPortMemory /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/dataOut
add wave -noupdate -expand -group simpleDualPortMemory -expand /i2sMaster_tb/dut/i2sMasterCore/singleClockFifo/simpleDualPortMemory/memoryBlock
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {47011300 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 481
configure wave -valuecolwidth 204
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
WaveRestoreZoom {41432800 ps} {52599200 ps}
