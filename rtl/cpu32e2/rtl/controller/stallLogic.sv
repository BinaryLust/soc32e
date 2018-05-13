

module stallLogic(
    input   controllerPkg::states  state,
    input   architecture::opcodes  instruction,
    input   logic                  waitRequest,
    input   logic                  readValid,
    input   logic                  aluDone,
    input   logic                  shifterDone,
    input   logic                  multiplierDone,
    input   logic                  dividerDone,

    output  logic                  enable
    );


    import architecture::*;
    import controllerPkg::*;


    always_comb begin
        // default
        enable = 1'b1;

        case(state)
            EXECUTE0: casex(instruction)
                          ADC_I,
                          ADC_R,
                          UADC_I,
                          UADC_R,
                          ADD_I,
                          ADD_R,
                          UADD_I,
                          UADD_R,
                          AND_I,
                          AND_R,
                          TST_I,
                          TST_R,
                          NOT_R,
                          OR_I,
                          OR_R,
                          SBB_I,
                          SBB_R,
                          USBB_I,
                          USBB_R,
                          CMP_I,
                          CMP_R,
                          SUB_I,
                          SUB_R,
                          UCMP_I,
                          UCMP_R,
                          USUB_I,
                          USUB_R:  enable = (aluDone) ? 1'b1 : 1'b0;

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
                          SHL_I,
                          SHL_R,
                          SHR_I,
                          SHR_R:   enable = (shifterDone) ? 1'b1 : 1'b0;

                          SMUL_R,
                          UMUL_R:  enable = (multiplierDone) ? 1'b1 : 1'b0;

                          SDIV_R,
                          UDIV_R:  enable = (dividerDone) ? 1'b1 : 1'b0;

                          default: enable = 1'b1;
                      endcase

            FETCH1,
            MEMORY1:  enable = (waitRequest) ? 1'b0 : 1'b1;

            FETCH3,
            MEMORY3:  enable = (readValid) ? 1'b1 : 1'b0;

            default:  enable = 1'b1;
        endcase
    end


endmodule

