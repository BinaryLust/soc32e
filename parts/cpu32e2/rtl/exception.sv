

package exceptionGroup;


    import boolPkg::*;


    // control group structure
    typedef struct packed {
        bool                exceptionsReset;
        bool                interruptAcknowledge;
        bool                causeEn;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP  = '{exceptionsReset:F, interruptAcknowledge:F, causeEn:F},
        DO_EXC = '{exceptionsReset:T, interruptAcknowledge:F, causeEn:T},
        DO_INT = '{exceptionsReset:F, interruptAcknowledge:T, causeEn:T};


endpackage


module exception(
    input   logic                               clk,
    input   logic                               reset,
    input   exceptionGroup::controlBus          exceptionControl,
    input   logic                               interruptEnable,
    input   logic                       [15:0]  exceptionMask,
    input   logic                       [15:0]  triggerException,
    input   logic                               interruptRequest,
    input   logic                       [3:0]   interruptIn,
    output  logic                       [4:0]   cause,
    output  logic                               exceptionPending,
    output  logic                               interruptPending,
    output  logic                       [3:0]   interruptOut,
    output  logic                               interruptAcknowledge
    );


    logic  [3:0]   priorityException;
    logic  [15:0]  triggeredExceptions;
    logic  [4:0]   causeNext;
    logic  [3:0]   interruptInReg;
    logic          interruptRequestReg;


    exceptionState
    exceptionState(
        .clk,
        .reset,
        .interruptEnable,
        .exceptionsReset   (exceptionControl.exceptionsReset),
        .triggerException,
        .exceptionMask,
        .exceptionPending,
        .triggeredExceptions
    );


    exceptionEncoder
    exceptionEncoder(
        .triggeredExceptions,
        .priorityException
    );


    // cause register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            cause <= 5'b0;
        else if(exceptionControl.causeEn)
            cause <= causeNext;
        else
            cause <= cause;
    end


    // cause mux
    always_comb begin
        case(exceptionPending)
            1'b0: causeNext = {1'b1, interruptInReg};
            1'b1: causeNext = {1'b0, priorityException};
        endcase
    end


    // interrupt registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            interruptOut        <= 4'd0;
            interruptRequestReg <= 1'b0;
        end else begin
            interruptOut        <= interruptInReg;
            interruptRequestReg <= interruptRequest;
        end
    end


    always_ff @(posedge clk) begin
        interruptInReg      <= interruptIn;
    end


    assign interruptAcknowledge = exceptionControl.interruptAcknowledge;
    assign interruptPending     = interruptEnable & interruptRequestReg;


endmodule

