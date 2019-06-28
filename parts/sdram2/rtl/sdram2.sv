

module sdram2(
    input   logic          clk,
    input   logic          reset,
    input   logic          chipEnable,
    input   logic          read,
    input   logic          write,
    input   logic  [3:0]   bwe,
    input   logic  [23:0]  address,
    input   logic  [31:0]  dataIn,

    output  logic          waitRequest,
    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic  [12:0]  externalSdramAddress, // changed from 12 to 13 bits
    output  logic  [1:0]   externalSdramBa,
    output  logic          externalSdramCas,
    output  logic          externalSdramCke,
    output  logic          externalSdramCs,
    inout   wire   [15:0]  externalSdramDq,
    output  logic  [1:0]   externalSdramDqm,
    output  logic          externalSdramRas,
    output  logic          externalSdramWe
    );


    logic          wordCount;
    logic          readCount;
    logic  [1:0]   bweMux;
    logic  [15:0]  dataInMux;
    logic  [15:0]  readDataReg;


    logic          sdramWaitRequest;
    logic          sdramValid;
    logic  [15:0]  sdramData;


    // data output
    assign dataOut     = {readDataReg, sdramData};


    // wait request logic
    assign waitRequest = (read || write) && ((wordCount == 1'b0) || sdramWaitRequest);


    // read valid logic
    assign readValid   = (readCount == 1'b1) && sdramValid;


    // word counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            wordCount <= 1'b0;
        else if((read || write) && !sdramWaitRequest) // advance the counter if read/write is active unless the sdram controller requests a wait
            wordCount <= !wordCount;
        else
            wordCount <= wordCount;
    end


    // read counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readCount <= 1'b0;
        else if (sdramValid)            // advance the count everytime we detect a valid output word
            readCount <= !readCount;
        else
            readCount <= readCount;
    end


    // read data register
    always_ff @(posedge clk) begin
        if((readCount == 1'b0) && sdramValid)
            readDataReg <= sdramData;   // store the first word
        else
            readDataReg <= readDataReg; // keep old data
    end


    // bwe select
    always_comb begin
        case(wordCount)
            1'b0: bweMux = ~bwe[3:2];
            1'b1: bweMux = ~bwe[1:0];
        endcase
    end


     // data in select
     always_comb begin
        case(wordCount)
            1'b0: dataInMux = dataIn[31:16];
            1'b1: dataInMux = dataIn[15:0];
        endcase
    end


    sdram_controller_32Mx16
    sdram_controller_32Mx16(
        .az_addr                ({address, wordCount}),
        .az_be_n                (bweMux),
        .az_cs                  (chipEnable),
        .az_data                (dataInMux),
        .az_rd_n                (!read),
        .az_wr_n                (!write),
        .clk,
        .reset_n                (!reset),
        .za_data                (sdramData),
        .za_valid               (sdramValid),
        .za_waitrequest         (sdramWaitRequest),
        .zs_addr                (externalSdramAddress),
        .zs_ba                  (externalSdramBa),
        .zs_cas_n               (externalSdramCas),
        .zs_cke                 (externalSdramCke),
        .zs_cs_n                (externalSdramCs),
        .zs_dq                  (externalSdramDq),
        .zs_dqm                 (externalSdramDqm),
        .zs_ras_n               (externalSdramRas),
        .zs_we_n                (externalSdramWe)
    );

endmodule

