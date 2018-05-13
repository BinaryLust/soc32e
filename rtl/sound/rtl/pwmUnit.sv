

module pwmUnit(
    input   logic          clk,
    input   logic          reset,
    input   logic  [15:0]  clocksPerCycle,
    input   logic  [7:0]   dataIn,
    output  logic          pwmOut,
    output  logic          readReq
    );


    logic  [3:0]   repeatCount;
    logic  [3:0]   repeatCountNext;
    logic  [7:0]   pwmCount;
    logic  [7:0]   pwmCountNext;
    logic  [7:0]   pwmLimit;
    logic  [7:0]   pwmLimitNext;
    logic  [15:0]  cycleCounter;
    logic  [15:0]  cycleCounterValue;
    logic          pwmOutNext;


    // repeat counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            repeatCount <= 4'd1;
        else
            repeatCount <= repeatCountNext;
    end


    // pwm counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            pwmCount <= 8'd0;
        else
            pwmCount <= pwmCountNext;
    end


    // pwm limit register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            pwmLimit <= 8'd0;
        else
            pwmLimit <= pwmLimitNext;
    end


    // cycle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cycleCounter <= 16'd1;
        else
            cycleCounter <= cycleCounterValue;
    end


    // pwm output value register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            pwmOut <= 1'd1;
        else
            pwmOut <= pwmOutNext;
    end


    always_comb begin
        // defaults
        repeatCountNext   = repeatCount;          // keep old value
        pwmCountNext      = pwmCount;             // keep old value
        pwmLimitNext      = pwmLimit;             // keep old value
        cycleCounterValue = cycleCounter + 16'd1; // increment
        readReq           = 1'b0;                 // don't request to read


        if(cycleCounter >= clocksPerCycle) begin
            cycleCounterValue = 16'd1;        // reset cycle counter

            pwmCountNext = pwmCount + 8'd1;   // increment pwm counter

            if(repeatCount == 4'd8) begin
                if(pwmCount == 8'd254)                // request a read of data
                    readReq = 1'b1;

                if(pwmCount == 8'd255) begin          // load new limit data
                    pwmLimitNext = dataIn;
                    repeatCountNext = 4'd1;           // reset repeat counter
                end
            end else begin
                if(pwmCount == 8'd255)
                    repeatCountNext = repeatCount + 4'd1; // increment repeat count
            end
        end


        if(pwmCount > pwmLimit)               // set new output value
            pwmOutNext = 1'b0;                // use (pwmCount >= pwmLimit) if you need to be able to
        else                                  // keep the output fully off
            pwmOutNext = 1'b1;
    end


endmodule

