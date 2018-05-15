

module regfileLiveValueTable(
    input   logic         clk,
    input   logic         reset,
    input   logic         writeEnableA,
    input   logic         writeEnableB,
    input   logic  [4:0]  writeAddressA,
    input   logic  [4:0]  writeAddressB,
    input   logic  [4:0]  readAddressA,
    input   logic  [4:0]  readAddressB,

    output  logic         bankSelectA,
    output  logic         bankSelectB
    );


    logic  [31:0]  liveValue;
    logic          portBValue;


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            liveValue <= 32'd0;
        end else if(writeEnableA || writeEnableB) begin
            if(writeEnableA) liveValue[writeAddressA] <= 1'b0;
            if(writeEnableB) liveValue[writeAddressB] <= portBValue;
        end else begin
            liveValue <= liveValue;
        end
    end


    always_comb begin
        // if we are writting to both write ports and the write address is the same, then give the assign the valid write to port A otherwise assign the value address to port B
        portBValue = ((writeEnableA && writeEnableB) && (writeAddressA == writeAddressB)) ? 1'b0 : 1'b1;


        // output multiplexers
        bankSelectA = liveValue[readAddressA];
        bankSelectB = liveValue[readAddressB];
    end


endmodule

