

module shift2(
    input   shifterPkg::shiftOpSel          shiftOp,
	 input   logic                           shift,
	 input   logic                           carry1,
	 input   logic                   [31:0]  data1,
	
	 output  logic                           carry2,
	 output  logic                   [31:0]  data2
	 );

	
	 import shifterPkg::*;
	

	 logic          c2;
	 logic  [31:0]  d2;
	
	
	 // shift 2
	 always_comb begin
	     casex(shiftOp)
		      SHL:     begin c2 = data1[30]; d2 = {   data1[29:0],                2'b0}; end // logical left shift
			   SHR:     begin c2 =  data1[1]; d2 = {          2'b0,         data1[31:2]}; end // logical right shift
			   SAR:     begin c2 =  data1[1]; d2 = {{2{data1[31]}},         data1[31:2]}; end // arithmatic right shift
			   ROL:     begin c2 = data1[30]; d2 = {   data1[29:0],        data1[31:30]}; end // left rotate
			   ROR:     begin c2 =  data1[1]; d2 = {    data1[1:0],         data1[31:2]}; end // right rotate
			   RCL:     begin c2 = data1[30]; d2 = {   data1[29:0], carry1,   data1[31]}; end // left rotate carry
			   RCR:     begin c2 =  data1[1]; d2 = {      data1[0], carry1, data1[31:2]}; end // right rotate carry
			   default: begin c2 = 1'bx; d2 = 32'bx; end
		  endcase
		
		
        {carry2, data2} = (shift) ? {c2, d2} : {carry1, data1};
	 end
	
	
endmodule

