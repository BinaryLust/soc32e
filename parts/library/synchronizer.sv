

module synchronizer
    #(parameter WIDTH  = 1)(
    input   logic               clk,
    input   logic               reset,

    input   logic  [WIDTH-1:0]  in,
    output  logic  [WIDTH-1:0]  out
    );


    logic  [WIDTH-1:0]  syncReg1;
    logic  [WIDTH-1:0]  syncReg2;


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            syncReg1 <= {WIDTH{1'b0}};
            syncReg2 <= {WIDTH{1'b0}};
        end else begin
            syncReg1 <= in;
            syncReg2 <= syncReg1;
        end
    end


    assign out = syncReg2;


endmodule

