

module sdramArbiter(
    input   logic          clk,
    input   logic          reset,
    input   logic          cpuChipEnable,
    input   logic          cpuRead,
    input   logic          cpuWrite,
    input   logic  [3:0]   cpuBwe,
    input   logic  [20:0]  cpuAddress,
    input   logic  [31:0]  cpuDataIn,
    output  logic          cpuWaitRequest,
    output  logic          cpuReadValid,
    output  logic  [31:0]  cpuDataOut,

    input   logic          videoChipEnable,
    input   logic          videoRead,
    //input   logic          videoWrite,
    //input   logic  [3:0]        videoBwe,
    input   logic  [20:0]  videoAddress,
    //input   logic  [31:0]  videoDataIn,
    output  logic          videoWaitRequest,
    output  logic          videoReadValid,
    output  logic  [31:0]  videoDataOut,

    output  logic          sdramChipEnable,
    output  logic          sdramRead,
    output  logic          sdramWrite,
    output  logic  [3:0]   sdramBwe,
    output  logic  [20:0]  sdramAddress,
    output  logic  [31:0]  sdramDataIn,
    input   logic          sdramWaitRequest,
    input   logic          sdramReadValid,
    input   logic  [31:0]  sdramDataOut
    );


    logic  readDest;


    always_comb begin
        // sdram outputs
        sdramChipEnable  = (cpuChipEnable || videoChipEnable);
        sdramRead        = (cpuRead || videoRead);
        sdramWrite       = cpuWrite;
        sdramBwe         = cpuBwe;
        sdramAddress     = (videoRead) ? videoAddress : cpuAddress; // give priority to video
        sdramDataIn      = cpuDataIn;

        // cpu outputs
        cpuWaitRequest   = ((cpuRead || cpuWrite) && videoRead) || sdramWaitRequest; // give priority to video
        cpuReadValid     = !readDest && sdramReadValid; // set if there is a read and its destination is zero
        cpuDataOut       = sdramDataOut;

        // video outputs
        videoWaitRequest = sdramWaitRequest;
        videoReadValid   = readDest && sdramReadValid; // set if there is a read and its destination is one
        videoDataOut     = sdramDataOut;
    end


    // read ownership fifo
    sdramArbiterFifo
    sdramArbiterFifo(
        .clk,
        .reset,
        .writeEn     ((cpuRead || videoRead) && !sdramWaitRequest),
        .readReq     (sdramReadValid),
        .dataIn      (videoRead), // output of 0 means the read goes to the cpu, output of 1 means the read goes to the video system
        .dataOut     (readDest)
    );


endmodule

