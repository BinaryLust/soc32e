

// change the write instructions to write to memory at the writeback stage only, this will allow for proper memory exceptions to happen without destorying the machine state.


`include "G:/My Code/on git/systemverilog/soc32e/parts/cpu32e2/rtl/globals.sv"


module cpu32e2(
    input   logic                         clk,
    input   logic                         reset,
    input   logic                         waitRequest,
    input   logic                         readValid,
    input   logic                         interruptRequest,
    input   logic                 [3:0]   interruptIn,
    input   logic                 [31:0]  dataIn,

    `ifdef  DEBUG
    output  debugPkg::debugLines          debugOut,
    `endif

    output  logic                         interruptAcknowledge,
    output  logic                 [3:0]   interruptOut,
    output  logic                         read,
    output  logic                         write,
    output  logic                 [3:0]   bwe,
    output  logic                 [31:0]  dataOut,
    output  logic                 [31:0]  address
    );


    // control signals
    transactionGroup::controlBus       transactionControl;
    addressGroup::controlBus           addressControl;
    dataGroup::controlBus              dataControl;
    programCounterGroup::controlBus    programCounterControl;
    systemGroup::controlBus            systemControl;
    regfileAGroup::controlBus          regfileAControl;
    regfileBGroup::controlBus          regfileBControl;
    resultGroup::controlBus            resultControl;
    resultFlagsGroup::controlBus       resultFlagsControl;
    executeGroup::controlBus           executeControl;
    loadGroup::controlBus              loadControl;
    exceptionGroup::controlBus         exceptionControl;
    exceptionTriggerGroup::controlBus  exceptionTriggerControl;


    // internal datapath wires
    logic  [31:0]  nextPC;
    logic  [31:0]  registerFileA;
    logic  [31:0]  registerFileB;
    logic  [31:0]  aRegister;
    logic  [31:0]  bRegister;
    logic  [1:0]   dataSelectBits;
    logic  [31:0]  calculatedAddress;
    logic  [31:0]  instructionReg;
    logic  [31:0]  dataInReg;
    logic  [31:0]  isrBaseAddress;
    logic  [3:0]   resultFlags;
    logic  [4:0]   cause;
    logic          interruptEnable;
    logic  [15:0]  exceptionMask;
    logic  [31:0]  systemRegister;
    logic  [3:0]   flags;
    logic  [31:0]  resultLow;
    logic  [31:0]  resultHigh;
    logic  [31:0]  multiplierResultHigh;
    logic  [31:0]  multiplierResultLow;
    logic  [31:0]  dividerQuotient;
    logic  [31:0]  dividerRemainder;
    logic          dividerError;  // divide by zero exception
    logic  [31:0]  aluResult;
    logic  [31:0]  shifterResult;
    logic          aluCarry;
    logic          shifterCarry;
    logic          aluOverflow;
    logic          aluDone;
    logic          overflowException;
    logic          shifterDone;
    logic          multiplierDone;
    logic          dividerDone;
    logic  [15:0]  triggerException;
    logic          exceptionPending;
    logic          interruptPending;


    `ifdef DEBUG
    logic                fetchCycle;
    logic                machineCycleDone;
    logic  [31:0][31:0]  regfileState;
    logic  [5:0]         systemCallState;


    assign debugOut.fetchCycle           = fetchCycle;
    assign debugOut.machineCycleDone     = machineCycleDone;
    assign debugOut.regfileState         = regfileState;
    assign debugOut.nextPCState          = nextPC;
    assign debugOut.flagsState           = flags;
    assign debugOut.systemCallState      = systemCallState;
    assign debugOut.isrBaseAddressState  = isrBaseAddress;
    assign debugOut.interruptEnableState = interruptEnable;
    assign debugOut.exceptionMaskState   = exceptionMask;
    assign debugOut.causeState           = cause;
    `endif


    // instruction wires
    architecture::opcodes     opcode;
    architecture::conditions  condition;


    // wire assignments
    assign opcode           = architecture::opcodes'({instructionReg[31:26], instructionReg[5:0]});
    assign condition        = architecture::conditions'(instructionReg[9:6]);
    assign read             = transactionControl.read;
    assign write            = transactionControl.write;
    assign bwe              = transactionControl.bwe;


    // exception assignments
    assign triggerException =
       {9'b0,                                                   // unused                - exceptions 7-15
        exceptionTriggerControl.unknownException,               // unknown instruction   - exception 6
        exceptionTriggerControl.systemException,                // system interrupt      - exception 5
        exceptionTriggerControl.breakException,                 // break                 - exception 4
        exceptionTriggerControl.dataAlignmentException,         // data alignment        - exception 3
        overflowException,                                      // overflow              - exception 2
        dividerError,                                           // divide by zero        - exception 1
        exceptionTriggerControl.instructionAlignmentException}; // instruction alignment - exception 0


    // control unit
    controller
    controller(
        .clk,
        .reset,
        .opcode,
        .condition,
        .flags,
        .exceptionPending,
        .interruptPending,
        .dataSelectBits,
        .waitRequest,
        .readValid,
        .aluDone,
        .shifterDone,
        .multiplierDone,
        .dividerDone,

        `ifdef  DEBUG
        .fetchCycle,
        .machineCycleDone,
        `endif

        .transactionControl,
        .addressControl,
        .dataControl,
        .programCounterControl,
        .systemControl,
        .regfileAControl,
        .regfileBControl,
        .resultControl,
        .resultFlagsControl,
        .executeControl,
        .loadControl,
        .exceptionControl,
        .exceptionTriggerControl
    );


    // data path modules
    addressUnit
    addressUnit(
        .clk,
        .reset,
        .addressControl,
        .nextPC,
        .registerFileA,
        .aRegister,
        .bRegister,
        .dataSelectBits,
        .address,
        .calculatedAddress
    );


    data
    data(
        .clk,
        .reset,
        .dataControl,
        .dataIn,
        .registerFileB,
        .instructionReg,
        .dataInReg,
        .dataOut
    );


    programCounter
    programCounter(
        .clk,
        .reset,
        .exceptionPending,
        .programCounterControl,
        .registerFileA,
        .calculatedAddress,
        .isrBaseAddress,
        .nextPC
    );


    system
    system(
        .clk,
        .reset,
        .exceptionPending,
        .systemControl,
        .instructionReg,
        .resultFlags,
        .registerFileB,
        .cause,

        `ifdef  DEBUG
        .systemCallState,
        `endif

        .interruptEnable,
        .exceptionMask,
        .systemRegister,
        .flags,
        .isrBaseAddress
    );


    registerFile
    registerFile(
        .clk,
        .reset,
        .exceptionPending,
        .regfileAControl,
        .regfileBControl,
        .dataSelectBits,
        .dataInReg,
        .resultLow,
        .bRegister,
        .nextPC,
        .systemRegister,
        .resultHigh,
        .calculatedAddress,
        .instructionReg,

        `ifdef  DEBUG
        .regfileState,
        `endif

        .registerFileA,
        .registerFileB
    );


    result
    result(
        .clk,
        .resultControl,
        .resultFlagsControl,
        .multiplierResultHigh,
        .dividerRemainder,
        .aluResult,
        .shifterResult,
        .multiplierResultLow,
        .dividerQuotient,
        .aluCarry,
        .shifterCarry,
        .aluOverflow,
        .resultHigh,
        .resultLow,
        .resultFlags,
        .overflowException
    );


    execute
    execute(
        .clk,
        .reset,
        .executeControl,
        .aRegister,
        .bRegister,
        .carryFlag                (flags[0]),
        .aluResult,
        .aluCarry,
        .aluOverflow,
        .aluDone,
        .shifterResult,
        .shifterCarry,
        .shifterDone,
        .multiplierResultLow,
        .multiplierResultHigh,
        .multiplierDone,
        .dividerQuotient,
        .dividerRemainder,
        .dividerDone,
        .dividerError
    );


    load
    load(
        .clk,
        .loadControl,
        .registerFileA,
        .nextPC,
        .registerFileB,
        .instructionReg,
        .aRegister,
        .bRegister
    );


    exception
    exception(
        .clk,
        .reset,
        .exceptionControl,
        .interruptEnable,
        .exceptionMask,
        .triggerException,
        .interruptRequest,
        .interruptIn,
        .cause,
        .exceptionPending,
        .interruptPending,
        .interruptOut,
        .interruptAcknowledge
    );


endmodule

