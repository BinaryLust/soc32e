

module i2cClockUnit(
    input   logic          clk,
    input   logic          reset,

    //input   logic  [15:0]  clocksPerCycle, // the cycles of main clock we must count for a slave cycle to complete
    
    output  logic          cycleDone       // high when a full cycle is complete
    );


    logic  [7:0]  cycleCounter;
    logic  [7:0]  cycleCounterValue;


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 8'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    // combinationial logic
    assign cycleDone         = (cycleCounter >= 8'd250); // this assumes a 100 MHz clock, it outputs a 400 KHz done signal which makes for a 100 KHz i2c clock
    //assign halfCycle         = (cycleCounter == {1'b0, clocksPerCycle[15:1]}); // shift right one position to get the half cycle count
    assign cycleCounterValue = (cycleDone) ?  8'd1 : cycleCounter + 8'd1;    // reset at cycle end, else increment


endmodule

