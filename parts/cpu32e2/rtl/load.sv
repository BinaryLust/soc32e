

package loadGroup;


    import boolPkg::*;


    // a mux values
    typedef enum logic [1:0] {
        REGFILEA = 2'b00,
        NEXTPC   = 2'b01,
        COMBO    = 2'b10
    } aMux;


    // b mux values
    typedef enum logic [3:0] {
        REGFILEB = 4'b0000,
        IMM16    = 4'b0001,
        IMM21    = 4'b0010,
        IMM5     = 4'b0011,
        IMM19    = 4'b0100,
        IMM24    = 4'b0101
    } bMux;


    // control group structure
    typedef struct packed {
        bool  aRegisterEn;
        bool  bRegisterEn;
        aMux  aSel;
        bMux  bSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP         = '{aRegisterEn:F, bRegisterEn:F, aSel:REGFILEA, bSel:REGFILEB},
        NEXTPC_IMM21  = '{aRegisterEn:T, bRegisterEn:T, aSel:NEXTPC,   bSel:IMM21},
        NEXTPC_IMM24  = '{aRegisterEn:T, bRegisterEn:T, aSel:NEXTPC,   bSel:IMM24},
        RFA_IMM16     = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM16},
        RFA_IMM19     = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM19},
        RFA_IMM5      = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM5},
        RFA_RFB       = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:REGFILEB},
        RFA_NULL      = '{aRegisterEn:T, bRegisterEn:F, aSel:REGFILEA, bSel:REGFILEB},
        COMBO_NULL    = '{aRegisterEn:T, bRegisterEn:F, aSel:COMBO,    bSel:REGFILEB};


endpackage


module load(
    input   logic                          clk,
    input   loadGroup::controlBus          loadControl,
    input   logic                  [31:0]  registerFileA,
    input   logic                  [31:0]  nextPC,
    input   logic                  [31:0]  registerFileB,
    input   logic                  [31:0]  instructionReg,
    output  logic                  [31:0]  aRegister,
    output  logic                  [31:0]  bRegister
    );


    import loadGroup::*;


    logic  [31:0]  aRegisterNext;
    logic  [31:0]  bRegisterNext;


    // Registers
    always_ff @(posedge clk) begin
        if(loadControl.aRegisterEn)
            aRegister <= aRegisterNext;
        else
            aRegister <= aRegister;


        if(loadControl.bRegisterEn)
            bRegister <= bRegisterNext;
        else
            bRegister <= bRegister;
    end


    // Combinational Logic
    always_comb begin
        // a mux
        case(loadControl.aSel)
            REGFILEA: aRegisterNext = registerFileA;
            NEXTPC:   aRegisterNext = nextPC;
            COMBO:    aRegisterNext = {instructionReg[15:0], registerFileA[15:0]};
            default:  aRegisterNext = registerFileA;
        endcase


        // b mux
        case(loadControl.bSel)
            REGFILEB: bRegisterNext = registerFileB;
            IMM16:    bRegisterNext = {{16{instructionReg[15]}}, instructionReg[15:0]};        // bits[15:0] sign extended to bits[31:0]
            IMM21:    bRegisterNext = {{11{instructionReg[20]}}, instructionReg[20:0]};        // bits[20:0] sign extended to bits[31:0]
            IMM5:     bRegisterNext = {27'b0, instructionReg[10:6]};                           // bits[10:6] zero extended to bits[31:0]
            IMM19:    bRegisterNext = {{14{instructionReg[25]}}, instructionReg[15:0], 2'b0};  // {bits[25], bits[15:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            IMM24:    bRegisterNext = {{9{instructionReg[25]}}, instructionReg[20:0], 2'b0};   // {bits[25], bits[20:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            default:  bRegisterNext = registerFileB;
        endcase
    end


endmodule

