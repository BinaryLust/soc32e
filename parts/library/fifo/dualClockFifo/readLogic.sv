

module readLogic
    #(parameter WIDTH  = 4)(
    input   logic               clk,
    input   logic               reset,
    input   logic               readReq,
    input   logic  [WIDTH-1:0]  syncedWritePtrGray,

    output  logic  [WIDTH-2:0]  readPtrBinary,
    output  logic  [WIDTH-1:0]  readPtrGray,
    output  logic               empty
    );


    logic  [WIDTH-1:0]  readPtrBinaryReg;
    logic  [WIDTH-1:0]  readPtrBinaryRegNext;
    logic  [WIDTH-1:0]  readPtrGrayNext;
    logic               emptyNext;


    // binary pointer register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readPtrBinaryReg <= {WIDTH{1'b0}};
        else
            readPtrBinaryReg <= readPtrBinaryRegNext;
    end


    // gray pointer register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            readPtrGray <= {WIDTH{1'b0}};
        else
            readPtrGray <= readPtrGrayNext;
    end


    // empty flag register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            empty <= 1'b1;
        else
            empty <= emptyNext;
    end


    // combinational logic
    assign readPtrBinaryRegNext = (readReq) ? readPtrBinaryReg + {{WIDTH-1{1'b0}}, 1'b1} : readPtrBinaryReg;
    assign readPtrGrayNext      = (readPtrBinaryRegNext >> 1) ^ readPtrBinaryRegNext; // binary to gray code
    assign emptyNext            = (syncedWritePtrGray == readPtrGrayNext);
    assign readPtrBinary        = readPtrBinaryReg[WIDTH-2:0]; // chop off the msb


endmodule

