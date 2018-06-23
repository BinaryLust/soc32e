



module singleClockFifo
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input   logic                      clk,
    input   logic                      reset,
    input   logic                      writeEn,
    input   logic                      readReq,
    input   logic  [DATAWIDTH-1:0]     dataIn,
    output  logic  [DATAWIDTH-1:0]     dataOut,
    output  logic  [ADDRESSWIDTH-1:0]  wordCount,
    output  logic                      empty,
    output  logic                      full
    );


    //logic  [DATAWIDTH-1:0]  dataOutWire;
    logic  [ADDRESSWIDTH-1:0]  writePointer;
    logic  [ADDRESSWIDTH-1:0]  readPointer;


    assign empty = (wordCount == 0);
    assign full  = (wordCount == (DATADEPTH-1));


    // write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            writePointer <= 0;
        else if(writeEn)
            writePointer <= writePointer + {{ADDRESSWIDTH-1{1'b0}}, 1'b1};
        else
            writePointer <= writePointer;
    end


    // read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readPointer <= 0;
        else if(readReq)
            readPointer <= readPointer + {{ADDRESSWIDTH-1{1'b0}}, 1'b1};
        else
            readPointer <= readPointer;
    end


    // word counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            wordCount <= 0;
        else if(readReq && !writeEn)
            wordCount <= wordCount - {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // read but no write
        else if(writeEn && !readReq)
            wordCount <= wordCount + {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // write but no read
        else
            wordCount <= wordCount;         // no change if read and write at the same time or no activity
    end


    // data output register
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataOut <= 8'd0;
        else if(readReq)
            dataOut <= dataOutWire;
        else
            dataOut <= dataOut;
    end*/


    simpleDualPortMemory #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(DATADEPTH))
    simpleDualPortMemory(
        .clk,
        .writeEn,
        .dataIn,
        .readAddress    (readPointer),
        .writeAddress   (writePointer),
        .dataOut        //(dataOutWire)
    );


endmodule

