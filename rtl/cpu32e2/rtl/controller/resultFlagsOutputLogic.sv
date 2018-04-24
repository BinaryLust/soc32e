

module resultFlagsOutputLogic(
    input   logic                                 clk,
	 input   logic                                 reset,
	 input   logic                                 enable, // for stalling
	 input   architecture::opcodes                 instruction,
	 //input   decoderPkg::instructions              instruction,
	 input   controllerPkg::states                 state,
	 
	 output  resultFlagsGroup::controlBus          resultFlagsControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import resultFlagsGroup::*;
	 
	 
	 resultFlagsGroup::controlBus  resultFlagsControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      resultFlagsControl <= NO_OP;
		  else if(enable)
		      resultFlagsControl <= resultFlagsControlNext;
		  else
		      resultFlagsControl <= resultFlagsControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  resultFlagsControlNext = NO_OP;
		  
	 	  case(state)
		      EXECUTE0: casex(instruction)
				              UADC_I,
				              UADC_R,
				              UADD_I,
				              UADD_R,
				              UCMP_I,
				              UCMP_R,
				              USBB_I,
				              USBB_R,
				              USUB_I,
				              USUB_R:  resultFlagsControlNext = LOAD_ARITH;

				              ADC_I,
				              ADC_R,
				              ADD_I,
				              ADD_R,
				              CMP_I,
				              CMP_R,
				              SBB_I,
				              SBB_R,
				              SUB_I,
				              SUB_R:   resultFlagsControlNext = LOAD_ARITH_O;

				              AND_I,
				              AND_R,
				              NOT_R,
				              OR_I,
				              OR_R,
				              TEQ_I,
				              TEQ_R,
				              TST_I,
				              TST_R,
				              XOR_I,
				              XOR_R:   resultFlagsControlNext = LOAD_LOGIC;

				              SMUL_R,
				              UMUL_R:  resultFlagsControlNext = LOAD_MULT;

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
				              SHR_R:   resultFlagsControlNext = LOAD_SHIFT;
								  
								  default: resultFlagsControlNext = NO_OP;
				          endcase

		      default:  resultFlagsControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

