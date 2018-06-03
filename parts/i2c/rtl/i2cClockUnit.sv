

// this assumes a 100 MHz clock, which makes for a 100 KHz i2c clock
module i2cClockUnit(
    input   logic          clk,
    input   logic          reset,

    output  logic          firstCycle,
    output  logic          dataCycle,
    output  logic          finalCycle
    );


    logic  [8:0]  cycleCounter;
    logic  [8:0]  cycleCounterValue;


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 9'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    // combinationial logic
    assign firstCycle        = (cycleCounter == 9'd1);
    assign dataCycle         = (cycleCounter == 9'd100);
    assign finalCycle        = (cycleCounter >= 9'd500);
    assign cycleCounterValue = (finalCycle) ?  9'd1 : cycleCounter + 9'd1;


endmodule

