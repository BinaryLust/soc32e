

module exceptionOutputLogic(
    input   logic                               clk,
	 input   logic                               reset,
	 input   logic                               enable, // for stalling
	 input   architecture::opcodes               instruction,
	 //input   decoderPkg::instructions            instruction,
	 input   controllerPkg::states               state,
	 input   logic                               exceptionPending,
	 input   logic                               interruptPending,
	 
	 output  exceptionGroup::controlBus          exceptionControl
	 );

	 
	 import architecture::*;
	 //import decoderPkg::*;
	 import controllerPkg::*;
	 import exceptionGroup::*;
	 
	 
	 exceptionGroup::controlBus  exceptionControlNext;
	 
	 
	 // output register
	 always_ff @(posedge clk or posedge reset) begin
        if(reset)
		      exceptionControl <= NO_OP;
		  else if(enable)
		      exceptionControl <= exceptionControlNext;
		  else
		      exceptionControl <= exceptionControl;
	 end
	 
	 
	 // output logic
	 always_comb begin
	     // default
		  exceptionControlNext = NO_OP;
		  
	 	  case(state)
		      WRITEBACK: case({exceptionPending, interruptPending})
				               2'b00: exceptionControlNext = NO_OP;
									2'b01: exceptionControlNext = DO_INT;
									2'b10: exceptionControlNext = DO_EXC;
									2'b11: exceptionControlNext = DO_EXC;
				           endcase
							  
		      default:   exceptionControlNext = NO_OP;
		  endcase
	 end
	 
	 
endmodule

