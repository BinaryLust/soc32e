

package resultGroup;


    import boolPkg::*;


    // result high mux values
    typedef enum logic {
        MULTIPLIER_HIGH   = 1'b0,
        DIVIDER_REMAINDER = 1'b1
    } resultHighMux;


    // result low mux values
    typedef enum logic [1:0] {
        ALU_RESULT        = 2'b00,
        SHIFTER_RESULT    = 2'b01,
        MULTIPLIER_LOW    = 2'b10,
        DIVIDER_QUOTIENT  = 2'b11
    } resultLowMux;


    // control group structure
    typedef struct packed {
        bool               resultHighEn;
        bool               resultLowEn;
        resultHighMux      resultHighSel;
        resultLowMux       resultLowSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP           = '{resultHighEn:F, resultLowEn:F, resultHighSel:MULTIPLIER_HIGH,   resultLowSel:ALU_RESULT},
        LOAD_ALU        = '{resultHighEn:F, resultLowEn:T, resultHighSel:MULTIPLIER_HIGH,   resultLowSel:ALU_RESULT},
        LOAD_SHIFTER    = '{resultHighEn:F, resultLowEn:T, resultHighSel:MULTIPLIER_HIGH,   resultLowSel:SHIFTER_RESULT},
        LOAD_MULTIPLIER = '{resultHighEn:T, resultLowEn:T, resultHighSel:MULTIPLIER_HIGH,   resultLowSel:MULTIPLIER_LOW},
        LOAD_DIVIDER    = '{resultHighEn:T, resultLowEn:T, resultHighSel:DIVIDER_REMAINDER, resultLowSel:DIVIDER_QUOTIENT};


endpackage


package resultFlagsGroup;


    import boolPkg::*;


    // carry result mux values
    typedef enum logic [1:0] {
        ALU_CARRY         = 2'b00,
        SHIFTER_CARRY     = 2'b01,
        CARRY_CLEAR       = 2'b10
    } carryResultMux;



    // negative result mux values
    typedef enum logic { //[1:0] {
        BIT31             = 1'b0,
        BIT63             = 1'b1
    } negativeResultMux;



    // zero result mux values
    typedef enum logic { // [1:0] {
        CHECK32           = 1'b0,
        CHECK64           = 1'b1
    } zeroResultMux;



    // overflow result mux values
    typedef enum logic {
        ALU_OVERFLOW      = 1'b0,
        OVERFLOW_CLEAR    = 1'b1
    } overflowResultMux;


    // control group structure
    typedef struct packed {
        bool               flagResultEn;
        carryResultMux     carryResultSel;
        negativeResultMux  negativeResultSel;
        zeroResultMux      zeroResultSel;
        overflowResultMux  overflowResultSel;
        bool               overflowExceptionEn; // not sure if this should be here or not
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP        = '{flagResultEn:F, carryResultSel:ALU_CARRY,     negativeResultSel:BIT31, zeroResultSel:CHECK32, overflowResultSel:ALU_OVERFLOW,   overflowExceptionEn:F},
        LOAD_ARITH   = '{flagResultEn:T, carryResultSel:ALU_CARRY,     negativeResultSel:BIT31, zeroResultSel:CHECK32, overflowResultSel:ALU_OVERFLOW,   overflowExceptionEn:F},
        LOAD_ARITH_O = '{flagResultEn:T, carryResultSel:ALU_CARRY,     negativeResultSel:BIT31, zeroResultSel:CHECK32, overflowResultSel:ALU_OVERFLOW,   overflowExceptionEn:T},
        LOAD_LOGIC   = '{flagResultEn:T, carryResultSel:CARRY_CLEAR,   negativeResultSel:BIT31, zeroResultSel:CHECK32, overflowResultSel:OVERFLOW_CLEAR, overflowExceptionEn:F},
        LOAD_SHIFT   = '{flagResultEn:T, carryResultSel:SHIFTER_CARRY, negativeResultSel:BIT31, zeroResultSel:CHECK32, overflowResultSel:OVERFLOW_CLEAR, overflowExceptionEn:F},
        LOAD_MULT    = '{flagResultEn:T, carryResultSel:CARRY_CLEAR,   negativeResultSel:BIT63, zeroResultSel:CHECK64, overflowResultSel:OVERFLOW_CLEAR, overflowExceptionEn:F};


endpackage


module result(
    input   logic                                 clk,
    input   resultGroup::controlBus               resultControl,
    input   resultFlagsGroup::controlBus          resultFlagsControl,
    input   logic                         [31:0]  multiplierResultHigh,
    input   logic                         [31:0]  dividerRemainder,
    input   logic                         [31:0]  aluResult,
    input   logic                         [31:0]  shifterResult,
    input   logic                         [31:0]  multiplierResultLow,
    input   logic                         [31:0]  dividerQuotient,
    input   logic                                 aluCarry,
    input   logic                                 shifterCarry,
    input   logic                                 aluOverflow,
    output  logic                         [31:0]  resultHigh,
    output  logic                         [31:0]  resultLow,
    output  logic                         [3:0]   resultFlags,
    output  logic                                 overflowException
    );


    import resultGroup::*;
    import resultFlagsGroup::*;


    logic  [31:0]  resultHighNext;
    logic  [31:0]  resultLowNext;
    logic          carryResultNext;
    logic          negativeResultNext;
    logic          zeroResultNext;
    logic          overflowResultNext;
    logic          zeroLow;
    logic          zeroHigh;


    // Registers
    always_ff @(posedge clk) begin
        if(resultControl.resultHighEn)
            resultHigh <= resultHighNext;
        else
            resultHigh <= resultHigh;


        if(resultControl.resultLowEn)
            resultLow  <= resultLowNext;
        else
            resultLow  <= resultLow;


        if(resultFlagsControl.flagResultEn) begin
            // group all flags
            resultFlags <= {negativeResultNext, overflowResultNext, zeroResultNext, carryResultNext};
        end else begin
            resultFlags <= resultFlags;
        end
    end


    // Combinational Logic
    always_comb begin
        // result high mux
        case(resultControl.resultHighSel)
            MULTIPLIER_HIGH:   resultHighNext = multiplierResultHigh;
            DIVIDER_REMAINDER: resultHighNext = dividerRemainder;
            default:           resultHighNext = multiplierResultHigh;
        endcase


        // result low mux
        case(resultControl.resultLowSel)
            ALU_RESULT:        resultLowNext = aluResult;
            SHIFTER_RESULT:    resultLowNext = shifterResult;
            MULTIPLIER_LOW:    resultLowNext = multiplierResultLow;
            DIVIDER_QUOTIENT:  resultLowNext = dividerQuotient;
            default:           resultLowNext = multiplierResultLow;
        endcase


        // carry result mux
        case(resultFlagsControl.carryResultSel)
            ALU_CARRY:         carryResultNext = aluCarry;
            SHIFTER_CARRY:     carryResultNext = shifterCarry;
            CARRY_CLEAR:       carryResultNext = 1'b0;
            default:           carryResultNext = aluCarry;
        endcase


        // negative result mux
        case(resultFlagsControl.negativeResultSel)
            BIT31:             negativeResultNext = resultLowNext[31];
            BIT63:             negativeResultNext = resultHighNext[31];
            default:           negativeResultNext = resultLowNext[31];
        endcase


        // zero check logic
        zeroLow  = ~|resultLowNext;
        zeroHigh = ~|resultHighNext;


        // zero result mux
        case(resultFlagsControl.zeroResultSel)
            CHECK32:           zeroResultNext = zeroLow;
            CHECK64:           zeroResultNext = zeroHigh & zeroLow;
            default:           zeroResultNext = zeroLow;
        endcase


        // overflow result mux
        case(resultFlagsControl.overflowResultSel)
            ALU_OVERFLOW:      overflowResultNext = aluOverflow;
            OVERFLOW_CLEAR:    overflowResultNext = 1'b0;
            default:           overflowResultNext = aluOverflow;
        endcase


        // overflow exception check
        overflowException = resultFlagsControl.overflowExceptionEn & overflowResultNext;
    end


endmodule

