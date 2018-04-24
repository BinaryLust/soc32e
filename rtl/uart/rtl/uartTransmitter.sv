

module uartTransmitter(
    input   logic          clk,
	 input   logic          reset,
	 input                  txDataValid,
	 input   logic  [7:0]   txDataIn,
	 input   logic  [15:0]  clocksPerCycle,
	 input   logic  [3:0]   bitsPerFrame,
	 
	 output  logic          txReady,
	 output  logic          tx
	 );


    typedef  enum  logic  [1:0]  {IDLE = 2'b00, STOP = 2'b01, START = 2'b10, DATA = 2'b11}  states;	

	 
	 states          state;
	 states          nextState;
    logic   [15:0]  cycleCounter;
	 logic   [15:0]  cycleCounterValue;
	 logic   [3:0]   bitCounter;
	 logic   [3:0]   bitCounterValue;
	 logic   [7:0]   txData;
	 logic   [7:0]   txDataValue;
	 logic           cycleDone;
	 logic           bitsDone;
	 logic           txValue;
	 

	 // state register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      state <= IDLE;
		  else
		      state <= nextState;
	 end
	
	
	 // cycle counter register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      cycleCounter <= 16'd1;
		  else
		      cycleCounter <= cycleCounterValue;
	 end
	 
	 
	 // bit counter register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      bitCounter <= 4'd1;
		  else
		      bitCounter <= bitCounterValue;
	 end
	 
	 
	 // data register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      txData     <= 8'b0;
		  else
		      txData     <= txDataValue;
	 end
	 
	 
	 // tx register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      tx         <= 1'b1;
		  else
		      tx         <= txValue;
	 end
	 
	 
	 assign cycleDone = (cycleCounter >= clocksPerCycle); // changed from ==
	 assign bitsDone  = (bitCounter   >= bitsPerFrame);   // changed from ==

	
	 // combinationial logic
	 always_comb begin
	     // defaults
		  nextState         = IDLE;
	     cycleCounterValue = 16'd1;
	     bitCounterValue   = 4'd1;
	     txDataValue       = txData;
	     txValue           = 1'b1;
	     txReady           = 1'b0;
		  
	     case(state)
		      IDLE:    begin
	                      // output logic
								 cycleCounterValue = 16'd1;
	                      bitCounterValue   = 4'd1;
	                      txDataValue       = txDataIn; // load new data
	                      txValue           = 1'b1;     // output 1
	                      txReady           = 1'b1;     // signal ready
								 
								 // next state logic
								 nextState = (txDataValid) ? START : IDLE;
				         end
							
				START:   begin
				             // output logic
								 cycleCounterValue = (cycleDone) ? 16'b1 : cycleCounter + 16'd1;
	                      bitCounterValue   = 4'd1;
	                      txDataValue       = txData; // keep old data
	                      txValue           = 1'b0;   // output 0
	                      txReady           = 1'b0;
								 
								 // next state logic
								 nextState = (cycleDone) ? DATA  : START;
				         end
							
				DATA:    begin
				             // output logic
	                      if(cycleDone) begin
								     cycleCounterValue = 16'b1;
									  bitCounterValue   = bitCounter + 4'd1;
									  txDataValue       = {1'b0, txData[7:1]};  // right shift data
								 end else begin
								     cycleCounterValue = cycleCounter + 16'd1;
									  bitCounterValue   = bitCounter; // keep old value
									  txDataValue       = txData;     // keep old data
								 end
								 txValue               = txData[0]; // output data bit
	                      txReady               = 1'b0;
								 
								 // next state logic
								 nextState = (bitsDone & cycleDone) ? STOP : DATA;
				         end
							
				STOP:    begin
				             // output logic
								 cycleCounterValue = (cycleDone) ? 16'b1 : cycleCounter + 16'd1;
	                      bitCounterValue   = 4'd1;
	                      txDataValue       = txData; // keep old data
	                      txValue           = 1'b1;   // output 1
	                      txReady           = 1'b0;
								 
								 // next state logic
								 nextState = (cycleDone) ? IDLE : STOP;
				         end
	     endcase
    end


endmodule

