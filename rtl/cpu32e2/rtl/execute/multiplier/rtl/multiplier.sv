

module multiplier(
    input   logic          clk,
	 input   logic          reset,
	 input   logic          sign,
	 input   logic          multiplierStart,
	 input   logic  [31:0]  operandA,
	 input   logic  [31:0]  operandB,
	
	 output  logic  [31:0]  multiplierResultHigh,
	 output  logic  [31:0]  multiplierResultLow,
	 output  logic          multiplierDone
    );
	
	
	 //logic  [31:0]  multiplierResultHighNext;
	 //logic  [31:0]  multiplierResultLowNext;
	
	
	 // registers
	 /*always_ff @(posedge clk) begin
	     if(multiplierStart) begin
		      multiplierResultHigh <= multiplierResultHighNext;
		      multiplierResultLow  <= multiplierResultLowNext;
		  end else begin
		      multiplierResultHigh <= multiplierResultHigh;
				multiplierResultLow  <= multiplierResultLow;
		  end
		  
		  
		  // registered done signal
		  multiplierDone <= multiplierStart;
	 end
	
	
	 // combinationial logic
	 always_comb begin
	     if(sign)
		      {multiplierResultHighNext, multiplierResultLowNext} = signed'(operandA) * signed'(operandB);
	     else
		      {multiplierResultHighNext, multiplierResultLowNext} = unsigned'(operandA) * unsigned'(operandB);
	 end*/
	
	
	 // dsp multiplier
    dspMultiplier
	 dspMultiplier(
	     .clock0   (clk),
	     .dataa_0  (operandA),
	     .datab_0  (operandB),
		  .ena0     (multiplierDone),
	     .signa    (sign),
	     .signb    (sign),
	     .result   ({multiplierResultHigh, multiplierResultLow})
	 );
	 
	 
	 // one cycle latency
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      multiplierDone <= 1'b0;
		  else if(multiplierStart)
		      multiplierDone <= !multiplierDone; // done is set every 2nd cycle
		  else
		      multiplierDone <= multiplierDone;
	 end
	 
	 
endmodule

