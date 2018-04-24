

module shift16(
    input   shifterPkg::shiftOpSel          shiftOp,
	 input   logic                           shift,
	 input   logic                           carry8,
	 input   logic                   [31:0]  data8,
	
	 output  logic                           carry16,
	 output  logic                   [31:0]  data16
	 );

	
	 import shifterPkg::*;
	
	
	 logic          c16;
	 logic  [31:0]  d16;
	
	
	 // shift 16
	 always_comb begin
	     casex(shiftOp)
		      SHL:     begin c16 = data8[16]; d16 = {    data8[15:0],                16'b0}; end // logical left shift
			   SHR:     begin c16 = data8[15]; d16 = {          16'b0,         data8[31:16]}; end // logical right shift
			   SAR:     begin c16 = data8[15]; d16 = {{16{data8[31]}},         data8[31:16]}; end // arithmatic right shift
			   ROL:     begin c16 = data8[16]; d16 = {    data8[15:0],         data8[31:16]}; end // left rotate
			   ROR:     begin c16 = data8[15]; d16 = {    data8[15:0],         data8[31:16]}; end // right rotate
			   RCL:     begin c16 = data8[16]; d16 = {    data8[15:0], carry8, data8[31:17]}; end // left rotate carry
			   RCR:     begin c16 = data8[15]; d16 = {    data8[14:0], carry8, data8[31:16]}; end // right rotate carry
			   default: begin c16 = 1'bx; d16 = 32'bx; end
		  endcase
		
		
        {carry16, data16} = (shift) ? {c16, d16} : {carry8, data8};
	 end
	
	
endmodule

