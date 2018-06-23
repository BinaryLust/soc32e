

module synchronizerEdge(
    input   logic  clk,
    input   logic  reset,
    input   logic  in,

    output  logic  out,
    output  logic  outRose
    );


    logic  syncReg1;
    logic  syncReg2;
    logic  pulseReg;


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            syncReg1 <= 1'b0;
            syncReg2 <= 1'b0;
            pulseReg <= 1'b0;
        end else begin
            syncReg1 <= in;
            syncReg2 <= syncReg1;
            pulseReg <= syncReg2;
        end
    end


    assign out     = pulseReg;
    assign outRose = (syncReg2 && !pulseReg); // detect the rising edge of the signal


endmodule

