

module io(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic  [7:0]   ioOut
    );


    logic  [7:0]  dataInReg;
    logic         readReg;
    logic         writeReg;


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
        dataInReg    <= dataIn[7:0];
        dataOut[7:0] <= ioOut;
    end


    // the rest of the output to save registers
    assign dataOut[31:8] = 24'b0;


    // the actual device core
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ioOut <= 8'b0;
        else if(writeReg)
            ioOut <= dataInReg;
        else
            ioOut <= ioOut;
    end


endmodule

