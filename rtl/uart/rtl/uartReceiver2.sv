

module uartReceiver2(
    input   logic          clk,
	 input   logic          reset,
	 input   logic  [15:0]  clocksPerCycle,
	 input   logic  [3:0]   bitsPerFrame,
	 input   logic          rx,
	 
	 output  logic          rxValid,
	 output  logic  [7:0]   rxData
	 );


    typedef  enum  logic  [1:0]  {WAITSTART = 2'b00, START = 2'b01, DATA = 2'b10, STOP = 2'b11}  states;	

	 
	 states          state;
	 states          nextState;
    logic   [15:0]  cycleCounter;
	 logic   [15:0]  cycleCounterValue;
	 logic   [3:0]   bitCounter;
	 logic   [3:0]   bitCounterValue;
	 logic   [7:0]   rxDataValue;
	 logic           halfCycle;
	 logic           cycleDone;
	 logic           bitsDone;
	 logic           rxReg;
	 logic           oldRxReg;
	 logic           startEdge;

	 
	 // state register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      state <= WAITSTART;
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
		      rxData     <= 8'b0;
		  else
		      rxData     <= rxDataValue;
	 end
	 
	 
	 // rx register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset) begin
		      rxReg      <= 1'b1;
				oldRxReg   <= 1'b1;
		  end else begin
		      rxReg      <= rx;
				oldRxReg   <= rxReg;
		  end
	 end
	 
	 
	 assign halfCycle = (cycleCounter == {1'b0, clocksPerCycle[15:1]}); // shift right one position to get the half cycle count
	 assign cycleDone = (cycleCounter >= clocksPerCycle);               // changed from ==
	 assign bitsDone  = (bitCounter   >= bitsPerFrame);                 // changed from ==
    assign startEdge = (!rxReg && oldRxReg);                           // on a valid start edge the new data is 0, and the old data is 1
	 
	
	 // combinationial logic
	 always_comb begin
	     // defaults
		  nextState         = WAITSTART;
	     cycleCounterValue = 16'd1;
	     bitCounterValue   = 4'd1;
	     rxDataValue       = rxData;
	     rxValid           = 1'b0;
		  
	     case(state)
		      WAITSTART:begin // wait for starting edge
	                      // output logic
								 cycleCounterValue = (startEdge) ? 16'b1 : cycleCounter + 16'd1; // increment here to keep sync with signal
	                      bitCounterValue   = 4'd1;
	                      rxDataValue       = rxData;   // keep old data
	                      rxValid           = 1'b0;     // signal not valid
								 
								 // next state logic
								 nextState = (startEdge) ? START : WAITSTART;
				         end
							
				START:   begin
				             // output logic
								 cycleCounterValue = (cycleDone) ? 16'b1 : cycleCounter + 16'd1;
	                      bitCounterValue   = 4'd1;
	                      rxDataValue       = rxData;  // keep old data
	                      rxValid           = 1'b0;    // signal not valid
								 
								 // next state logic
								 if(halfCycle)
								     nextState = (!rxReg)    ? START : WAITSTART; // check that start bit is still set to 0, if its not jump back to wait start
				             else
								     nextState = (cycleDone) ? DATA  : START;     // move to data state at the end of the cycle
							end
							
				DATA:    begin
				             // output logic
	                      if(cycleDone) begin
								     cycleCounterValue = 16'b1;
									  bitCounterValue   = bitCounter + 4'd1;
								 end else begin
								     cycleCounterValue = cycleCounter + 16'd1;
									  bitCounterValue   = bitCounter; // keep old value
								 end
	                      if(halfCycle) begin
								     rxDataValue       = {rxReg, rxData[7:1]};  // right shift a bit of data in
								 end else begin
								     rxDataValue       = rxData;     // keep old data
								 end
								 rxValid               = 1'b0;       // signal not valid
								 
								 // next state logic
								 nextState = (bitsDone & cycleDone) ? STOP : DATA;
				         end
							
				STOP:    begin // make sure rx data is 1 and jump back to wait start state
				             // output logic
								 rxValid               = (rxReg) ? 1'b1 : 1'b0; // signal valid when rx data is high
								 cycleCounterValue     = 16'b1;
	                      bitCounterValue       = 4'd1;
	                      rxDataValue           = rxData;     // keep old data
								 
								 // next state logic
								 nextState = (rxReg) ? WAITSTART : STOP; // jump back to wait start if rx data is high
				         end
	     endcase
    end


endmodule

