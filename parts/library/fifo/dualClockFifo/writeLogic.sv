

module writeLogic
    #(parameter WIDTH  = 4)(
    input   logic               clk,
    input   logic               reset,
    input   logic               writeEn,
    input   logic  [WIDTH-1:0]  syncedReadPtrGray,

    output  logic  [WIDTH-2:0]  writePtrBinary,
    output  logic  [WIDTH-1:0]  writePtrGray,
    output  logic               full
    );


    logic  [WIDTH-1:0]  writePtrBinaryReg;
    logic  [WIDTH-1:0]  writePtrBinaryRegNext;
    logic               fullNext;


    // binary pointer register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            writePtrBinaryReg <= {WIDTH{1'b0}};
        else
            writePtrBinaryReg <= writePtrBinaryRegNext;
    end


    // gray pointer register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            writePtrGray <= {WIDTH{1'b0}};
        else
            writePtrGray <= writePtrGrayNext;
    end


    // full flag register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            full <= 1'b0;
        else
            full <= fullNext;
    end


    // combinational logic
    assign writePtrBinaryRegNext = (writeEn) ? writePtrBinaryReg + {WIDTH-1{1'b0}, 1'b1} : writePtrBinaryReg;
    assign writePtrGrayNext      = (writePtrBinaryRegNext >> 1) ^ writePtrBinaryRegNext; // binary to gray code
    assign fullNext              = (writePtrGrayNext[WIDTH-1] != syncedReadPtrGray[WIDTH-1]) &&
                                   (writePtrGrayNext[WIDTH-2] != syncedReadPtrGray[WIDTH-2]) &&
                                   (writePtrGrayNext[WIDTH-3:0] == syncedReadPtrGray[WIDTH-3:0]);
    assign writePtrBinary        = writePtrBinaryReg[WIDTH-2:0]; // chop off the msb


endmodule

