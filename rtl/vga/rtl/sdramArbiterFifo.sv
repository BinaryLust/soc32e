

module sdramArbiterFifo(
    input   logic         clk,
    input   logic         reset,
    input   logic         writeEn,
    input   logic         readReq,
    input   logic         dataIn,
    output  logic         dataOut
    //output  logic  [3:0]  wordCount,
    //output  logic         empty
    );


    //logic  [3:0]  wordCount;
    //logic  [7:0]  dataOutWire;
    logic  [3:0]  writePointer;
    logic  [3:0]  readPointer;


    //assign empty = (wordCount == 4'd0);


    // write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            writePointer <= 4'd0;
        else if(writeEn)
            writePointer <= writePointer + 4'd1;
        else
            writePointer <= writePointer;
    end


    // read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readPointer <= 4'd0;
        else if(readReq)
            readPointer <= readPointer + 4'd1;
        else
            readPointer <= readPointer;
    end


    // word counter
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset)
            wordCount <= 4'd0;
        else if(readReq && !writeEn)
            wordCount <= wordCount - 4'd1; // read but no write
        else if(writeEn && !readReq)
            wordCount <= wordCount + 4'd1; // write but no read
        else
            wordCount <= wordCount;         // no change if read and write at the same time or no activity
    end*/


    // data output register
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataOut <= 8'd0;
        else if(readReq)
            dataOut <= dataOutWire;
        else
            dataOut <= dataOut;
    end*/


    sdramArbiterFifoMemory
    sdramArbiterFifoMemory(
        .clk,
        .writeEn,
        .dataIn,
        .readAddress    (readPointer),
        .writeAddress   (writePointer),
        .dataOut        //(dataOutWire)
    );


endmodule

