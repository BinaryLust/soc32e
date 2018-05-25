

module controllerState(
    input   logic                           clk,
    input   logic                           reset,
    input   logic                           enable, // for stalling
    input   architecture::opcodes           instruction,
    //input   decoderPkg::instructions        instruction,
    input   boolPkg::bool                   conditionResult,
    input   logic                           exceptionPending,
    input   logic                           interruptPending,

    output  controllerPkg::states           state
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;


    controllerPkg::states  nextState;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= RESET0;
        else if(enable)
            state <= nextState;
        else
            state <= state;
    end


    // next state logic
    always_comb begin
        // default
         nextState = RESET0;

        case(state)
            RESET0:    nextState = RESET1;
            RESET1:    nextState = FETCH0;
            FETCH0:    nextState = FETCH1;
            FETCH1:    nextState = FETCH2;
            FETCH2:    nextState = FETCH3;
            FETCH3:    nextState = DECODE;
            DECODE:    casex(instruction)
                           ADC_I,
                           ADC_R,
                           ADD_I,
                           ADD_R,
                           AND_I,
                           AND_R,
                           CMP_I,
                           CMP_R,
                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB,
                           MOV_I,
                           MUI_I,
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
                           STB_PR,
                           STB_RO,
                           STB_IA,
                           STB_IB,
                           STD_PR,
                           STD_RO,
                           STD_IA,
                           STD_IB,
                           STW_PR,
                           STW_RO,
                           STW_IA,
                           STW_IB,
                           SUB_I,
                           SUB_R,
                           TEQ_I,
                           TEQ_R,
                           TST_I,
                           TST_R,
                           UADC_I,
                           UADC_R,
                           UADD_I,
                           UADD_R,
                           UCMP_I,
                           UCMP_R,
                           UDIV_R,
                           UMUL_R,
                           USBB_I,
                           USBB_R,
                           USUB_I,
                           USUB_R,
                           XOR_I,
                           XOR_R:   nextState = LOAD;

                           BR_PR,
                           BR_RO,
                           BRL_PR,
                           BRL_RO:  nextState = (conditionResult) ? LOAD : WRITEBACK; // skip address calculation if we aren't going to branch anyway

                           IRET_R,
                           NOP_R,
                           LSR_R,
                           SSR_R:   nextState = WRITEBACK;

                           default: nextState = EXECUTE0; // BREAK_R, INT_I // and all unknown instructions
                       endcase

            LOAD:      casex(instruction)
                           ADC_I,
                           ADC_R,
                           ADD_I,
                           ADD_R,
                           AND_I,
                           AND_R,
                           BR_PR,
                           BR_RO,
                           BRL_PR,
                           BRL_RO,
                           CMP_I,
                           CMP_R,
                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB,
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
                           STB_PR,
                           STB_RO,
                           STB_IA,
                           STB_IB,
                           STD_PR,
                           STD_RO,
                           STD_IA,
                           STD_IB,
                           STW_PR,
                           STW_RO,
                           STW_IA,
                           STW_IB,
                           SUB_I,
                           SUB_R,
                           TEQ_I,
                           TEQ_R,
                           TST_I,
                           TST_R,
                           UADC_I,
                           UADC_R,
                           UADD_I,
                           UADD_R,
                           UCMP_I,
                           UCMP_R,
                           UDIV_R,
                           UMUL_R,
                           USBB_I,
                           USBB_R,
                           USUB_I,
                           USUB_R,
                           XOR_I,
                           XOR_R:   nextState = EXECUTE0;

                           MOV_I,
                           MUI_I:   nextState = WRITEBACK;

                           default: nextState = RESET0;
                       endcase

            EXECUTE0:  casex(instruction)
                           ADC_I,
                           ADC_R,
                           ADD_I,
                           ADD_R,
                           AND_I,
                           AND_R,
                           CMP_I,
                           CMP_R,
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
                           TEQ_I,
                           TEQ_R,
                           TST_I,
                           TST_R,
                           UADC_I,
                           UADC_R,
                           UADD_I,
                           UADD_R,
                           UCMP_I,
                           UCMP_R,
                           UDIV_R,
                           UMUL_R,
                           USBB_I,
                           USBB_R,
                           USUB_I,
                           USUB_R,
                           XOR_I,
                           XOR_R:   nextState = EXECUTE1;

                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB: nextState = MEMORY1;

                           STB_PR,
                           STB_RO,
                           STB_IA,
                           STB_IB,
                           STD_PR,
                           STD_RO,
                           STD_IA,
                           STD_IB,
                           STW_PR,
                           STW_RO,
                           STW_IA,
                           STW_IB:  nextState = EXECUTE1;

                           BR_PR,
                           BR_RO,
                           BREAK_R,
                           BRL_PR,
                           BRL_RO,
                           INT_I,
                           UKN1_I,
                           UKN2_I,
                           UKN3_I,
                           UKN4_I,
                           UKN5_I,
                           UKN6_I,
                           UKN7_I,
                           UKN8_I,
                           UKN9_I,
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
                           UKN25_R: nextState = WRITEBACK;

                           default: nextState = RESET0;
                       endcase

            EXECUTE1:  casex(instruction)
                           STB_PR,
                           STB_RO,
                           STB_IA,
                           STB_IB,
                           STD_PR,
                           STD_RO,
                           STD_IA,
                           STD_IB,
                           STW_PR,
                           STW_RO,
                           STW_IA,
                           STW_IB:  nextState = MEMORY1;

                           ADC_I,
                           ADC_R,
                           ADD_I,
                           ADD_R,
                           AND_I,
                           AND_R,
                           CMP_I,
                           CMP_R,
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
                           TEQ_I,
                           TEQ_R,
                           TST_I,
                           TST_R,
                           UADC_I,
                           UADC_R,
                           UADD_I,
                           UADD_R,
                           UCMP_I,
                           UCMP_R,
                           UDIV_R,
                           UMUL_R,
                           USBB_I,
                           USBB_R,
                           USUB_I,
                           USUB_R,
                           XOR_I,
                           XOR_R:   nextState = WRITEBACK;

                           default: nextState = RESET0;
                       endcase

            MEMORY1:   casex(instruction)
                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB: nextState = MEMORY2;

                           STB_PR,
                           STB_RO,
                           STB_IA,
                           STB_IB,
                           STD_PR,
                           STD_RO,
                           STD_IA,
                           STD_IB,
                           STW_PR,
                           STW_RO,
                           STW_IA,
                           STW_IB:  nextState = WRITEBACK;

                           default: nextState = RESET0;
                       endcase

            MEMORY2:   casex(instruction)
                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB: nextState = MEMORY3;

                           default: nextState = RESET0;
                       endcase

            MEMORY3:   casex(instruction)
                           LDBS_PR,
                           LDBS_RO,
                           LDBS_IA,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RO,
                           LDBU_IA,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RO,
                           LDD_IA,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RO,
                           LDWS_IA,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RO,
                           LDWU_IA,
                           LDWU_IB: nextState = WRITEBACK;

                           default: nextState = RESET0;
                       endcase

            WRITEBACK: nextState = (exceptionPending || interruptPending) ? INTERRUPT : FETCH0;

            INTERRUPT: nextState = RESET1;

            default:   nextState = RESET0;
        endcase
    end

endmodule

