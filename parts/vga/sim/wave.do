onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /vgaDriver_tb/dut/clk
add wave -noupdate /vgaDriver_tb/dut/reset
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalTotal
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalDisplayStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalDisplayEnd
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalBlankingStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalBlankingEnd
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalRetraceStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalRetraceEnd
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalTotal
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalDisplayStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalDisplayEnd
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalBlankingStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalBlankingEnd
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalRetraceStart
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalRetraceEnd
add wave -noupdate /vgaDriver_tb/dut/doubleScan
add wave -noupdate /vgaDriver_tb/dut/horizontalSyncLevel
add wave -noupdate /vgaDriver_tb/dut/verticalSyncLevel
add wave -noupdate /vgaDriver_tb/dut/enableDisplay
add wave -noupdate /vgaDriver_tb/dut/horizontalBlank
add wave -noupdate /vgaDriver_tb/dut/verticalBlank
add wave -noupdate /vgaDriver_tb/dut/horizontalRetrace
add wave -noupdate /vgaDriver_tb/dut/verticalRetrace
add wave -noupdate /vgaDriver_tb/dut/bufferData
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/bufferAddress
add wave -noupdate /vgaDriver_tb/dut/lineRequest
add wave -noupdate /vgaDriver_tb/dut/endOfFrame
add wave -noupdate /vgaDriver_tb/dut/horizontalSync
add wave -noupdate /vgaDriver_tb/dut/verticalSync
add wave -noupdate /vgaDriver_tb/dut/red
add wave -noupdate /vgaDriver_tb/dut/green
add wave -noupdate /vgaDriver_tb/dut/blue
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalState
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalState
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/horizontalStateNext
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/verticalStateNext
add wave -noupdate /vgaDriver_tb/dut/lineRequestNext
add wave -noupdate /vgaDriver_tb/dut/endOfFrameNext
add wave -noupdate /vgaDriver_tb/dut/horizontalBlankNext
add wave -noupdate /vgaDriver_tb/dut/verticalBlankNext
add wave -noupdate /vgaDriver_tb/dut/horizontalRetraceNext
add wave -noupdate /vgaDriver_tb/dut/verticalRetraceNext
add wave -noupdate /vgaDriver_tb/dut/horizontalSyncNext
add wave -noupdate /vgaDriver_tb/dut/verticalSyncNext
add wave -noupdate /vgaDriver_tb/dut/redNext
add wave -noupdate /vgaDriver_tb/dut/greenNext
add wave -noupdate /vgaDriver_tb/dut/blueNext
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/pixelAddress
add wave -noupdate -radix unsigned /vgaDriver_tb/dut/pixelAddressNext
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5250030000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 268
configure wave -valuecolwidth 100
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
WaveRestoreZoom {4667834400 ps} {10280861400 ps}
