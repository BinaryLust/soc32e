

module DECA_soc
    #(parameter LINES = 1)(
    input   logic               clk,
    input   logic               reset,

    // output  logic  [7:0]   ioOut,

    input   logic               rx,
    output  logic               tx,

    // input   logic          dacMiso,
    // output  logic          dacMosi,
    // output  logic          dacSclk,
    // output  logic          dacSs,

    input   logic               sdCardMiso,
    output  logic               sdCardMosi,
    output  logic               sdCardSclk,
    output  logic  [3:0]        sdCardSs,

    inout   wire   [LINES-1:0]  scl,
    inout   wire   [LINES-1:0]  sda,

    output  logic               mdc,
    inout   wire                mdio,

    output  logic               mclk,
    output  logic               wclk,
    output  logic               bclk,
    input   logic               sdin,
    output  logic               sdout

    // output  logic          pwmOut,

    // output  logic  [11:0]  externalSdramAddress,
    // output  logic  [1:0]   externalSdramBa,
    // output  logic          externalSdramCas,
    // output  logic          externalSdramCke,
    // output  logic          externalSdramClk,
    // output  logic          externalSdramCs,
    // inout   wire   [15:0]  externalSdramDq,
    // output  logic  [1:0]   externalSdramDqm,
    // output  logic          externalSdramRas,
    // output  logic          externalSdramWe,

    // output  logic          horizontalSync,
    // output  logic          verticalSync,
    // output  logic  [2:0]   red,
    // output  logic  [2:0]   green,
    // output  logic  [1:0]   blue
    );


    // pll wires
    //logic          pllLocked;


    // clock lines
    logic          clk100;
    logic          clk10;
    logic          clk25;
    logic          clk16;
    logic          clk295;


    // reset lines
    logic          reset100;
    logic          reset25;
    logic          reset295;


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
    //logic          ramChipEnable;
    logic          ramRead;
    logic          ramWrite;
    logic  [11:0]  ramAddress;
    logic          ramValid;
    logic  [31:0]  ramData;

    //logic          randomChipEnable;
    logic          randomRead;
    logic          randomWrite;
    logic          randomValid;
    logic  [31:0]  randomData;

    //logic          timerChipEnable;
    logic          timerRead;
    logic          timerWrite;
    logic  [2:0]   timerAddress;
    logic          timerValid;
    logic  [31:0]  timerData;

    //logic          uartChipEnable;
    logic          uartRead;
    logic          uartWrite;
    logic  [1:0]   uartAddress;
    logic          uartValid;
    logic  [31:0]  uartData;

    // logic          sdramWaitRequest;
    // //logic          sdramChipEnable;
    // logic          sdramRead;
    // logic          sdramWrite;
    // logic  [20:0]  sdramAddress;
    // logic          sdramValid;
    // logic  [31:0]  sdramData;

    // //logic          sequencerChipEnable;
    // logic          sequencerRead;
    // logic          sequencerWrite;
    // logic          sequencerAddress;
    // logic          sequencerValid;
    // logic  [31:0]  sequencerData;

    // //logic          sampleChipEnable;
    // logic          sampleRead;
    // logic          sampleWrite;
    // logic  [6:0]   sampleAddress;
    // logic          sampleValid;
    // logic  [31:0]  sampleData;

    // //logic          ioChipEnable;
    // logic          ioRead;
    // logic          ioWrite;
    // logic          ioValid;
    // logic  [31:0]  ioData;

    // //logic          dacSpiChipEnable;
    // logic          dacSpiRead;
    // logic          dacSpiWrite;
    // logic  [2:0]   dacSpiAddress;
    // logic          dacSpiValid;
    // logic  [31:0]  dacSpiData;

    // //logic          soundChipEnable;
    // logic          soundRead;
    // logic          soundWrite;
    // logic  [1:0]   soundAddress;
    // logic          soundValid;
    // logic  [31:0]  soundData;

    //logic          sdCardSpiChipEnable;
    logic          sdCardSpiRead;
    logic          sdCardSpiWrite;
    logic  [2:0]   sdCardSpiAddress;
    logic          sdCardSpiValid;
    logic  [31:0]  sdCardSpiData;

    //logic          i2cChipEnable;
    logic          i2cRead;
    logic          i2cWrite;
    logic          i2cAddress;
    logic          i2cValid;
    logic  [31:0]  i2cData;

    logic          ocFlashWaitRequest;
    //logic          ocFlashChipEnable;
    logic          ocFlashRead;
    //logic          ocFlashWrite;
    logic  [13:0]  ocFlashAddress;
    logic          ocFlashValid;
    logic  [31:0]  ocFlashData;

    //logic          ethernetSmiChipEnable;
    logic          ethernetSmiRead;
    logic          ethernetSmiWrite;
    logic          ethernetSmiAddress;
    logic          ethernetSmiValid;
    logic  [31:0]  ethernetSmiData;

    //logic          i2sMasterChipEnable;
    logic          i2sMasterRead;
    logic          i2sMasterWrite;
    logic  [1:0]   i2sMasterAddress;
    logic          i2sMasterValid;
    logic  [31:0]  i2sMasterData;

    // interrupt wires
    logic  [15:0]  triggerInterrupt;
    logic          rxIrq;
    logic          txIrq;
    logic  [2:0]   timerIrq;
    logic          i2sMasterIrq;
    // logic          dacSpiReceiveIrq;
    // logic          dacSpiTransmitIrq;
    // logic          soundIrq;
    logic          sdCardSpiReceiveIrq;
    logic          sdCardSpiTransmitIrq;


    // interrupt mapping
    assign triggerInterrupt[0]  = timerIrq[0];          // interrupt 0  // timer 1
    assign triggerInterrupt[1]  = timerIrq[1];          // interrupt 1  // timer 2
    assign triggerInterrupt[2]  = timerIrq[2];          // interrupt 2  // timer 3
    assign triggerInterrupt[3]  = rxIrq;                // interrupt 3  // uart receive
    assign triggerInterrupt[4]  = txIrq;                // interrupt 4  // uart transmit
    assign triggerInterrupt[5]  = 1'b0; //dacSpiReceiveIrq;     // interrupt 5  // unused
    assign triggerInterrupt[6]  = 1'b0; //dacSpiTransmitIrq;    // interrupt 6  // unused
    assign triggerInterrupt[7]  = i2sMasterIrq; //soundIrq;     // interrupt 7  // unused
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
        .c1                     (),//(externalSdramClk),
        .c2                     (clk25),
        .c3                     (clk16),
        .locked                 ()
    );


    pll2
    pll2(
        .areset                 (1'b0),      //(reset),
        .inclk0                 (clk),
        .c0                     (clk10),
        .c1                     (clk295),
        .locked                 ()//(pllLocked)
    );


    resetCore
    resetCore(
        .reset,
        .clk,
        .clk100,
        .clk25,
        .clk295,
        .reset100,
        .reset25,
        .reset295
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


    // io
    // io(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .read                   (ioRead),
    //     .write                  (ioWrite),
    //     .dataIn                 (dataOut),
    //     .readValid              (ioValid),
    //     .dataOut                (ioData),
    //     .ioOut
    // );


    // /*uart
    // uart(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .read                   (uartRead),
    //     .write                  (uartWrite),
    //     .address                (uartAddress),
    //     .dataIn                 (dataOut),
    //     .readValid              (uartValid),
    //     .dataOut                (uartData),
    //     .txIrq,
    //     .rxIrq,
    //     .rx,
    //     .tx
    // );*/


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


    // sdram
    // sdram(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .chipEnable             (1'b1),
    //     .read                   (sdramRead),
    //     .write                  (sdramWrite),
    //     .bwe,
    //     .address                (sdramAddress),
    //     .dataIn                 (dataOut),
    //     .waitRequest            (sdramWaitRequest),
    //     .readValid              (sdramValid),
    //     .dataOut                (sdramData),
    //     .externalSdramAddress,
    //     .externalSdramBa,
    //     .externalSdramCas,
    //     .externalSdramCke,
    //     .externalSdramCs,
    //     .externalSdramDq,
    //     .externalSdramDqm,
    //     .externalSdramRas,
    //     .externalSdramWe
    // );


    // adc
    // adc(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .adcClk                 (clk10),
    //     .adcClkLocked           (pllLocked),
    //     .adcDataIn              (dataOut),
    //     .sequencerAddress,
    //     .sequencerRead,
    //     .sequencerWrite,
    //     .sequencerDataOut       (sequencerData),
    //     .sequencerValid,
    //     .sampleAddress,
    //     .sampleRead,
    //     .sampleWrite,
    //     .sampleDataOut          (sampleData),
    //     .sampleValid,
    //     .sampleIrq              ()
    // );


    // spi  #(.DATAWIDTH(8))
    // dacSpi(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .read                   (dacSpiRead),
    //     .write                  (dacSpiWrite),
    //     .address                (dacSpiAddress),
    //     .dataIn                 (dataOut),
    //     .readValid              (dacSpiValid),
    //     .dataOut                (dacSpiData),
    //     .transmitIrq            (dacSpiTransmitIrq),
    //     .receiveIrq             (dacSpiReceiveIrq),
    //     .miso                   (dacMiso),
    //     .mosi                   (dacMosi),
    //     .sclk                   (dacSclk),
    //     .ss                     (dacSs)
    // );


    // sound
    // sound(
    //     .clk                    (clk100),
    //     .reset                  (reset100),
    //     .read                   (soundRead),
    //     .write                  (soundWrite),
    //     .address                (soundAddress),
    //     .dataIn                 (dataOut),
    //     .readValid              (soundValid),
    //     .dataOut                (soundData),
    //     .soundIrq,
    //     .pwmOut
    // );


    // vgaCore
    // vgaCore(
    //     .coreClk                (clk100),
    //     .videoClk               (clk25),
    //     .coreReset              (reset100),
    //     .videoReset             (reset25),
    //     .horizontalSync,
    //     .verticalSync,
    //     .red,
    //     .green,
    //     .blue
    // );


    spi #(.DATAWIDTH(8), .BUFFERDEPTH(1024))
    sdCardSpi(
        .clk                    (clk100),
        .reset                  (reset100),
        .read                   (sdCardSpiRead),
        .write                  (sdCardSpiWrite),
        .address                (sdCardSpiAddress),
        .dataIn                 (dataOut),
        .readValid              (sdCardSpiValid),
        .dataOut                (sdCardSpiData),
        .txIrq                  (sdCardSpiTransmitIrq),
        .rxIrq                  (sdCardSpiReceiveIrq),
        .miso                   (sdCardMiso),
        .mosi                   (sdCardMosi),
        .sclk                   (sdCardSclk),
        .ss                     (sdCardSs)
    );


    i2c #(.LINES(LINES))
    i2c(
       .clk                     (clk100),
       .reset                   (reset100),
       .read                    (i2cRead),
       .write                   (i2cWrite),
       .address                 (i2cAddress),
       .dataIn                  (dataOut),
       .readValid               (i2cValid),
       .dataOut                 (i2cData),
       .scl,
       .sda
    );


    ocflash
    ocflash(
		.clock                   (clk100),
		.avmm_data_addr          (ocFlashAddress),
		.avmm_data_read          (ocFlashRead),
		.avmm_data_readdata      (ocFlashData),
		.avmm_data_waitrequest   (ocFlashWaitRequest),
		.avmm_data_readdatavalid (ocFlashValid),
		.avmm_data_burstcount    (4'd1),
		.reset_n                 (~reset100)
	);


    ethernetSmi
    ethernetSmi(
        .clk                     (clk100),
        .reset                   (reset100),
        .read                    (ethernetSmiRead),
        .write                   (ethernetSmiWrite),
        .address                 (ethernetSmiAddress),
        .dataIn                  (dataOut),
        .readValid               (ethernetSmiValid),
        .dataOut                 (ethernetSmiData),
        .mdc,
        .mdio
    );


    i2sMaster
    i2sMaster(
        .clk                     (clk100),
        .reset                   (reset100),
        .synthClk                (clk295),
        .synthReset              (reset295),
        .read                    (i2sMasterRead),
        .write                   (i2sMasterWrite),
        .address                 (i2sMasterAddress),
        .dataIn                  (dataOut),
        .readValid               (i2sMasterValid),
        .dataOut                 (i2sMasterData),
        .soundIrq                (i2sMasterIrq),
        .mclk,
        .wclk,
        .bclk,
        .sdin,
        .sdout
    );


    DECA_soc_interconnect
    DECA_soc_interconnect(
        .ramData,
        .ramValid,
        .ramRead,
        .ramWrite,
        .ramAddress,
        .randomData,
        .randomValid,
        .randomRead,
        .randomWrite,
        .timerData,
        .timerValid,
        .timerRead,
        .timerWrite,
        .timerAddress,
        .uartData,
        .uartValid,
        .uartRead,
        .uartWrite,
        .uartAddress,
        // .sdramData,
        // .sdramValid,
        // .sdramWaitRequest,
        // .sdramRead,
        // .sdramWrite,
        // .sdramAddress,
        // .sequencerData,
        // .sequencerValid,
        // .sequencerRead,
        // .sequencerWrite,
        // .sequencerAddress,
        // .sampleData,
        // .sampleValid,
        // .sampleRead,
        // .sampleWrite,
        // .sampleAddress,
        // .ioData,
        // .ioValid,
        // .ioRead,
        // .ioWrite,
        // .dacSpiData,
        // .dacSpiValid,
        // .dacSpiRead,
        // .dacSpiWrite,
        // .dacSpiAddress,
        // .soundData,
        // .soundValid,
        // .soundRead,
        // .soundWrite,
        // .soundAddress,
        .sdCardSpiData,
        .sdCardSpiValid,
        .sdCardSpiRead,
        .sdCardSpiWrite,
        .sdCardSpiAddress,
        .i2cData,
        .i2cValid,
        .i2cRead,
        .i2cWrite,
        .i2cAddress,
        .ocFlashData,
        .ocFlashValid,
        .ocFlashWaitRequest,
        .ocFlashRead,
        .ocFlashAddress,
        .ethernetSmiData,
        .ethernetSmiValid,
        .ethernetSmiRead,
        .ethernetSmiWrite,
        .ethernetSmiAddress,
        .i2sMasterData,
        .i2sMasterValid,
        .i2sMasterRead,
        .i2sMasterWrite,
        .i2sMasterAddress,
        .clk                     (clk100),
        .reset                   (reset100),
        .address,
        .read,
        .write,
        .waitRequest,
        .readValid,
        .dataIn
    );


endmodule

