`timescale 1ns / 100ps


module vgaDriver_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic  [10:0]  horizontalTotal;          // the entire number of horizontal cycles
    logic  [10:0]  horizontalDisplayStart;   // the cycle to start outputing pixels on
    logic  [10:0]  horizontalDisplayEnd;     // the cycle to stop outputing pixels on
    logic  [10:0]  horizontalBlankingStart;  // the cycle to start horizontal blanking on
    logic  [10:0]  horizontalBlankingEnd;    // the cycle to stop horizontal blanking on
    logic  [10:0]  horizontalRetraceStart;   // the cycle to start horizontal sync on
    logic  [10:0]  horizontalRetraceEnd;     // the cycle to stop horizontal sync on
    logic  [10:0]  verticalTotal;            // the entire number of vertical cycles
    logic  [10:0]  verticalDisplayStart;     // the cycle to start outputing pixels on
    logic  [10:0]  verticalDisplayEnd;       // the cycle to stop outputing pixels on
    logic  [10:0]  verticalBlankingStart;    // the cycle to start vertical blanking on
    logic  [10:0]  verticalBlankingEnd;      // the cycle to stop vertical blanking on
    logic  [10:0]  verticalRetraceStart;     // the cycle to start vertical sync on
    logic  [10:0]  verticalRetraceEnd;       // the cycle to stop vertical sync on
    logic          doubleScan;               // if active we output the same pixels for 2 lines in a row
    logic          horizontalSyncLevel;      // determines the active level of horizontal sync
    logic          verticalSyncLevel;        // determines the active level of vertical sync
    logic          enableDisplay;            // if active signals are driven by the driver
    logic  [7:0]   bufferData;               // pixel data from the line buffer


    // output wires
    logic          horizontalBlank;
    logic          verticalBlank;
    logic          horizontalRetrace;
    logic          verticalRetrace;
    logic  [10:0]  bufferAddress;            // buffer address to the line buffer
    logic          lineRequest;              // request a new line from the vga core
    logic          endOfFrame;               // reset the pixel address in the vga core, because we are done with this fram
    logic          horizontalSync;           // horizontal sync to the monitor
    logic          verticalSync;             // vertical sync to the monitor
    logic  [2:0]   red;                      // red pixel to the monitor
    logic  [2:0]   green;                    // green pixel data to the monitor
    logic  [1:0]   blue;                     // blue pixel data to the monitor


    // inout wires


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    vgaDriver
    dut(
        .clk,
        .reset,
        .horizontalTotal,          // the entire number of horizontal cycles
        .horizontalDisplayStart,   // the cycle to start outputing pixels on
        .horizontalDisplayEnd,     // the cycle to stop outputing pixels on
        .horizontalBlankingStart,  // the cycle to start horizontal blanking on
        .horizontalBlankingEnd,    // the cycle to stop horizontal blanking on
        .horizontalRetraceStart,   // the cycle to start horizontal sync on
        .horizontalRetraceEnd,     // the cycle to stop horizontal sync on
        .verticalTotal,            // the entire number of vertical cycles
        .verticalDisplayStart,     // the cycle to start outputing pixels on
        .verticalDisplayEnd,       // the cycle to stop outputing pixels on
        .verticalBlankingStart,    // the cycle to start vertical blanking on
        .verticalBlankingEnd,      // the cycle to stop vertical blanking on
        .verticalRetraceStart,     // the cycle to start vertical sync on
        .verticalRetraceEnd,       // the cycle to stop vertical sync on
        .doubleScan,               // if active we output the same pixels for 2 lines in a row
        .horizontalSyncLevel,      // determines the active level of horizontal sync
        .verticalSyncLevel,        // determines the active level of vertical sync
        .enableDisplay,            // if active signals are driven by the driver
        .horizontalBlank,
        .verticalBlank,
        .horizontalRetrace,
        .verticalRetrace,
        .bufferData,               // buffer data from the line buffer
        .bufferAddress,            // buffer address to the line buffer
        .lineRequest,              // request a new line from the vga core
        .endOfFrame,               // reset the pixel address in the vga core, because we are done with this fram
        .horizontalSync,           // horizontal sync to the monitor
        .verticalSync,             // vertical sync to the monitor
        .red,                      // red pixel to the monitor
        .green,                    // green pixel data to the monitor
        .blue                      // blue pixel data to the monitor
    );


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset                     = 1'b0;
        horizontalTotal           = 11'd800; // the entire number of horizontal cycles
        horizontalDisplayStart    = 11'd161; // the cycle to start outputing pixels on
        horizontalDisplayEnd      = 11'd800; // the cycle to stop outputing pixels on
        horizontalBlankingStart   = 11'd1;   // the cycle to start horizontal blanking on
        horizontalBlankingEnd     = 11'd160; // the cycle to stop horizontal blanking on
        horizontalRetraceStart    = 11'd17;  // the cycle to start horizontal sync on
        horizontalRetraceEnd      = 11'd112; // the cycle to stop horizontal sync on
        verticalTotal             = 11'd525; // the entire number of vertical cycles
        verticalDisplayStart      = 11'd46;  // the cycle to start outputing pixels on
        verticalDisplayEnd        = 11'd525; // the cycle to stop outputing pixels on
        verticalBlankingStart     = 11'd1;   // the cycle to start vertical blanking on
        verticalBlankingEnd       = 11'd45;  // the cycle to stop vertical blanking on
        verticalRetraceStart      = 11'd11;  // the cycle to start vertical sync on
        verticalRetraceEnd        = 11'd12;  // the cycle to stop vertical sync on
        doubleScan                = 1'b0;    // if active we output the same pixels for 2 lines in a row
        horizontalSyncLevel       = 1'b0;    // determines the active level of horizontal sync
        verticalSyncLevel         = 1'b0;    // determines the active level of vertical sync
        enableDisplay             = 1'b1;    // if active signals are driven by the driver
        bufferData                = 8'haa;   // pixel data from the line buffer
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        hardwareReset();
        repeat(1000000) @(posedge clk);

        $stop;
    end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardwareReset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(20) @(posedge clk);
        reset = 1'b0;
    endtask


endmodule

