

package transactionGroup;


    import boolPkg::*;
	 
	 
	 // byte write enable values
	 typedef enum logic [3:0] {
		  NULL  = 4'b0000,
		  DWORD = 4'b1111,
	     WORD0 = 4'b1100,
		  WORD1 = 4'b0011,
		  BYTE0 = 4'b1000,
        BYTE1 = 4'b0100,
        BYTE2 = 4'b0010,
        BYTE3 = 4'b0001
	 } byteWriteEn;
	 
	 
	 // control group structure
	 typedef struct packed {
		  bool         read;
        bool         write;
		  byteWriteEn  bwe;
	 } controlBus;
	 
	 
	 // control group macro values
	 localparam controlBus
	     NO_OP       = '{read:F, write:F, bwe:NULL},
		  READ        = '{read:T, write:F, bwe:NULL},
		  WRITE_DWORD = '{read:F, write:T, bwe:DWORD},
		  WRITE_WORD0 = '{read:F, write:T, bwe:WORD0},
		  WRITE_WORD1 = '{read:F, write:T, bwe:WORD1},
		  WRITE_BYTE0 = '{read:F, write:T, bwe:BYTE0},
		  WRITE_BYTE1 = '{read:F, write:T, bwe:BYTE1},
		  WRITE_BYTE2 = '{read:F, write:T, bwe:BYTE2},
		  WRITE_BYTE3 = '{read:F, write:T, bwe:BYTE3};
	
	
endpackage

