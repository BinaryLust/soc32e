

module programCounterOutputLogic(
    input   logic                                    clk,
	 input   logic                                    reset,
	 input   logic                                    enable, // for stalling
	 input   architecture::opcodes                    instruction,
	 //input   decoderPkg::instructions                 instruction,
	 input   controllerPkg::states                    state,
	 input   boolPkg::bool                            conditionResult,
	 input   logic                                    exceptionPending,
	 input   logic                                    interruptPending,
	 
	 output  programCounterGroup::controlBus          programCounterControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import programCounterGroup::*;
	 
	 
	 programCounterGroup::controlBus  programCounterControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      programCounterControl <= NO_OP;
		  else if(enable)
		      programCounterControl <= programCounterControlNext;
		  else
		      programCounterControl <= programCounterControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  programCounterControlNext = NO_OP;
		  
	 	  case(state)
		      RESET1:    programCounterControlNext = LOAD_PLUS4;

		      DECODE:    casex(instruction)
				               BR_R,
                           BRL_R:   programCounterControlNext = (conditionResult) ? LOAD_RFA : NO_OP; // don't load if we aren't going to branch anyway
									
                           IRET_R:  programCounterControlNext = LOAD_RFA;

									default: programCounterControlNext = NO_OP;
				           endcase
							  
		      EXECUTE0:  casex(instruction)
				               BR_PR,
				               BR_RO,
				               BRL_PR,
				               BRL_RO:  programCounterControlNext = LOAD_CALC;
									
									default: programCounterControlNext = NO_OP;
				           endcase

		      WRITEBACK: programCounterControlNext = (exceptionPending || interruptPending) ? NO_OP : LOAD_PLUS4;
				
				INTERRUPT: programCounterControlNext = LOAD_ISR;
				
		      default:   programCounterControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

