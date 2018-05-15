

module exceptionTriggerOutputLogic(
    input   logic                                      clk,
    input   logic                                      reset,
    input   logic                                      enable, // for stalling
    input   architecture::opcodes                      instruction,
    //input   decoderPkg::instructions                   instruction,
    input   controllerPkg::states                      state,

    output  exceptionTriggerGroup::controlBus          exceptionTriggerControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import exceptionTriggerGroup::*;


    exceptionTriggerGroup::controlBus  exceptionTriggerControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            exceptionTriggerControl <= NO_OP;
        else if(enable)
            exceptionTriggerControl <= exceptionTriggerControlNext;
        else
            exceptionTriggerControl <= exceptionTriggerControl;
    end


    // output logic
    always_comb begin
        // default
        exceptionTriggerControlNext = NO_OP;

        case(state)
            DECODE:  casex(instruction)
                         BREAK_R: exceptionTriggerControlNext <= BREAK_EXC;

                         INT_I:   exceptionTriggerControlNext <= SYS_EXC;

                         UKN1_R,
                         UKN2_R,
                         UKN3_R,
                         UKN4_R,
                         UKN5_R,
                         UKN6_R,
                         UKN7_R,
                         UKN8_R,
                         UKN9_R,
                         UKN10_R,
                         UKN11_R,
                         UKN12_R,
                         UKN13_R,
                         UKN14_R,
                         UKN1_I,
                         UKN2_I,
                         UKN3_I,
                         UKN4_I,
                         UKN5_I,
                         UKN6_I,
                         UKN7_I,
                         UKN8_I,
                         UKN9_I:  exceptionTriggerControlNext <= UNK_EXC;

                         default: exceptionTriggerControlNext <= NO_OP;
                     endcase

            default: exceptionTriggerControlNext <= NO_OP;
        endcase
    end


endmodule

