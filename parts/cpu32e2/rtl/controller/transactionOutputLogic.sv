

module transactionOutputLogic(
    input   logic                                clk,
    input   logic                                reset,
    input   logic                                enable, // for stalling
    input   architecture::opcodes                instruction,
    //input   decoderPkg::instructions             instruction,
    input   controllerPkg::states                state,
    input   logic                         [1:0]  dataSelectBits,

    output  transactionGroup::controlBus         transactionControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import transactionGroup::*;


    transactionGroup::controlBus  transactionControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transactionControl <= NO_OP;
        else if(enable)
            transactionControl <= transactionControlNext;
        else
            transactionControl <= transactionControl;
    end


    // output logic
    always_comb begin
        // default
        transactionControlNext = NO_OP;

        case(state)
            FETCH0:   transactionControlNext = READ;

            EXECUTE0: casex(instruction)
                          LDBS_PR,
                          LDBS_RR,
                          LDBS_RO,
                          LDBS_IA,
                          LDBS_IB,
                          LDBU_PR,
                          LDBU_RR,
                          LDBU_RO,
                          LDBU_IA,
                          LDBU_IB,
                          LDD_PR,
                          LDD_RR,
                          LDD_RO,
                          LDD_IA,
                          LDD_IB,
                          LDWS_PR,
                          LDWS_RR,
                          LDWS_RO,
                          LDWS_IA,
                          LDWS_IB,
                          LDWU_PR,
                          LDWU_RR,
                          LDWU_RO,
                          LDWU_IA,
                          LDWU_IB: transactionControlNext = READ;

                          default: transactionControlNext = NO_OP;
                      endcase

            EXECUTE1: casex(instruction)
                          STB_PR,
                          STB_RR,
                          STB_RO,
                          STB_IA,
                          STB_IB:  case(dataSelectBits)
                                       2'b00: transactionControlNext = WRITE_BYTE0;
                                       2'b01: transactionControlNext = WRITE_BYTE1;
                                       2'b10: transactionControlNext = WRITE_BYTE2;
                                       2'b11: transactionControlNext = WRITE_BYTE3;
                                   endcase

                          STD_PR,
                          STD_RR,
                          STD_RO,
                          STD_IA,
                          STD_IB:  transactionControlNext = WRITE_DWORD;

                          STW_PR,
                          STW_RR,
                          STW_RO,
                          STW_IA,
                          STW_IB:  case(dataSelectBits[1])
                                       1'b0:  transactionControlNext = WRITE_WORD0;
                                       1'b1:  transactionControlNext = WRITE_WORD1;
                                   endcase

                          default: transactionControlNext = NO_OP;
                      endcase

            default:  transactionControlNext = NO_OP;
        endcase
    end


endmodule

