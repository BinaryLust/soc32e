

module trueDualPortDualClockMemory
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(

    input   logic                      clkA,
    input   logic                      writeEnA,
    input   logic  [DATAWIDTH-1:0]     dataInA,
    input   logic  [ADDRESSWIDTH-1:0]  addressA,
    output  logic  [DATAWIDTH-1:0]     dataOutA,

    input   logic                      clkB,
    input   logic                      writeEnB,
    input   logic  [DATAWIDTH-1:0]     dataInB,
    input   logic  [ADDRESSWIDTH-1:0]  addressB,
    output  logic  [DATAWIDTH-1:0]     dataOutB
    );


    logic  [DATAWIDTH-1:0]  memoryBlock[DATADEPTH-1:0];


    // initialize to all 0's for simulation
    initial begin : INIT
        integer i;
        for(i = 0; i < DATADEPTH; i++)
            memoryBlock[i] = {DATAWIDTH{1'b0}};
    end


    // port A
    always_ff @(posedge clkA) begin
        if(writeEnA) begin
            memoryBlock[addressA] <= dataInA;
            dataOutA <= dataInA;
        end else begin
            dataOutA <= memoryBlock[addressA];
        end
    end


    // port B
    always_ff @(posedge clkB) begin
        if(writeEnB) begin
            memoryBlock[addressB] <= dataInB;
            dataOutB <= dataInB;
        end else begin
            dataOutB <= memoryBlock[addressB];
        end
    end


endmodule

