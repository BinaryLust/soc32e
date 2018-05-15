

module resetSync(
    input   logic  clk,
    input   logic  masterReset,

    output  logic  syncedReset
    );


    logic  sync0;
    logic  sync1;


    always_ff @(posedge clk or posedge masterReset) begin
        if(masterReset) begin
            sync0 <= 1'b1;
            sync1 <= 1'b1;
        end else begin
            sync0 <= 1'b0;
            sync1 <= sync0;
        end
    end


    assign syncedReset = sync1;


endmodule

