

// valid is set when there is data ready to be consumed
// ready is sent back to acknowledge that the data was actually consumed.


module i2cCore(
    input   logic          clk,
    input   logic          reset,

    input   logic  [1:0]   commandIn,       // data from the master interface
    input   logic  [7:0]   transmitDataIn,  // data from the master interface
    input   logic          transmitAckIn,   // data from the master interface

	input   logic          transmitDataLoadEn, // write enable from the master interface
	input   logic          receiveDataReadReq, // read request from the master interface

    output  logic  [7:0]   receiveData,     // visible state to the master interface
    output  logic          receiveAck,      // visible state to the master interface
    output  logic          receiveValid,    // visible state to the master interface
    output  logic          transmitReady,   // visible state to the master interface

    inout   wire           scl,          // i2c clock
    inout   wire           sda           // i2c data
    );


    // wires
    logic         cycleDone;
    logic         transmitReadyWire;
    logic         receiveValidWire;
    logic  [7:0]  receiveDataWire;
    logic         receiveAckWire;
    logic  [1:0]  command;
    logic  [7:0]  transmitData;
    logic         transmitAck;


    //------------------------------------------------
    // visible registers


    // command register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            command <= 0;
        else if(transmitDataLoadEn)
            command <= commandIn;
        else
            command <= command;
     end


    // transmit data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitData <= 8'd0;
        else if(transmitDataLoadEn)
            transmitData <= transmitDataIn;
        else
            transmitData <= transmitData;
    end


    // transmit ack bit register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitAck <= 1'b1;
        else if(transmitDataLoadEn)
            transmitAck <= transmitAckIn;
        else
            transmitAck <= transmitAck;
    end


    // receive data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveData <= 8'd0;
        else if(receiveValidWire)
            receiveData <= receiveDataWire;
        else
            receiveData <= receiveData;
    end


    // receive ack bit register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveAck <= 1'b1;
        else if(receiveValidWire)
            receiveAck <= receiveAckWire;
        else
            receiveAck <= receiveAck;
    end


    // receiveValid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveValid <= 1'b0; // reset valid
        else if(receiveValidWire)
            receiveValid <= 1'b1; // set valid (this gets priority if the condition below is active at the same time)
        else if(receiveDataReadReq)
            receiveValid <= 1'b0; // reset valid
        else
            receiveValid <= receiveValid;
    end


    // transmitReady register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitReady <= 1'b1; // set ready
        else if(transmitDataLoadEn)
            transmitReady <= 1'b0; // reset ready when writting transmitData byte (this gets priority if the condition below is active at the same time)
        else if(transmitReadyWire) // might need to be this for some reason that i can't remember (~transmitReady && transmitReadyWire)
            transmitReady <= 1'b1; // set ready if data is already valid and transmitter reads the stored byte
        else
            transmitReady <= transmitReady;
    end


    //------------------------------------------------
    // master modules


    i2cUnit
    i2cUnit(
        .clk,
        .reset,
        .command,
        .transmitData,
        .receiveData          (receiveDataWire),
        .transmitAck,
        .receiveAck           (receiveAckWire),
        .cycleDone,
        .transmitValid        (~transmitReady),
        .transmitReady        (transmitReadyWire),
        .receiveValid         (receiveValidWire),
        .busy                 (),
        .scl,
        .sda
    );


    i2cClockUnit
    i2cClockUnit(
        .clk,
        .reset,
        .cycleDone       // high when a full cycle is complete
    );


endmodule

