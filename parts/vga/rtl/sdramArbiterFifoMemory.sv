

module sdramArbiterFifoMemory(
    input   logic         clk,
    input   logic         writeEn,
    input   logic         dataIn,
    input   logic  [3:0]  readAddress,
    input   logic  [3:0]  writeAddress,
    output  logic         dataOut
    );


    logic  memoryBlock[15:0];


    always_ff @(posedge clk) begin
        if (writeEn)
            memoryBlock[writeAddress] <= dataIn;

        dataOut <= memoryBlock[readAddress];
    end


endmodule

