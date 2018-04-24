

module resultOutputLogic(
    input   logic                            clk,
	 input   logic                            reset,
	 input   logic                            enable, // for stalling
	 input   architecture::opcodes            instruction,
	 //input   decoderPkg::instructions         instruction,
	 input   controllerPkg::states            state,
	 
	 output  resultGroup::controlBus          resultControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import resultGroup::*;
	 
	 
	 resultGroup::controlBus  resultControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      resultControl <= NO_OP;
		  else if(enable)
		      resultControl <= resultControlNext;
		  else
		      resultControl <= resultControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  resultControlNext = NO_OP;
		  
	 	  case(state)
		      EXECUTE0: casex(instruction)
				              ADC_I,
				              ADC_R,
				              ADD_I,
				              ADD_R,
				              AND_I,
				              AND_R,
				              NOT_R,
				              OR_I,
				              OR_R,
				              SBB_I,
				              SBB_R,
				              SUB_I,
				              SUB_R,
				              UADC_I,
				              UADC_R,
				              UADD_I,
				              UADD_R,
				              USBB_I,
				              USBB_R,
				              USUB_I,
				              USUB_R,
				              XOR_I,
				              XOR_R:   resultControlNext = LOAD_ALU;

				              SDIV_R,
				              UDIV_R:  resultControlNext = LOAD_DIVIDER;

				              SMUL_R,
				              UMUL_R:  resultControlNext = LOAD_MULTIPLIER;

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
				              SHL_I,
				              SHL_R,
				              SHR_I,
				              SHR_R:   resultControlNext = LOAD_SHIFTER;
								  
								  default: resultControlNext = NO_OP;
				          endcase

		      default:  resultControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

