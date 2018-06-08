

// if opcode is 10 it's a read just transmit the first 14 bits of the write register, disconnect output after that, 2 bits
// later start clocking in the 16 bits of the read register

// if opcode is anything but 10 just do a normal 32 bit transmit of the write register

// we should have a line that loads the read register after a cycle and a seperate line that trips the read valid flag?

// it appears for some reason when receiving the postive edge of clk changes the value and we are supposed to latch the value
// on the negative edge...

// we should change this later to have 1 idle cycle before data is sent and 1 idle cycle after data is sent


module ethernetSmiUnit(
    input   logic               clk,
    input   logic               reset,

    input   logic  [31:0]       transmitData,   // the data we want to write to the slave
    output  logic  [15:0]       receiveData,    // the data that was read from the slave

    input   logic               finalCycle,

    input   logic               transmitValid,  // this line tells this core when a command is ready to be processed
    output  logic               transmitReady,  // this signals when the write data has been used
    output  logic               receiveValid,   // this signals that the data on the read data lines is valid
    output  logic               busy,           // this signals if the core is busy or not

    output  logic               mdc,
    inout   wire                mdio
    );


    typedef  enum  logic  [1:0]
    {
        IDLE   = 2'd0,
        CYCLE1 = 2'd1,
        CYCLE2 = 2'd2,
        FINISH = 2'd3
    }   states;


    states          state;
    states          nextState;
    logic   [5:0]   bitCounter;
    logic   [5:0]   bitCounterNext;
    logic   [2:0]   idleCounter;
    logic   [2:0]   idleCounterNext;
    logic   [15:0]  upperDataReg;
    logic   [15:0]  upperDataRegNext;
    logic   [15:0]  lowerDataReg;
    logic   [15:0]  lowerDataRegNext;
    logic   [1:0]   opcodeReg;
    logic   [1:0]   opcodeRegNext;
    logic           transmitReadyReg;
    logic           transmitReadyRegNext;
    logic           receiveValidReg;
    logic           receiveValidRegNext;

    logic           mdcNext;
    logic           mdioIn;
    logic           mdioOutReg;
    logic           mdioOutRegNext;
    logic           mdioOutEnReg;
    logic           mdioOutEnRegNext;


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
            bitCounter <= 6'd1;
        else
            bitCounter <= bitCounterNext;
    end


    // idle counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            idleCounter <= 3'd1;
        else
            idleCounter <= idleCounterNext;
    end


    // upper data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            upperDataReg <= 16'd0;
        else
            upperDataReg <= upperDataRegNext;
    end


    // lower data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            lowerDataReg <= 16'd0;
        else
            lowerDataReg <= lowerDataRegNext;
    end


    // opcode register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            opcodeReg <= 2'd0;
        else
            opcodeReg <= opcodeRegNext;
    end


    // transmitReady register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitReadyReg <= 1'd0;
        else
            transmitReadyReg <= transmitReadyRegNext;
    end


    // receiveValid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveValidReg <= 1'd0;
        else
            receiveValidReg <= receiveValidRegNext;
    end


    // clock output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            mdc <= 1'b0;
        else
            mdc <= mdcNext;
    end


    // data output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            mdioOutReg <= 1'b0;
        else
            mdioOutReg <= mdioOutRegNext;
    end


    // data output enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            mdioOutEnReg <= 1'b0;
        else
            mdioOutEnReg <= mdioOutEnRegNext;
    end


    assign receiveData   = lowerDataReg;
    assign transmitReady = transmitReadyReg;
    assign receiveValid  = receiveValidReg;


    // combinationial logic
    always_comb begin
        // defaults
        nextState            = IDLE;         // go to idle
        bitCounterNext       = bitCounter;   // keep old value
        idleCounterNext      = idleCounter;  // keep old value
        upperDataRegNext     = upperDataReg; // keep old value
        lowerDataRegNext     = lowerDataReg; // keep old value
        opcodeRegNext        = opcodeReg;    // keep old value
        mdcNext              = mdc;          // keep old value
        mdioOutRegNext       = mdioOutReg;   // keep old value
        mdioOutEnRegNext     = mdioOutEnReg; // keep old value
        busy                 = 1'b1;         // signal busy
        transmitReadyRegNext = 1'b0;         // signal not ready
        receiveValidRegNext  = 1'b0;         // read not valid


        case(state)
            IDLE: begin
                bitCounterNext  = 6'd1;
                idleCounterNext = 3'd1;
                busy            = 1'b0;

                if(!reset && transmitValid && finalCycle) begin
                    transmitReadyRegNext = 1'b1;                // signal ready
                    opcodeRegNext        = transmitData[29:28]; // set opcode reg to input opcode
                    upperDataRegNext     = transmitData[31:16]; // set upper data reg to input data
                    lowerDataRegNext     = transmitData[15:0];  // set upper data reg to input data

                    // next state logic
                    nextState = CYCLE1;
                end else begin
                    // next state logic
                    nextState = IDLE;
                end
            end


            // lower clock and set/capture data
            CYCLE1: begin
                if(finalCycle) begin
                    mdcNext = 1'b0; // lower clock
                    if(opcodeReg == 2'b10) begin
                        if(bitCounter >= 6'd15) begin
                            mdioOutEnRegNext = 1'b0;             // disable output
                        end else begin
                            mdioOutEnRegNext = 1'b1;             // enable output
                            mdioOutRegNext   = upperDataReg[15]; // output a new bit
                        end
                        if(bitCounter < 6'd17)
                            upperDataRegNext = {upperDataReg[14:0], upperDataReg[15]}; // rotate output data
                        else
                            lowerDataRegNext = {lowerDataReg[14:0], mdioIn};           // capture input data
                    end else begin                               // if opcode is not 10 then we are doing a write so set new data to the line here
                        mdioOutRegNext   = upperDataReg[15];     // output a new bit
                        mdioOutEnRegNext = 1'b1;                 // enable output
                        {upperDataRegNext, lowerDataRegNext} = {upperDataReg[14:0], lowerDataReg, upperDataReg[15]}; // rotate data
                    end
                end

                // next state logic
                nextState = (finalCycle) ? CYCLE2 : CYCLE1;
            end


            // raise clock and capture data
            CYCLE2: begin
                if(finalCycle) begin
                    mdcNext = 1'b1; // raise clock

                    if(bitCounter == 6'd32) begin
                        if(opcodeReg == 2'b10)
                            receiveValidRegNext = 1'b1;     // send read valid signal

                        nextState = FINISH;
                    end else begin
                        bitCounterNext = bitCounter + 6'd1; // increment bit counter

                        nextState = CYCLE1;
                    end
                end else begin
                    nextState = CYCLE2;
                end
            end


            // toggle clock a few times to give the bus some idle cycles
            FINISH: begin
                if(finalCycle) begin
                    //mdcNext          = 1'b0; // lower clock
                    mdcNext          = ~mdc; // toggle clock
                    mdioOutEnRegNext = 1'b0; // disable output
                    idleCounterNext  = idleCounter + 3'd1;
                end

                // next state logic
                nextState = (finalCycle && (idleCounter == 6'd5)) ? IDLE : FINISH;
            end


            //default:
        endcase
    end


    assign mdio   = (mdioOutEnReg) ? mdioOutReg : 1'bz;
    assign mdioIn = mdio;


endmodule

