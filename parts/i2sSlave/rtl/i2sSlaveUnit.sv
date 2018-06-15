
// samples are always 16 bits to simplify things


module i2sSlaveUnit(
    input   logic          clk,
    input   logic          reset,
    input   logic          sampleSize,
    input   logic          stereoMode,
    input   logic          playback,
    input   logic  [31:0]  sampleData,
    output  logic          readReq,

    input   logic          wclk,
    input   logic          bclk,
    input   logic          sdin,
    output  logic          sdout
    );


    typedef  enum  logic  [2:0]
    {
        IDLE   = 3'd0,
        WAIT   = 3'd1,
        SAMPLE = 3'd2,
        CYCLE1 = 3'd3,
        CYCLE2 = 3'd4
    }   states;


    states         state;
    states         nextState;
    logic  [15:0]  sample;
    logic  [15:0]  sampleNext;
    logic  [1:0]   sampleCounter;
    logic  [1:0]   sampleCounterNext;
    logic  [4:0]   bitCounter;
    logic  [4:0]   bitCounterNext;
    logic          wclkReg;
    logic          wclkPrevReg;
    logic          wclkRose;
    logic          wclkFell;
    logic          syncBclk;
    logic          bclkReg;
    logic          bclkPrevReg;
    logic          bclkRose;
    logic          bclkFell;
    logic          sdoutNext;
    logic          readReqReg;
    logic          readReqRegNext;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= IDLE;
        else
            state <= nextState;
    end


    // serial data output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sdout <= 1'b0;
        else
            sdout <= sdoutNext;
    end


    // read request register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readReqReg <= 1'd0;
        else
            readReqReg <= readReqRegNext;
    end


    // sample register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sample <= 16'd0;
        else
            sample <= sampleNext;
    end


    // sample counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sampleCounter <= 2'd0;
        else
            sampleCounter <= sampleCounterNext;
    end


    // bit counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            bitCounter <= 5'd1;
        else
            bitCounter <= bitCounterNext;
    end


    // wclk register // sample at rising edge of bclk
    always_ff @(posedge syncBclk or posedge reset) begin
        if(reset) begin
            wclkReg     <= 1'b0;
            wclkPrevReg <= 1'b0;
        end else begin
            wclkReg     <= wclk;
            wclkPrevReg <= wclkReg;
        end
    end


    // blck register
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            bclkReg     <= 1'b0;
            bclkPrevReg <= 1'b0;
        end else begin
            bclkReg     <= syncBclk;
            bclkPrevReg <= bclkReg;
        end
    end


    synchronizer
    bclkSynchronizer(
        .clk,
        .reset,
        .in       (bclk),
        .out      (syncBclk)
    );


    // detect rising and falling edge of wclk
    assign wclkRose = ( wclkReg && !wclkPrevReg);
    assign wclkFell = (!wclkReg &&  wclkPrevReg);


    // detect rising and falling edge of bclk
    assign bclkRose = ( bclkReg && !bclkPrevReg);
    assign bclkFell = (!bclkReg &&  bclkPrevReg);


    assign readReq = readReqReg;


    always_comb begin
        // defaults
        nextState         = IDLE;          // go to idle
        sampleNext        = sample;        // keep old value
        sampleCounterNext = sampleCounter; // keep old value
        bitCounterNext    = bitCounter;    // keep old value
        sdoutNext         = sdout;         // keep old value
        readReqRegNext    = 1'b0;          // signal no read request


        case(state)
            // wait for playback to be enabled and wclk falling edge
            IDLE: begin
                bitCounterNext    = 1'b1;
                sampleCounterNext = 1'b0;
                sdoutNext         = 1'b0;

                nextState = (playback && bclkRose && wclkFell) ? SAMPLE : IDLE;
            end


            // wait for word clock to change states
            WAIT: begin
                bitCounterNext = 1'b1;
                sdoutNext      = 1'b0;

                if(bclkRose) begin
                    if(playback) begin
                        nextState = (wclkRose || wclkFell) ? SAMPLE : WAIT;
                    end else begin
                        nextState = IDLE; // go back to idle since playback isn't enabled anymore
                    end
                end else begin
                    nextState = WAIT;
                end
            end


            // if necessary input a new sample from external modules
            SAMPLE: begin
                // if we are in stereo mode grab a sample every time
                // if we are in mono mode grab a sample only if word clock fell
                if((stereoMode && (wclkRose || wclkFell)) || (!stereoMode && wclkFell)) begin
                    if(sampleSize) begin // 16 bit mode
                        if(sampleCounter == 2'd1) begin
                            readReqRegNext    = 1'b1; // request new sample
                            sampleCounterNext = 2'd0; // reset sample count
                        end else begin
                            sampleCounterNext = sampleCounter + 2'd1; // increment sample count
                        end
                        case(sampleCounter[0])
                            1'b0:  sampleNext = sampleData[31:16];
                            1'b1:  sampleNext = sampleData[15:0];
                        endcase
                    end else begin // 8 bit mode
                        if(sampleCounter == 2'd3) begin
                            readReqRegNext    = 1'b1; // request new sample
                            sampleCounterNext = 2'd0; // reset sample count
                        end else begin
                            sampleCounterNext = sampleCounter + 2'd1; // increment sample count
                        end
                        case(sampleCounter)
                            2'b00: sampleNext = {sampleData[31:24], 8'b0};
                            2'b01: sampleNext = {sampleData[23:16], 8'b0};
                            2'b10: sampleNext = {sampleData[15:8],  8'b0};
                            2'b11: sampleNext = {sampleData[7:0],   8'b0};
                        endcase
                    end
                end
                nextState = CYCLE1;
            end


            // at bclk falling edge output new bit of sample
            CYCLE1: begin
                if(bclkFell) begin
                    if(bitCounter <= 5'd16) begin
                        sdoutNext  = sample[15];
                        sampleNext = {sample[14:0], sample[15]}; // rotate sample left by 1 bit

                        nextState = CYCLE2;
                    end else begin
                        nextState = WAIT;
                    end
                end else begin
                    nextState = CYCLE1;
                end
            end


            // at bclk rising edge capture new bit of sample
            CYCLE2: begin
                if(bclkRose) begin
                    //inSampleNext = {inSample[14:0], sdin}; // capure bit of input
                    bitCounterNext = bitCounter + 5'd1;

                    nextState = CYCLE1;
                end else begin
                    nextState = CYCLE2;
                end
            end


            //default: ;
        endcase
    end


endmodule

