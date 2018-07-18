

// this assumes a 100 MHz clock
module spiClockUnit(
    input   logic          clk,
    input   logic          reset,
    input   logic  [15:0]  clocksPerCycle,
    output  logic          finalCycle
    );


    logic  [15:0]  cycleCounter;
    logic  [15:0]  cycleCounterValue;


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 16'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    // combinationial logic
    assign finalCycle        = (cycleCounter >= clocksPerCycle);
    assign cycleCounterValue = (finalCycle) ?  16'd1 : cycleCounter + 16'd1;


endmodule

