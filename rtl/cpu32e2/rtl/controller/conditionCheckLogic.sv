

module conditionCheckLogic(
    input   architecture::conditions         condition,
    input   logic                     [3:0]  flags,

    output  boolPkg::bool                    conditionResult
    );


    import boolPkg::*;
    import architecture::*;


    logic carryFlag;
    logic zeroFlag;
    logic overflowFlag;
    logic negativeFlag;


    assign {negativeFlag, overflowFlag, zeroFlag, carryFlag} = flags;


    always_comb begin
        case(condition)
            UNCONDITIONAL:    conditionResult = T;
            ZERO:             conditionResult = (zeroFlag)                                    ? T : F;
            NOTZERO:          conditionResult = (!zeroFlag)                                   ? T : F;
            CARRY:            conditionResult = (carryFlag)                                   ? T : F;
            NOTCARRY:         conditionResult = (!carryFlag)                                  ? T : F;
            OVERFLOW:         conditionResult = (overflowFlag)                                ? T : F;
            NOTOVERFLOW:      conditionResult = (!overflowFlag)                               ? T : F;
            NEGATIVE:         conditionResult = (negativeFlag)                                ? T : F;
            NOTNEGATIVE:      conditionResult = (!negativeFlag)                               ? T : F;
            GREATER_U:        conditionResult = (carryFlag && !zeroFlag)                      ? T : F;
            LESSOREQUAL_U:    conditionResult = (!carryFlag || zeroFlag)                      ? T : F;
            GREATER_S:        conditionResult = (!zeroFlag && (negativeFlag == overflowFlag)) ? T : F;
            LESS_S:           conditionResult = (negativeFlag != overflowFlag)                ? T : F;
            GREATEROREQUAL_S: conditionResult = (negativeFlag == overflowFlag)                ? T : F;
            LESSOREQUAL_S:    conditionResult = (zeroFlag && (negativeFlag != overflowFlag))  ? T : F;
            default:          conditionResult = F;
        endcase
    end


endmodule

