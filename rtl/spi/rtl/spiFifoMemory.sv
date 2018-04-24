

module spiFifoMemory
    #(parameter DATAWIDTH    = 8,
	   parameter DATADEPTH    = 1024,
		parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    
	 input   logic                      clk,
	 input   logic                      writeEn,
	 input   logic  [DATAWIDTH-1:0]     dataIn,
	 input   logic  [ADDRESSWIDTH-1:0]  readAddress,
	 input   logic  [ADDRESSWIDTH-1:0]  writeAddress,
	 output  logic  [DATAWIDTH-1:0]     dataOut
    );

	 
	 logic  [DATAWIDTH-1:0]  memoryBlock[DATADEPTH-1:0];

	 
	 always_ff @(posedge clk) begin
		  if (writeEn)
		      memoryBlock[writeAddress] <= dataIn;

        dataOut <= memoryBlock[readAddress];
	 end

	 
endmodule

