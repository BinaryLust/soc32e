

module alu(
    input   logic                     clk,
	 input   aluPkg::aluOpSel          aluOp,
	 input   logic                     aluStart,
	 input   logic                     carryIn,
	 input   logic             [31:0]  operandA,
	 input   logic             [31:0]  operandB,
	
	 output  logic                     aluCarry,
	 output  logic             [31:0]  aluResult,
	 output  logic                     aluOverflow,
	 output  logic                     aluDone
    );
	
	
	 import aluPkg::*;
	
	
	 // primary version
    logic          carrySelect;
	 logic  [31:0]  bSel;
    logic  [31:0]  aluResultNext;
	 logic          aluCarryNext;
	 logic          aluOverflowNext;
	
	
	 // zero cycle latency
	 assign aluDone = aluStart;
	 
	 
	 always_ff @(posedge clk) begin
	     if(aluStart) begin
		      aluCarry    <= aluCarryNext;
				aluResult   <= aluResultNext;
				aluOverflow <= aluOverflowNext;
		  end else begin
		      aluCarry    <= aluCarry;
				aluResult   <= aluResult;
				aluOverflow <= aluOverflow;
		  end
	 end
	 
	 
	 always_comb begin
        case(aluOp)
		      ADD:     begin bSel = operandB;  carrySelect = 1'b0;    end
			   ADC:     begin bSel = operandB;  carrySelect = carryIn; end
			   SUB:     begin bSel = ~operandB; carrySelect = 1'b1;    end
			   SBB:     begin bSel = ~operandB; carrySelect = carryIn; end
				default: begin bSel = operandB;  carrySelect = 1'b0;    end
		  endcase
		  
		  
	     case(aluOp)
		      ADD,
			   ADC,
			   SUB,
			   SBB: begin {aluCarryNext, aluResultNext} = operandA + bSel + carrySelect; end
				
			   AND: begin {aluCarryNext, aluResultNext} = {1'b0, operandA & operandB};   end
			   OR:  begin {aluCarryNext, aluResultNext} = {1'b0, operandA | operandB};   end
			   XOR: begin {aluCarryNext, aluResultNext} = {1'b0, operandA ^ operandB};   end
			   NOT: begin {aluCarryNext, aluResultNext} = {1'b0, ~operandB};             end
		  endcase
		
		  // overflow detection
	     aluOverflowNext = (~operandA[31] & ~bSel[31] & aluResultNext[31]) | (operandA[31] & bSel[31] & ~aluResultNext[31]);
	 end

	
    // alternate version
	 /*always_comb begin
	     case(aluOp)
		   ADD: {aluCarryOut, aluResult} = operandA + operandB;
			ADC: {aluCarryOut, aluResult} = operandA + operandB + carryIn;
			SUB: {aluCarryOut, aluResult} = operandA - operandB;
			SBB: {aluCarryOut, aluResult} = operandA - operandB - carryIn;
			AND: {aluCarryOut, aluResult} = {1'b0, operandA & operandB};
			OR:  {aluCarryOut, aluResult} = {1'b0, operandA | operandB};
			XOR: {aluCarryOut, aluResult} = {1'b0, operandA ^ operandB};
			NOT: {aluCarryOut, aluResult} = {1'b0, ~operandB};
		   default: {aluCarryOut, aluResult} = operandA + operandB;
	     endcase
	 end*/
	
	
endmodule

