

// memory map
// 3'd0: {{32-DATAWIDTH{1'b0}}, spiData}                                                                    // data register   // read/write
// 3'd1: {27'd0, rxAlmostEmpty, rxEmpty, txAlmostFull, txFull, idle}                                        // status register // read only
// 3'd2: {txCount}                                                                                          // status register // read only
// 3'd3: {rxCount}                                                                                          // status register // read only
// 3'd4: {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, ssNumber, 8'b0, rxIre, txIre} // config register // read/write
// 3'd5: {txAlmostFullCount}                                                                                // config register // read/write
// 3'd6: {rxAlmostEmptyCount}                                                                               // config register // read/write


// dataDirection = 0 - (LSB First) right shift
// dataDirection = 1 - (MSB First) left shift


// the master should first set clocks per cycle, clock polarity, clock phase, data direction
// then set slave select on the desired device
// then start transations
// followed by resetting slave select


// if txFull flag is set we must read data before it will become unset again.


module spi
    #(parameter DATAWIDTH    = 8,
      parameter BUFFERDEPTH  = 1024,
      parameter ADDRESSWIDTH = $clog2(BUFFERDEPTH))(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [2:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic          txIrq,        // interrupt request to the master
    output  logic          rxIrq,        // interrupt request to the master

    input   logic          miso,
    output  logic          mosi,
    output  logic          sclk,
    output  logic  [3:0]   ss
    );


    // control lines/registers
    logic  [31:0]            dataInReg;
    logic                    readReg;
    logic                    writeReg;
    logic  [2:0]             addressReg;
    logic  [31:0]            readMux;


    // write enable lines
    logic                    txDataLoadEn;
    logic                    configLoadEn;
    logic                    txAlmostFullCountLoadEn;
    logic                    rxAlmostEmptyCountLoadEn;


    // read data lines
    logic  [DATAWIDTH-1:0]   rxData;
    logic                    idle;
    logic                    txFull;
    logic                    txAlmostFull;
    logic                    rxEmpty;
    logic                    rxAlmostEmpty;
    logic  [ADDRESSWIDTH:0]  txAlmostFullCount;
    logic  [ADDRESSWIDTH:0]  rxAlmostEmptyCount;
    logic  [ADDRESSWIDTH:0]  txCount;
    logic  [ADDRESSWIDTH:0]  rxCount;
    logic  [15:0]            clocksPerCycle;
    logic                    clockPolarity;
    logic                    clockPhase;
    logic                    dataDirection;
    logic                    ssEnable;
    logic  [1:0]             ssNumber;
    logic                    rxIre;
    logic                    txIre;


    // wires
    logic                    rxDataReadReq;


    // control registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            readReg    <= 1'b0;
            writeReg   <= 1'b0;
            readValid  <= 1'b0;
            addressReg <= 3'd0;
        end else begin
            readReg    <= read;
            writeReg   <= write;
            readValid  <= readReg;
            addressReg <= address;
        end
    end


    // data input/output registers
    always_ff @(posedge clk) begin
        dataInReg <= dataIn;
        dataOut   <= readMux;
    end


    // write decoder
    always_comb begin
        // defaults
        txDataLoadEn             = 1'b0;
        configLoadEn             = 1'b0;
        txAlmostFullCountLoadEn  = 1'b0;
        rxAlmostEmptyCountLoadEn = 1'b0;

        if(writeReg) begin
            case(addressReg)
                3'd0: txDataLoadEn             = 1'b1;
                3'd4: configLoadEn             = 1'b1;
                3'd5: txAlmostFullCountLoadEn  = 1'b1;
                3'd6: rxAlmostEmptyCountLoadEn = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            3'd0: readMux = {{32-DATAWIDTH{1'b0}}, rxData};
            3'd1: readMux = {27'd0, rxAlmostEmpty, rxEmpty, txAlmostFull, txFull, idle};
            3'd2: readMux = {{32-(ADDRESSWIDTH+1){1'b0}}, txCount};
            3'd3: readMux = {{32-(ADDRESSWIDTH+1){1'b0}}, rxCount};
            3'd4: readMux = {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, ssNumber, 8'b0, rxIre, txIre};
            3'd5: readMux = {{32-(ADDRESSWIDTH+1){1'b0}}, txAlmostFullCount};
            3'd6: readMux = {{32-(ADDRESSWIDTH+1){1'b0}}, rxAlmostEmptyCount};
            default: readMux = 32'd0;
        endcase
    end


    assign rxDataReadReq = ((addressReg == 3'd0) && readReg);


    spiCore  #(.DATAWIDTH(DATAWIDTH), .BUFFERDEPTH(BUFFERDEPTH))
    spiCore(
        .clk,
        .reset,
        .txDataIn                    (dataInReg[DATAWIDTH-1:0]),  // data from the master interface
        .txAlmostFullCountIn         (dataInReg[ADDRESSWIDTH:0]), // data from the master interface
        .rxAlmostEmptyCountIn        (dataInReg[ADDRESSWIDTH:0]), // data from the master interface
        .clocksPerCycleIn            (dataInReg[31:16]),          // data from the master interface
        .clockPolarityIn             (dataInReg[15]),             // data from the master interface
        .clockPhaseIn                (dataInReg[14]),             // data from the master interface
        .dataDirectionIn             (dataInReg[13]),             // data from the master interface
        .ssEnableIn                  (dataInReg[12]),             // data from the master interface
        .ssNumberIn                  (dataInReg[11:10]),          // data from the master interface
        .rxIreIn                     (dataInReg[1]),              // data from the master interface
        .txIreIn                     (dataInReg[0]),              // data from the master interface
        .txDataLoadEn,                                            // write enable from the master interface
        .txAlmostFullCountLoadEn,                                 // write enable from the master interface
        .rxAlmostEmptyCountLoadEn,                                // write enable from the master interface
        .configLoadEn,                                            // write enable from the master interface
        .rxDataReadReq,                                           // read request from the master interface
        .rxData,                                                  // visible state to the master interface
        .txAlmostFullCount,                                       // visible state to the master interface
        .rxAlmostEmptyCount,                                      // visible state to the master interface
        .txCount,                                                 // visible state to the master interface
        .rxCount,                                                 // visible state to the master interface
        .txFull,                                                  // visible state to the master interface
        .txAlmostFull,                                            // visible state to the master interface
        .rxEmpty,                                                 // visible state to the master interface
        .rxAlmostEmpty,                                           // visible state to the master interface
        .idle,                                                    // visible state to the master interface
        .clocksPerCycle,                                          // visible state to the master interface
        .clockPolarity,                                           // visible state to the master interface
        .clockPhase,                                              // visible state to the master interface
        .dataDirection,                                           // visible state to the master interface
        .ssEnable,                                                // visible state to the master interface
        .ssNumber,                                                // visible state to the master interface
        .rxIre,                                                   // visible state to the master interface
        .txIre,                                                   // visible state to the master interface
        .txIrq,                                                   // interrupt request to the master
        .rxIrq,                                                   // interrupt request to the master
        .miso,
        .mosi,
        .sclk,
        .ss
    );


endmodule

