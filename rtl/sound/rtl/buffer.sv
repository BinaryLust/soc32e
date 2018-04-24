

module buffer(
    input   logic         clk,
	 input   logic         reset,
	 input   logic         writeEn,
	 input   logic         readReq,
	 input   logic  [7:0]  dataIn,
	 output  logic  [7:0]  dataOut,
	 output  logic  [9:0]  wordCount
	 );


	 logic  [7:0]  dataOutWire;
	 logic  [9:0]  writePointer;
	 logic  [9:0]  readPointer;
	 
	 
    // write pointer
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      writePointer <= 10'd0;
		  else if(writeEn)
		      writePointer <= writePointer + 10'd1;
		  else
		      writePointer <= writePointer;
	 end
	 
	 
	 // read pointer
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      readPointer <= 10'd0;
		  else if(readReq)
		      readPointer <= readPointer + 10'd1;
		  else
		      readPointer <= readPointer;
	 end
	 
	 
	 // word counter
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      wordCount <= 10'd0;
		  else if(readReq && !writeEn)
		      wordCount <= wordCount - 10'd1; // read but no write
		  else if(writeEn && !readReq)
		      wordCount <= wordCount + 10'd1; // write but no read
		  else
		      wordCount <= wordCount;         // no change if read and write at the same time or no activity
	 end
	 
	 
	 // data output register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      dataOut <= 8'd0;
		  else if(readReq)
		      dataOut <= dataOutWire;
		  else
		      dataOut <= dataOut;
	 end
	 
	 
	 bufferMemory
	 bufferMemory(
        .clk,
	     .writeEn,
	     .dataIn,
	     .readAddress    (readPointer),
	     .writeAddress   (writePointer),
	     .dataOut        (dataOutWire)
    );
	 

endmodule

