

module dividendState(
    input   logic                             clk,
    input   logic                             reset,
    input   boolPkg::bool                     dividendEn,
    input   divider2Pkg::dividendMux          dividendSel,
    input   logic                             fillerBit,
    input   logic                     [31:0]  dividendIn,

    output  logic                     [31:0]  dividend
    );


    import divider2Pkg::*;


    logic  [31:0]  dividendNext;


    // Register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dividend <= 32'b0;
        else if(dividendEn)
            dividend <= dividendNext;
        else
            dividend <= dividend;
    end


    // Combinationial Logic
    always_comb begin
        case(dividendSel)
            RESET_DIVIDEND:   dividendNext = 32'b0;
            DIVIDEND_IN:      dividendNext = dividendIn;
            NEG_DIVIDEND_IN:  dividendNext = -dividendIn;
            NEG_DIVIDEND:     dividendNext = -dividend;
            SHIFTED_DIVIDEND: dividendNext = {dividend[30:0], fillerBit};
            default:          dividendNext = dividendIn;
        endcase
    end


endmodule

