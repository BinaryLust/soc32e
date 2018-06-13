

module systemRamBlock(
    input   logic          clk,
    input   logic          writeEn,
    input   logic  [3:0]   bwe,
    input   logic  [31:0]  dataIn,
    input   logic  [11:0]  address,
    output  logic  [31:0]  dataOut
    );


    logic  [3:0][7:0]  memoryBlock[4095:0];
    logic  [11:0]      addressReg;
    //logic  [31:0]      dataOutReg;


    // initialize to all 0's for simulation
    initial begin : INIT
        // use this to predefine memory contents in a file
        //$readmemh("init.txt, memoryBlock);

        integer i;
        for(i = 0; i < 4096; i++)
            memoryBlock[i] = 32'b0;
    end


    always_ff @(posedge clk) begin
        if(writeEn) begin
            if(bwe[0]) memoryBlock[address][0] <= dataIn[7:0];
            if(bwe[1]) memoryBlock[address][1] <= dataIn[15:8];
            if(bwe[2]) memoryBlock[address][2] <= dataIn[23:16];
            if(bwe[3]) memoryBlock[address][3] <= dataIn[31:24];
        end

        addressReg <= address;
        //dataOutReg <= memoryBlock[addressReg];
        dataOut <= memoryBlock[addressReg];
    end


    //always_ff @(posedge clk) begin
        //dataOut <= dataOutReg;
    //end


    // return new data
    //assign dataOut = memoryBlock[addressReg];
    //assign dataOut = dataOutReg;


endmodule

