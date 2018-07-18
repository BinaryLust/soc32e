

// memory map
// 2'd0: {{32-DATAWIDTH{1'b0}}, transmitData}                                                                          // data register   // write only
// 2'd1: {{32-DATAWIDTH{1'b0}}, receiveData}                                                                           // data register   // read only
// 2'd2: {29'd0, idle, receiveValid, transmitReady}                                                                    // status register // read only
// 2'd3: {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, ssNumber, 8'b0, receiveIre, transmitIre} // config register // read/write

// dataDirection = 0 - (LSB First) right shift
// dataDirection = 1 - (MSB First) left shift


// the master should first set clocks per cycle, clock polarity, clock phase, data direction
// then set slave select on the desired device
// then start transations
// followed by resetting slave select


module spi
    #(parameter DATAWIDTH   = 8,
      parameter BUFFERDEPTH = 1024)(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [1:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic          transmitIrq,        // interrupt request to the master
    output  logic          receiveIrq,         // interrupt request to the master

    input   logic          miso,
    output  logic          mosi,
    output  logic          sclk,
    output  logic  [3:0]   ss
    );


    // control lines/registers
    logic  [31:0]           dataInReg;
    logic                   readReg;
    logic                   writeReg;
    logic  [1:0]            addressReg;
    logic  [31:0]           readMux;


    // write enable lines
    logic                   transmitDataLoadEn;
    logic                   configLoadEn;


    // read data lines
    logic  [DATAWIDTH-1:0]  receiveData;
    logic                   idle;
    logic                   receiveValid;
    logic                   transmitReady;
    logic  [15:0]           clocksPerCycle;
    logic                   clockPolarity;
    logic                   clockPhase;
    logic                   dataDirection;
    logic                   ssEnable;
    logic  [1:0]            ssNumber;
    logic                   receiveIre;
    logic                   transmitIre;


    // wires
    logic                   receiveDataReadReq;


    // control registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            readReg       <= 1'b0;
            writeReg      <= 1'b0;
            readValid     <= 1'b0;
            addressReg    <= 2'd0;
        end else begin
            readReg       <= read;
            writeReg      <= write;
            readValid     <= readReg;
            addressReg    <= address;
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
        transmitDataLoadEn = 1'b0;
        configLoadEn       = 1'b0;

        if(writeReg) begin
            case(addressReg)
                2'd0: transmitDataLoadEn = 1'b1;
                2'd3: configLoadEn       = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            2'd1: readMux = {{32-DATAWIDTH{1'b0}}, receiveData};
            2'd2: readMux = {29'd0, idle, receiveValid, transmitReady};
            2'd3: readMux = {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, ssNumber, 8'b0, receiveIre, transmitIre};
            default: readMux = 32'd0;
        endcase
    end


    assign receiveDataReadReq = ((addressReg == 2'd1) && readReg);


    spiCore  #(.DATAWIDTH(DATAWIDTH), .BUFFERDEPTH(BUFFERDEPTH))
    spiCore(
        .clk,
        .reset,
        .transmitDataIn       (dataInReg[DATAWIDTH-1:0]), // data from the master interface
        .clocksPerCycleIn     (dataInReg[31:16]),         // data from the master interface
        .clockPolarityIn      (dataInReg[15]),            // data from the master interface
        .clockPhaseIn         (dataInReg[14]),            // data from the master interface
        .dataDirectionIn      (dataInReg[13]),            // data from the master interface
        .ssEnableIn           (dataInReg[12]),            // data from the master interface
        .ssNumberIn           (dataInReg[11:10]),         // data from the master interface
        .receiveIreIn         (dataInReg[1]),             // data from the master interface
        .transmitIreIn        (dataInReg[0]),             // data from the master interface
        .transmitDataLoadEn,                              // write enable from the master interface
        .configLoadEn,                                    // write enable from the master interface
        .receiveDataReadReq,                              // read request from the master interface
        .receiveData,                                     // visible state to the master interface
        .receiveValid,                                    // visible state to the master interface
        .transmitReady,                                   // visible state to the master interface
        .idle,
        .clocksPerCycle,                                  // visible state to the master interface
        .clockPolarity,                                   // visible state to the master interface
        .clockPhase,                                      // visible state to the master interface
        .dataDirection,                                   // visible state to the master interface
        .ssEnable,                                        // visible state to the master interface
        .ssNumber,
        .receiveIre,                                      // visible state to the master interface
        .transmitIre,                                     // visible state to the master interface
        .transmitIrq,                                     // interrupt request to the master
        .receiveIrq,                                      // interrupt request to the master
        .miso,
        .mosi,
        .sclk,
        .ss
    );


endmodule

