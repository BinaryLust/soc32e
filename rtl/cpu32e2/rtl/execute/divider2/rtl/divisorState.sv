

module divisorState(
    input   logic                            clk,
	 input   logic                            reset,
	 input   boolPkg::bool                    divisorEn,
	 input   divider2Pkg::divisorMux          divisorSel,
	 input   logic                    [31:0]  divisorIn,
	 
	 output  logic                    [31:0]  divisor
	 );
	 
	 
	 import divider2Pkg::*;
	 
	 
	 logic  [31:0]  divisorNext;
	 
	 
	 // Register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      divisor <= 32'b0;
		  else if(divisorEn)
		      divisor <= divisorNext;
		  else
		      divisor <= divisor;
	 end

	 
	 // Combinationial Logic
	 always_comb begin
		  case(divisorSel)
		      DIVISOR_IN:     divisorNext = divisorIn;
		      NEG_DIVISOR_IN: divisorNext = -divisorIn;
		  endcase
	 end
	 
	 
endmodule

