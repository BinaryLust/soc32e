

module spiCore
    #(parameter DATAWIDTH    = 8,
      parameter BUFFERDEPTH  = 1024,
      parameter ADDRESSWIDTH = $clog2(BUFFERDEPTH))(
    input   logic                   clk,
    input   logic                   reset,

    input   logic  [DATAWIDTH-1:0]  transmitDataIn,     // data from the master interface
    input   logic  [15:0]           clocksPerCycleIn,   // data from the master interface
    input   logic                   clockPolarityIn,    // data from the master interface
    input   logic                   clockPhaseIn,       // data from the master interface
    input   logic                   dataDirectionIn,    // data from the master interface
    input   logic                   ssEnableIn,         // data from the master interface
    input   logic  [1:0]            ssNumberIn,         // data from the master interface
    input   logic                   receiveIreIn,       // data from the master interface
    input   logic                   transmitIreIn,      // data from the master interface

    input   logic                   transmitDataLoadEn, // write enable from the master interface
    input   logic                   configLoadEn,       // write enable from the master interface
    input   logic                   receiveDataReadReq, // read request from the master interface

    output  logic  [DATAWIDTH-1:0]  receiveData,        // visible state to the master interface
    output  logic                   receiveValid,       // visible state to the master interface
    output  logic                   transmitReady,      // visible state to the master interface
    output  logic                   idle,               // visible state to the master interface
    output  logic  [15:0]           clocksPerCycle,     // visible state to the master interface
    output  logic                   clockPolarity,      // visible state to the master interface
    output  logic                   clockPhase,         // visible state to the master interface
    output  logic                   dataDirection,      // visible state to the master interface
    output  logic                   ssEnable,           // visible state to the master interface
    output  logic  [1:0]            ssNumber,           // visible state tot he master interface
    output  logic                   receiveIre,         // visible state to the master interface
    output  logic                   transmitIre,        // visible state to the master interface

    output  logic                   transmitIrq,        // interrupt request to the master
    output  logic                   receiveIrq,         // interrupt request to the master

    input   logic                   miso,
    output  logic                   mosi,
    output  logic                   sclk,
    output  logic  [3:0]            ss
    );


    // wires
    logic  [DATAWIDTH-1:0]  coreIn;
    logic  [DATAWIDTH-1:0]  coreOut;
    logic                   coreRead;
    logic                   coreWrite;
    logic                   transmitDataReady;
    logic                   finalCycle;
    logic  [3:0]            ssNext;


    // interrupt detection registers
    //logic                   transmitIrePre;
    //logic                   transmitDataReadyPre;


    //------------------------------------------------
    // transmit interrupt notes
    // we can do a transmit interrupt anytime the transmit data is empty or
    // when the transmit data goes from being full to empty after sending a
    // byte to begin with


    // transmit interrupt request logic
    // if transmitDataReady is not valid and we detect transmitIre changing from disabled to enabled
    // or if transmitIre is enabled and we detect transmitDataReady changing from valid to not valid
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            transmitIrq          <= 1'b0;
            transmitIrePre       <= 1'b0;
            transmitDataReadyPre <= 1'b0;
        end else begin
            transmitIrq          <= (!transmitDataReady && (!transmitIrePre && transmitIre)) | (transmitIre && (transmitDataReadyPre && !transmitDataReady));
            transmitIrePre       <= transmitIre;
            transmitDataReadyPre <= transmitDataReady;
        end
    end


    // receive interrupt request logic
    // if receive interrupt request enable is set and coreWrite is asserted
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveIrq <= 1'b0;
        else
            receiveIrq <= receiveIre & coreWrite;
    end*/


    // use greater than/less than comparator to monitor fifo fill level and trigger interrupt
    assign transmitIrq = 1'b0;
    assign receiveIrq  = 1'b0;


    // active slave select line decoder logic
    always_comb begin
       if(ssEnableIn) begin
           case(ssNumberIn)
               2'd0: ssNext = 4'b1110;
               2'd1: ssNext = 4'b1101;
               2'd2: ssNext = 4'b1011;
               2'd3: ssNext = 4'b0111;
           endcase
       end else begin
           ssNext = 4'b1111; // active no lines because enable is false
       end
    end


    //------------------------------------------------
    // visible registers


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


    // slave select number register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ssNumber <= 2'd0;
        else if(configLoadEn)
            ssNumber <= ssNumberIn;
        else
            ssNumber <= ssNumber;
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


    // slave select lines
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ss <= 4'b1111;
        else if(configLoadEn)
            ss <= ssNext;
        else
            ss <= ss;
    end


    // previous word count registers
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            wordCountP1 <= 1'd0;
            wordCountP2 <= 1'd0;
        end else if(rxDataValid) begin  // update the count when the buffer is written to
            wordCountP1 <= wordCount;   // last cycle
            wordCountP2 <= wordCountP1; // two cycles ago
        end
    end*/


    //-------------------------------------------------
    // modules


    spiClockUnit
    spiClockUnit(
        .clk,
        .reset,
        .clocksPerCycle,
        .finalCycle
    );


    spiUnit  #(.DATAWIDTH(DATAWIDTH))
    spiUnit(
        .clk,
        .reset,
        .clockPolarity,
        .clockPhase,
        .dataDirection,
        .finalCycle,
        .dataRegIn         (coreOut),
        .dataReg           (coreIn),
        .transmitReady     (transmitDataReady),
        .coreRead,
        .coreWrite,
        .idle,
        .miso,
        .mosi,
        .sclk
    );


    spiRingBuffer #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(BUFFERDEPTH))
    spiRingBuffer(
        .clk,
        .reset,
        .dataIn              (transmitDataIn),
        .dataOut             (receiveData),
        .dataWrite           (transmitDataLoadEn),
        .dataRead            (receiveDataReadReq),
        .dataWordCount       (),
        .transmitReady,
        .receiveValid,
        .coreIn,
        .coreOut,
        .coreWrite,
        .coreRead,
        .coreWordCount    (),
        .transmitDataReady
    );


endmodule

