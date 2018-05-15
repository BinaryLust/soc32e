

module divider2(
    input   logic          clk,
    input   logic          reset,
    input   logic  [31:0]  dividendIn,
    input   logic  [31:0]  divisorIn,
    input   logic          sign,
    input   logic          dividerStart,

    output  logic  [31:0]  quotientOut,
    output  logic  [31:0]  remainderOut,
    output  logic          dividerError,
    output  logic          dividerDone
    );


    import boolPkg::*;
    import divider2Pkg::*;


    // internal wires
    logic         wasNegative;
    bool          dividendEn;
    dividendMux   dividendSel;
    logic         fillerBit;
    bool          divisorEn;
    divisorMux    divisorSel;
    bool          remainderEn;
    remainderMux  remainderSel;

    logic  [31:0]  dividend;
    logic  [31:0]  divisor;
    logic  [31:0]  remainder;


    assign quotientOut  = dividend;
    assign remainderOut = remainder;


    divider2Controller
    divider2Controller(
        .clk,
        .reset,
        .sign,
        .dividerStart,
        .dividendIn,
        .divisorIn,
        .wasNegative,
        .dividendEn,
        .dividendSel,
        .fillerBit,
        .divisorEn,
        .divisorSel,
        .remainderEn,
        .remainderSel,
        .dividerDone,
        .dividerError
    );


    dividendState
    dividendState(
        .clk,
        .reset,
        .dividendEn,
        .dividendSel,
        .fillerBit,
        .dividendIn,
        .dividend
    );


    divisorState
    divisorState(
        .clk,
        .reset,
        .divisorEn,
        .divisorSel,
        .divisorIn,
        .divisor
    );


    remainderState
    remainderState(
        .clk,
        .reset,
        .remainderEn,
        .remainderSel,
        .dividend,
        .divisor,
        .wasNegative,
        .remainder
    );


endmodule

