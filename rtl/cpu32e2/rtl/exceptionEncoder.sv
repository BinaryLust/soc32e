

module exceptionEncoder(
    input   logic  [15:0]  triggeredExceptions,
	 output  logic  [3:0]   priorityException
	 );
	 
	 
	 // priority encoder
	 // we could use a bit scan followed by a normal non-priority encoder if this is too slow
	 always_comb begin
		  priorityException  = 4'b0000;
		  casex(triggeredExceptions)
		      {16'bxxxx_xxxx_xxxx_xxx1}: priorityException = 4'b0000;
            {16'bxxxx_xxxx_xxxx_xx10}: priorityException = 4'b0001;
			   {16'bxxxx_xxxx_xxxx_x100}: priorityException = 4'b0010;
			   {16'bxxxx_xxxx_xxxx_1000}: priorityException = 4'b0011;
		      {16'bxxxx_xxxx_xxx1_0000}: priorityException = 4'b0100;
            {16'bxxxx_xxxx_xx10_0000}: priorityException = 4'b0101;
			   {16'bxxxx_xxxx_x100_0000}: priorityException = 4'b0110;
			   {16'bxxxx_xxxx_1000_0000}: priorityException = 4'b0111;
		      {16'bxxxx_xxx1_0000_0000}: priorityException = 4'b1000;
            {16'bxxxx_xx10_0000_0000}: priorityException = 4'b1001;
			   {16'bxxxx_x100_0000_0000}: priorityException = 4'b1010;
			   {16'bxxxx_1000_0000_0000}: priorityException = 4'b1011;
		      {16'bxxx1_0000_0000_0000}: priorityException = 4'b1100;
            {16'bxx10_0000_0000_0000}: priorityException = 4'b1101;
			   {16'bx100_0000_0000_0000}: priorityException = 4'b1110;
		      {16'b1000_0000_0000_0000}: priorityException = 4'b1111;
		      default:                   priorityException = 4'b0000;
		  endcase
	 end
	 
	 
endmodule

