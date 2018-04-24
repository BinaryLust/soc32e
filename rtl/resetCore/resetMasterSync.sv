

module resetMasterSync(
    input   logic  clk,
	 input   logic  reset,
	 
	 output  logic  masterReset
	 );


	 logic  [7:0]  masterResetSync;
	 
	 
	 always_ff @(posedge clk) begin
        masterResetSync <= {masterResetSync[6:0], reset}; // left shift register
		  masterReset     <= &masterResetSync;              // master reset is only triggered if reset has been high the last 8 cycles in a row, to debounce.
	 end

	 
endmodule

