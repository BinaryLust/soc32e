

module uartCore(
    input   logic          clk,
	 input   logic          reset,
	 
	 input   logic  [7:0]   txDataIn,         // data from the master interface
	 input   logic  [15:0]  clocksPerCycleIn, // data from the master interface
	 input   logic  [3:0]   bitsPerFrameIn,   // data from the master interface
	 input   logic          rxIreIn,          // data from the master interface
	 input   logic          txIreIn,          // data from the master interface
	 
	 input   logic          txDataLoadEn,     // write enable from the master interface
	 input   logic          configLoadEn,     // write enable from the master interface
	 input   logic          rxDataReadReq,    // read request from the master interface
	 
	 output  logic  [7:0]   txData,           // visible state to the master interface
	 output  logic  [7:0]   rxData,           // visible state to the master interface
	 output  logic          rxValid,          // visible state to the master interface
	 output  logic          txReady,          // visible state to the master interface
	 output  logic  [15:0]  clocksPerCycle,   // visible state to the master interface
	 output  logic  [3:0]   bitsPerFrame,     // visible state to the master interface
	 output  logic          rxIre,            // visible state to the master interface
	 output  logic          txIre,            // visible state to the master interface
	 
	 output  logic          txIrq,            // interrupt request to the master
	 output  logic          rxIrq,            // interrupt request to the master
	 
	 output  logic          tx,
	 input   logic          rx
	 );
	 
	 
	 // wires
	 logic          txReadyWire;   // from the transmitter
	 logic          rxDataValid;   // from the receiver
	 logic  [7:0]   rxDataWire;    // from the receiver
	 logic          txDataValid;   // to the the transmitter
	 
	 
	 // interrupt detection registers
	 logic          txIrePre;
	 logic          txDataValidPre;
	 
	 
	 //------------------------------------------------
	 // transmit interrupt notes
	 // we can do a transmit interrupt anytime the transmit data is empty or
	 // when the transmit data goes from being full to empty after sending a
	 // byte to begin with

	 
	 // transmit interrupt request logic
	 // if txDataValid is not valid and we detect txIre changing from disabled to enabled
	 // or if txIre is enabled and we detect txDataValid changing from valid to not valid
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset) begin
		      txIrq          <= 1'b0;
				txIrePre       <= 1'b0;
				txDataValidPre <= 1'b0;
		  end else begin
		      txIrq          <= (!txDataValid && (!txIrePre && txIre)) | (txIre && (txDataValidPre && !txDataValid));
				txIrePre       <= txIre;
				txDataValidPre <= txDataValid;
		  end
	 end
	 
	 
	 // receive interrupt request logic
	 // if receive interrupt request enable is set and rxDataValid is asserted
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      rxIrq <= 1'b0;
		  else
		      rxIrq <= rxIre & rxDataValid;
	 end
	 
	 
	 //------------------------------------------------
	 // visible registers
	 
	 
	 // txData register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      txData <= 8'b0;
		  else if(txDataLoadEn)
		      txData <= txDataIn;
		  else
		      txData <= txData;
	 end
	 
	 
	 // rxData register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      rxData <= 8'b0;
		  else if(rxDataValid)
		      rxData <= rxDataWire;
		  else
		      rxData <= rxData;
	 end
	 
	 
	 // rxValid register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      rxValid <= 1'b0; // reset valid
		  else if(rxDataValid)
		      rxValid <= 1'b1; // set valid (this gets priority if the condition below is active at the same time)
		  else if(rxDataReadReq)
		      rxValid <= 1'b0; // reset valid
		  else
		      rxValid <= rxValid;
	 end
	 
	 
	 // txReady register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      txReady <= 1'b1; // set ready
	     else if(txDataLoadEn)
		      txReady <= 1'b0; // reset ready when writting txData byte (this gets priority if the condition below is active at the same time)
		  else if(txDataValid && txReadyWire)
		      txReady <= 1'b1; // set ready if data is already valid and transmitter reads the stored byte
		  else
		      txReady <= txReady;
	 end
	 
	 
	 // cycles per clock register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
				clocksPerCycle <= 16'd10416; // (100Mhz / 9600 baud) = 10,416 cycles per bit default //(50MHz / 9600 baud) = 5,208 cycles per bit default
		  else if(configLoadEn)
	         clocksPerCycle <= clocksPerCycleIn;
		  else
				clocksPerCycle <= clocksPerCycle;
	 end
	 
	 
	 // bits per frame register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
				bitsPerFrame <= 4'd8;     // 8 bits per transfer default
		  else if(configLoadEn)
	         bitsPerFrame <= bitsPerFrameIn;
		  else
				bitsPerFrame <= bitsPerFrame;
	 end
	 
	 
	 // receive interrupt request enable register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
				rxIre <= 1'd0;
		  else if(configLoadEn)
	         rxIre <= rxIreIn;
		  else
				rxIre <= rxIre;
	 end
	 
	 
	 // transmit interrupt request enable register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
				txIre <= 1'd0;
		  else if(configLoadEn)
	         txIre <= txIreIn;
		  else
				txIre <= txIre;
	 end
	 
	 
	 //------------------------------------------------
	 // hidden registers
	 
	 
	 // txDataValid register
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      txDataValid <= 1'b0; // set not valid
		  else if(txDataLoadEn)
		      txDataValid <= 1'b1; // set ready if another byte is written (this gets priority if the condition below is active at the same time)
	     else if(txReadyWire)
		      txDataValid <= 1'b0; // reset ready when the transmitter reads the data
		  else
		      txDataValid <= txDataValid;
	 end
	 
	 
	 //------------------------------------------------
	 // transmit and receive modules
	 
	 
	 uartTransmitter
	 uartTransmitter(
        .clk,
	     .reset,
	     .txDataValid,
	     .txDataIn          (txData),
	     .clocksPerCycle,
	     .bitsPerFrame,
	     .txReady           (txReadyWire),
	     .tx
	 );
	 
	 
	 uartReceiver
	 uartReceiver(
        .clk,
	     .reset,
	     .clocksPerCycle,
	     .bitsPerFrame,
	     .rx,
	     .rxValid           (rxDataValid),
	     .rxData            (rxDataWire)
	 );
	 
	 
endmodule

