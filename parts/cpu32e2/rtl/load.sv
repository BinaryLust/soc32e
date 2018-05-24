

package loadGroup;


    import boolPkg::*;


    // a mux values
    typedef enum logic {
        REGFILEA = 1'b0,
        NEXTPC   = 1'b1
    } aMux;


    // b mux values
    typedef enum logic [3:0] {
        REGFILEB = 4'b0000,
        COMBO    = 4'b0001,
        IMM16A   = 4'b0010,
        IMM16B   = 4'b0011,
        IMM21A   = 4'b0100,
        IMM21B   = 4'b0101,
        IMM21C   = 4'b0110,
        IMM5     = 4'b0111,
        IMM19    = 4'b1000,
        IMM24    = 4'b1001
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
        RFA_IMM16A    = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM16A},
        RFA_RFB       = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:REGFILEB},
        NEXTPC_IMM24  = '{aRegisterEn:T, bRegisterEn:T, aSel:NEXTPC,   bSel:IMM24},
        RFA_IMM19     = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM19},
        RFA_IMM21A    = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM21A},
        RFA_NULL      = '{aRegisterEn:T, bRegisterEn:F, aSel:REGFILEA, bSel:REGFILEB},
        NEXTPC_IMM21B = '{aRegisterEn:T, bRegisterEn:T, aSel:NEXTPC,   bSel:IMM21B},
        RFA_IMM5      = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM5},
        NULL_IMM21B   = '{aRegisterEn:F, bRegisterEn:T, aSel:REGFILEA, bSel:IMM21B},
        NULL_COMBO    = '{aRegisterEn:F, bRegisterEn:T, aSel:REGFILEA, bSel:COMBO},
        RFA_IMM16B    = '{aRegisterEn:T, bRegisterEn:T, aSel:REGFILEA, bSel:IMM16B},
        NEXTPC_IMM21C = '{aRegisterEn:T, bRegisterEn:T, aSel:NEXTPC,   bSel:IMM21C};


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
            default:  aRegisterNext = registerFileA;
        endcase


        // b mux
        case(loadControl.bSel)
            REGFILEB: bRegisterNext = registerFileB;
            COMBO:    bRegisterNext = {instructionReg[20:16], instructionReg[10:0], registerFileB[15:0]};
            IMM16A:   bRegisterNext = {{16{instructionReg[15]}}, instructionReg[15:0]};                                                    // bits[15:0] sign extended to bits[31:0]
            IMM16B:   bRegisterNext = {{16{instructionReg[25]}}, instructionReg[25:21], instructionReg[10:0]};                             // {bits[25:21], bits[10:0]} sign extended to bits[31:0]
            IMM21A:   bRegisterNext = {{11{instructionReg[25]}}, instructionReg[25:21], instructionReg[15:0]};                             // {bits[25:21], bits[15:0]} sign extended to bits[31:0]
            IMM21B:   bRegisterNext = {{11{instructionReg[20]}}, instructionReg[20:0]};                                                    // bits[20:0] sign extended to bits[31:0]
            IMM21C:   bRegisterNext = {{11{instructionReg[25]}}, instructionReg[25:16], instructionReg[10:0]};                             // {bits[25:16], bits[10:0]} sign extended to bits[31:0]
            IMM5:     bRegisterNext = {27'b0, instructionReg[10:6]};                                                                       // bits[10:6] zero extended to bits[31:0]
            IMM19:    bRegisterNext = {{13{instructionReg[25]}}, instructionReg[25:21], instructionReg[15:10], instructionReg[5:0], 2'b0}; // {bits[25:21], bits[15:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            IMM24:    bRegisterNext = {{8{instructionReg[25]}}, instructionReg[25:10], instructionReg[5:0], 2'b0};                         // {bits[25:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            default:  bRegisterNext = registerFileB;
        endcase
    end


endmodule

