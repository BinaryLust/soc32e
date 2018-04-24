

module dataOutputLogic(
    input   logic                          clk,
	 input   logic                          reset,
	 input   logic                          enable, // for stalling
	 input   architecture::opcodes          instruction,
	 //input   decoderPkg::instructions       instruction,
	 input   controllerPkg::states          state,
	 
	 output  dataGroup::controlBus          dataControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import dataGroup::*;
	 
	 
	 dataGroup::controlBus  dataControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      dataControl <= NO_OP;
		  else if(enable)
		      dataControl <= dataControlNext;
		  else
		      dataControl <= dataControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  dataControlNext = NO_OP;
		  
	 	  case(state)
		      FETCH2:  dataControlNext = READ_INSTR;

		      DECODE:  casex(instruction)
				             STB_PR,
				             STB_R,
				             STB_RO,
				             STB_IA,
				             STB_IB:  dataControlNext = WRITE_BYTE;
								  
				             STD_PR,
				             STD_R,
				             STD_RO,
				             STD_IA,
				             STD_IB:  dataControlNext = WRITE_DWORD;
								  
				             STW_PR,
				             STW_R,
				             STW_RO,
				             STW_IA,
				             STW_IB:  dataControlNext = WRITE_WORD;
								  
							    default: dataControlNext = NO_OP;
				         endcase
				
		      MEMORY2: casex(instruction)
				             LDBS_PR,
				             LDBS_R,
				             LDBS_RO,
				             LDBS_IA,
				             LDBS_IB,
				             LDBU_PR,
				             LDBU_R,
				             LDBU_RO,
				             LDBU_IA,
				             LDBU_IB,
				             LDD_PR,
				             LDD_R,
				             LDD_RO,
				             LDD_IA,
				             LDD_IB,
				             LDWS_PR,
				             LDWS_R,
				             LDWS_RO,
				             LDWS_IA,
				             LDWS_IB,
				             LDWU_PR,
				             LDWU_R,
				             LDWU_RO,
				             LDWU_IA,
				             LDWU_IB: dataControlNext = READ_DATA;

				             default: dataControlNext = NO_OP;
				         endcase

		      default: dataControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

