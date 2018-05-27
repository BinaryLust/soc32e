

module exceptionTriggerOutputLogic(
    input   logic                                      clk,
    input   logic                                      reset,
    input   logic                                      enable, // for stalling
    input   architecture::opcodes                      instruction,
    //input   decoderPkg::instructions                   instruction,
    input   controllerPkg::states                      state,
    input   logic                              [1:0]   dataSelectBits,

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
            FETCH1:   if(dataSelectBits != 2'b00) exceptionTriggerControlNext <= INSTA_EXC;

            DECODE:   casex(instruction)
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
                          UKN15_R,
                          UKN16_R,
                          UKN17_R,
                          UKN18_R,
                          UKN19_R,
                          UKN20_R,
                          UKN21_R,
                          UKN22_R,
                          UKN23_R,
                          UKN24_R,
                          UKN25_R,
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

            EXECUTE1: casex(instruction)
                          STD_PR,
                          STD_RO,
                          STD_IA,
                          STD_IB:  if(dataSelectBits != 2'b00) exceptionTriggerControlNext <= DATAA_EXC;

                          STW_PR,
                          STW_RO,
                          STW_IA,
                          STW_IB:  if(dataSelectBits[0] != 1'b0) exceptionTriggerControlNext <= DATAA_EXC;

                          default: exceptionTriggerControlNext <= NO_OP;
                      endcase

            MEMORY1:  casex(instruction)
                          LDD_PR,
                          LDD_RO,
                          LDD_IA,
                          LDD_IB:  if(dataSelectBits != 2'b00) exceptionTriggerControlNext <= DATAA_EXC;

                          LDWS_PR,
                          LDWS_RO,
                          LDWS_IA,
                          LDWS_IB,
                          LDWU_PR,
                          LDWU_RO,
                          LDWU_IA,
                          LDWU_IB: if(dataSelectBits[0] != 1'b0) exceptionTriggerControlNext <= DATAA_EXC;

                          default: exceptionTriggerControlNext <= NO_OP;
                      endcase

            default: exceptionTriggerControlNext <= NO_OP;
        endcase
    end


endmodule

