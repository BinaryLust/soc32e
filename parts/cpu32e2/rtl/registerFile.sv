

`include "G:/My Code/on git/systemverilog/soc32e/parts/cpu32e2/rtl/globals.sv"


package regfileAGroup;


    import boolPkg::*;


    // rfa data mux values
    typedef enum logic [3:0] {
        RFA_RESULT_LOW = 4'b0000,
        RFA_BREG       = 4'b0001,
        RFA_NEXTPC     = 4'b0010,
        RFA_SYSREG     = 4'b0011,
        RFA_DWORD      = 4'b0100,
        RFA_SWORD      = 4'b0101,
        RFA_UWORD      = 4'b0110,
        RFA_SBYTE      = 4'b0111,
        RFA_UBYTE      = 4'b1000
    } regfileADataMux;


    // rfa destination mux values
    typedef enum logic [1:0] {
        RFA_DRL        = 2'b00,
        RFA_LR         = 2'b01,
        RFA_EPC        = 2'b10
    } regfileADestMux;


    // control group structure
    typedef struct packed {
        bool             regfileAWriteEn;
        regfileADataMux  regfileADataSel;
        regfileADestMux  regfileADestSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP      = '{regfileAWriteEn:F, regfileADataSel:RFA_RESULT_LOW, regfileADestSel:RFA_DRL},
        RESULT_DRL = '{regfileAWriteEn:T, regfileADataSel:RFA_RESULT_LOW, regfileADestSel:RFA_DRL},
        NEXTPC_LR  = '{regfileAWriteEn:T, regfileADataSel:RFA_NEXTPC,     regfileADestSel:RFA_LR},
        DWORD_DRL  = '{regfileAWriteEn:T, regfileADataSel:RFA_DWORD,      regfileADestSel:RFA_DRL},
        SWORD_DRL  = '{regfileAWriteEn:T, regfileADataSel:RFA_SWORD,      regfileADestSel:RFA_DRL},
        UWORD_DRL  = '{regfileAWriteEn:T, regfileADataSel:RFA_UWORD,      regfileADestSel:RFA_DRL},
        SBYTE_DRL  = '{regfileAWriteEn:T, regfileADataSel:RFA_SBYTE,      regfileADestSel:RFA_DRL},
        UBYTE_DRL  = '{regfileAWriteEn:T, regfileADataSel:RFA_UBYTE,      regfileADestSel:RFA_DRL},
        SYSREG_DRL = '{regfileAWriteEn:T, regfileADataSel:RFA_SYSREG,     regfileADestSel:RFA_DRL},
        BREG_DRL   = '{regfileAWriteEn:T, regfileADataSel:RFA_BREG,       regfileADestSel:RFA_DRL},
        NEXTPC_EPC = '{regfileAWriteEn:T, regfileADataSel:RFA_NEXTPC,     regfileADestSel:RFA_EPC};


endpackage


package regfileBGroup;


    import boolPkg::*;


    // rfa data mux values
    typedef enum logic {
        RFB_RESULT_HIGH = 1'b0,
        RFB_CALC        = 1'b1
    } regfileBDataMux;


    // rfa destination mux values
    typedef enum logic {
        RFB_DRH         = 1'b0,
        RFB_SRA         = 1'b1
    } regfileBDestMux;


    // control group structure
    typedef struct packed {
        bool             regfileBWriteEn;
        regfileBDataMux  regfileBDataSel;
        regfileBDestMux  regfileBDestSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP      = '{regfileBWriteEn:F, regfileBDataSel:RFB_RESULT_HIGH, regfileBDestSel:RFB_DRH},
        CALC_SRA   = '{regfileBWriteEn:T, regfileBDataSel:RFB_CALC,        regfileBDestSel:RFB_SRA},
        RESULT_DRH = '{regfileBWriteEn:T, regfileBDataSel:RFB_RESULT_HIGH, regfileBDestSel:RFB_DRH};


endpackage


module registerFile(
    input   logic                                    clk,
    input   logic                                    reset,
    input   logic                                    exceptionPending,
    input   regfileAGroup::controlBus                regfileAControl,
    input   regfileBGroup::controlBus                regfileBControl,
    input   logic                      [1:0]         dataSelectBits,
    input   logic                      [31:0]        dataInReg,
    input   logic                      [31:0]        resultLow,
    input   logic                      [31:0]        bRegister,
    input   logic                      [31:0]        nextPC,
    input   logic                      [31:0]        systemRegister,
    input   logic                      [31:0]        resultHigh,
    input   logic                      [31:0]        calculatedAddress,
    input   logic                      [31:0]        instructionReg,

    `ifdef  DEBUG
    output  logic                      [31:0][31:0]  regfileState,
    `endif

    output  logic                      [31:0]        registerFileA,
    output  logic                      [31:0]        registerFileB
    );


    import architecture::*;
    import regfileAGroup::*;
    import regfileBGroup::*;


    logic  [15:0]  dataWord;
    logic  [7:0]   dataByte;
    logic  [31:0]  regfileAData;
    logic  [31:0]  regfileBData;
    logic  [4:0]   regfileADest;
    logic  [4:0]   regfileBDest;


    `ifdef DEBUG

    // Debug Register File
    regfileDebug
    regfileDebug(
        .clk,
        .reset,
        .writeEnableA    (regfileAControl.regfileAWriteEn && !exceptionPending),
        .writeEnableB    (regfileBControl.regfileBWriteEn && !exceptionPending),
        .writeAddressA   (regfileADest),
        .writeAddressB   (regfileBDest),
        .writeDataA      (regfileAData),
        .writeDataB      (regfileBData),
        .readAddressA    (instructionReg[20:16]),
        .readAddressB    (instructionReg[15:11]),
        .regfileState,
        .readDataA       (registerFileA),
        .readDataB       (registerFileB)
    );

    `else

    // Register File
    regfile
    regfile(
        .clk,
        .reset,
        .writeEnableA   (regfileAControl.regfileAWriteEn && !exceptionPending),
        .writeEnableB   (regfileBControl.regfileBWriteEn && !exceptionPending),
        .writeAddressA  (regfileADest),
        .writeAddressB  (regfileBDest),
        .writeDataA     (regfileAData),
        .writeDataB     (regfileBData),
        .readAddressA   (instructionReg[20:16]),
        .readAddressB   (instructionReg[15:11]),
        .readDataA      (registerFileA),
        .readDataB      (registerFileB)
    );

    `endif


    // Combinational Logic
    always_comb begin
        // data word mux
        case(dataSelectBits[1])
            1'b0:  dataWord = dataInReg[31:16];
            1'b1:  dataWord = dataInReg[15:0];
        endcase

        // put endianness selector here? {endian_type, dataSelectBits}

        // data byte mux
        case(dataSelectBits)
            2'b00: dataByte = dataInReg[31:24];
            2'b01: dataByte = dataInReg[23:16];
            2'b10: dataByte = dataInReg[15:8];
            2'b11: dataByte = dataInReg[7:0];
        endcase


        //rfa data mux
        case(regfileAControl.regfileADataSel)
            RFA_RESULT_LOW: regfileAData = resultLow;
            RFA_BREG:       regfileAData = bRegister;
            RFA_NEXTPC:     regfileAData = nextPC;
            RFA_SYSREG:     regfileAData = systemRegister;
            RFA_DWORD:      regfileAData = dataInReg;
            RFA_SWORD:      regfileAData = {{16{dataWord[15]}}, dataWord};
            RFA_UWORD:      regfileAData = {16'b0, dataWord};
            RFA_SBYTE:      regfileAData = {{24{dataByte[7]}}, dataByte};
            RFA_UBYTE:      regfileAData = {24'b0, dataByte};
            default:        regfileAData = resultLow;
        endcase


        //rfb data mux
        case(regfileBControl.regfileBDataSel)
            RFB_RESULT_HIGH: regfileBData = resultHigh;
            RFB_CALC:        regfileBData = calculatedAddress;
            default:         regfileBData = resultHigh;
        endcase


        // cleaner solution for bit fields below?
        // maybe a struct or concatenation or
        // a macro

        // rfa destination mux
        case(regfileAControl.regfileADestSel)
            RFA_DRL: regfileADest = instructionReg[25:21];
            RFA_LR:  regfileADest = LR;
            RFA_EPC: regfileADest = EPC;
            default: regfileADest = instructionReg[25:21];
        endcase


        // rfb destination mux
        case(regfileBControl.regfileBDestSel)
            RFB_DRH: regfileBDest = instructionReg[10:6];
            RFB_SRA: regfileBDest = instructionReg[20:16];
            default: regfileBDest = instructionReg[10:6];
        endcase
    end


endmodule

