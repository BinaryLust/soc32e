

module lineBuffer(
   input   logic          writeClk,
	input   logic          writeEn,
	input   logic  [9:0]   writeAddress,
	input   logic  [31:0]  writeData,
	
	input   logic          readClk,
	input   logic  [11:0]  readAddress,
	output  logic  [7:0]   readData
   );
	
	
	// Declare the RAM variable
	logic  [3:0][7:0]  ram[511:0];
	
	
	integer i;
	
	
	// fill the block with stuff
	initial begin
	    for(i = 0; i < 512; i++)
	        ram[i] = 32'haaaaaaaa;
	end
	
	
	always_ff @(posedge writeClk) begin
		if (writeEn)
			ram[writeAddress] <= writeData;
	end
	
	
	always_ff @(posedge readClk) begin
		readData <= ram[readAddress[11:2]][readAddress[1:0]];
	end
	
	
endmodule

