

package shifterPkg;

	
	 // shifter operation select
	 typedef enum logic [2:0] {
	     SHL = 3'b000,
        SHR = 3'b001,
		  SAR = 3'b010,
		  ROL = 3'b011,
		  ROR = 3'b100,
		  RCL = 3'b101,
		  RCR = 3'b110
	 } shiftOpSel;

	
endpackage

