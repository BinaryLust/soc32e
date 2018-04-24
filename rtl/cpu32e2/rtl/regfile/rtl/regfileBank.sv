

module regfileBank(
    input   logic          clk,
	 input   logic          writeEnable,
	 input   logic  [4:0]   writeAddress,
	 input   logic  [31:0]  writeData,
	 input   logic  [4:0]   readAddressA,
	 input   logic  [4:0]   readAddressB,
	
	 output  logic  [31:0]  readDataA,
	 output  logic  [31:0]  readDataB
	 );

	
	 // data shows up in memory 1 cycle after we is asserted
	 // and on the output 2 cycles after we is asserted
	 regfileMemoryBlock2 #(.DATA_WIDTH(32), .ADDR_WIDTH(5))
	 regfileMemoryBlockA(
	     .clk        (clk),
	     .data       (writeData),
	     .read_addr  (readAddressA),
	     .write_addr (writeAddress),
	     .we         (writeEnable),
	     .q          (readDataA)
	 );
	
	
	 // data shows up in memory 1 cycle after we is asserted
	 // and on the output 2 cycles after we is asserted
	 regfileMemoryBlock2 #(.DATA_WIDTH(32), .ADDR_WIDTH(5))
	 regfileMemoryBlockB(
        .clk        (clk),
	     .data       (writeData),
	     .read_addr  (readAddressB),
	     .write_addr (writeAddress),
	     .we         (writeEnable),
	     .q          (readDataB)
	 );
	
	
  	 /*regfileMemoryBlock
	 regfileMemoryBlockA(
	     .clock      (clk),
	     .data       (writeData),
	     .rdaddress  (readAddressA),
	     .wraddress  (writeAddress),
	     .wren       (writeEnable),
	     .q          (readDataA)
	 );
	
	
	 regfileMemoryBlock
	 regfileMemoryBlockB(
	     .clock      (clk),
	     .data       (writeData),
	     .rdaddress  (readAddressB),
	     .wraddress  (writeAddress),
	     .wren       (writeEnable),
	     .q          (readDataB)
	 );*/
	
	
endmodule

