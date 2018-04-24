

module dataSelect(
    input   logic          ramValid,
	 input   logic          ioValid,
	 input   logic          uartValid,
	 input   logic          randomValid,
	 input   logic          timerValid,
	 input   logic          sdramValid,
	 input   logic          sequencerValid,
	 input   logic          sampleValid,
	 input   logic          dacSpiValid,
	 input   logic          soundValid,
	 input   logic          sdCardSpiValid,
	 input   logic  [31:0]  ramData,
	 input   logic  [31:0]  ioData,
	 input   logic  [31:0]  uartData,
	 input   logic  [31:0]  randomData,
	 input   logic  [31:0]  timerData,
	 input   logic  [31:0]  sdramData,
	 input   logic  [31:0]  sequencerData,
	 input   logic  [31:0]  sampleData,
	 input   logic  [31:0]  dacSpiData,
	 input   logic  [31:0]  soundData,
	 input   logic  [31:0]  sdCardSpiData,
	 
	 output  logic          readValid,
	 output  logic  [31:0]  dataIn
	 );


	 always_comb begin
	     case({sdCardSpiValid, soundValid, dacSpiValid, sampleValid, sequencerValid, sdramValid, timerValid, randomValid, uartValid, ioValid, ramValid})
		      11'b00000000001: dataIn = ramData;
				11'b00000000010: dataIn = ioData;
				11'b00000000100: dataIn = uartData;
				11'b00000001000: dataIn = randomData;
				11'b00000010000: dataIn = timerData;
				11'b00000100000: dataIn = sdramData;
				11'b00001000000: dataIn = sequencerData;
				11'b00010000000: dataIn = sampleData;
				11'b00100000000: dataIn = dacSpiData;
				11'b01000000000: dataIn = soundData;
				11'b10000000000: dataIn = sdCardSpiData;
				default:         dataIn = 32'bx;
		  endcase
		  
		  readValid = ramValid | ioValid | uartValid | randomValid | timerValid | sdramValid | sequencerValid | sampleValid | dacSpiValid | soundValid | sdCardSpiValid;
	 end
	 
	 
endmodule

