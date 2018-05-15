

// module spiCoreWithFifos
//     #(parameter DATAWIDTH            = 8,
// 	   parameter TRANSMITDEPTH        = 1024,
// 		parameter RECEIVEDEPTH         = 1024,
// 		parameter TRANSMITADDRESSWIDTH = $clog2(TRANSMITDEPTH),
// 		parameter RECEIVEADDRESSWIDTH  = $clog2(RECEIVEDEPTH))(
//     input   logic                   clk,
// 	 input   logic                   reset,

// 	 input   logic  [DATAWIDTH-1:0]  transmitDataIn,     // data from the master interface
// 	 input   logic  [15:0]           clocksPerCycleIn,   // data from the master interface
// 	 input   logic                   clockPolarityIn,    // data from the master interface
// 	 input   logic                   clockPhaseIn,       // data from the master interface
// 	 input   logic                   dataDirectionIn,    // data from the master interface
// 	 input   logic                   ssEnableIn,         // data from the master interface
// 	 input   logic                   receiveIreIn,       // data from the master interface
// 	 input   logic                   transmitIreIn,      // data from the master interface

// 	 input   logic                   transmitDataLoadEn, // write enable from the master interface
// 	 input   logic                   configLoadEn,       // write enable from the master interface
// 	 input   logic                   receiveDataReadReq, // read request from the master interface

// 	 output  logic  [DATAWIDTH-1:0]  receiveData,        // visible state to the master interface
// 	 output  logic                   receiveValid,       // visible state to the master interface
// 	 output  logic                   transmitReady,      // visible state to the master interface
// 	 output  logic  [15:0]           clocksPerCycle,     // visible state to the master interface
// 	 output  logic                   clockPolarity,      // visible state to the master interface
// 	 output  logic                   clockPhase,         // visible state to the master interface
// 	 output  logic                   dataDirection,      // visible state to the master interface
// 	 output  logic                   ssEnable,           // visible state to the master interface
// 	 output  logic                   receiveIre,         // visible state to the master interface
// 	 output  logic                   transmitIre,        // visible state to the master interface

// 	 output  logic                   transmitIrq,        // interrupt request to the master
// 	 output  logic                   receiveIrq,         // interrupt request to the master

// 	 input   logic                   miso,
// 	 output  logic                   mosi,
// 	 output  logic                   sclk,
// 	 output  logic                   ss
// 	 );


// 	 // wires
// 	 logic                   transmitReadyWire;  // from the transmitter
// 	 logic                   receiveDataValid;   // from the receiver
// 	 logic  [DATAWIDTH-1:0]  receiveDataWire;    // from the receiver
// 	 logic                   transmitDataValid;  // to the the transmitter
// 	 logic                   transmitFifoEmpty;
// 	 logic                   transmitFifoFull;
// 	 logic                   receiveFifoEmpty;
//     logic  [DATAWIDTH-1:0]  transmitData;


// 	 // interrupt detection registers
// 	 //logic                   transmitIrePre;
// 	 //logic                   transmitDataValidPre;


// 	 //------------------------------------------------
// 	 // transmit interrupt notes
// 	 // we can do a transmit interrupt anytime the transmit data is empty or
// 	 // when the transmit data goes from being full to empty after sending a
// 	 // byte to begin with


// 	 // transmit interrupt request logic
// 	 // if transmitDataValid is not valid and we detect transmitIre changing from disabled to enabled
// 	 // or if transmitIre is enabled and we detect transmitDataValid changing from valid to not valid
// 	 /*always_ff @(posedge clk or posedge reset) begin
// 	     if(reset) begin
// 		      transmitIrq          <= 1'b0;
// 				transmitIrePre       <= 1'b0;
// 				transmitDataValidPre <= 1'b0;
// 		  end else begin
// 		      transmitIrq          <= (!transmitDataValid && (!transmitIrePre && transmitIre)) | (transmitIre && (transmitDataValidPre && !transmitDataValid));
// 				transmitIrePre       <= transmitIre;
// 				transmitDataValidPre <= transmitDataValid;
// 		  end
// 	 end


// 	 // receive interrupt request logic
// 	 // if receive interrupt request enable is set and receiveDataValid is asserted
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 		      receiveIrq <= 1'b0;
// 		  else
// 		      receiveIrq <= receiveIre & receiveDataValid;
// 	 end*/


// 	 // use greater than/less than comparator to monitor fifo fill level and trigger interrupt
// 	 assign transmitIrq = 1'b0;
// 	 assign receiveIrq  = 1'b0;


