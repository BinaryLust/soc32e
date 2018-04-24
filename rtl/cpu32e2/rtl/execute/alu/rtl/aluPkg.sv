

package aluPkg;


    // alu operation select
	 typedef enum logic [2:0] {
	     ADD = 3'b000,
		  ADC = 3'b001,
		  SUB = 3'b010,
		  SBB = 3'b011,
		  AND = 3'b100,
		  OR  = 3'b101,
		  XOR = 3'b110,
		  NOT = 3'b111
	 } aluOpSel;
	 
	 
endpackage

