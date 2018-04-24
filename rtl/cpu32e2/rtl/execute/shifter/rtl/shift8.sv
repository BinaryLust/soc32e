

module shift8(
    input   shifterPkg::shiftOpSel          shiftOp,
	 input   logic                           shift,
	 input   logic                           carry4,
	 input   logic                   [31:0]  data4,
	
	 output  logic                           carry8,
	 output  logic                   [31:0]  data8
	 );

	
	 import shifterPkg::*;

	
	 logic          c8;
	 logic  [31:0]  d8;

	
	 // shift 8
	 always_comb begin
	     casex(shiftOp)
		      SHL:     begin c8 = data4[24]; d8 = {   data4[23:0],                 8'b0}; end // logical left shift
			   SHR:     begin c8 =  data4[7]; d8 = {          8'b0,          data4[31:8]}; end // logical right shift
			   SAR:     begin c8 =  data4[7]; d8 = {{8{data4[31]}},          data4[31:8]}; end // arithmatic right shift
			   ROL:     begin c8 = data4[24]; d8 = {   data4[23:0],         data4[31:24]}; end // left rotate
			   ROR:     begin c8 =  data4[7]; d8 = {    data4[7:0],          data4[31:8]}; end // right rotate
			   RCL:     begin c8 = data4[24]; d8 = {   data4[23:0], carry4, data4[31:25]}; end // left rotate carry
			   RCR:     begin c8 =  data4[7]; d8 = {    data4[6:0], carry4,  data4[31:8]}; end // right rotate carry
			   default: begin c8 = 1'bx; d8 = 32'bx; end
		  endcase
		
		
        {carry8, data8} = (shift) ? {c8, d8} : {carry4, data4};
	 end
	
	
endmodule

