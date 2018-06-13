

module singlePortByteEnMemory
    #(parameter BYTES        = 4,
      parameter DATADEPTH    = 256,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(

    input   logic                      clk,
    input   logic                      writeEn,
    input   logic  [BYTES-1:0]         bwe,
    input   logic  [BYTES-1:0][7:0]    dataIn,
    input   logic  [ADDRESSWIDTH-1:0]  address,
    output  logic  [BYTES-1:0][7:0]    dataOut
    );


    integer i;
    logic  [BYTES-1:0][7:0]    memoryBlock[DATADEPTH-1:0];
    logic  [ADDRESSWIDTH-1:0]  addressReg;


    // initialize to all 0's for simulation
    // initial begin : INIT
    //     // use this to predefine memory contents in a file
    //     //$readmemh("init.txt, memoryBlock);
    //     integer i;
    //     for(i = 0; i < DATADEPTH; i++)
    //         memoryBlock[i] = {BYTES*8{1'b0}};
    // end


    always_ff @(posedge clk) begin
        //generate
            //genvar i;

            //if(writeEn) begin
                for(i = 0; i < BYTES; i++) begin
                    //if(writeEn) begin
                        if(writeEn && bwe[i]) memoryBlock[address][i] <= dataIn[i];
                    //end
                end
            //end
        //endgenerate

        addressReg <= address;
    end


    // return new data
    assign dataOut = memoryBlock[addressReg];


endmodule

