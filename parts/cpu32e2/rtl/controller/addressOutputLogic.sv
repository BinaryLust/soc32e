

module addressOutputLogic(
    input   logic                             clk,
    input   logic                             reset,
    input   logic                             enable, // for stalling
    input   architecture::opcodes             instruction,
    //input   decoderPkg::instructions          instruction,
    input   controllerPkg::states             state,
    input   logic                             exceptionPending,
    input   logic                             interruptPending,

    output  addressGroup::controlBus          addressControl
    );


    import architecture::*;
    //import decoderPkg::*;
    import controllerPkg::*;
    import addressGroup::*;


    addressGroup::controlBus  addressControlNext;


    // output register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            addressControl <= NO_OP;
        else if(enable)
            addressControl <= addressControlNext;
        else
            addressControl <= addressControl;
    end


    // output logic
    always_comb begin
        // default
        addressControlNext = NO_OP;

        case(state)
            RESET1:    addressControlNext = PC_ADDR;

            LOAD:      casex(instruction)
                           LDBS_PR,
                           LDBS_RR,
                           LDBS_RO,
                           LDBS_IB,
                           LDBU_PR,
                           LDBU_RR,
                           LDBU_RO,
                           LDBU_IB,
                           LDD_PR,
                           LDD_RR,
                           LDD_RO,
                           LDD_IB,
                           LDWS_PR,
                           LDWS_RR,
                           LDWS_RO,
                           LDWS_IB,
                           LDWU_PR,
                           LDWU_RR,
                           LDWU_RO,
                           LDWU_IB,
                           STB_PR,
                           STB_RR,
                           STB_RO,
                           STB_IB,
                           STD_PR,
                           STD_RR,
                           STD_RO,
                           STD_IB,
                           STW_PR,
                           STW_RR,
                           STW_RO,
                           STW_IB,
                           BR_PR,
                           BR_RR,
                           BR_RO,
                           BRL_PR,
                           BRL_RR,
                           BRL_RO:  addressControlNext = APLUSB_ADDR;

                           LDBS_IA,
                           LDBU_IA,
                           LDD_IA,
                           LDWS_IA,
                           LDWU_IA,
                           STB_IA,
                           STD_IA,
                           STW_IA:  addressControlNext = RFA_ADDR;

                           default: addressControlNext = NO_OP;
                       endcase

            WRITEBACK: addressControlNext = (exceptionPending || interruptPending) ? NO_OP : PC_ADDR;

            default:   addressControlNext = NO_OP;
        endcase
    end


endmodule

