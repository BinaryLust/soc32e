

module remainderState(
    input   logic                              clk,
    input   logic                              reset,
    input   boolPkg::bool                      remainderEn,
    input   divider2Pkg::remainderMux          remainderSel,
    input   logic                      [31:0]  dividend,
    input   logic                      [31:0]  divisor,

    output  logic                              wasNegative,
    output  logic                      [31:0]  remainder
    );


    import divider2Pkg::*;


    logic  [31:0]  remainderNext;
    logic  [31:0]  shiftedRemainder;
    logic  [31:0]  subtractedRemainder;


    // Register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            remainder <= 32'b0;
        else if(remainderEn)
            remainder <= remainderNext;
        else
            remainder <= remainder;
    end


    // Combinationial Logic
    always_comb begin
        shiftedRemainder                   = {remainder[30:0], dividend[31]};
        {wasNegative, subtractedRemainder} = shiftedRemainder - divisor;

        case(remainderSel)
            RESET_REMAINDER:      remainderNext = 32'b0;
            NEG_REMAINDER:        remainderNext = -remainder;
            SHIFTED_REMAINDER:    remainderNext = shiftedRemainder;
            SUBTRACTED_REMAINDER: remainderNext = subtractedRemainder;
        endcase
    end


endmodule

