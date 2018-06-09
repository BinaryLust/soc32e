

module regfileBank(
    input   logic          clk,
    input   logic          writeEnable,
    input   logic  [4:0]   writeAddress,
    input   logic  [31:0]  writeData,
    input   logic  [4:0]   readAddressA,
    input   logic  [4:0]   readAddressB,

    output  logic  [31:0]  readDataA,
    output  logic  [31:0]  readDataB
    );


    // data shows up in memory 1 cycle after we is asserted
    // and on the output 2 cycles after we is asserted
    simpleDualPortMemory #(.DATAWIDTH(32), .DATADEPTH(32))
    regfileMemoryBlockA(
        .clk,
        .writeEn        (writeEnable),
        .dataIn         (writeData),
        .readAddress    (readAddressA),
        .writeAddress   (writeAddress),
        .dataOut        (readDataA)
    );


    // data shows up in memory 1 cycle after we is asserted
    // and on the output 2 cycles after we is asserted
    simpleDualPortMemory #(.DATAWIDTH(32), .DATADEPTH(32))
    regfileMemoryBlockB(
        .clk,
        .writeEn        (writeEnable),
        .dataIn         (writeData),
        .readAddress    (readAddressB),
        .writeAddress   (writeAddress),
        .dataOut        (readDataB)
    );


endmodule

