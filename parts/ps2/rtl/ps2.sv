

// memory map
// 2'd0: {22'd0, parity, data}  // data register   // read/write
// 2'd1: {31'd0, ready}         // status register // read
// 2'd2: {31'd0, ire}           // config register // read/write



module ps2(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [1:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic          irq,

    input   logic          ps2Clk,
    input   logic          ps2Data
    );


    // control lines/registers
    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic  [1:0]   addressReg;
    logic  [31:0]  readMux;


    // write enable lines
    logic          configLoadEn;


    // read data lines
    logic  [7:0]   data;
    logic          parity;
    logic          ready;
    logic          ire;


    // wires
    logic          dataReadReq;


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
        configLoadEn = 1'b0;

        if(writeReg) begin
            case(addressReg)
                2'd2: configLoadEn = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            2'd0: readMux = {23'd0, parity, data};
            2'd1: readMux = {31'd0, ready};
            2'd2: readMux = {31'd0, ire};
            3'd3: readMux = 32'd0;
        endcase
    end


    // special read request signal to reset the ready bit
    assign dataReadReq = (addressReg == 2'd0) && readReg;


    ps2Core
    ps2Core(
        .clk,
        .reset,
        .ireIn         (dataInReg[0]), // data to the slave
        .configLoadEn,                 // write enable to the slave
        .dataReadReq,                  // read request to the slave
        .data,                         // visible state from the slave
        .parity,                       // visible state from the slave
        .ready,                        // visible state from the slave
        .ire,                          // visible state from the slave
        .irq,                          // interrupt request from the slave
        .ps2Clk,
        .ps2Data
    );


endmodule

