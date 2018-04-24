

package divider2Pkg;
	 
	 
	 // dividend select values
	 typedef enum logic [2:0] {
		  DIVIDEND_IN      = 3'd0,
		  RESET_DIVIDEND   = 3'd1,
        NEG_DIVIDEND_IN  = 3'd2,
		  NEG_DIVIDEND     = 3'd3,
		  SHIFTED_DIVIDEND = 3'd4
	 } dividendMux;
	 
	 
	 // divisor select values
	 typedef enum logic {
	     DIVISOR_IN       = 1'b0,
		  NEG_DIVISOR_IN   = 1'b1
	 } divisorMux;


	 // remainder select values
	 typedef enum logic[1:0] {
	 	  RESET_REMAINDER      = 2'd0,
		  NEG_REMAINDER        = 2'd1,
		  SHIFTED_REMAINDER    = 2'd2,
	     SUBTRACTED_REMAINDER = 2'd3
	 } remainderMux;
	
	
endpackage

