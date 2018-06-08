

// memory map
// 1'd0: {upperData, LowerData}                // data register   // upperData write only, LowerData read/write
// 1'd1: {30'd0, receiveValid, transmitReady}  // status register // read only


module ethernetSmi(
    input   logic               clk,
    input   logic               reset,
    input   logic               read,
    input   logic               write,
    input   logic               address,
    input   logic  [31:0]       dataIn,

    output  logic               readValid,
    output  logic  [31:0]       dataOut,

    output  logic               mdc,
    inout   wire                mdio
    );


    // control lines/registers
    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic          addressReg;
    logic  [31:0]  readMux;


    // write enable lines
    logic          transmitDataLoadEn;


    // read data lines
    logic  [15:0]  receiveData;
    logic          receiveAck;
    logic          receiveValid;
    logic          transmitReady;


    // wires
    logic          receiveDataReadReq;


    // control registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            readReg       <= 1'b0;
            writeReg      <= 1'b0;
            readValid     <= 1'b0;
            addressReg    <= 1'd0;
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

        if(writeReg) begin
            case(addressReg)
                1'd0: transmitDataLoadEn = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            1'd0: readMux = {16'd0, receiveData};
            1'd1: readMux = {30'd0, receiveValid, transmitReady};
        endcase
    end


    // special read request signal to reset rx valid bit
    assign receiveDataReadReq = ((addressReg == 1'd0) && readReg) ? 1'b1 : 1'b0;


    ethernetSmiCore
    ethernetSmiCore(
        .clk,
        .reset,
        .transmitDataIn        (dataInReg),
        .transmitDataLoadEn,
        .receiveDataReadReq,
        .receiveData,
        .receiveValid,
        .transmitReady,
        .mdc,
        .mdio
    );


endmodule