// 	 //------------------------------------------------
// 	 // visible registers


// 	 assign transmitDataValid = !transmitFifoEmpty;
// 	 assign receiveValid      = !receiveFifoEmpty;
// 	 assign transmitReady     = !transmitFifoFull;


// 	 // transmit fifo
// 	 spiFifo #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(TRANSMITDEPTH))
// 	 spiTransmitFifo(
//         .clk,
// 	     .reset,
// 	     .writeEn       (transmitDataLoadEn),
// 	     .readReq       (transmitDataValid && transmitReadyWire),
// 	     .dataIn        (transmitDataIn),
// 	     .dataOut       (transmitData),
// 	     .wordCount     (),
// 	     .empty         (transmitFifoEmpty),
// 		  .full          (transmitFifoFull)
// 	 );


// 	 // receive fifo
// 	 spiFifo #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(RECEIVEDEPTH))
// 	 spiReceiveFifo(
//         .clk,
// 	     .reset,
// 	     .writeEn       (receiveDataValid),
// 	     .readReq       (receiveDataReadReq),
// 	     .dataIn        (receiveDataWire),
// 	     .dataOut       (receiveData),
// 	     .wordCount     (),
// 	     .empty         (receiveFifoEmpty),
// 		  .full          ()
// 	 );


// 	 // cycles per clock register
// 	 always_ff @(posedge clk or posedge reset) begin
// 		  if(reset)
// 				clocksPerCycle <= 16'd500; // 100 Kbps default
// 		  else if(configLoadEn)
// 	         clocksPerCycle <= clocksPerCycleIn;
// 		  else
// 				clocksPerCycle <= clocksPerCycle;
// 	 end


// 	 // clock polarity register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				clockPolarity <= 1'd0;
// 		  else if(configLoadEn)
// 	         clockPolarity <= clockPolarityIn;
// 		  else
// 				clockPolarity <= clockPolarity;
// 	 end


// 	 // clock phase register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				clockPhase <= 1'd0;
// 		  else if(configLoadEn)
// 	         clockPhase <= clockPhaseIn;
// 		  else
// 				clockPhase <= clockPhase;
// 	 end


// 	 // data direction register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				dataDirection <= 1'd0;
// 		  else if(configLoadEn)
// 	         dataDirection <= dataDirectionIn;
// 		  else
// 				dataDirection <= dataDirection;
// 	 end


// 	 // slave select enable register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				ssEnable <= 1'd0;
// 		  else if(configLoadEn)
// 	         ssEnable <= ssEnableIn;
// 		  else
// 				ssEnable <= ssEnable;
// 	 end


// 	 // receive interrupt request enable register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				receiveIre <= 1'd0;
// 		  else if(configLoadEn)
// 	         receiveIre <= receiveIreIn;
// 		  else
// 				receiveIre <= receiveIre;
// 	 end


// 	 // transmit interrupt request enable register
// 	 always_ff @(posedge clk or posedge reset) begin
// 	     if(reset)
// 				transmitIre <= 1'd0;
// 		  else if(configLoadEn)
// 	         transmitIre <= transmitIreIn;
// 		  else
// 				transmitIre <= transmitIre;
// 	 end


// 	 //------------------------------------------------
// 	 // hidden registers


// 	 // previous word count registers
// 	 /*always_ff @(posedge clk or posedge reset) begin
// 	     if(reset) begin
// 				wordCountP1 <= 1'd0;
// 				wordCountP2 <= 1'd0;
// 		  end else if(rxDataValid) begin  // update the count when the buffer is written to
// 				wordCountP1 <= wordCount;   // last cycle
// 				wordCountP2 <= wordCountP1; // two cycles ago
// 		  end
// 	 end*/


// 	 //------------------------------------------------
// 	 // transmit and receive modules


//     spiUnit  #(.DATAWIDTH(DATAWIDTH))
// 	 spiUnit(
//         .clk,
// 	     .reset,
//         .clocksPerCycle,
// 	     .clockPolarity,
// 	     .clockPhase,
// 	     .dataDirection,
// 		  .ssEnable,
// 	     .transmitValid     (transmitDataValid),
// 	     .dataRegIn         (transmitData),
// 	     .dataReg           (receiveDataWire),
// 	     .transmitReady     (transmitReadyWire),
// 	     .receiveValid      (receiveDataValid),
// 	     .miso,
// 	     .mosi,
// 	     .sclk,
// 		  .ss
// 	 );


// endmodule

