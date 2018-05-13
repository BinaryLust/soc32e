

module regfileAOutputLogic(
    input   logic                              clk,
    input   logic                              reset,
    input   logic                              enable, // for stalling
    input   architecture::opcodes              instruction,
    //input   decoderPkg::instructions           instruction,
    input   controllerPkg::states              state,
    input   boolPkg::bool                      conditionResult,
    input   logic                              exceptionPending,
    input   logic                              interruptPending,

    output  regfileAGroup::controlBus          regfileAControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import regfileAGroup::*;


    regfileAGroup::controlBus  regfileAControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            regfileAControl <= NO_OP;
        else if(enable)
            regfileAControl <= regfileAControlNext;
        else
            regfileAControl <= regfileAControl;
    end


    // output logic
    always_comb begin
        // default
        regfileAControlNext = NO_OP;

        case(state)
            DECODE:    casex(instruction)
                           BRL_R:   regfileAControlNext = (conditionResult) ? NEXTPC_LR : NO_OP; // don't load if we aren't going to branch anyway

                           LSR_R:   regfileAControlNext = SYSREG_DRL;

                           default: regfileAControlNext = NO_OP;
                       endcase

            LOAD:      casex(instruction)
                           MOV_I,
                           MOV_R,
                           MUI_I:   regfileAControlNext = BREG_DRL;

                           default: regfileAControlNext = NO_OP;
                       endcase

            EXECUTE0:  casex(instruction)
                           BRL_PR,
                           BRL_RO:  regfileAControlNext = NEXTPC_LR;

                           default: regfileAControlNext = NO_OP;
                       endcase

            EXECUTE1:  casex(instruction)
                           ADC_I,
                           ADC_R,
                           ADD_I,
                           ADD_R,
                           AND_I,
                           AND_R,
                           NOT_R,
                           OR_I,
                           OR_R,
                           RCL_I,
                           RCL_R,
                           RCR_I,
                           RCR_R,
                           ROL_I,
                           ROL_R,
                           ROR_I,
                           ROR_R,
                           SAR_I,
                           SAR_R,
                           SBB_I,
                           SBB_R,
                           SDIV_R,
                           SHL_I,
                           SHL_R,
                           SHR_I,
                           SHR_R,
                           SMUL_R,
                           SUB_I,
                           SUB_R,
                           UADC_I,
                           UADC_R,
                           UADD_I,
                           UADD_R,
                           UDIV_R,
                           UMUL_R,
                           USBB_I,
                           USBB_R,
                           USUB_I,
                           USUB_R,
                           XOR_I,
                           XOR_R:   regfileAControlNext = RESULT_DRL;

                           default: regfileAControlNext = NO_OP;
                       endcase

            MEMORY3:   casex(instruction)
                           LDD_PR,
                           LDD_R,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB:  regfileAControlNext = DWORD_DRL;

                           LDBS_PR,
                           LDBS_R,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB: regfileAControlNext = SBYTE_DRL;

                           LDWS_PR,
                           LDWS_R,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB: regfileAControlNext = SWORD_DRL;

                           LDBU_PR,
                           LDBU_R,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB: regfileAControlNext = UBYTE_DRL;

                           LDWU_PR,
                           LDWU_R,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB: regfileAControlNext = UWORD_DRL;

                           default: regfileAControlNext = NO_OP;
                       endcase

            //WRITEBACK: regfileAControlNext = (exceptionPending || interruptPending) ? NEXTPC_EPC : NO_OP;

            INTERRUPT: regfileAControlNext = NEXTPC_EPC;

            default:   regfileAControlNext = NO_OP;
        endcase
    end


endmodule

