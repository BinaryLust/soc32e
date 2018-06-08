

// this assumes a 100 MHz clock, which makes for a 1 MHz ethernet smi clock
module ethernetSmiClockUnit(
    input   logic          clk,
    input   logic          reset,

    output  logic          finalCycle
    );


    logic  [5:0]  cycleCounter;
    logic  [5:0]  cycleCounterValue;


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 6'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    // combinationial logic
    assign finalCycle        = (cycleCounter >= 6'd50);
    assign cycleCounterValue = (finalCycle) ? 6'd1 : cycleCounter + 6'd1;


endmodule

