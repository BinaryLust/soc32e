

module resetCore(
    input   logic  reset,      // raw reset signal straight from the input pin on the fpga
	 input   logic  clk,        // primary clock strait from the crystal
	 input   logic  clk100,     // secondary clock from the pll
	 input   logic  clk25,
	 
	 output  logic  reset100,    // synchronized secondary reset signal
	 output  logic  reset25
	 );

	 
	 logic  masterReset;
	 
	 
	 // master synchronizer/debouncer
	 resetMasterSync
	 resetMasterSync(
        .clk,
	     .reset,
	     .masterReset
	 );
	 
	 
	 // secondary reset synchronizer
	 resetSync
	 resetSync100(
        .clk           (clk100),
	     .masterReset,
	     .syncedReset   (reset100)
	 );
	 
	 
	 // secondary reset synchronizer
	 resetSync
	 resetSync25(
        .clk           (clk25),
	     .masterReset,
	     .syncedReset   (reset25)
	 );
	 
	 
endmodule

