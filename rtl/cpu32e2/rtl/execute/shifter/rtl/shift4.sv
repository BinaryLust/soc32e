

module shift4(
    input   shifterPkg::shiftOpSel          shiftOp,
	 input   logic                           shift,
	 input   logic                           carry2,
	 input   logic                   [31:0]  data2,
	
	 output  logic                           carry4,
	 output  logic                   [31:0]  data4
	 );

	
	 import shifterPkg::*;
	
	
	 logic          c4;
	 logic  [31:0]  d4;
	
	
	 // shift 4
	 always_comb begin
	     casex(shiftOp)
		      SHL:     begin c4 = data2[28]; d4 = {   data2[27:0],                 4'b0}; end // logical left shift
			   SHR:     begin c4 =  data2[3]; d4 = {          4'b0,          data2[31:4]}; end // logical right shift
			   SAR:     begin c4 =  data2[3]; d4 = {{4{data2[31]}},          data2[31:4]}; end // arithmatic right shift
			   ROL:     begin c4 = data2[28]; d4 = {   data2[27:0],         data2[31:28]}; end // left rotate
			   ROR:     begin c4 =  data2[3]; d4 = {    data2[3:0],          data2[31:4]}; end // right rotate
			   RCL:     begin c4 = data2[28]; d4 = {   data2[27:0], carry2, data2[31:29]}; end // left rotate carry
			   RCR:     begin c4 =  data2[3]; d4 = {    data2[2:0], carry2,  data2[31:4]}; end // right rotate carry
			   default: begin c4 = 1'bx; d4 = 32'bx; end
		  endcase
		
		
        {carry4, data4} = (shift) ? {c4, d4} : {carry2, data2};
	 end
	
	
endmodule

