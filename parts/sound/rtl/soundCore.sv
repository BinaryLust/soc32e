

module soundCore(
    input   logic          clk,
    input   logic          reset,

    input   logic  [7:0]   bufferDataIn,     // data from the master interface
    input   logic  [15:0]  clocksPerCycleIn, // data from the master interface
    input   logic          soundIreIn,       // data from the master interface

    input   logic          bufferLoadEn,     // write enable from the master interface
    input   logic          configLoadEn,     // write enable from the master interface

    output  logic  [9:0]   wordCount,        // visible state to the master interface
    output  logic  [15:0]  clocksPerCycle,   // visible state to the master interface
    output  logic          soundIre,         // visible state to the master interface

    output  logic          soundIrq,

    output  logic          pwmOut
    );


    logic         readReq;
    logic  [7:0]  bufferDataOut;
    logic  [9:0]  wordCountP1;
    logic  [9:0]  wordCountP2;


    //assign soundIrq = ((wordCount == 128) && (wordCountP1 == 129) && (wordCountP2 == 130) && (readReq && soundIre));


    //------------------------------------------------
    // visible registers


    // for pwm see below
    // 16'd567; // set to 22050 Hz default play rate ((100MHz \ 22050) \ 8) = 566.893 cycles
    //
    // clocksPerCycle register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            clocksPerCycle <= 16'd18; // set to 22050 Hz default play rate ((22050 * 256 samples) \ 100MHz) = 17.715 clocks per sample
        else if(configLoadEn)
            clocksPerCycle <= clocksPerCycleIn;
        else
            clocksPerCycle <= clocksPerCycle;
    end


    // sound interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            soundIre <= 1'd0;
        else if(configLoadEn)
            soundIre <= soundIreIn;
        else
            soundIre <= soundIre;
    end


    //------------------------------------------------
    // hidden registers


    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            soundIrq <= 1'b0;
        else
            soundIrq <= ((wordCount == 128) && (wordCountP1 == 129) && (wordCountP2 == 130) && (readReq && soundIre));
    end


    // previous word count registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            wordCountP1 <= 1'd0;
            wordCountP2 <= 1'd0;
        end else if(readReq) begin      // update the count when the buffer is read from
            wordCountP1 <= wordCount;   // last cycle
            wordCountP2 <= wordCountP1; // two cycles ago
        end
    end


    buffer
    buffer(
        .clk,
        .reset,
        .writeEn           (bufferLoadEn),
        .readReq,
        .dataIn            (bufferDataIn),
        .dataOut           (bufferDataOut),
        .wordCount
    );


    sigmaDeltaUnit
    sigmaDeltaUnit(
        .clk,
        .reset,
        .clocksPerCycle,
        .dataIn            (bufferDataOut),
        .pwmOut,
        .readReq
    );


    /*pwmUnit
    pwmUnit(
        .clk,
        .reset,
        .clocksPerCycle,
        .dataIn      (bufferDataOut),
        .pwmOut,
        .readReq
    );*/


endmodule

