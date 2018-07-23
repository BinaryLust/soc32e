

module spiCore
    #(parameter DATAWIDTH    = 8,
      parameter BUFFERDEPTH  = 1024,
      parameter ADDRESSWIDTH = $clog2(BUFFERDEPTH))(
    input   logic                    clk,
    input   logic                    reset,

    input   logic  [DATAWIDTH-1:0]   txDataIn,                 // data from the master interface
    input   logic  [ADDRESSWIDTH:0]  txAlmostFullCountIn,      // data from the master interface
    input   logic  [ADDRESSWIDTH:0]  rxAlmostEmptyCountIn,     // data from the master interface
    input   logic  [15:0]            clocksPerCycleIn,         // data from the master interface
    input   logic                    clockPolarityIn,          // data from the master interface
    input   logic                    clockPhaseIn,             // data from the master interface
    input   logic                    dataDirectionIn,          // data from the master interface
    input   logic                    ssEnableIn,               // data from the master interface
    input   logic  [1:0]             ssNumberIn,               // data from the master interface
    input   logic                    rxIreIn,                  // data from the master interface
    input   logic                    txIreIn,                  // data from the master interface

    input   logic                    txDataLoadEn,             // write enable from the master interface
    input   logic                    txAlmostFullCountLoadEn,  // write enable from the master interface
    input   logic                    rxAlmostEmptyCountLoadEn, // write enable from the master interface
    input   logic                    configLoadEn,             // write enable from the master interface
    input   logic                    rxDataReadReq,            // read request from the master interface

    output  logic  [DATAWIDTH-1:0]   rxData,                   // visible state to the master interface
    output  logic  [ADDRESSWIDTH:0]  txAlmostFullCount,        // visible state to the master interface
    output  logic  [ADDRESSWIDTH:0]  rxAlmostEmptyCount,       // visible state to the master interface
    output  logic  [ADDRESSWIDTH:0]  txCount,                  // visible state to the master interface
    output  logic  [ADDRESSWIDTH:0]  rxCount,                  // visible state to the master interface
    output  logic                    txFull,                   // visible state to the master interface
    output  logic                    txAlmostFull,             // visible state to the master interface
    output  logic                    rxEmpty,                  // visible state to the master interface
    output  logic                    rxAlmostEmpty,            // visible state to the master interface
    output  logic                    idle,                     // visible state to the master interface
    output  logic  [15:0]            clocksPerCycle,           // visible state to the master interface
    output  logic                    clockPolarity,            // visible state to the master interface
    output  logic                    clockPhase,               // visible state to the master interface
    output  logic                    dataDirection,            // visible state to the master interface
    output  logic                    ssEnable,                 // visible state to the master interface
    output  logic  [1:0]             ssNumber,                 // visible state tot he master interface
    output  logic                    rxIre,                    // visible state to the master interface
    output  logic                    txIre,                    // visible state to the master interface

    output  logic                    txIrq,                    // interrupt request to the master
    output  logic                    rxIrq,                    // interrupt request to the master

    input   logic                    miso,
    output  logic                    mosi,
    output  logic                    sclk,
    output  logic  [3:0]             ss
    );


    // wires
    logic  [DATAWIDTH-1:0]  coreIn;
    logic  [DATAWIDTH-1:0]  coreOut;
    logic                   coreRead;
    logic                   coreWrite;
    logic                   coreTxEmpty;
    logic                   finalCycle;
    logic  [3:0]            ssNext;


    // interrupt detection registers
    //logic                   txIrePre;
    //logic                   coreTxEmptyPre;


    //------------------------------------------------
    // transmit interrupt notes
    // we can do a transmit interrupt anytime the transmit data is empty or
    // when the transmit data goes from being full to empty after sending a
    // byte to begin with


    // transmit interrupt request logic
    // if !coreTxEmpty is not valid and we detect txIre changing from disabled to enabled
    // or if txIre is enabled and we detect !coreTxEmpty changing from valid to not valid
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            txIrq          <= 1'b0;
            txIrePre       <= 1'b0;
            !coreTxEmptyPre <= 1'b0;
        end else begin
            txIrq          <= (!!coreTxEmpty && (!txIrePre && txIre)) | (txIre && (!coreTxEmptyPre && !!coreTxEmpty));
            txIrePre       <= txIre;
            !coreTxEmptyPre <= !coreTxEmpty;
        end
    end


    // receive interrupt request logic
    // if receive interrupt request enable is set and coreWrite is asserted
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            rxIrq <= 1'b0;
        else
            rxIrq <= rxIre & coreWrite;
    end*/


    // use greater than/less than comparator to monitor fifo fill level and trigger interrupt
    assign txIrq = 1'b0;
    assign rxIrq  = 1'b0;


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


    // transmit almost full count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            txAlmostFullCount <= 16;
        else if(txAlmostFullCountLoadEn)
            txAlmostFullCount <= txAlmostFullCountIn;
        else
            txAlmostFullCount <= txAlmostFullCount;
    end


    // receive almost empty count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            rxAlmostEmptyCount <= 16;
        else if(rxAlmostEmptyCountLoadEn)
            rxAlmostEmptyCount <= rxAlmostEmptyCountIn;
        else
            rxAlmostEmptyCount <= rxAlmostEmptyCount;
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
            rxIre <= 1'd0;
        else if(configLoadEn)
            rxIre <= rxIreIn;
        else
            rxIre <= rxIre;
    end


    // transmit interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            txIre <= 1'd0;
        else if(configLoadEn)
            txIre <= txIreIn;
        else
            txIre <= txIre;
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


    spiController  #(.DATAWIDTH(DATAWIDTH))
    spiController(
        .clk,
        .reset,
        .clockPolarity,
        .clockPhase,
        .dataDirection,
        .finalCycle,
        .dataIn                  (coreOut),
        .dataOut                 (coreIn),
        .coreTxEmpty             (coreTxEmpty),
        .coreRead,
        .coreWrite,
        .idle,
        .miso,
        .mosi,
        .sclk
    );


    spiCircularBuffer #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(BUFFERDEPTH))
    spiCircularBuffer(
        .clk,
        .reset,
        .dataIn                  (txDataIn),
        .dataOut                 (rxData),
        .dataWrite               (txDataLoadEn),
        .dataRead                (rxDataReadReq),
        .dataTxAlmostFullCount   (txAlmostFullCount),
        .dataRxAlmostEmptyCount  (rxAlmostEmptyCount),
        .dataTxCount             (txCount),
        .dataRxCount             (rxCount),
        .dataTxFull              (txFull),
        .dataTxAlmostFull        (txAlmostFull),
        .dataRxEmpty             (rxEmpty),
        .dataRxAlmostEmpty       (rxAlmostEmpty),
        .coreIn,
        .coreOut,
        .coreWrite,
        .coreRead,
        .coreTxEmpty
    );


endmodule

