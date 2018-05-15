

module timerUnit(
    input   logic          clk,
    input   logic          reset,
    input   logic          loadEn,
    input   logic          countEn,
    input   logic  [31:0]  dataIn,
    input   logic  [31:0]  timerResetValue,

    output  logic  [31:0]  timerCount,
    output  logic          timerReset
    );


    logic  [31:0]  timerCountNext;


     // register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            timerCount <= 32'd0;
        else
            timerCount <= timerCountNext;
    end


    // combinationial logic
    always_comb begin
        timerReset = (timerCount >= timerResetValue); // changed from ==

        if(loadEn)
            timerCountNext = dataIn;
        else if(countEn)
            timerCountNext = (timerReset) ?  32'd0 : timerCount + 32'd1; // reset or increment
        else
            timerCountNext = timerCount;                                 // old data
    end


endmodule

