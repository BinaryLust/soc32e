

// don't even look at clock polarity

// clock phase = 0
// output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// toggle clock, output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// ...

// clock phase = 1
// output data to mosi, and toggle clock, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// toggle clock, output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
//...

// the only difference between the two is toggling or not toggling the clock on the first cycle

// received data will always end up in dataReg

// polarity = 0, phase = 0: initially setup data half cycle early with no clock toggle, sample on the first clock edge (positive edge) and toggle clock, setup new data on second clock edge (falling edge) and toggle clock
// polarity = 0, phase = 1: setup data on first clock edge (positive edge) and toggle clock, sample on second clock edge (negative edge) and toggle clock
// polarity = 1, phase = 0: initially setup data half cycle early with no clock toggle, sample on the first clock edge (negative edge) and toggle clock, setup new data on second clock edge (rising edge) and toggle clock
// polarity = 1, pahse = 1: setup data on the first clock edge (negative edge) and toggle clock, sample on second clock edge (positive edge) and toggle clock

// for the ring buffer data and core lines are seperate data paths but each can only be read or written at any given time not both at the same time
// so we must make sure the states here only do one or the other per cycle


module spiUnit
    #(parameter DATAWIDTH       = 8,
      parameter BITCOUNTERWIDTH = $clog2(DATAWIDTH))(
    input   logic                   clk,
    input   logic                   reset,
    input   logic                   clockPolarity,
    input   logic                   clockPhase,
    input   logic                   dataDirection,

    input   logic                   finalCycle,

    input   logic  [DATAWIDTH-1:0]  dataRegIn,
    output  logic  [DATAWIDTH-1:0]  dataReg,
    input   logic                   transmitReady,
    output  logic                   coreWrite,
    output  logic                   coreRead,
    output  logic                   idle,

    input   logic                   miso,
    output  logic                   mosi,
    output  logic                   sclk
    );


    typedef  enum  logic  [2:0]
    {
        IDLE   = 3'd0,
        START  = 3'd1,
        OUTPUT = 3'd2,
        SAMPLE = 3'd3,
        CHECK  = 3'd4,
        STOP   = 3'd5
    }   states;


    states                       state;
    states                       nextState;
    logic   [BITCOUNTERWIDTH:0]  bitCounter;
    logic   [BITCOUNTERWIDTH:0]  bitCounterValue;
    logic   [DATAWIDTH-1:0]      dataRegNext;
    logic                        finalBit;
    logic                        mosiNext;
    logic                        sclkNext;
    logic                        coreReadNext;
    logic                        coreWriteNext;
    logic                        idleNext;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= IDLE;
        else
            state <= nextState;
    end


    // bit counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            bitCounter <= 1;
        else
            bitCounter <= bitCounterValue;
    end


    // data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataReg <= {DATAWIDTH{1'b0}};
        else
            dataReg <= dataRegNext;
    end


    // spi clock register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sclk <= 1'b0; // reset to default value for the current mode
        else
            sclk <= sclkNext;
    end


    // mosi register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            mosi <= 1'b0;
        else
            mosi <= mosiNext;
    end


    // coreRead register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreRead <= 1'b0;
        else
            coreRead <= coreReadNext;
    end


    // coreWrite register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreWrite <= 1'b0;
        else
            coreWrite <= coreWriteNext;
    end


    // idle register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            idle <= 1'b1;
        else
            idle <= idleNext;
    end


    assign finalBit = (bitCounter >= DATAWIDTH);


    // combinationial logic
    always_comb begin
        // defaults
        nextState       = IDLE;       // go to idle
        bitCounterValue = bitCounter; // keep old value
        dataRegNext     = dataReg;    // keep old data
        sclkNext        = sclk;       // keep old value
        coreWriteNext   = 1'b0;       // don't write to current point in buffer
        coreReadNext    = 1'b0;       // don't read from current point in buffer
        idleNext        = 1'b0;       // signal not idle
        mosiNext        = mosi;       // keep old data


        case(state)
            IDLE: begin // reset counters, and clock, and load new data
                // we could insert delay between bytes here and/or CHECK state by not moving to output state
                // until some counter hits a certain value.
                // ie nextState = (count > limit) ? NEXTSTATE : CURRENTSTATE;
                idleNext        = 1'b1;          // signal idle
                bitCounterValue = 1;             // reset the bit counter
                sclkNext        = clockPolarity; // reset clock to default value

                if(finalCycle && transmitReady) begin
                    dataRegNext    = dataRegIn;  // load new data
                    coreReadNext = 1'b1;         // read from current point in buffer
                end

                // next state logic
                nextState = (finalCycle && transmitReady) ? START : IDLE;
            end

            START: begin // send a new data bit to mosi line, and toggle clock if necessary
                if(finalCycle) begin
                    if(clockPhase)
                        sclkNext = !sclk; // toggle clock

                    case(dataDirection)
                        1'b0: mosiNext = dataReg[0];           // load mosi (lsb first)
                        1'b1: mosiNext = dataReg[DATAWIDTH-1]; // load mosi (msb first)
                    endcase
                end

                // next state logic
                nextState = (finalCycle) ? SAMPLE : START;
            end

            OUTPUT: begin // send a new data bit to mosi line, and toggle clock
                if(finalCycle) begin
                    sclkNext = !sclk; // toggle clock

                    case(dataDirection)
                        1'b0: mosiNext = dataReg[0];           // load mosi (lsb first)
                        1'b1: mosiNext = dataReg[DATAWIDTH-1]; // load mosi (msb first)
                    endcase
                end

                // next state logic
                nextState = (finalCycle) ? SAMPLE : OUTPUT;
            end

            SAMPLE: begin // shift in new data bit from miso, and toggle clock
                if(finalCycle) begin
                    sclkNext        = !sclk;          // toggle clock
                    case(dataDirection)
                        1'b0: dataRegNext = {miso, dataReg[DATAWIDTH-1:1]}; // right shift new data in
                        1'b1: dataRegNext = {dataReg[DATAWIDTH-2:0], miso}; // left shift new data in
                    endcase
                    if(finalBit) begin
                        bitCounterValue = 1;              // reset bit count
                        coreWriteNext   = 1'b1;           // write to current point in buffer
                    end else begin
                        bitCounterValue = bitCounter + 1; // increment bit count
                    end
                end

                // next state logic
                if(finalCycle) begin
                    nextState = (finalBit) ? CHECK : OUTPUT;
                end else begin
                    nextState = SAMPLE;
                end                
            end

            // if we want the inputs/outputs to be fully registered we have to add a SHIFT state back in right here to do a shift
            // before we store the value

            CHECK: begin // check if there is more data to transmit and read it in if so
                if(transmitReady) begin
                    dataRegNext  = dataRegIn; // load new data
                    coreReadNext = 1'b1;      // read from current point in buffer
                end

                // next state logic
                nextState = (transmitReady) ? OUTPUT : STOP;
            end

            // finish off the 2nd half of the spi cycle here before going to idle state
            // so that phase/polarity changes can be set instantly after external slave
            // select line has been deactived while controller is in idle state
            STOP: begin
                if(finalCycle)
                    sclkNext = clockPolarity; // reset clock to default value

                // next state logic
                nextState = (finalCycle) ? IDLE : STOP;
            end

            //default:
        endcase
    end


endmodule

