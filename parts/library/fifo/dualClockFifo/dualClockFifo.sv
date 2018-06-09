

// the gray pointers have an extra bit to detect full and empty

module dualClockFifo
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 8,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input   logic                      readClk,
    input   logic                      readReset,
    input   logic                      writeClk,
    input   logic                      writeReset,
    input   logic                      writeEn,
    input   logic                      readReq,
    input   logic  [DATAWIDTH-1:0]     dataIn,
    output  logic  [DATAWIDTH-1:0]     dataOut,
    output  logic                      empty,
    output  logic                      full
    );


    logic  [ADDRESSWIDTH-1:0]  readPtrBinary,
    logic  [ADDRESSWIDTH:0]    readPtrGray,
    logic  [ADDRESSWIDTH:0]    syncedReadPtrGray;
    logic  [ADDRESSWIDTH-1:0]  writePtrBinary,
    logic  [ADDRESSWIDTH:0]    writePtrGray,
    logic  [ADDRESSWIDTH:0]    syncedWritePtrGray;


    // data output register
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataOut <= {DATAWIDTH{1'b0};
        else if(readReq)
            dataOut <= dataOutWire;
        else
            dataOut <= dataOut;
    end*/


    readLogic #(.WIDTH(ADDRESSWIDTH+1))
    readLogic(
        .clk               (readClk),
        .reset             (readReset),
        .readReq,
        .syncedWritePtrGray,
        .readPtrBinary,
        .readPtrGray,
        .empty
    );


    writeLogic #(.WIDTH(ADDRESSWIDTH+1))
    writeLogic(
        .clk               (writeClk),
        .reset             (writeReset),
        .writeEn,
        .syncedReadPtrGray,
        .writePtrBinary,
        .writePtrGray,
        .full
    );


    synchronizer #(.WIDTH(ADDRESSWIDTH+1))
    syncedReadPointer(
        .clk      (writeClk),
        .reset    (writeReset),
        .in       (readPtrGray),
        .out      (syncedReadPtrGray)
    );


    synchronizer #(.WIDTH(ADDRESSWIDTH+1))
    syncedWritePointer(
        .clk      (readClk),
        .reset    (readReset),
        .in       (writePtrGray),
        .out      (syncedWritePtrGray)
    );


    simpleDualPortDualClockMemory #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(DATADEPTH))
    simpleDualPortDualClockMemory(
        .readClk,
        .writeClk,
        .writeEn, // or (!full && writeEn) if we want to really ensure that it isn't written to when full
        .dataIn,
        .readAddress    (readPtrBinary),
        .writeAddress   (writePtrBinary),
        .dataOut        //(dataOutWire)
    );


endmodule

