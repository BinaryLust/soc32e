

module randomCore(
    input   logic          clk,
    input   logic          reset,
    input   logic          writeEnable,
    input   logic  [31:0]  dataIn,

    output  logic  [31:0]  randomValue
    );


    logic  [31:0]  valueNext;
    logic  [31:0]  randomValueNext;


    // random value register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            randomValue = 32'b1;
        else
            randomValue = valueNext;
    end


    // random value regiseter next value mux
    assign valueNext = (writeEnable) ? dataIn : randomValueNext;


    // Galois Linear Feedback Shift Register Logic
    always_comb begin
        // the taps for a 32 bit Galois lfsr are
        // the 32th bit (bit 0) because this is a rotating register
        // the 30th bit
        // the 26th bit
        // the 25th bit

        randomValueNext[31] = randomValue[0];
        randomValueNext[30] = randomValue[31];
        randomValueNext[29] = randomValue[30] ^ randomValue[0];
        randomValueNext[28] = randomValue[29];
        randomValueNext[27] = randomValue[28];
        randomValueNext[26] = randomValue[27];
        randomValueNext[25] = randomValue[26] ^ randomValue[0];
        randomValueNext[24] = randomValue[25] ^ randomValue[0];
        randomValueNext[23] = randomValue[24];
        randomValueNext[22] = randomValue[23];
        randomValueNext[21] = randomValue[22];
        randomValueNext[20] = randomValue[21];
        randomValueNext[19] = randomValue[20];
        randomValueNext[18] = randomValue[19];
        randomValueNext[17] = randomValue[18];
        randomValueNext[16] = randomValue[17];
        randomValueNext[15] = randomValue[16];
        randomValueNext[14] = randomValue[15];
        randomValueNext[13] = randomValue[14];
        randomValueNext[12] = randomValue[13];
        randomValueNext[11] = randomValue[12];
        randomValueNext[10] = randomValue[11];
        randomValueNext[9]  = randomValue[10];
        randomValueNext[8]  = randomValue[9];
        randomValueNext[7]  = randomValue[8];
        randomValueNext[6]  = randomValue[7];
        randomValueNext[5]  = randomValue[6];
        randomValueNext[4]  = randomValue[5];
        randomValueNext[3]  = randomValue[4];
        randomValueNext[2]  = randomValue[3];
        randomValueNext[1]  = randomValue[2];
        randomValueNext[0]  = randomValue[1];
    end


endmodule

