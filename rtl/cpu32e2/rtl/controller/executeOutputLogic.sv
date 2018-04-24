

module executeOutputLogic(
    input   logic                             clk,
	 input   logic                             reset,
	 input   logic                             enable, // for stalling
	 input   architecture::opcodes             instruction,
	 //input   decoderPkg::instructions          instruction,
	 input   controllerPkg::states             state,
	 
	 output  executeGroup::controlBus          executeControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import executeGroup::*;
	 
	 
	 executeGroup::controlBus  executeControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      executeControl <= NO_OP;
		  else if(enable)
		      executeControl <= executeControlNext;
		  else
		      executeControl <= executeControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  executeControlNext = NO_OP;
		  
	 	  case(state)
		      LOAD:    casex(instruction)
				             ADC_I,
				             ADC_R,
				             UADC_I,
				             UADC_R:  executeControlNext = DO_ADC;
								 
				             ADD_I,
				             ADD_R,
				             UADD_I,
				             UADD_R:  executeControlNext = DO_ADD;
								 
				             AND_I,
				             AND_R,
				             TST_I,
				             TST_R:   executeControlNext = DO_AND;
								 
				             NOT_R:   executeControlNext = DO_NOT;
								 
				             OR_I,
				             OR_R:    executeControlNext = DO_OR;
								 
				             RCL_I,
				             RCL_R:   executeControlNext = DO_RCL;
								 
				             RCR_I,
				             RCR_R:   executeControlNext = DO_RCR;
								 
				             ROL_I,
				             ROL_R:   executeControlNext = DO_ROL;
								 
				             ROR_I,
				             ROR_R:   executeControlNext = DO_ROR;
								 
				             SAR_I,
				             SAR_R:   executeControlNext = DO_SAR;
								 
				             SBB_I,
				             SBB_R,
				             USBB_I,
				             USBB_R:  executeControlNext = DO_SBB;
								 
				             SDIV_R:  executeControlNext = DO_SDIV;
								 
				             SHL_I,
				             SHL_R:   executeControlNext = DO_SHL;
								 
				             SHR_I,
				             SHR_R:   executeControlNext = DO_SHR;
								 
				             SMUL_R:  executeControlNext = DO_SMUL;
								 
				             CMP_I,
				             CMP_R,
				             SUB_I,
				             SUB_R,
				             UCMP_I,
				             UCMP_R,
				             USUB_I,
				             USUB_R:  executeControlNext = DO_SUB;
								 
				             UDIV_R:  executeControlNext = DO_UDIV;
								 
				             UMUL_R:  executeControlNext = DO_UMUL;
								 
				             TEQ_I,
				             TEQ_R,
				             XOR_I,
				             XOR_R:   executeControlNext = DO_XOR;

				             default: executeControlNext = NO_OP;
				         endcase

		      default: executeControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

