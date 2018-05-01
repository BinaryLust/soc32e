

// we can build this in a couple of ways
// 1: we simply send or receive a single piece of data each time, send the address and start sequence every time
// 2: we can send or receive single data each time, but have a fifo to queue them up for both address and data, send the start sequence every time
// 3: we can have a fifo and send or receive multiple pieces of data each time and only send the address and start sequence once

// if we receive NACK instead of ACK we should send a stop sequence, and set an error bit
// we can send start sequences one after the other without sending stop sequences, this is good for multiple master setups
// if there are multiple masters and they try driving data at the exact same time, the first master that sees a mismatch of its data on the sda line loses arbitration and waits.


// data bit changes when clock is low
// msb first

// transmit
// 1: send start sequence
// 2: send 7 bit address and write bit
// 3: send 8 bit data
// 4: send stop sequence

// receive
// 1: send start sequence
// 2: send 7 bit address and read bit
// 3: receive 8 bit data
// 4: send stop sequence

// method 1 (manual start/stop)
// have start and stop bits in the config register
// when set these force the controller to generate start or stop sequences
//
// method 2 (automatic start/stop)
// have a transfer count register when the set amount of transfers has happened the
// controller will automatically generate a stop sequence

// for clock streching
// transfer 8 data bits, on the 9th bit the slave drives the clock and may hold it low until it is ready.

// 0: data register    // read/write
// 1: address register // read/write
// 2: config register  // read/write
// 3: status register  // read only


// config register bits
// start/go bit    // starts the i2c transaction
// abort/stop bit  // stops the i2c transaction
// clocksPerCycle
// transmit interrupt enable
// receive interrupt enable
// byte/transfer count??? maybe


// status register
// busy
// error
// transmit ready??
// receive valid???


// initial sequence (common to read and write)
// wait for start bit to be set
// when set generate start sequence
// transmit address and r/w bit, release bus
// wait for slave to send ack bit, it may clock stretch

// for reads
// wait for slave to transmit data, then claim bus
// send ack or nack go to idle state and wait for data to be read by cpu, after keep looping if more data is expected
// send repeated start, or stop sequence
// to back to initial state

// start sequence is
// pull clock low  // the first 2 cycles are to ensure that the data line is high for the last 2 cycles
// pull data high
// pull clock high
// pull data low

// stop sequence is
// pull clock low  // the first 2 cycles are to ensure that the data line is low for the last 2 cycles
// pull data low
// pull clock high
// pull data high

// 7 bit address / 1 bit r/w register
// 8 bit byte count register // not really needed we can just keep reading/writing bytes when the go bit is set
// 8 bit data register read/write
// config register go bit, stop bit, cycles per clock, interrupt enable, ect
// status register busy, error, done, ect
// need synchronizers for input signals???

// have an 8 bit register that feeds directly to/from the sda tristate/input line


