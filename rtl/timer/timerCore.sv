

module timerCore(
    input   logic          clk,
    input   logic          reset,

    input   logic  [31:0]  timer1CountIn,
    input   logic  [31:0]  timer2CountIn,
    input   logic  [31:0]  timer3CountIn,
    input   logic  [31:0]  timer1ResetValueIn,
    input   logic  [31:0]  timer2ResetValueIn,
    input   logic  [31:0]  timer3ResetValueIn,
    input   logic  [2:0]   interruptEnableIn,

    input   logic          timer1CountLoadEn,
    input   logic          timer2CountLoadEn,
    input   logic          timer3CountLoadEn,
    input   logic          timer1ResetValueLoadEn,
    input   logic          timer2ResetValueLoadEn,
    input   logic          timer3ResetValueLoadEn,
    input   logic          interruptEnableLoadEn,

    output  logic  [31:0]  timer1Count,
    output  logic  [31:0]  timer2Count,
    output  logic  [31:0]  timer3Count,
    output  logic  [31:0]  timer1ResetValue,
    output  logic  [31:0]  timer2ResetValue,
    output  logic  [31:0]  timer3ResetValue,
    output  logic  [2:0]   interruptEnable,
    output  logic  [2:0]   irq
    );


    logic  [31:0]  timer1ResetValueNext;
    logic  [31:0]  timer2ResetValueNext;
    logic  [31:0]  timer3ResetValueNext;
    logic  [2:0]   interruptEnableNext;
    logic          timer1Reset;
    logic          timer2Reset;
    logic          timer3Reset;
    logic          countEn;


    assign countEn = 1'b1; // could sync this to a reference clock or use a prescaler to only enable this every N clocks
    assign irq     = {timer3Reset & interruptEnable[2],
                      timer2Reset & interruptEnable[1],
                      timer1Reset & interruptEnable[0]};


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            timer1ResetValue <= 32'b0;
            timer2ResetValue <= 32'b0;
            timer3ResetValue <= 32'b0;
            interruptEnable  <= 3'b0;
        end else begin
            timer1ResetValue <= timer1ResetValueNext;
            timer2ResetValue <= timer2ResetValueNext;
            timer3ResetValue <= timer3ResetValueNext;
            interruptEnable  <= interruptEnableNext;
        end
    end


    always_comb begin
        timer1ResetValueNext = (timer1ResetValueLoadEn) ? timer1ResetValueIn : timer1ResetValue;
        timer2ResetValueNext = (timer2ResetValueLoadEn) ? timer2ResetValueIn : timer2ResetValue;
        timer3ResetValueNext = (timer3ResetValueLoadEn) ? timer3ResetValueIn : timer3ResetValue;
        interruptEnableNext  = (interruptEnableLoadEn)  ? interruptEnableIn  : interruptEnable;
    end


    timerUnit
    timerUnit1(
        .clk,
        .reset,
        .loadEn           (timer1CountLoadEn),
        .countEn,
        .dataIn           (timer1CountIn),
        .timerResetValue  (timer1ResetValue),
        .timerCount       (timer1Count),
        .timerReset       (timer1Reset)
    );


    timerUnit
    timerUnit2(
        .clk,
        .reset,
        .loadEn           (timer2CountLoadEn),
        .countEn,
        .dataIn           (timer2CountIn),
        .timerResetValue  (timer2ResetValue),
        .timerCount       (timer2Count),
        .timerReset       (timer2Reset)
    );


    timerUnit
    timerUnit3(
        .clk,
        .reset,
        .loadEn           (timer3CountLoadEn),
        .countEn,
        .dataIn           (timer3CountIn),
        .timerResetValue  (timer3ResetValue),
        .timerCount       (timer3Count),
        .timerReset       (timer3Reset)
    );


endmodule

