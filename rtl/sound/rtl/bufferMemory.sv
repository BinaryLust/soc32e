

module bufferMemory(
    input   logic         clk,
	 input   logic         writeEn,
	 input   logic  [7:0]  dataIn,
	 input   logic  [9:0]  readAddress,
	 input   logic  [9:0]  writeAddress,
	 output  logic  [7:0]  dataOut
    );

	 
	 logic  [7:0]  memoryBlock[1023:0];

	 
	 always_ff @(posedge clk) begin
		  if (writeEn)
		      memoryBlock[writeAddress] <= dataIn;

        dataOut <= memoryBlock[readAddress];
	 end

	 
endmodule