module i2cUnit(
    input   logic         clk,
    input   logic         reset,

    input   logic  [1:0]  i2cCommand,             // the command we want to write to the slave
    input   logic  [7:0]  i2cWriteData,           // the data we want to write to the slave
    output  logic  [7:0]  i2cReadData,            // the data that was read from the slave

    input   logic         cycleDone,              // this signals when a cycle is complete
    input   logic         i2cTransactionValid,    // this line tells this core when a transaction is ready to be processed
    output  logic         i2cBusy,                // this signals if the core is busy or not
    output  logic         i2cWriteAck,            // this signals when the write data has been used
    output  logic         i2cReadDataValid,       // this signals that the data on the read data lines is valid

    inout   logic         i2cScl,                 // i2c clock
    inout   logic         i2cSda                  // i2c data
    );


    typedef  enum  logic  [4:0]
    {
        IDLE   = 5'd0,
        START1 = 5'd1,
        START2 = 5'd2,
        START3 = 5'd3,
        START4 = 5'd4,
        STOP1  = 5'd5,
        STOP2  = 5'd6,
        STOP3  = 5'd7,
        STOP4  = 5'd8,
        TX1    = 5'd9,
        TX2    = 5'd10,
        TX3    = 5'd11,
        TX4    = 5'd12,
        TXACK1 = 5'd13,
        TXACK2 = 5'd14,
        TXACK3 = 5'd15,
        TXACK4 = 5'd16
    }   states;


    states         state;
    states         nextState;
    logic   [2:0]  bitCounter;
    logic   [2:0]  bitCounterNext;
    logic          bitsDone;
    logic   [7:0]  dataReg;
    logic   [7:0]  dataRegNext;
    logic          sclOutNext;
    logic          sclOut;
    logic          sclIn;
    logic          sdaOutNext;
    logic          sdaOut;
    logic          sdaIn;


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
            bitCounter <= 3'd0;
        else
            bitCounter <= bitCounterNext;
    end


    // data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataReg <= 8'd0;
        else
            dataReg <= dataRegNext;
    end


    // i2c clock input register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sclIn <= 1'b1; // reset to default value for the current mode
        else
            sclIn <= i2cScl;
    end


    // i2c clock output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sclOut <= 1'b1; // reset to default value for the current mode
        else
            sclOut <= sclOutNext;
    end


    // i2c data input register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sdaIn <= 1'b1; // reset to default value for the current mode
        else
            sdaIn <= i2cSda;
    end


    // i2c data output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            sdaOut <= 1'b1; // reset to default value for the current mode
        else
            sdaOut <= sdaOutNext;
    end


    assign i2cScl      = (sclOut) ? 1'bz : 1'b0; // either high-z when we need a high state or pull low for low state
    //assign sclIn       = i2cScl;
    assign i2cSda      = (sdaOut) ? 1'bz : 1'b0; // either high-z when we need a high state or pull low for low state
    //assign sdaIn       = i2cSda;
    assign bitsDone    = (bitCounter == 3'd7);
    assign i2cReadData = dataReg;


    // combinationial logic
    always_comb begin
        // defaults
        nextState        = IDLE;       // go to idle
        bitCounterNext   = bitCounter; // keep old value
        dataRegNext      = dataReg;    // keep old value
        sclOutNext       = sclOut;     // keep old value
        sdaOutNext       = sdaOut;     // keep old value
        i2cBusy          = 1'b1;       // signal busy
        i2cWriteAck      = 1'b0;       // signal not ack
        i2cReadDataValid = 1'b0;       // read not valid


        case(state)
            IDLE: begin // reset counters, keep clock and data line high, and keep i2cBusy low
                bitCounterNext = 3'd0;
                i2cBusy        = 1'b0;
                if(cycleDone && i2cTransactionValid) begin
                    if(i2cCommand == 2'b10) begin
                        dataRegNext = i2cWriteData; // set data reg to input data
                        i2cWriteAck = 1'b1;         // signal ack
                    end
                end

                // next state logic
                if(cycleDone && i2cTransactionValid) begin
                    case(i2cCommand)
                        2'b00: nextState = START1; // start command
                        2'b01: nextState = STOP1;  // stop command
                        2'b10: nextState = TX1;    // transmit command
                        2'b11: ; // receive command
                    endcase
                end
            end

            START1: begin // pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? START2 : START1;
            end

            START2: begin // pull data high
                if(cycleDone) sdaOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? START3 : START2;
            end

            START3: begin // pull clock high
                if(cycleDone) sclOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? START4 : START3;
            end

            START4: begin // pull data low
                if(cycleDone) sdaOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? IDLE : START4;
            end

            STOP1: begin // pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? STOP2 : STOP1;
            end

            STOP2: begin // pull data low
                if(cycleDone) sdaOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? STOP3 : STOP2;
            end

            STOP3: begin // pull clock high
                if(cycleDone) sclOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? STOP4 : STOP3;
            end

            STOP4: begin // pull data high
                if(cycleDone) sdaOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? IDLE : STOP4;
            end

            TX1: begin // pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? TX2 : TX1;
            end

            TX2: begin // put data on line
                if(cycleDone) sdaOutNext = dataReg[7]; // set sda to msb of data

                // next state logic
                nextState = (cycleDone) ? TX3 : TX2;
            end

            TX3: begin // pull clock high
                if(cycleDone) sclOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? TX4 : TX3;
            end

            TX4: begin // check for end of bits
                if(cycleDone) begin
                    dataRegNext    = {dataReg[6:0], 1'b0}; // left shift data
                    bitCounterNext = bitCounter + 3'd1;    // increment bit count
                end

                // next state logic
                if(cycleDone) begin
                    nextState = (bitsDone) ? TXACK1 : TX1;
                end else begin
                    nextState = TX4;
                end
            end

            TXACK1: begin // pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? TXACK2 : TXACK1;
            end

            TXACK2: begin // wait for the slave to put the ack bit on the data line
                if(cycleDone) sdaOutNext = 1'b1; // set sda to high-z to let the slave put data it

                // next state logic
                nextState = (cycleDone) ? TXACK3 : TXACK2;
            end

            TXACK3: begin // pull clock high
                if(cycleDone) begin
                    sclOutNext  = 1'b1;
                    dataRegNext = {7'b0, sdaIn}; // capture ack value in lsb of data register
                end

                // next state logic
                nextState = (cycleDone) ? TXACK4 : TXACK3;
            end

            TXACK4: begin // wait another cycle and return to idle state
                if(cycleDone) i2cReadDataValid = 1'b1; // send read valid signal

                // next state logic
                nextState = (cycleDone) ? IDLE : TXACK4;
            end

    //         STORE: begin // store the result to the receive register
    //             // output logic
    //             //cycleCounterValue      = cycleCounter + 16'b1;                  // increment cycle counter
    //             //bitCounterValue        = 1;                                     // reset bit count
    //             //transmitReady          = 1'b1;                                  // signal transmit ready
    //             //receiveValid           = 1'b1;                                  // signal receive valid
    //             //dataRegNext            = (transmitValid) ? dataRegIn : dataReg; // load new data or keep old value

    //             // next state logic
    //             nextState = (transmitValid) ? OUTPUT : STOP0;
    //         end

    //         STOP0: begin // reset clock to default state
    //             // output logic
    //             //sclkNext               = (cycleDone) ? clockPolarity : sclk;          // reset clock to default value at the end of the cycle

    //             // next state logic
    //             nextState = (cycleDone) ? STOP1 : STOP0;
    //         end

    //         STOP1: begin // deassert slave select and return to idle
    //             //ssNext                 = (cycleDone) ? 1'b1 : ss;

    //             // next state logic
    //             nextState = (cycleDone) ? IDLE : STOP1;
    //         end

            //default:
        endcase
    end


endmodule

