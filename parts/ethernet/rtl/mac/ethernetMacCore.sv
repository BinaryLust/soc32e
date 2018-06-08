

module ethernetMacCore(
    input   logic               clk,
    input   logic               reset,

    input   logic  [31:0]       transmitDataIn,     // data from the master interface

    input   logic               transmitDataLoadEn, // write enable from the master interface
    input   logic               receiveDataReadReq, // read request from the master interface

    output  logic  [15:0]       receiveData,        // visible state to the master interface
    output  logic               receiveValid,       // visible state to the master interface
    output  logic               transmitReady,      // visible state to the master interface

    output  logic               mdc,
    inout   wire                mdio
    );


    // wires
    // logic          finalCycle;
    // logic          transmitReadyWire;
    // logic          receiveValidWire;
    // logic  [15:0]  receiveDataWire;
    // logic  [31:0]  transmitData;


    //------------------------------------------------
    // visible registers


    // transmit data register
    // always_ff @(posedge clk or posedge reset) begin
    //     if(reset)
    //         transmitData <= 32'd0;
    //     else if(transmitDataLoadEn)
    //         transmitData <= transmitDataIn;
    //     else
    //         transmitData <= transmitData;
    // end


    // receive data register
    // always_ff @(posedge clk or posedge reset) begin
    //     if(reset)
    //         receiveData <= 16'd0;
    //     else if(receiveValidWire)
    //         receiveData <= receiveDataWire;
    //     else
    //         receiveData <= receiveData;
    // end


    // receiveValid register
    // always_ff @(posedge clk or posedge reset) begin
    //     if(reset)
    //         receiveValid <= 1'b0; // reset valid
    //     else if(receiveValidWire)
    //         receiveValid <= 1'b1; // set valid (this gets priority if the condition below is active at the same time)
    //     else if(receiveDataReadReq)
    //         receiveValid <= 1'b0; // reset valid
    //     else
    //         receiveValid <= receiveValid;
    // end


    // transmitReady register
    // always_ff @(posedge clk or posedge reset) begin
    //     if(reset)
    //         transmitReady <= 1'b1; // set ready
    //     else if(transmitDataLoadEn)
    //         transmitReady <= 1'b0; // reset ready when writting transmitData byte (this gets priority if the condition below is active at the same time)
    //     else if(transmitReadyWire) // might need to be this for some reason that i can't remember (~transmitReady && transmitReadyWire)
    //         transmitReady <= 1'b1; // set ready if data is already valid and transmitter reads the stored byte
    //     else
    //         transmitReady <= transmitReady;
    // end


    //------------------------------------------------
    // master modules


    asyncFifo#(.DATAWIDTH(8), .DATADEPTH(1024))
    rxFifo(
        readClk,
        readReset,
        writeClk,
        writeReset,
        writeEn,
        readReq,
        dataIn,
        dataOut,
        empty,
        full
    );


endmodule

