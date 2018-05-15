

module regfileBOutputLogic(
    input   logic                              clk,
    input   logic                              reset,
    input   logic                              enable, // for stalling
    input   architecture::opcodes              instruction,
    //input   decoderPkg::instructions           instruction,
    input   controllerPkg::states              state,

    output  regfileBGroup::controlBus          regfileBControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import regfileBGroup::*;


    regfileBGroup::controlBus  regfileBControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            regfileBControl <= NO_OP;
        else if(enable)
            regfileBControl <= regfileBControlNext;
        else
            regfileBControl <= regfileBControl;
    end


    // output logic
    always_comb begin
        // default
        regfileBControlNext = NO_OP;

        case(state)
            EXECUTE1: casex(instruction)
                          SDIV_R,
                          SMUL_R,
                          UDIV_R,
                          UMUL_R:  regfileBControlNext = RESULT_DRH;

                          default: regfileBControlNext = NO_OP;
                      endcase

            MEMORY1:  casex(instruction)
                          STB_IA,
                          STB_IB,
                          STD_IA,
                          STD_IB,
                          STW_IA,
                          STW_IB:  regfileBControlNext = CALC_SRA;

                          default: regfileBControlNext = NO_OP;
                      endcase

            MEMORY3:  casex(instruction)
                          LDBS_IA,
                          LDBS_IB,
                          LDBU_IA,
                          LDBU_IB,
                          LDD_IA,
                          LDD_IB,
                          LDWS_IA,
                          LDWS_IB,
                          LDWU_IA,
                          LDWU_IB: regfileBControlNext = CALC_SRA;

                          default: regfileBControlNext = NO_OP;
                      endcase

            default:  regfileBControlNext = NO_OP;
        endcase
    end


endmodule

