

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
// pull clock low  // if data is already high we can just do nothing here, this is for repeated start only
// pull data high  // if data is already high we can just do nothing here, this is for repeated start only
// pull clock high // if data is already high we can just do nothing here, this is for repeated start only
// pull data low

// stop sequence is
// pull clock low  // if data is already low we can just do nothing here
// pull data low   // if data is already low we can just do nothing here
// pull clock high // if data is already low we can just do nothing here
// pull data high

// 7 bit address / 1 bit r/w register
// 8 bit byte count register // not really needed we can just keep reading/writing bytes when the go bit is set
// 8 bit data register read/write
// config register go bit, stop bit, cycles per clock, interrupt enable, ect
// status register busy, error, done, ect
// need synchronizers for input signals???

// have an 8 bit register that feeds directly to/from the sda tristate/input line

// in normal mode clock streching can happen during any scl low cycle, but in high speed mode
// clock streching is only allowed after the ack bit (and before the 1st bit of the next byte)

// should the clock streching check happen on cycle boundaries or constantly?

// it looks like clock streching can happen after a read or a write both, and even start/stop sequences...
// we need to check that the clock has actually gone high everytime we set it high.


module i2cUnit(
    input   logic         clk,
    input   logic         reset,

    input   logic  [1:0]  i2cCommand,             // the command we want to write to the slave
    input   logic  [7:0]  i2cWriteData,           // the data we want to write to the slave
    output  logic  [7:0]  i2cReadData,            // the data that was read from the slave
    input   logic         i2cWriteAck,            // the ack bit that we want to write to the slave after a receiving a byte
    output  logic         i2cReadAck,             // the ack bit from the slave after transmitting a byte

    input   logic         cycleDone,              // this signals when a cycle is complete
    input   logic         i2cTransactionValid,    // this line tells this core when a transaction is ready to be processed
    output  logic         i2cBusy,                // this signals if the core is busy or not
    output  logic         i2cWriteDataAck,        // this signals when the write data has been used
    output  logic         i2cReadDataValid,       // this signals that the data on the read data lines is valid

    inout   logic         i2cScl,                 // i2c clock
    inout   logic         i2cSda                  // i2c data
    );


    typedef  enum  logic  [3:0]
    {
        IDLE   = 4'd0,
        INIT1  = 4'd1,
        INIT2  = 4'd2,
        INIT3  = 4'd3,
        INIT4  = 4'd4,
        CYCLE1 = 4'd5,
        CYCLE2 = 4'd6,
        CYCLE3 = 4'd7,
        CYCLE4 = 4'd8
    }   states;


    states         state;
    states         nextState;
    logic   [3:0]  bitCounter;
    logic   [3:0]  bitCounterNext;
    logic   [7:0]  dataReg;
    logic   [7:0]  dataRegNext;
    logic          ackReg;
    logic          ackRegNext;
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
            bitCounter <= 4'd0;
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


    // ack register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ackReg <= 8'd0;
        else
            ackReg <= ackRegNext;
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
    assign i2cReadData = dataReg;
    assign i2cReadAck  = ackReg;


    // combinationial logic
    always_comb begin
        // defaults
        nextState        = IDLE;       // go to idle
        bitCounterNext   = bitCounter; // keep old value
        dataRegNext      = dataReg;    // keep old value
        ackRegNext       = ackReg;     // keep old value
        sclOutNext       = sclOut;     // keep old value
        sdaOutNext       = sdaOut;     // keep old value
        i2cBusy          = 1'b1;       // signal busy
        i2cWriteDataAck  = 1'b0;       // signal not ack
        i2cReadDataValid = 1'b0;       // read not valid


        case(state)
            IDLE: begin // reset counters, keep clock and data line high, and keep i2cBusy low
                bitCounterNext = 4'd0;
                i2cBusy        = 1'b0;
                if(!reset && i2cTransactionValid) begin
                    case(i2cCommand)
                        2'b10: begin
                            dataRegNext = i2cWriteData;   // set data reg to input data
                            i2cWriteDataAck = 1'b1;       // signal ack
                        end

                        2'b11: begin
                            ackRegNext = i2cWriteAck;     // set ack reg to input ack
                            i2cWriteDataAck = 1'b1;       // signal ack
                        end
                    endcase

                // next state logic
                    case(i2cCommand)
                        2'b00, 2'b01: nextState = INIT1;  // start/stop command
                        2'b10, 2'b11: nextState = CYCLE1; // transmit/receive command
                    endcase
                end
            end

            INIT1: begin // start/stop = pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? INIT2 : INIT1;
            end

            INIT2: begin // start = pull data high, stop = pull data low
                if(cycleDone) begin
                    if(i2cCommand == 2'b00) sdaOutNext = 1'b1;
                    if(i2cCommand == 2'b01) sdaOutNext = 1'b0;
                end

                // next state logic
                nextState = (cycleDone) ? INIT3 : INIT2;
            end

            INIT3: begin // start/stop = pull clock high
                if(cycleDone) sclOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? INIT4 : INIT3;
            end

            INIT4: begin // start = pull data low, stop = pull data high
                if(cycleDone) begin
                    if(i2cCommand == 2'b00) sdaOutNext = 1'b0;
                    if(i2cCommand == 2'b01) sdaOutNext = 1'b1;
                end

                // next state logic
                nextState = (cycleDone) ? IDLE : INIT4;
            end

            CYCLE1: begin // TX/RX = pull clock low
                if(cycleDone) sclOutNext = 1'b0;

                // next state logic
                nextState = (cycleDone) ? CYCLE2 : CYCLE1;
            end

            CYCLE2: begin // TX = put data on line, RX = wait for data to be put on line
                if(cycleDone) begin
                    if(bitCounter == 4'd8) begin // ack bit
                        if(i2cCommand == 2'b10) sdaOutNext = 1'b1;       // for tx ack bits set sda to high-z
                        if(i2cCommand == 2'b11) sdaOutNext = ackReg;     // for rx ack bits set sda to ackReg value
                    end else begin               // normal bits
                        if(i2cCommand == 2'b10) sdaOutNext = dataReg[7]; // for tx bits set sda to msb of data
                        if(i2cCommand == 2'b11) sdaOutNext = 1'b1;       // for rx bits set sda to high-z
                    end
                end

                // next state logic
                nextState = (cycleDone) ? CYCLE3 : CYCLE2;
            end

            CYCLE3: begin // TX/RX = pull clock high
                if(cycleDone) sclOutNext = 1'b1;

                // next state logic
                nextState = (cycleDone) ? CYCLE4 : CYCLE3;
            end

            CYCLE4: begin // TX/RX = check that clock is acually high
                if(cycleDone && (sclIn == 1'b1)) begin            // if the clock is high
                    if(bitCounter == 4'd8) begin                  // ack bit
                        i2cReadDataValid = 1'b1;                  // send read valid signal // should be pipelined i think?
                        // set sda back to 1 here
                        if(i2cCommand == 2'b10)
                            ackRegNext   = sdaIn;                 // for tx capture ack value in ack register
                        if(i2cCommand == 2'b11)
                            sdaOutNext   = 1'b1;                  // for rx set sda to high-z

                        // next state logic
                        nextState        = IDLE;
                    end else begin                                // normal bits
                        bitCounterNext   = bitCounter + 4'd1;     // increment bit count
                        dataRegNext      = {dataReg[6:0], sdaIn}; // capture data and left shift it // this works for both TX and RX

                        // next state logic
                        nextState        = CYCLE1;
                    end
                end else begin
                    // next state logic
                    nextState = CYCLE4;
                end
            end

            //default:
        endcase
    end


endmodule

