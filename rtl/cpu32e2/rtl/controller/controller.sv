

`include "E:/My Code/systemverilog/soc32e/rtl/cpu32e2/rtl/globals.sv"


module controller(
    input   logic                                     clk,
	 input   logic                                     reset,
	 input   architecture::opcodes                     opcode,
	 input   architecture::conditions                  condition,
	 input   logic                              [3:0]  flags,
	 input   logic                                     exceptionPending,
	 input   logic                                     interruptPending,
	 input   logic                              [1:0]  dataSelectBits,
	 input   logic                                     waitRequest,
	 input   logic                                     readValid,
	 input   logic                                     aluDone,
	 input   logic                                     shifterDone,
	 input   logic                                     multiplierDone,
	 input   logic                                     dividerDone,
	 
	 `ifdef  DEBUG
	 output  logic                                     fetchCycle,
	 output  logic                                     machineCycleDone,
	 `endif
	 
	 output  transactionGroup::controlBus              transactionControl,
	 output  addressGroup::controlBus                  addressControl,
	 output  dataGroup::controlBus                     dataControl,
	 output  programCounterGroup::controlBus           programCounterControl,
	 output  systemGroup::controlBus                   systemControl,
	 output  regfileAGroup::controlBus                 regfileAControl,
	 output  regfileBGroup::controlBus                 regfileBControl,
	 output  resultGroup::controlBus                   resultControl,
	 output  resultFlagsGroup::controlBus              resultFlagsControl,
	 output  executeGroup::controlBus                  executeControl,
	 output  loadGroup::controlBus                     loadControl,
	 output  exceptionGroup::controlBus                exceptionControl,
	 output  exceptionTriggerGroup::controlBus         exceptionTriggerControl
	 );

	 
	 //decoderPkg::instructions  instruction;
	 architecture::opcodes     instruction;
	 logic                     enable;
	 controllerPkg::states     state;
	 boolPkg::bool             conditionResult;
	 
	 
	 `ifdef DEBUG
	 import controllerPkg::*;
	 
	 always_comb begin
	     case(state)
		      FETCH0,
				FETCH1,
				FETCH2,
				FETCH3:  fetchCycle = 1'b1;
				default: fetchCycle = 1'b0;
		  endcase
		  
		  
		  machineCycleDone = (state == FETCH0) ?  1'b1 : 1'b0;
	 end
	 `endif

	 
	 assign instruction = opcode;
	 
	 
	 // it uses less gates and runs just as fast
	 // to not use this
	 /*instructionDecoder
	 instructionDecoder(
        .opcode,
	     .instruction
	 );*/
	 
	 
	 stallLogic
	 stallLogic(
        .state,
		  .instruction,
	     .waitRequest,
	     .readValid,
	     .aluDone,
	     .shifterDone,
	     .multiplierDone,
        .dividerDone,
        .enable
	 );
	 
	 
    controllerState
	 controllerState(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .conditionResult,
	     .exceptionPending,
	     .interruptPending,
        .state
	 );
	 
	 
    conditionCheckLogic
	 conditionCheckLogic(
	     .condition,
	     .flags,
	     .conditionResult
	 );
	 
	 
	 transactionOutputLogic
	 transactionOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .dataSelectBits,
	     .transactionControl
	 );
	 
	 
	 addressOutputLogic
	 addressOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .exceptionPending,
	     .interruptPending,
	     .addressControl
	 );
	 
	 
	 dataOutputLogic
	 dataOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .dataControl
	 );
	 
	 
	 programCounterOutputLogic
	 programCounterOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
		  .conditionResult,
	     .exceptionPending,
	     .interruptPending,
	     .programCounterControl
	 );
	 
	 
	 systemOutputLogic
	 systemOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .exceptionPending,
	     .interruptPending,
	     .systemControl
	 );
	 
	 
	 regfileAOutputLogic
	 regfileAOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
		  .conditionResult,
	     .exceptionPending,
	     .interruptPending,
	     .regfileAControl
	 );
	 
	 
	 regfileBOutputLogic
	 regfileBOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .regfileBControl
	 );
	 
	 
	 resultOutputLogic
	 resultOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .resultControl
	 );
	 
	 
	 resultFlagsOutputLogic
	 resultFlagsOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .resultFlagsControl
	 );
	 
	 
	 executeOutputLogic
	 executeOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .executeControl
	 );
	 
	 
	 loadOutputLogic
	 loadOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
		  .conditionResult,
	     .loadControl
	 );
	 
	 
	 exceptionOutputLogic
	 exceptionOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
	     .state,
	     .exceptionPending,
	     .interruptPending,
        .exceptionControl
	 );
	 
	 
	 exceptionTriggerOutputLogic
	 exceptionTriggerOutputLogic(
        .clk,
	     .reset,
	     .enable,
	     .instruction,
        .state,
	     .exceptionTriggerControl
	 );
	 

endmodule

