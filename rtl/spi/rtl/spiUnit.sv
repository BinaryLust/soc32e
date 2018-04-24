

// don't even look at clock polarity

// clock phase = 0
// load data in data register and output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// toggle clock, output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// ...

// clock phase = 1
// load data in data register, output data to mosi, and toggle clock, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
// toggle clock, output data to mosi, wait a full cycle
// toggle clock, and sample miso data, wait a full cycle
//...

// the only difference between the two is toggling or not toggling the clock on the first cycle


// received data will always end up in dataReg


// whenever dataReg gets loaded we load mosi at the same time with the correct bit depending on data direction from the dataRegIn line

// 1 - load data register with transmit data
// 2 - load mosi with data bit from data register
// 3 - sample miso input
// 4 - shift sample in to data register, and load mosi


module spiUnit
	 #(parameter DATAWIDTH       = 8,
	   parameter BITCOUNTERWIDTH = $clog2(DATAWIDTH))(
    input   logic                   clk,
	 input   logic                   reset,
    input   logic  [15:0]           clocksPerCycle,
	 input   logic                   clockPolarity,
	 input   logic                   clockPhase,
	 input   logic                   dataDirection,
	 input   logic                   ssEnable,
	 
	 input   logic                   transmitValid,
	 input   logic  [DATAWIDTH-1:0]  dataRegIn,
	 output  logic  [DATAWIDTH-1:0]  dataReg,
	 output  logic                   transmitReady,
	 output  logic                   receiveValid,
	 
	 input   logic                   miso,
	 output  logic                   mosi,
	 output  logic                   sclk,
	 output  logic                   ss
	 );

	 
    typedef  enum  logic  [2:0]  {IDLE = 3'b000, START = 3'b001, OUTPUT = 3'b010, SAMPLE = 3'b011, SHIFT = 3'b100, STORE = 3'b101, STOP0 = 3'b110, STOP1 = 3'b111}  states;	

	 
	 states                       state;
	 states                       nextState;
    logic   [15:0]               cycleCounter;
	 logic   [15:0]               cycleCounterValue;
	 logic   [BITCOUNTERWIDTH:0]  bitCounter;
	 logic   [BITCOUNTERWIDTH:0]  bitCounterValue;
	 logic   [DATAWIDTH-1:0]      dataRegNext;
	 logic                        cycleDone;
	 logic                        bitsDone;
	 logic                        mosiReg;
	 logic                        misoReg;
	 logic                        mosiNext;
	 logic                        misoNext;
    logic                        sclkNext;
    logic                        ssNext;
	 
	 
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
		      bitCounter <= 1;
		  else
		      bitCounter <= bitCounterValue;
	 end
	 
	 
	 // data register
	 always_ff @(posedge clk or posedge reset) begin 
	     if(reset)
		      dataReg <= {DATAWIDTH{1'b0}};
		  else
		      dataReg <= dataRegNext;
	 end
	 
	 
	 // spi clock register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      sclk <= 1'b0; // reset to default value for the current mode
		  else
		      sclk <= sclkNext;
	 end
	 
	 
	 // slave select register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      ss <= 1'b1;
		  else
		      ss <= ssNext;
	 end
	 
	 
	 // mosi register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      mosiReg <= 1'b0;
		  else
		      mosiReg <= mosiNext;
	 end
	 
	 
	 // miso register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      misoReg <= 1'b0;
		  else
		      misoReg <= misoNext;
	 end
	 
	 
	 assign mosi = mosiReg;
	 assign cycleDone = (cycleCounter >= clocksPerCycle);
	 assign bitsDone  = (bitCounter   >= DATAWIDTH);

	
	 // combinationial logic
	 always_comb begin
	     // defaults
		  nextState         = IDLE;        // go to idle
	     cycleCounterValue = cycleCounter;// keep old value
	     bitCounterValue   = bitCounter;  // keep old value
		  dataRegNext       = dataReg;     // keep old data
		  sclkNext          = sclk;        // keep old value
		  ssNext            = ss;          // keep old value
		  transmitReady     = 1'b0;        // signal not ready
		  receiveValid      = 1'b0;        // signal not valid
		  mosiNext          = mosiReg;     // keep old data
		  misoNext          = misoReg;     // keep old data
		  
	     case(state)
		      IDLE:    begin // reset counters, and clocks, and assert slave select if we are ready to transmit
								 ssNext                 = (cycleDone && transmitValid && ssEnable) ? 1'b0 : 1'b1; // activate slave if transmit valid is asserted
								 sclkNext               = clockPolarity;                                          // reset clock to default value
                         cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1;            // reset at cycle end, else increment
								 bitCounterValue        = 1;                                                      // reset the bit counter
								 
				             // next state logic
							    nextState = (cycleDone && transmitValid) ? START : IDLE;
				         end
							
				START:   begin// load mosi and data reg, and toggle clock if necessary
                         if(cycleDone) begin
									  transmitReady = 1'b1;                                       // signal ready
									  case(dataDirection)
								         1'b0: mosiNext = dataRegIn[0];                          // load mosi (right shift LSB first)
									      1'b1: mosiNext = dataRegIn[DATAWIDTH-1];                // load mosi (left shift MSB first)
									  endcase
								     dataRegNext        = dataRegIn;                             // load new data
									  sclkNext           = (clockPhase) ? !sclk : sclk;           // toggle the clock if clock phase 1 is set
								 end
                         cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1; // reset at cycle end, else increment
								 
				             // next state logic
							    nextState = (cycleDone) ? SAMPLE : START;
				         end
							
				OUTPUT:  begin // send a new data bit to mosi line
				             if(cycleDone) begin
									  sclkNext           = !sclk;                                 // toggle clock
									  case(dataDirection)
								         1'b0: mosiNext = dataReg[0];                            // load mosi (right shift LSB first)
									      1'b1: mosiNext = dataReg[DATAWIDTH-1];                  // load mosi (left shift MSB first)
									  endcase
								 end
								 cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1; // reset at cycle end, else increment
								 
								 // next state logic
							    nextState = (cycleDone) ? SAMPLE : OUTPUT;
				         end
							
				SAMPLE:  begin // sample data bit from the miso line
				             if(cycleDone) begin
									  sclkNext           = !sclk;                                 // toggle clock
									  misoNext           = miso;                                  // load new data bit
								 end
								 cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1; // reset at cycle end, else increment
								 
								 // next state logic
							    nextState = (cycleDone) ? SHIFT : SAMPLE;
				         end
							
				SHIFT:   begin // shift the sample bit to the data register
                         // output logic
								 cycleCounterValue      = cycleCounter + 16'b1;                  // increment cycle counter
								 bitCounterValue        = bitCounter + 1;                        // increment bit count
								 case(dataDirection)
								     1'b0: dataRegNext  = {misoReg, dataReg[DATAWIDTH-1:1]};     // shift data (right shift LSB first)
									  1'b1: dataRegNext  = {dataReg[DATAWIDTH-2:0], misoReg};     // shift data (left shift MSB first)
								 endcase
								 
								 // next state logic
							    nextState = (bitsDone) ? STORE : OUTPUT;
				         end
							
				STORE:   begin // store the result to the receive register
                         // output logic
								 cycleCounterValue      = cycleCounter + 16'b1;                  // increment cycle counter
								 bitCounterValue        = 1;                                     // reset bit count
								 transmitReady          = 1'b1;                                  // signal transmit ready
								 receiveValid           = 1'b1;                                  // signal receive valid
								 dataRegNext            = (transmitValid) ? dataRegIn : dataReg; // load new data or keep old value
								 
								 // next state logic
						       nextState = (transmitValid) ? OUTPUT : STOP0;
				         end
							
				STOP0:   begin // reset clock to default state
				             // output logic
								 sclkNext               = (cycleDone) ? clockPolarity : sclk;          // reset clock to default value at the end of the cycle
								 cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1; // reset at cycle end, else increment
								 
								 // next state logic
							    nextState = (cycleDone) ? STOP1 : STOP0;
				         end
							
				STOP1:   begin // deassert slave select and return to idle
				             ssNext                 = (cycleDone) ? 1'b1 : ss;
				             cycleCounterValue      = (cycleDone) ?  16'd1 : cycleCounter + 16'd1; // reset at cycle end, else increment
								 
								 // next state logic
							    nextState = (cycleDone) ? IDLE : STOP1;
				         end
							
				//default: 
	     endcase
    end

	 
endmodule

