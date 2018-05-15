

module sigmaDeltaUnit(
    input   logic          clk,
    input   logic          reset,
    input   logic  [15:0]  clocksPerCycle,
    input   logic  [7:0]   dataIn,
    output  logic          pwmOut,
    output  logic          readReq
    );


    logic  [8:0]  accumulator;
    logic  [8:0]  accumulatorNext;
    logic  [7:0]  bitCount;
    logic  [7:0]  bitCountNext;
    logic  [15:0]  cycleCounter;
    logic  [15:0]  cycleCounterValue;


    assign pwmOut = accumulator[8];


    // sigma delta pwm accumulator register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            accumulator  <= 9'd0;
        else
            accumulator  <= accumulatorNext;
    end


    // bit count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            bitCount     <= 8'd0;
        else
            bitCount     <= bitCountNext;
    end


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 16'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    always_comb begin
        // defaults
        accumulatorNext   = accumulator;          // keep old value
        bitCountNext      = bitCount;             // keep old value
        readReq           = 1'b0;                 // don't request a read
        cycleCounterValue = cycleCounter + 16'd1; // increment

        if(cycleCounter >= clocksPerCycle) begin
            cycleCounterValue = 16'd1;                     // reset cycle counter
            accumulatorNext   = accumulator[7:0] + dataIn; // do add
            bitCountNext      = bitCount + 8'd1;           // increment bit count

            if(bitCount == 8'd254)
                readReq = 1'b1;
            else
                readReq = 1'b0;
        end
    end


endmodule

