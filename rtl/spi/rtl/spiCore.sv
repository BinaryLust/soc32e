

module spiCore #(parameter DATAWIDTH = 8)(
    input   logic                   clk,
    input   logic                   reset,

    input   logic  [DATAWIDTH-1:0]  transmitDataIn,     // data from the master interface
    input   logic  [15:0]           clocksPerCycleIn,   // data from the master interface
    input   logic                   clockPolarityIn,    // data from the master interface
    input   logic                   clockPhaseIn,       // data from the master interface
    input   logic                   dataDirectionIn,    // data from the master interface
    input   logic                   ssEnableIn,         // data from the master interface
    input   logic                   receiveIreIn,       // data from the master interface
    input   logic                   transmitIreIn,      // data from the master interface

    input   logic                   transmitDataLoadEn, // write enable from the master interface
    input   logic                   configLoadEn,       // write enable from the master interface
    input   logic                   receiveDataReadReq, // read request from the master interface

    output  logic  [DATAWIDTH-1:0]  transmitData,       // visible state to the master interface
    output  logic  [DATAWIDTH-1:0]  receiveData,        // visible state to the master interface
    output  logic                   receiveValid,       // visible state to the master interface
    output  logic                   transmitReady,      // visible state to the master interface
    output  logic  [15:0]           clocksPerCycle,     // visible state to the master interface
    output  logic                   clockPolarity,      // visible state to the master interface
    output  logic                   clockPhase,         // visible state to the master interface
    output  logic                   dataDirection,      // visible state to the master interface
    output  logic                   ssEnable,           // visible state to the master interface
    output  logic                   receiveIre,         // visible state to the master interface
    output  logic                   transmitIre,        // visible state to the master interface

    output  logic                   transmitIrq,        // interrupt request to the master
    output  logic                   receiveIrq,         // interrupt request to the master

    input   logic                   miso,
    output  logic                   mosi,
    output  logic                   sclk,
    output  logic                   ss
    );


    // wires
    logic                   transmitReadyWire;  // from the transmitter
    logic                   receiveDataValid;   // from the receiver
    logic  [DATAWIDTH-1:0]  receiveDataWire;    // from the receiver
    logic                   transmitDataValid;  // to the the transmitter


    // interrupt detection registers
    logic                   transmitIrePre;
    logic                   transmitDataValidPre;


    //------------------------------------------------
    // transmit interrupt notes
    // we can do a transmit interrupt anytime the transmit data is empty or
    // when the transmit data goes from being full to empty after sending a
    // byte to begin with


    // transmit interrupt request logic
    // if transmitDataValid is not valid and we detect transmitIre changing from disabled to enabled
    // or if transmitIre is enabled and we detect transmitDataValid changing from valid to not valid
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            transmitIrq          <= 1'b0;
            transmitIrePre       <= 1'b0;
            transmitDataValidPre <= 1'b0;
        end else begin
            transmitIrq          <= (!transmitDataValid && (!transmitIrePre && transmitIre)) | (transmitIre && (transmitDataValidPre && !transmitDataValid));
            transmitIrePre       <= transmitIre;
            transmitDataValidPre <= transmitDataValid;
        end
    end


    // receive interrupt request logic
    // if receive interrupt request enable is set and receiveDataValid is asserted
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveIrq <= 1'b0;
        else
            receiveIrq <= receiveIre & receiveDataValid;
    end


    //------------------------------------------------
    // visible registers


    // transmitData register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitData <= 0;
        else if(transmitDataLoadEn)
            transmitData <= transmitDataIn;
        else
            transmitData <= transmitData;
    end


    // receiveData register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveData <= 0;
        else if(receiveDataValid)
            receiveData <= receiveDataWire;
        else
            receiveData <= receiveData;
    end


    // receiveValid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveValid <= 1'b0; // reset valid
        else if(receiveDataValid)
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
        else if(transmitDataValid && transmitReadyWire)
            transmitReady <= 1'b1; // set ready if data is already valid and transmitter reads the stored byte
        else
            transmitReady <= transmitReady;
    end


    // cycles per clock register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            clocksPerCycle <= 16'd500; // 100 Kbps default
        else if(configLoadEn)
            clocksPerCycle <= clocksPerCycleIn;
        else
            clocksPerCycle <= clocksPerCycle;
    end


    // clock polarity register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            clockPolarity <= 1'd0;
        else if(configLoadEn)
            clockPolarity <= clockPolarityIn;
        else
            clockPolarity <= clockPolarity;
    end


    // clock phase register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            clockPhase <= 1'd0;
        else if(configLoadEn)
            clockPhase <= clockPhaseIn;
        else
            clockPhase <= clockPhase;
    end


    // data direction register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataDirection <= 1'd0;
        else if(configLoadEn)
            dataDirection <= dataDirectionIn;
        else
            dataDirection <= dataDirection;
    end


    // slave select enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ssEnable <= 1'd0;
        else if(configLoadEn)
            ssEnable <= ssEnableIn;
        else
            ssEnable <= ssEnable;
    end


    // receive interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveIre <= 1'd0;
        else if(configLoadEn)
            receiveIre <= receiveIreIn;
        else
            receiveIre <= receiveIre;
    end


    // transmit interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitIre <= 1'd0;
        else if(configLoadEn)
            transmitIre <= transmitIreIn;
        else
            transmitIre <= transmitIre;
    end


    //------------------------------------------------
    // hidden registers


    // transmitDataValid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitDataValid <= 1'b0; // set not valid
        else if(transmitDataLoadEn)
            transmitDataValid <= 1'b1; // set ready if another byte is written (this gets priority if the condition below is active at the same time)
        else if(transmitReadyWire)
            transmitDataValid <= 1'b0; // reset ready when the transmitter reads the data
        else
            transmitDataValid <= transmitDataValid;
    end


    //------------------------------------------------
    // transmit and receive modules


    spiUnit  #(.DATAWIDTH(DATAWIDTH))
    spiUnit(
        .clk,
        .reset,
        .clocksPerCycle,
        .clockPolarity,
        .clockPhase,
        .dataDirection,
        .ssEnable,
        .transmitValid     (transmitDataValid),
        .dataRegIn         (transmitData),
        .dataReg           (receiveDataWire),
        .transmitReady     (transmitReadyWire),
        .receiveValid      (receiveDataValid),
        .miso,
        .mosi,
        .sclk,
        .ss
    );


endmodule

