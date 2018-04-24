

module soc32e(
    input   logic          clk,
	 input   logic          reset,
	 
	 output  logic  [7:0]   ioOut,
	 
	 input   logic          rx,
	 output  logic          tx,
	 
	 input   logic          dacMiso,
	 output  logic          dacMosi,
	 output  logic          dacSclk,
	 output  logic          dacSs,
	 
	 input   logic          sdCardMiso,
	 output  logic          sdCardMosi,
	 output  logic          sdCardSclk,
	 output  logic          sdCardSs,
	 
	 output  logic          pwmOut,
	 
	 output  logic  [11:0]  externalSdramAddress,
    output  logic  [1:0]   externalSdramBa,
    output  logic          externalSdramCas,
    output  logic          externalSdramCke,
	 output  logic          externalSdramClk,
    output  logic          externalSdramCs,
    inout   wire   [15:0]  externalSdramDq,
    output  logic  [1:0]   externalSdramDqm,
    output  logic          externalSdramRas,
    output  logic          externalSdramWe,
	 
	 output  logic          horizontalSync,
	 output  logic          verticalSync,
	 output  logic  [2:0]   red,
	 output  logic  [2:0]   green,
	 output  logic  [1:0]   blue
	 );


	 // pll wires
	 logic          pllLocked;
	 
	 
	 // clock lines
	 logic          clk100;
	 logic          clk10;
	 logic          clk25;
	 
	 
	 // reset lines
	 logic          reset100;
	 logic          reset25;
	 
	 
	 // cpu wires
	 logic          waitRequest;
	 logic          readValid;
	 logic          interruptRequest;
	 logic  [3:0]   interruptIn;
	 logic  [31:0]  dataIn;
	 logic          interruptAcknowledge;
	 logic  [3:0]   interruptOut;
	 logic          read;
	 logic          write;
	 logic  [3:0]   bwe;
	 logic  [31:0]  dataOut;
	 logic  [31:0]  address;

	 
	 // slave module wires
	 logic          ramChipEnable;
	 logic          ramRead;
	 logic          ramWrite;
	 logic  [11:0]  ramAddress;
	 logic          ramValid;
	 logic  [31:0]  ramData;
	 
	 logic          randomChipEnable;
	 logic          randomRead;
	 logic          randomWrite;
	 logic          randomValid;
	 logic  [31:0]  randomData;
	 
	 logic          timerChipEnable;
	 logic          timerRead;
	 logic          timerWrite;
	 logic  [2:0]   timerAddress;
	 logic          timerValid;
	 logic  [31:0]  timerData;
	 
	 logic          uartChipEnable;
	 logic          uartRead;
	 logic          uartWrite;
	 logic  [1:0]   uartAddress;
	 logic          uartValid;
	 logic  [31:0]  uartData;
	 
	 logic          sdramWaitRequest;
	 logic          sdramChipEnable;
	 logic          sdramRead;
	 logic          sdramWrite;
	 logic  [20:0]  sdramAddress;
	 logic          sdramValid;
	 logic  [31:0]  sdramData;
	 
	 logic          sequencerChipEnable;
	 logic          sequencerRead;
	 logic          sequencerWrite;
	 logic          sequencerAddress;
	 logic          sequencerValid;
	 logic  [31:0]  sequencerData;
	 
	 logic          sampleChipEnable;
	 logic          sampleRead;
	 logic          sampleWrite;
	 logic  [6:0]   sampleAddress;
	 logic          sampleValid;
    logic  [31:0]  sampleData;
	 
	 logic          ioChipEnable;
	 logic          ioRead;
	 logic          ioWrite;
	 logic          ioValid;
	 logic  [31:0]  ioData;

	 logic          dacSpiChipEnable;
	 logic          dacSpiRead;
	 logic          dacSpiWrite;
	 logic  [1:0]   dacSpiAddress;
	 logic          dacSpiValid;
	 logic  [31:0]  dacSpiData;
	 
	 logic          soundChipEnable;
	 logic          soundRead;
	 logic          soundWrite;
	 logic  [1:0]   soundAddress;
	 logic          soundValid;
	 logic  [31:0]  soundData;
	 
	 logic          sdCardSpiChipEnable;
	 logic          sdCardSpiRead;
	 logic          sdCardSpiWrite;
	 logic  [1:0]   sdCardSpiAddress;
	 logic          sdCardSpiValid;
	 logic  [31:0]  sdCardSpiData;
	 
	 
	 // interrupt wires
	 logic  [15:0]  triggerInterrupt;
	 logic          rxIrq;
	 logic          txIrq;
	 logic  [2:0]   timerIrq;
	 logic          dacSpiReceiveIrq;
	 logic          dacSpiTransmitIrq;
	 logic          soundIrq;
	 logic          sdCardSpiReceiveIrq;
	 logic          sdCardSpiTransmitIrq;
	 
	 
	 // interrupt mapping
	 assign triggerInterrupt[0]  = timerIrq[0];          // interrupt 0  // timer 1
	 assign triggerInterrupt[1]  = timerIrq[1];          // interrupt 1  // timer 2
	 assign triggerInterrupt[2]  = timerIrq[2];          // interrupt 2  // timer 3
	 assign triggerInterrupt[3]  = rxIrq;                // interrupt 3  // uart receive
	 assign triggerInterrupt[4]  = txIrq;                // interrupt 4  // uart transmit
	 assign triggerInterrupt[5]  = dacSpiReceiveIrq;     // interrupt 5  // unused
	 assign triggerInterrupt[6]  = dacSpiTransmitIrq;    // interrupt 6  // unused
	 assign triggerInterrupt[7]  = soundIrq;             // interrupt 7  // unused
	 assign triggerInterrupt[8]  = sdCardSpiReceiveIrq;  // interrupt 8  // unused
	 assign triggerInterrupt[9]  = sdCardSpiTransmitIrq; // interrupt 9  // unused
	 assign triggerInterrupt[10] = 1'b0;                 // interrupt 10 // unused
	 assign triggerInterrupt[11] = 1'b0;                 // interrupt 11 // unused
	 assign triggerInterrupt[12] = 1'b0;                 // interrupt 12 // unused
	 assign triggerInterrupt[13] = 1'b0;                 // interrupt 13 // unused
	 assign triggerInterrupt[14] = 1'b0;                 // interrupt 14 // unused
	 assign triggerInterrupt[15] = 1'b0;                 // interrupt 15 // unused
	 
	 
	 
	 
    pll
	 pll(
	     .areset                 (1'b0),      //(reset),
	     .inclk0                 (clk),
	     .c0                     (clk100),
		  .c1                     (externalSdramClk),
		  .c2                     (clk25),
	     .locked                 ()
	 );
	
	
	 pll2
	 pll2(
	     .areset                 (1'b0),      //(reset),
	     .inclk0                 (clk),
	     .c0                     (clk10),
	     .locked                 (pllLocked)
	 );
	
	
	 resetCore
	 resetCore(
        .reset,
		  .clk,
        .clk100,
		  .clk25,
        .reset100,
		  .reset25
	 );

	
	 addressMap
	 addressMap(
	     .address,
		  .read,
		  .write,
		  .waitRequest,
	     .ramChipEnable,
	     .ramRead,
	     .ramWrite,
	     .ramAddress,
	     .randomChipEnable,
		  .randomRead,
		  .randomWrite,
		  .timerChipEnable,
		  .timerRead,
		  .timerWrite,
		  .timerAddress,
		  .uartChipEnable,
		  .uartRead,
		  .uartWrite,
		  .uartAddress,
		  .sdramWaitRequest,
		  .sdramChipEnable,
		  .sdramRead,
		  .sdramWrite,
		  .sdramAddress,
	     .sequencerChipEnable,
		  .sequencerRead,
		  .sequencerWrite,
	     .sequencerAddress,
	     .sampleChipEnable,
		  .sampleRead,
		  .sampleWrite,
	     .sampleAddress,
	     .ioChipEnable,
	     .ioRead,
	     .ioWrite,
	     .dacSpiChipEnable,
	     .dacSpiRead,
	     .dacSpiWrite,
	     .dacSpiAddress,
	     .soundChipEnable,
	     .soundRead,
	     .soundWrite,
	     .soundAddress,
	     .sdCardSpiChipEnable,
	     .sdCardSpiRead,
	     .sdCardSpiWrite,
	     .sdCardSpiAddress
	 );

	 
	 interruptController
	 interruptController(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .triggerInterrupt,
	     .interruptIn            (interruptOut),
	     .interruptAcknowledge,
	     .interruptOut           (interruptIn),
	     .interruptRequest
	 );
	 
	 
    cpu32e2
	 cpu32e2(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .waitRequest,
	     .readValid,
	     .interruptRequest,
	     .interruptIn,
	     .dataIn,
	
	     //`ifdef  DEBUG
	     //.debugOut,
	     //`endif
	
	     .interruptAcknowledge,
	     .interruptOut,
	     .read,
	     .write,
	     .bwe,
	     .dataOut,
	     .address
	 );
	 
	 
	 ram
	 ram(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (ramRead),
	     .write                  (ramWrite),
	     .bwe,
        .address                (ramAddress),
	     .dataIn                 (dataOut),
	     .readValid              (ramValid),
	     .dataOut                (ramData)
	 );


	 io
	 io(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (ioRead),
	     .write                  (ioWrite),
	     .dataIn                 (dataOut),
	     .readValid              (ioValid),
	     .dataOut                (ioData),
	     .ioOut
	 );
	 
	 
	 /*uart
	 uart(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (uartRead),
	     .write                  (uartWrite),
        .address                (uartAddress),
	     .dataIn                 (dataOut),
	     .readValid              (uartValid),
	     .dataOut                (uartData),
	     .txIrq,
        .rxIrq,
	     .rx,
	     .tx
	 );*/
	 
	 
	 uart2
	 uart2(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (uartRead),
	     .write                  (uartWrite),
        .address                (uartAddress),
	     .dataIn                 (dataOut),
	     .readValid              (uartValid),
	     .dataOut                (uartData),
	     .txIrq,
        .rxIrq,
	     .rx,
	     .tx
	 );
	 
	 
	 random
	 random(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (randomRead),
	     .write                  (randomWrite),
	     .dataIn                 (dataOut),
	     .readValid              (randomValid),
	     .dataOut                (randomData)
	 );
	 
	 
	 timer
	 timer(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (timerRead),
	     .write                  (timerWrite),
	     .address                (timerAddress),
	     .dataIn                 (dataOut),
	     .readValid              (timerValid),
	     .dataOut                (timerData),
	     .irq                    (timerIrq)
	 );
	
	
	 sdram
	 sdram(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .chipEnable             (sdramChipEnable),
	     .read                   (sdramRead),
	     .write                  (sdramWrite),
	     .bwe,
        .address                (sdramAddress),
	     .dataIn                 (dataOut),
	     .waitRequest            (sdramWaitRequest),
	     .readValid              (sdramValid),
	     .dataOut                (sdramData),
	     .externalSdramAddress,
        .externalSdramBa,
        .externalSdramCas,
        .externalSdramCke,
        .externalSdramCs,
        .externalSdramDq,
        .externalSdramDqm,
        .externalSdramRas,
        .externalSdramWe
	 );
	 
	
	 adc
	 adc(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .adcClk                 (clk10),
	     .adcClkLocked           (pllLocked),
	     .adcDataIn              (dataOut),
	     .sequencerAddress,
	     .sequencerRead,
	     .sequencerWrite,
	     .sequencerDataOut       (sequencerData),
	     .sequencerValid,
	     .sampleAddress,
	     .sampleRead,
	     .sampleWrite,
	     .sampleDataOut          (sampleData),
	     .sampleValid,
	     .sampleIrq              ()
	 );
	 
	 
	 spi  #(.DATAWIDTH(8))
	 dacSpi(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (dacSpiRead),
	     .write                  (dacSpiWrite),
        .address                (dacSpiAddress),
	     .dataIn                 (dataOut),
	     .readValid              (dacSpiValid),
	     .dataOut                (dacSpiData),
	     .transmitIrq            (dacSpiTransmitIrq),
	     .receiveIrq             (dacSpiReceiveIrq),
	     .miso                   (dacMiso),
	     .mosi                   (dacMosi),
	     .sclk                   (dacSclk),
		  .ss                     (dacSs)
	 );
	 
	 
	 sound
	 sound(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (soundRead),
	     .write                  (soundWrite),
        .address                (soundAddress),
	     .dataIn                 (dataOut),
	     .readValid              (soundValid),
	     .dataOut                (soundData),
	     .soundIrq,
	     .pwmOut
	 );
	
	
	 vgaCore
	 vgaCore(
        .coreClk                (clk100),
	     .videoClk               (clk25),
	     .coreReset              (reset100),
	     .videoReset             (reset25),
        .horizontalSync,
	     .verticalSync,
	     .red,
	     .green,
	     .blue
	 );
	 
	 
	 spiWithFifos #(.DATAWIDTH(8), .TRANSMITDEPTH(1024), .RECEIVEDEPTH(1024))
	 sdCardSpi(
        .clk                    (clk100),
	     .reset                  (reset100),
	     .read                   (sdCardSpiRead),
	     .write                  (sdCardSpiWrite),
        .address                (sdCardSpiAddress),
	     .dataIn                 (dataOut),
	     .readValid              (sdCardSpiValid),
	     .dataOut                (sdCardSpiData),
	     .transmitIrq            (sdCardSpiTransmitIrq),
	     .receiveIrq             (sdCardSpiReceiveIrq),
	     .miso                   (sdCardMiso),
	     .mosi                   (sdCardMosi),
	     .sclk                   (sdCardSclk),
		  .ss                     (sdCardSs)
	 );
	 
	
    dataSelect
	 dataSelect(
        .ramValid,
	     .ioValid,
		  .uartValid,
		  .randomValid,
		  .timerValid,
		  .sdramValid,
		  .sequencerValid,
		  .sampleValid,
		  .dacSpiValid,
		  .soundValid,
		  .sdCardSpiValid,
	     .ramData,
	     .ioData,
		  .uartData,
		  .randomData,
		  .timerData,
		  .sdramData,
		  .sequencerData,
		  .sampleData,
		  .dacSpiData,
		  .soundData,
		  .sdCardSpiData,
	     .readValid,
	     .dataIn
	 );
	 
	 
endmodule

