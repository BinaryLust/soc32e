

// memory map
// 2'd0: {24'd0, txData}                                     // data register   // read/write
// 2'd1: {24'd0, rxData}                                     // data register   // read only
// 2'd2: {30'd0, rxValid, txReady}                           // status register // read only
// 2'd3: {clocksPerCycle, bitsPerFrame, 10'd0, rxIre, txIre} // config register // read/write


module uart2(
    input   logic          clk,
	 input   logic          reset,
	 input   logic          read,
	 input   logic          write,
    input   logic  [1:0]   address,
	 input   logic  [31:0]  dataIn,
	 
	 output  logic          readValid,
	 output  logic  [31:0]  dataOut,
	 
	 output  logic          txIrq,
	 output  logic          rxIrq,
	 
	 input   logic          rx,
	 output  logic          tx
	 );
 
 
	 // control lines/registers
	 logic  [31:0]  dataInReg;
	 logic          readReg;
	 logic          writeReg;
	 logic  [1:0]   addressReg;
	 logic  [31:0]  readMux;
	

	
	 // write enable lines
	 logic          txDataLoadEn;
	 logic          configLoadEn;
	 
	 
	 // read data lines
	 logic  [7:0]   txData;
	 logic  [7:0]   rxData;
	 logic          rxValid;
	 logic          txReady;
	 logic  [15:0]  clocksPerCycle;
	 logic  [3:0]   bitsPerFrame;
	 logic          rxIre;
	 logic          txIre;
	 
	 
	 // wires
	 logic  [7:0]   rxDataWire;
	 logic          txReadyWire;
	 logic          txDataValid;
	 logic          rxDataValid;
	 logic          rxDataReadReq;
	 
	 
	 // control registers
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset) begin
				readReg       <= 1'b0;
				writeReg      <= 1'b0;
				readValid     <= 1'b0;
				addressReg    <= 2'd0;
		  end else begin
				readReg       <= read;
				writeReg      <= write;
				readValid     <= readReg;
				addressReg    <= address;
		  end
	 end
	 
	 
	 // data input/output registers
	 always_ff @(posedge clk) begin
	     dataInReg <= dataIn;
		  dataOut   <= readMux;
	 end


	 // write decoder
	 always_comb begin
	     // defaults
		  txDataLoadEn = 1'b0;
	     configLoadEn = 1'b0;
	 
	     if(writeReg) begin
		      case(addressReg)
		          2'd0: txDataLoadEn = 1'b1;
				    2'd3: configLoadEn = 1'b1;
					 default: ;
		      endcase
		  end
	 end
	 
	 
	 // read mux
	 always_comb begin
	     // default
		  readMux = 32'd0;
		  
		  case(addressReg)
		      2'd0: readMux = {24'd0, txData};
				2'd1: readMux = {24'd0, rxData};
				2'd2: readMux = {30'd0, rxValid, txReady};
				2'd3: readMux = {clocksPerCycle, bitsPerFrame, 10'd0, rxIre, txIre};
		  endcase
	 end
	 
	 
	 // special read request signal to reset rx valid bit
	 assign rxDataReadReq = ((addressReg == 2'd1) && readReg) ? 1'b1 : 1'b0;
	 
	 
	 uartCore2
	 uartCore2(
        .clk,
	     .reset,
		  .txDataIn          (dataInReg[7:0]),   // data to the slave
	     .clocksPerCycleIn  (dataInReg[31:16]), // data to the slave
	     .bitsPerFrameIn    (dataInReg[15:12]), // data to the slave
	     .rxIreIn           (dataInReg[1]),     // data to the slave
	     .txIreIn           (dataInReg[0]),     // data to the slave
	     .txDataLoadEn,                         // write enable to the slave
	     .configLoadEn,                         // write enable to the slave
	     .rxDataReadReq,                        // read request to the slave
	     .txData,                               // visible state from the slave
	     .rxData,                               // visible state from the slave
	     .rxValid,                              // visible state from the slave
	     .txReady,                              // visible state from the slave
	     .clocksPerCycle,                       // visible state from the slave
	     .bitsPerFrame,                         // visible state from the slave
	     .rxIre,                                // visible state from the slave
	     .txIre,                                // visible state from the slave
	     .txIrq,                                // interrupt request from the slave
	     .rxIrq,                                // interrupt request from the slave
	     .tx,
		  .rx
	 );

	 
endmodule

