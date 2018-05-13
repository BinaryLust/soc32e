

module random(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut
    );


    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic  [31:0]  randomValue;


    // control registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            readReg       <= 1'b0;
            writeReg      <= 1'b0;
            readValid     <= 1'b0;
        end else begin
            readReg       <= read;
            writeReg      <= write;
            readValid     <= readReg;
        end
    end


    // data input/output registers
    always_ff @(posedge clk) begin
        dataInReg <= dataIn;
        dataOut   <= randomValue;
    end


    // the actual device core
    randomCore
    randomCore(
        .clk,
        .reset,
        .writeEnable   (writeReg),
        .dataIn        (dataInReg),
        .randomValue
    );


endmodule

