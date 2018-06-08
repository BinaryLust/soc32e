

module asyncFifoMemory
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 8,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(

    input   logic                      readClk,
    input   logic                      writeClk,
    input   logic                      writeEn,
    input   logic  [DATAWIDTH-1:0]     dataIn,
    input   logic  [ADDRESSWIDTH-1:0]  readAddress,
    input   logic  [ADDRESSWIDTH-1:0]  writeAddress,
    output  logic  [DATAWIDTH-1:0]     dataOut
    );


    logic  [DATAWIDTH-1:0]  memoryBlock[DATADEPTH-1:0];


    always_ff @(posedge writeClk) begin
        if (writeEn)
            memoryBlock[writeAddress] <= dataIn;
    end


    always_ff @(posedge readClk) begin
        dataOut <= memoryBlock[readAddress];
    end


endmodule

