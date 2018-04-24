

module regfileInputRegisters(
    input   logic         clk,
	 input   logic         reset,
	 input   logic         writeEnableA,
	 input   logic         writeEnableB,
	 input   logic  [4:0]  writeAddressA,
	 input   logic  [4:0]  writeAddressB,
	 input   logic  [4:0]  readAddressA,
	 input   logic  [4:0]  readAddressB,
	
	 output  logic         writeEnableAReg,
	 output  logic         writeEnableBReg,
	 output  logic  [4:0]  writeAddressAReg,
	 output  logic  [4:0]  writeAddressBReg,
	 output  logic  [4:0]  readAddressAReg,
	 output  logic  [4:0]  readAddressBReg
	 );
	
	
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset) begin
		      writeEnableAReg  <= 1'b0;
		      writeEnableBReg  <= 1'b0;
            writeAddressAReg <= 5'b0;
            writeAddressBReg <= 5'b0;
		      readAddressAReg  <= 5'b0;
		      readAddressBReg  <= 5'b0;
		  end
		  else begin
		      writeEnableAReg  <= writeEnableA;
		      writeEnableBReg  <= writeEnableB;
            writeAddressAReg <= writeAddressA;
            writeAddressBReg <= writeAddressB;
		      readAddressAReg  <= readAddressA;
		      readAddressBReg  <= readAddressB;
		  end
	 end
	
	
endmodule

