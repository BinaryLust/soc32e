

module grayCounter
    #(parameter WIDTH  = 1)(
    input   logic               clk,
    input   logic               reset,
    input   logic               inc,

    output  logic  [WIDTH-1:0]  binaryCount,
    output  logic  [WIDTH-1:0]  grayCount
    );


    // binary count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            binaryCount <= {WIDTH{1'b0}};
        else
            binaryCount <= binaryCountNext;
    end


    // gray count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            grayCount <= {WIDTH{1'b0}};
        else
            grayCount <= grayCountNext;
    end


    // combinational logic
    assign binaryCountNext = (inc) ? binaryCount + {WIDTH-1{1'b0}, 1'b1} : binaryCount;
    assign grayCountNext   = (binaryCountNext >> 1) ^ binaryCountNext; // binary to gray code


endmodule

