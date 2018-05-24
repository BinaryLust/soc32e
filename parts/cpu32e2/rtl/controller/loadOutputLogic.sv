

module loadOutputLogic(
    input   logic                          clk,
    input   logic                          reset,
    input   logic                          enable, // for stalling
    input   architecture::opcodes          instruction,
    //input   decoderPkg::instructions       instruction,
    input   controllerPkg::states          state,
    input   boolPkg::bool                  conditionResult,

    output  loadGroup::controlBus          loadControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import loadGroup::*;


    loadGroup::controlBus  loadControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            loadControl <= NO_OP;
        else if(enable)
            loadControl <= loadControlNext;
        else
            loadControl <= loadControl;
    end


    // output logic
    always_comb begin
        // default
        loadControlNext = NO_OP;

        case(state)
            DECODE:  casex(instruction)
                         BR_PR,
                         BRL_PR:  loadControlNext = (conditionResult) ? NEXTPC_IMM24 : NO_OP; // don't load if we aren't going to branch anyway

                         BR_RO,
                         BRL_RO:  loadControlNext = (conditionResult) ? RFA_IMM19    : NO_OP; // don't load if we aren't going to branch anyway

                         LDBS_PR,
                         LDBU_PR,
                         LDD_PR,
                         LDWS_PR,
                         LDWU_PR: loadControlNext = NEXTPC_IMM21B;

                         STB_PR,
                         STD_PR,
                         STW_PR:  loadControlNext = NEXTPC_IMM21C;

                         MUI_I:   loadControlNext = NULL_COMBO;

                         NOT_R:   loadControlNext = NULL_RFB;

                         ADC_I,
                         ADD_I,
                         AND_I,
                         LDBS_RO,
                         LDBS_IA,
                         LDBS_IB,
                         LDBU_RO,
                         LDBU_IA,
                         LDBU_IB,
                         LDD_RO,
                         LDD_IA,
                         LDD_IB,
                         LDWS_RO,
                         LDWS_IA,
                         LDWS_IB,
                         LDWU_RO,
                         LDWU_IA,
                         LDWU_IB,
                         OR_I,
                         SBB_I,
                         SUB_I,
                         UADC_I,
                         UADD_I,
                         USBB_I,
                         USUB_I,
                         XOR_I:   loadControlNext = RFA_IMM16A;

                         STB_RO,
                         STB_IA,
                         STB_IB,
                         STD_RO,
                         STD_IA,
                         STD_IB,
                         STW_RO,
                         STW_IA,
                         STW_IB:  loadControlNext = RFA_IMM16B;

                         CMP_I,
                         TEQ_I,
                         TST_I,
                         UCMP_I:  loadControlNext = RFA_IMM21A;

                         RCL_I,
                         RCR_I,
                         ROL_I,
                         ROR_I,
                         SAR_I,
                         SHL_I,
                         SHR_I:   loadControlNext = RFA_IMM5;

                         ADC_R,
                         ADD_R,
                         AND_R,
                         CMP_R,
                         OR_R,
                         RCL_R,
                         RCR_R,
                         ROL_R,
                         ROR_R,
                         SAR_R,
                         SBB_R,
                         SDIV_R,
                         SHL_R,
                         SHR_R,
                         SMUL_R,
                         SUB_R,
                         TEQ_R,
                         TST_R,
                         UADC_R,
                         UADD_R,
                         UCMP_R,
                         UDIV_R,
                         UMUL_R,
                         USBB_R,
                         USUB_R,
                         XOR_R:   loadControlNext = RFA_RFB;

                         default: loadControlNext = NO_OP;
                     endcase

            default: loadControlNext = NO_OP;
        endcase
    end


endmodule

