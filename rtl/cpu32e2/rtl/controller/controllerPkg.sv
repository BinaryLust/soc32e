

package controllerPkg;


    // one-hot
    /*typedef enum logic [14:0] {
	     RESET0    = 15'b1 << 0,
		  RESET1    = 15'b1 << 1,
		  FETCH0    = 15'b1 << 2,
		  FETCH1    = 15'b1 << 3,
		  FETCH2    = 15'b1 << 4,
		  FETCH3    = 15'b1 << 5,
		  DECODE    = 15'b1 << 6,
		  LOAD      = 15'b1 << 7,
		  EXECUTE0  = 15'b1 << 8,
		  EXECUTE1  = 15'b1 << 9,
		  MEMORY1   = 15'b1 << 10,
		  MEMORY2   = 15'b1 << 11,
		  MEMORY3   = 15'b1 << 12,
		  WRITEBACK = 15'b1 << 13,
		  INTERRUPT = 15'b1 << 14
	 } states;*/
	 
	 
	 // binary
	 typedef enum logic [3:0] {
	     RESET0    = 4'd0,
		  RESET1    = 4'd1,
		  FETCH0    = 4'd2,
		  FETCH1    = 4'd3,
		  FETCH2    = 4'd4,
		  FETCH3    = 4'd5,
		  DECODE    = 4'd6,
		  LOAD      = 4'd7,
		  EXECUTE0  = 4'd8,
		  EXECUTE1  = 4'd9,
		  MEMORY1   = 4'd10,
		  MEMORY2   = 4'd11,
		  MEMORY3   = 4'd12,
		  WRITEBACK = 4'd13,
		  INTERRUPT = 4'd14
	 } states;
	 
	 
endpackage

