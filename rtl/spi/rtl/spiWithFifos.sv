

// memory map
// 2'd0: {{32-DATAWIDTH{1'b0}}, transmitData}                                                                 // data register   // write only
// 2'd1: {{32-DATAWIDTH{1'b0}}, receiveData}                                                                  // data register   // read only
// 2'd2: {30'd0, receiveValid, transmitReady}                                                                 // status register // read only
// 2'd3: {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, 10'b0, receiveIre, transmitIre} // config register // read/write

// dataDirection = 0 - (LSB First) right shift
// dataDirection = 1 - (MSB First) left shift


// add a period register that waits the set amount of cycle periods before transmitting another set of data?
// this would deassert slave select between bytes as well? or not?
// also maybe a slave select activation timer that sets how many cycles slave select is asserted before a
// transfer is started


module spiWithFifos
    #(parameter DATAWIDTH     = 8,
	   parameter TRANSMITDEPTH = 1024,
		parameter RECEIVEDEPTH  = 1024)(
    input   logic          clk,
	 input   logic          reset,
	 input   logic          read,
	 input   logic          write,
    input   logic  [1:0]   address,
	 input   logic  [31:0]  dataIn,
	 
	 output  logic          readValid,
	 output  logic  [31:0]  dataOut,
	 
	 output  logic          transmitIrq,        // interrupt request to the master
	 output  logic          receiveIrq,         // interrupt request to the master
	 
	 input   logic          miso,
	 output  logic          mosi,
	 output  logic          sclk,
	 output  logic          ss
	 );
 
 
	 // control lines/registers
	 logic  [31:0]           dataInReg;
	 logic                   readReg;
	 logic                   writeReg;
	 logic  [1:0]            addressReg;
	 logic  [31:0]           readMux;
	

	
	 // write enable lines
	 logic                   transmitDataLoadEn;
	 logic                   configLoadEn;
	 
	 
	 // read data lines
	 logic  [DATAWIDTH-1:0]  receiveData;
	 logic                   receiveValid;
	 logic                   transmitReady;
	 logic  [15:0]           clocksPerCycle;
	 logic                   clockPolarity;
	 logic                   clockPhase;
	 logic                   dataDirection;
	 logic                   ssEnable;
	 logic                   receiveIre;
	 logic                   transmitIre;
	 
	 
	 // wires
	 logic  [DATAWIDTH-1:0]  receiveDataWire;
	 logic                   transmitReadyWire;
	 logic                   transmitDataValid;
	 logic                   receiveDataValid;
	 logic                   receiveDataReadReq;
	 
	 
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
		  transmitDataLoadEn = 1'b0;
	     configLoadEn = 1'b0;
	 
	     if(writeReg) begin
		      case(addressReg)
		          2'd0: transmitDataLoadEn = 1'b1;
				    2'd3: configLoadEn       = 1'b1;
					 default: ;
		      endcase
		  end
	 end
	 
	 
	 // read mux
	 always_comb begin
	     // default
		  readMux = 32'd0;
		  
		  case(addressReg)
				2'd1: readMux = {{32-DATAWIDTH{1'b0}}, receiveData};
				2'd2: readMux = {30'd0, receiveValid, transmitReady};
				2'd3: readMux = {clocksPerCycle, clockPolarity, clockPhase, dataDirection, ssEnable, 10'b0, receiveIre, transmitIre};
				default: readMux = 32'd0;
		  endcase
	 end
	 
	 
	 // special read request signal to reset rx valid bit
	 assign receiveDataReadReq = ((addressReg == 2'd1) && readReg) ? 1'b1 : 1'b0;

	 
    spiCoreWithFifos  #(.DATAWIDTH(DATAWIDTH), .TRANSMITDEPTH(TRANSMITDEPTH), .RECEIVEDEPTH(RECEIVEDEPTH))
	 spiCoreWithFifos(
        .clk,
	     .reset,
	     .transmitDataIn       (dataInReg[DATAWIDTH-1:0]), // data from the master interface
	     .clocksPerCycleIn     (dataInReg[31:16]),         // data from the master interface
	     .clockPolarityIn      (dataInReg[15]),            // data from the master interface
	     .clockPhaseIn         (dataInReg[14]),            // data from the master interface
	     .dataDirectionIn      (dataInReg[13]),            // data from the master interface
		  .ssEnableIn           (dataInReg[12]),            // data from the master interface
	     .receiveIreIn         (dataInReg[1]),             // data from the master interface
	     .transmitIreIn        (dataInReg[0]),             // data from the master interface
	     .transmitDataLoadEn,                              // write enable from the master interface
	     .configLoadEn,                                    // write enable from the master interface
	     .receiveDataReadReq,                              // read request from the master interface
	     .receiveData,                                     // visible state to the master interface
	     .receiveValid,                                    // visible state to the master interface
	     .transmitReady,                                   // visible state to the master interface
	     .clocksPerCycle,                                  // visible state to the master interface
	     .clockPolarity,                                   // visible state to the master interface
	     .clockPhase,                                      // visible state to the master interface
	     .dataDirection,                                   // visible state to the master interface
		  .ssEnable,                                        // visible state to the master interface
	     .receiveIre,                                      // visible state to the master interface
	     .transmitIre,                                     // visible state to the master interface
	     .transmitIrq,                                     // interrupt request to the master
	     .receiveIrq,                                      // interrupt request to the master
	     .miso,
	     .mosi,
	     .sclk,
		  .ss
	 );
	 

endmodule

