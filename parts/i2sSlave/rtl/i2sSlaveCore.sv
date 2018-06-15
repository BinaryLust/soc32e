

module i2sSlaveCore(
    input   logic          clk,
    input   logic          reset,

    input   logic  [31:0]  bufferDataIn,     // data from the master interface
    input   logic          sampleSizeIn,     // data from the master interface
    input   logic          stereoModeIn,     // data from the master interface
    input   logic          playbackIn,       // data from the master interface
    input   logic          soundIreIn,       // data from the master interface

    input   logic          bufferLoadEn,     // write enable from the master interface
    input   logic          configLoadEn,     // write enable from the master interface

    output  logic  [8:0]   wordCount,        // visible state to the master interface
    output  logic          full,             // visible state to the master interface
    output  logic          sampleSize,       // visible state to the master interface
    output  logic          stereoMode,       // visible state to the master interface
    output  logic          playback,         // visible state to the master interface
    output  logic          soundIre,         // visible state to the master interface

    output  logic          soundIrq,

    input   logic          wclk,
    input   logic          bclk,
    input   logic          sdin,
    output  logic          sdout
    );


    logic          readReq;
    logic  [31:0]  bufferDataOut;
    logic  [8:0]   wordCountP1;
    logic  [8:0]   wordCountP2;


    //------------------------------------------------
    // visible registers


    // sample size register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sampleSize <= 1'd0; // 8 bit
        else if(configLoadEn)
            sampleSize <= sampleSizeIn;
        else
            sampleSize <= sampleSize;
    end


    // stereo mode register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            stereoMode <= 1'd0; // mono
        else if(configLoadEn)
            stereoMode <= stereoModeIn;
        else
            stereoMode <= stereoMode;
    end


    // playback register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            playback <= 1'd0; // playback disabled
        else if(configLoadEn)
            playback <= playbackIn;
        else
            playback <= playback;
    end


    // sound interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            soundIre <= 1'd0;
        else if(configLoadEn)
            soundIre <= soundIreIn;
        else
            soundIre <= soundIre;
    end


    //------------------------------------------------
    // hidden registers


    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            soundIrq <= 1'b0;
        else
            soundIrq <= ((wordCount == 32) && (wordCountP1 == 33) && (wordCountP2 == 34) && (readReq && soundIre));
    end


    // previous word count registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            wordCountP1 <= 1'd0;
            wordCountP2 <= 1'd0;
        end else if(readReq) begin      // update the count when the buffer is read from
            wordCountP1 <= wordCount;   // last cycle
            wordCountP2 <= wordCountP1; // two cycles ago
        end
    end


    singleClockFifo #(.DATAWIDTH(32), .DATADEPTH(512))
    singleClockFifo(
        .clk,
        .reset,
        .writeEn      (bufferLoadEn),
        .readReq,
        .dataIn       (bufferDataIn),
        .dataOut      (bufferDataOut),
        .wordCount,
        .empty        (),
        .full
    );


    i2sSlaveUnit
    i2sSlaveUnit(
        .clk,
        .reset,
        .sampleSize,
        .stereoMode,
        .playback,
        .sampleData   (bufferDataOut),
        .readReq,
        .wclk,
        .bclk,
        .sdin,
        .sdout
    );


endmodule

