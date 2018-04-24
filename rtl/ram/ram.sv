

module ram(
    input   logic          clk,
	 input   logic          reset,
	 input   logic          read,
	 input   logic          write,
	 input   logic  [3:0]   bwe,
    input   logic  [11:0]  address,
	 input   logic  [31:0]  dataIn,
	 
	 output  logic          readValid,
	 output  logic  [31:0]  dataOut
	 );


	 // control lines/registers
	 logic          readReg;
	 
	 
	 // control registers
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset) begin
				readReg       <= 1'b0;
				readValid     <= 1'b0;
		  end else begin
				readReg       <= read;
				readValid     <= readReg;
		  end
	 end


	 systemRam
	 systemRam(
	     .address    (address),
	     .byteena    (bwe),
	     .clken      (1'b1),
	     .clock      (clk),
	     .data       (dataIn),
	     .wren       (write),
	     .q          (dataOut)
	 );
	 
	 
endmodule

