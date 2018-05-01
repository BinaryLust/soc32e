

module i2cClockUnit(
    input   logic          clk,
    input   logic          reset,

    input   logic  [15:0]  clocksPerCycle, // the cycles of main clock we must count for a slave cycle to complete
    
    output  logic          cycleDone,      // high when a full cycle is complete
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
    assign cycleDone         = (cycleCounter >= clocksPerCycle);
    //assign halfCycle         = (cycleCounter == {1'b0, clocksPerCycle[15:1]}); // shift right one position to get the half cycle count
    assign cycleCounterValue = (cycleDone) ?  16'd1 : cycleCounter + 16'd1;    // reset at cycle end, else increment


endmodule