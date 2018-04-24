

module exceptionState(
    input  logic          clk,
	 input  logic          reset,
	 input  logic          interruptEnable,
	 input  logic          exceptionsReset,
	 input  logic  [15:0]  triggerException,
	 input  logic  [15:0]  exceptionMask,
	 output logic          exceptionPending,
	 output logic  [15:0]  triggeredExceptions
	 );

	 
	 logic          exceptionPendingNext;
	 logic  [15:0]  triggeredExceptionsNext;
	 logic  [15:0]  trigger;

	 
    // exception state register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      triggeredExceptions <= 16'b0;
		  else
			   triggeredExceptions <= triggeredExceptionsNext;
	 end


	 // exception pending register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      exceptionPending <= 1'b0;
		  else
			   exceptionPending <= exceptionPendingNext;
	 end

	
	 // exception state mux
	 generate
	
	     genvar i;

	     for(i = 0; i < 16; i++) begin : triggeredExceptionsMux
		      always_comb begin
			       trigger[i] = triggerException[i] & exceptionMask[i] & interruptEnable;
					 
					 case({exceptionsReset, trigger[i]})
					     2'b00: triggeredExceptionsNext[i] = triggeredExceptions[i]; // old data
						  2'b01: triggeredExceptionsNext[i] = 1'b1;              // set
						  2'b10: triggeredExceptionsNext[i] = 1'b0;              // reset
						  2'b11: triggeredExceptionsNext[i] = 1'b0;              // reset
					 endcase
			   end
	     end

	 endgenerate
	 
	 
	 // exception pending mux
	 always_comb begin
	     case({exceptionsReset, |trigger})
	     2'b00: exceptionPendingNext = exceptionPending; // old data
	     2'b01: exceptionPendingNext = 1'b1;              // set
	     2'b10: exceptionPendingNext = 1'b0;              // reset
	     2'b11: exceptionPendingNext = 1'b0;              // reset
	     endcase
	 end
	 
	 
endmodule

