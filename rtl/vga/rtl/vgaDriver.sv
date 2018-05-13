

module vgaDriver(
    input   logic          clk,
    input   logic          reset,

    input   logic  [10:0]  horizontalTotal,          // the entire number of horizontal cycles
    input   logic  [10:0]  horizontalDisplayStart,   // the cycle to start outputing pixels on
    input   logic  [10:0]  horizontalDisplayEnd,     // the cycle to stop outputing pixels on
    input   logic  [10:0]  horizontalBlankingStart,  // the cycle to start horizontal blanking on
    input   logic  [10:0]  horizontalBlankingEnd,    // the cycle to stop horizontal blanking on
    input   logic  [10:0]  horizontalRetraceStart,   // the cycle to start horizontal sync on
    input   logic  [10:0]  horizontalRetraceEnd,     // the cycle to stop horizontal sync on

    input   logic  [10:0]  verticalTotal,            // the entire number of vertical cycles
    input   logic  [10:0]  verticalDisplayStart,     // the cycle to start outputing pixels on
    input   logic  [10:0]  verticalDisplayEnd,       // the cycle to stop outputing pixels on
    input   logic  [10:0]  verticalBlankingStart,    // the cycle to start vertical blanking on
    input   logic  [10:0]  verticalBlankingEnd,      // the cycle to stop vertical blanking on
    input   logic  [10:0]  verticalRetraceStart,     // the cycle to start vertical sync on
    input   logic  [10:0]  verticalRetraceEnd,       // the cycle to stop vertical sync on

    input   logic          doubleScan,               // if active we output the same pixels for 2 lines in a row
    input   logic          horizontalSyncLevel,      // determines the active level of horizontal sync
    input   logic          verticalSyncLevel,        // determines the active level of vertical sync
    input   logic          enableDisplay,            // if active signals are driven by the driver

    output  logic          horizontalBlank,
    output  logic          verticalBlank,
    output  logic          horizontalRetrace,
    output  logic          verticalRetrace,

    input   logic  [7:0]   bufferData,               // buffer data from the line buffer
    output  logic  [10:0]  bufferAddress,            // buffer address to the line buffer
    output  logic          lineRequest,              // request a new line from the vga core
    output  logic          endOfFrame,               // reset the pixel address in the vga core, because we are done with this fram

    output  logic          horizontalSync,           // horizontal sync to the monitor
    output  logic          verticalSync,             // vertical sync to the monitor
    output  logic  [2:0]   red,                      // red pixel to the monitor
    output  logic  [2:0]   green,                    // green pixel data to the monitor
    output  logic  [1:0]   blue                      // blue pixel data to the monitor
    );


    logic  [10:0]  horizontalState;
    logic  [10:0]  verticalState;
    logic  [10:0]  horizontalStateNext;
    logic  [10:0]  verticalStateNext;


    logic          lineRequestNext;
    logic          endOfFrameNext;


    logic          horizontalBlankNext;
    logic          verticalBlankNext;
    logic          horizontalRetraceNext;
    logic          verticalRetraceNext;


    logic          horizontalSyncNext;
    logic          verticalSyncNext;
    logic  [2:0]   redNext;
    logic  [2:0]   greenNext;
    logic  [1:0]   blueNext;
    logic  [10:0]  pixelAddress;
    logic  [10:0]  pixelAddressNext;


    assign bufferAddress = pixelAddressNext;


    // state registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            horizontalState <= 11'd1; // or zero?
            verticalState   <= 11'd1; // or zero?
        end else begin
            horizontalState <= horizontalStateNext;
            verticalState   <= verticalStateNext;
        end
    end


    // control signal registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            pixelAddress <= 11'd0;
            lineRequest  <= 1'b0;
            endOfFrame   <= 1'b0;
        end else begin
            pixelAddress <= pixelAddressNext;
            lineRequest  <= lineRequestNext;
            endOfFrame   <= endOfFrameNext;
        end
    end


    // visible registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            horizontalBlank   <= 1'b0;
            verticalBlank     <= 1'b0;
            horizontalRetrace <= 1'b0;
            verticalRetrace   <= 1'b0;
        end else begin
            horizontalBlank   <= horizontalBlankNext;
            verticalBlank     <= verticalBlankNext;
            horizontalRetrace <= horizontalRetraceNext;
            verticalRetrace   <= verticalRetraceNext;
        end
    end


    // monitor output registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            horizontalSync <= 1'b0;
            verticalSync   <= 1'b0;
            red            <= 3'd0;
            green          <= 3'd0;
            blue           <= 2'd0;
        end else begin
            horizontalSync <= horizontalSyncNext;
            verticalSync   <= verticalSyncNext;
            red            <= redNext;
            green          <= greenNext;
            blue           <= blueNext;
        end
    end


    // combinational logic
    always_comb begin
        // defaults
        horizontalStateNext   = 11'd1;                // reset to state 1
        verticalStateNext     = 11'd1;                // reset to state 1
        lineRequestNext       = 1'b0;                 // no line request
        endOfFrameNext        = 1'b1;                 // end of frame
        horizontalBlankNext   = 1'b0;                 // not blanking
        verticalBlankNext     = 1'b0;                 // not blanking
        horizontalRetraceNext = 1'b0;                 // no retrace
        verticalRetraceNext   = 1'b0;                 // no retrace
        pixelAddressNext      = 11'd0;                // reset address
        horizontalSyncNext    = !horizontalSyncLevel; // no horizontal sync
        verticalSyncNext      = !verticalSyncLevel;   // no vertical sync
        redNext               = 3'd0;                 // output all zeros // keep old values
        greenNext             = 3'd0;                 // output all zeros // keep old values
        blueNext              = 2'd0;                 // output all zeros // keep old values


        if(enableDisplay) begin
            horizontalStateNext = horizontalState + 11'd1; // go to next horizontal state


            // next state
            if(horizontalState >= horizontalTotal) begin
                horizontalStateNext   = 11'd1;                 // reset to first horizontal state
                if(verticalState >= verticalTotal)
                    verticalStateNext  = 11'd1;                 // reset to first vertical state
                else
                    verticalStateNext = verticalState + 11'd1; // go to next vertical state
            end else begin
                verticalStateNext = verticalState;             // stay in old state
            end


            // request a new line to be delivered to the line buffer
            lineRequestNext = ((horizontalState == 11'd1) && (verticalState >= verticalDisplayStart) && (verticalState <= verticalDisplayEnd)) ? 1'b1 : 1'b0;


            // signal end of frame
            endOfFrameNext = ((horizontalState >= horizontalTotal) && (verticalState >= verticalTotal)) ? 1'b1 : 1'b0;


            // blanking
            if((horizontalState >= horizontalBlankingStart) && (horizontalState <= horizontalBlankingEnd))
                horizontalBlankNext    = 1'b1;

            if((verticalState >= verticalBlankingStart) && (verticalState <= verticalBlankingEnd))
                verticalBlankNext      = 1'b1;


            // retrace/ sync
            if((horizontalState >= horizontalRetraceStart) && (horizontalState <= horizontalRetraceEnd)) begin
                horizontalRetraceNext = 1'b1;
                horizontalSyncNext    = horizontalSyncLevel;
            end

            if((verticalState >= verticalRetraceStart) && (verticalState <= verticalRetraceEnd)) begin
                verticalRetraceNext   = 1'b1;
                verticalSyncNext       = verticalSyncLevel;
            end


            // pixel draw
            if((horizontalState >= horizontalDisplayStart) && (horizontalState <= horizontalDisplayEnd) &&
                (verticalState >= verticalDisplayStart) && (verticalState <= verticalDisplayEnd))
            begin
                pixelAddressNext = pixelAddress + 11'd1;
                redNext          = bufferData[7:5];
                greenNext        = bufferData[4:2];
                blueNext         = bufferData[1:0];
            end else begin
                pixelAddressNext = 11'd0;
                redNext          = 3'd0;
                greenNext        = 3'd0;
                blueNext         = 2'd0;
            end
        end
    end


endmodule

