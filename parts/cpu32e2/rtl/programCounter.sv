

package programCounterGroup;


    import boolPkg::*;


    // nextPC mux values
    typedef enum logic [1:0] {
        PLUS4    = 2'b00,
        REGFILEA = 2'b01,
        CALC     = 2'b10,
        ISR      = 2'b11
    } nextPCMux;


    // control group structure
    typedef struct packed {
        bool       nextPCEn;
        nextPCMux  nextPCSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP      = '{nextPCEn:F, nextPCSel:PLUS4},
        LOAD_PLUS4 = '{nextPCEn:T, nextPCSel:PLUS4},
        LOAD_RFA   = '{nextPCEn:T, nextPCSel:REGFILEA},
        LOAD_CALC  = '{nextPCEn:T, nextPCSel:CALC},
        LOAD_ISR   = '{nextPCEn:T, nextPCSel:ISR};


endpackage


module programCounter(
    input   logic                                    clk,
    input   logic                                    reset,
    input   logic                                    exceptionPending,
    input   programCounterGroup::controlBus          programCounterControl,
    input   logic                            [31:0]  registerFileA,
    input   logic                            [31:0]  calculatedAddress,
    input   logic                            [31:0]  isrBaseAddress,
    output  logic                            [31:0]  nextPC
    );


    import programCounterGroup::*;


    logic  [31:0]  nextPCNext;


    // Registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            nextPC <= 32'b0;
        else if(programCounterControl.nextPCEn && !exceptionPending)
            nextPC <= nextPCNext;
        else
            nextPC <= nextPC;
    end


    // Combinational Logic
    always_comb begin
        case(programCounterControl.nextPCSel)
            PLUS4:    nextPCNext = nextPC + 32'd4;
            REGFILEA: nextPCNext = registerFileA;
            CALC:     nextPCNext = calculatedAddress;
            ISR:      nextPCNext = isrBaseAddress;
            default:  nextPCNext = nextPC + 32'd4;
        endcase
    end


endmodule

