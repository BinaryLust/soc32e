

// memory map
// 2'd0: {24'd0, bufferData}               // data register   // write only
// 2'd1: {22'd0, wordCount}                // status register // read only
// 2'd2: {clocksPerCycle, 15'd0, soundIre} // config register // read/write


module sound(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [1:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic          soundIrq,

    output  logic          pwmOut
    );


    // control lines/registers
    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic  [1:0]   addressReg;
    logic  [31:0]  readMux;


    // write enable lines
    logic          bufferLoadEn;
    logic          configLoadEn;


    // read data lines
    logic  [9:0]   wordCount;
    logic  [15:0]  clocksPerCycle;
    logic          soundIre;


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
        bufferLoadEn = 1'b0;
        configLoadEn = 1'b0;

        if(writeReg) begin
            case(addressReg)
                2'd0: bufferLoadEn = 1'b1;
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
            2'd2:    readMux = {22'd0, wordCount};
            2'd3:    readMux = {clocksPerCycle, 15'd0, soundIre};
            default: readMux = 32'b0;
        endcase
    end


    soundCore
    soundCore(
        .clk,
        .reset,
        .bufferDataIn       (dataInReg[7:0]),   // data from the master interface
        .clocksPerCycleIn   (dataInReg[31:16]), // data from the master interface
        .soundIreIn         (dataInReg[0]),     // data from the master interface
        .bufferLoadEn,     // write enable from the master interface
        .configLoadEn,     // write enable from the master interface
        .wordCount,        // visible state to the master interface
        .clocksPerCycle,   // visible state to the master interface
        .soundIre,         // visible state to the master interface
        .soundIrq,
        .pwmOut
    );


endmodule

