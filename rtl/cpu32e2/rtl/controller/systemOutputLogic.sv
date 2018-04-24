

module systemOutputLogic(
    input   logic                          clk,
	 input   logic                          reset,
	 input   logic                          enable, // for stalling
	 input   architecture::opcodes          instruction,
	 //input   decoderPkg::instructions       instruction,
	 input   controllerPkg::states          state,
	 input   logic                          exceptionPending,
	 input   logic                          interruptPending,
	 
	 output  systemGroup::controlBus        systemControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import systemGroup::*;
	 
	 
	 systemGroup::controlBus  systemControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      systemControl <= NO_OP;
		  else if(enable)
		      systemControl <= systemControlNext;
		  else
		      systemControl <= systemControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  systemControlNext = NO_OP;
		  
	 	  case(state)
		      DECODE:    casex(instruction)
		                     IRET_R:  systemControlNext = SET_INTEN;
									
									SSR_R:   systemControlNext = WRITE_DRL;
									
									default: systemControlNext = NO_OP;
				           endcase
							  
		      EXECUTE0:  casex(instruction)
				               INT_I:   systemControlNext = WRITE_SYSCALL;
									
									default: systemControlNext = NO_OP;
				           endcase
							  
		      EXECUTE1:  casex(instruction)
				               ADC_I,
				               ADC_R,
				               ADD_I,
				               ADD_R,
				               AND_I,
				               AND_R,
				               CMP_I,
				               CMP_R,
				               NOT_R,
				               OR_I,
				               OR_R,
				               RCL_I,
				               RCL_R,
				               RCR_I,
				               RCR_R,
				               ROL_I,
				               ROL_R,
				               ROR_I,
				               ROR_R,
				               SAR_I,
				               SAR_R,
				               SBB_I,
				               SBB_R,
				               SHL_I,
				               SHL_R,
				               SHR_I,
				               SHR_R,
				               SMUL_R,
				               SUB_I,
				               SUB_R,
				               TEQ_I,
				               TEQ_R,
				               TST_I,
				               TST_R,
				               UADC_I,
				               UADC_R,
				               UADD_I,
				               UADD_R,
				               UCMP_I,
				               UCMP_R,
				               UMUL_R,
				               USBB_I,
				               USBB_R,
				               USUB_I,
				               USUB_R,
				               XOR_I,
				               XOR_R:   systemControlNext = WRITE_FLAGS;
									
									default: systemControlNext = NO_OP;
				           endcase

		      //WRITEBACK: systemControlNext = (exceptionPending || interruptPending) ? RESET_INTEN : NO_OP;
				
				INTERRUPT: systemControlNext = RESET_INTEN;
				
		      default:   systemControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

