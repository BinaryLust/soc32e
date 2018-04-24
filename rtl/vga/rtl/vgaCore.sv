

module vgaCore(
    input   logic          coreClk,
	 input   logic          videoClk,
	 input   logic          coreReset,
	 input   logic          videoReset,
	 
	 output  logic          horizontalSync,
	 output  logic          verticalSync,
	 output  logic  [2:0]   red,
	 output  logic  [2:0]   green,
	 output  logic  [1:0]   blue
	 );


	 logic  [7:0]   readData;
	 logic  [11:0]  readAddress;
	 
	 
	 vgaDriver
	 vgaDriver(
        .clk                     (videoClk),
	     .reset                   (videoReset),
	     .horizontalTotal         (11'd800),     // the entire number of horizontal cycles
	     .horizontalDisplayStart  (11'd161),     // the cycle to start outputing pixels on
	     .horizontalDisplayEnd    (11'd800),     // the cycle to stop outputing pixels on
	     .horizontalBlankingStart (11'd1),       // the cycle to start horizontal blanking on
	     .horizontalBlankingEnd   (11'd160),     // the cycle to stop horizontal blanking on
	     .horizontalRetraceStart  (11'd17),      // the cycle to start horizontal sync on
	     .horizontalRetraceEnd    (11'd112),     // the cycle to stop horizontal sync on
	     .verticalTotal           (11'd525),     // the entire number of vertical cycles
	     .verticalDisplayStart    (11'd46),      // the cycle to start outputing pixels on
	     .verticalDisplayEnd      (11'd525),     // the cycle to stop outputing pixels on
	     .verticalBlankingStart   (11'd1),       // the cycle to start vertical blanking on
	     .verticalBlankingEnd     (11'd45),      // the cycle to stop vertical blanking on
	     .verticalRetraceStart    (11'd11),      // the cycle to start vertical sync on
	     .verticalRetraceEnd      (11'd12),      // the cycle to stop vertical sync on
	     .doubleScan              (1'b0),        // if active we output the same pixels for 2 lines in a row
	     .horizontalSyncLevel     (1'b0),        // determines the active level of horizontal sync
	     .verticalSyncLevel       (1'b0),        // determines the active level of vertical sync
	     .enableDisplay           (1'b1),        // if active signals are driven by the driver
	     .horizontalBlank         (),
	     .verticalBlank           (),
	     .horizontalRetrace       (),
	     .verticalRetrace         (),
	     .bufferData              (readData),    // buffer data from the line buffer
	     .bufferAddress           (readAddress), // buffer address to the line buffer
	     .lineRequest             (),            // request a new line from the vga core
	     .endOfFrame              (),            // reset the pixel address in the vga core, because we are done with this fram
	     .horizontalSync,                        // horizontal sync to the monitor
	     .verticalSync,                          // vertical sync to the monitor
	     .red,                                   // red pixel to the monitor
	     .green,                                 // green pixel data to the monitor
	     .blue                                   // blue pixel data to the monitor
	 );
	 
	 
    lineBuffer
	 lineBuffer(
        .writeClk        (coreClk),
	     .writeEn         (1'b0),//(readValid),
	     .writeAddress    (9'd0),
	     .writeData       (32'd0),//(dataIn),
	     .readClk         (videoClk),
	     .readAddress,
	     .readData
    );
	
	
endmodule

