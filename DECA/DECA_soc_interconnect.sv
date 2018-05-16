

// the base address the device will be mapped to
`define RAM_BASE       32'h00000000
`define UART_BASE      32'h00004010
`define RANDOM_BASE    32'h00005000
`define TIMER_BASE     32'h00005100
//`define SDRAM_BASE     32'h01000000
//`define SEQUENCER_BASE 32'h02000000
//`define SAMPLE_BASE    32'h02001000
//`define IO_BASE        32'h03000000
//`define DACSPI_BASE    32'h03001000
//`define SOUND_BASE     32'h03002000
//`define SDCARDSPI_BASE 32'h03003000
`define I2C_BASE       32'h03004000


// the device address space size in bytes
`define RAM_SIZE       32'h4000
`define UART_SIZE      32'h10
`define RANDOM_SIZE    32'h4
`define TIMER_SIZE     32'h20
//`define SDRAM_SIZE     32'h800000
//`define SEQUENCER_SIZE 32'h8
//`define SAMPLE_SIZE    32'h0200
//`define IO_SIZE        32'h4
//`define DACSPI_SIZE    32'h10
//`define SOUND_SIZE     32'h10
//`define SDCARDSPI_SIZE 32'h10
`define I2C_SIZE       32'h8


module DECA_soc_interconnect(
    input   logic  [31:0]  ramData,
    input   logic          ramValid,
    //input   logic          ramWaitRequest,
    //output  logic          ramChipEnable,
    output  logic          ramRead,
    output  logic          ramWrite,
    output  logic  [11:0]  ramAddress,


    input   logic  [31:0]  randomData,
    input   logic          randomValid,
    //input   logic          randomWaitRequest,
    //output  logic          randomChipEnable,
    output  logic          randomRead,
    output  logic          randomWrite,
    //output  logic          randomAddress,


    input   logic  [31:0]  timerData,
    input   logic          timerValid,
    //input   logic          timerWaitRequest,
    //output  logic          timerChipEnable,
    output  logic          timerRead,
    output  logic          timerWrite,
    output  logic  [2:0]   timerAddress,


    input   logic  [31:0]  uartData,
    input   logic          uartValid,
    //input   logic          uartWaitRequest,
    //output  logic          uartChipEnable,
    output  logic          uartRead,
    output  logic          uartWrite,
    output  logic  [1:0]   uartAddress,


    // input   logic  [31:0]  sdramData,
    // input   logic          sdramValid,
    // input   logic          sdramWaitRequest,
    // //output  logic          sdramChipEnable,
    // output  logic          sdramRead,
    // output  logic          sdramWrite,
    // output  logic  [20:0]  sdramAddress,


    // input   logic  [31:0]  sequencerData,
    // input   logic          sequencerValid,
    // //input   logic          sequencerWaitRequest,
    // //output  logic          sequencerChipEnable,
    // output  logic          sequencerRead,
    // output  logic          sequencerWrite,
    // output  logic          sequencerAddress,


    // input   logic  [31:0]  sampleData,
    // input   logic          sampleValid,
    // //input   logic          sampleWaitRequest,
    // //output  logic          sampleChipEnable,
    // output  logic          sampleRead,
    // output  logic          sampleWrite,
    // output  logic  [6:0]   sampleAddress,


    // input   logic  [31:0]  ioData,
    // input   logic          ioValid,
    // //input   logic          ioWaitRequest,
    // //output  logic          ioChipEnable,
    // output  logic          ioRead,
    // output  logic          ioWrite,
    // //output  logic          ioAddress,


    // input   logic  [31:0]  dacSpiData,
    // input   logic          dacSpiValid,
    // //input   logic          dacSpiWaitRequest,
    // //output  logic          dacSpiChipEnable,
    // output  logic          dacSpiRead,
    // output  logic          dacSpiWrite,
    // output  logic  [1:0]   dacSpiAddress,


    // input   logic  [31:0]  soundData,
    // input   logic          soundValid,
    // //input   logic          soundWaitRequest,
    // //output  logic          soundChipEnable,
    // output  logic          soundRead,
    // output  logic          soundWrite,
    // output  logic  [1:0]   soundAddress,


    // input   logic  [31:0]  sdCardSpiData,
    // input   logic          sdCardSpiValid,
    // //input   logic          sdCardSpiWaitRequest,
    // //output  logic          sdCardSpiChipEnable,
    // output  logic          sdCardSpiRead,
    // output  logic          sdCardSpiWrite,
    // output  logic  [1:0]   sdCardSpiAddress,


    input   logic  [31:0]  i2cData,
    input   logic          i2cValid,
    //input   logic          i2cWaitRequest,
    //output  logic          i2cChipEnable,
    output  logic          i2cRead,
    output  logic          i2cWrite,
    output  logic          i2cAddress,


    input   logic  [31:0]  address,
    input   logic          read,
    input   logic          write,
    output  logic          waitRequest,
    output  logic          readValid,
    output  logic  [31:0]  dataIn
    );


    //logic  [11:0]  validBus;
    logic  [5:0]  validBus;


    always_comb begin
        // static ram
        if((address >= `RAM_BASE) && (address <= (`RAM_BASE + (`RAM_SIZE - 1)))) begin
            ramRead   = read;
            ramWrite  = write;
        end else begin
            ramRead   = 1'b0;
            ramWrite  = 1'b0;
        end
        ramAddress    = address[13:2]; // address[(size+2)>>1:2]; // won't work for 1 address lines

        // random number generator
        if((address >= `RANDOM_BASE) && (address <= (`RANDOM_BASE + (`RANDOM_SIZE - 1)))) begin
            randomRead  = read;
            randomWrite = write;
        end else begin
            randomRead  = 1'b0;
            randomWrite = 1'b0;
        end

        // timers
        if((address >= `TIMER_BASE) && (address <= (`TIMER_BASE + (`TIMER_SIZE - 1)))) begin
            timerRead  = read;
            timerWrite = write;
        end else begin
            timerRead  = 1'b0;
            timerWrite = 1'b0;
        end
        timerAddress   = address[4:2];

        // uart
        if((address >= `UART_BASE) && (address <= (`UART_BASE + (`UART_SIZE - 1)))) begin
            uartRead  = read;
            uartWrite = write;
        end else begin
            uartRead  = 1'b0;
            uartWrite = 1'b0;
        end
        uartAddress   = address[3:2];

        // sdram
        // if((address >= `SDRAM_BASE) && (address <= (`SDRAM_BASE + (`SDRAM_SIZE - 1)))) begin
        //     waitRequest = sdramWaitRequest;
        //     sdramRead   = read;
        //     sdramWrite  = write;
        // end else begin
        //     waitRequest = 1'b0;
        //     sdramRead   = 1'b0;
        //     sdramWrite  = 1'b0;
        // end
        // sdramAddress    = address[22:2];
        waitRequest = 1'b0; // set this if if you disable sdram

        // adc sequencer
        // if((address >= `SEQUENCER_BASE) && (address <= (`SEQUENCER_BASE + (`SEQUENCER_SIZE - 1)))) begin
        //     sequencerRead  = read;
        //     sequencerWrite = write;
        // end else begin
        //     sequencerRead  = 1'b0;
        //     sequencerWrite = 1'b0;
        // end
        // sequencerAddress   = address[2];

        // adc samples
        // if((address >= `SAMPLE_BASE) && (address <= (`SAMPLE_BASE + (`SAMPLE_SIZE - 1)))) begin
        //     sampleRead  = read;
        //     sampleWrite = write;
        // end else begin
        //     sampleRead  = 1'b0;
        //     sampleWrite = 1'b0;
        // end
        // sampleAddress   = address[8:2];

        // generic io
        // if((address >= `IO_BASE) && (address <= (`IO_BASE + (`IO_SIZE - 1)))) begin
        //     ioRead    = read;
        //     ioWrite   = write;
        // end else begin
        //     ioRead    = 1'b0;
        //     ioWrite   = 1'b0;
        // end

        // spi dac
        // if((address >= `DACSPI_BASE) && (address <= (`DACSPI_BASE + (`DACSPI_SIZE - 1)))) begin
        //     dacSpiRead  = read;
        //     dacSpiWrite = write;
        // end else begin
        //     dacSpiRead  = 1'b0;
        //     dacSpiWrite = 1'b0;
        // end
        // dacSpiAddress   = address[3:2];

        // pwm sound
        // if((address >= `SOUND_BASE) && (address <= (`SOUND_BASE + (`SOUND_SIZE - 1)))) begin
        //     soundRead  = read;
        //     soundWrite = write;
        // end else begin
        //     soundRead  = 1'b0;
        //     soundWrite = 1'b0;
        // end
        // soundAddress   = address[3:2];

        // spi for sd card
        // if((address >= `SDCARDSPI_BASE) && (address <= (`SDCARDSPI_BASE + (`SDCARDSPI_SIZE - 1)))) begin
        //     sdCardSpiRead  = read;
        //     sdCardSpiWrite = write;
        // end else begin
        //     sdCardSpiRead  = 1'b0;
        //     sdCardSpiWrite = 1'b0;
        // end
        // sdCardSpiAddress   = address[3:2];

        // i2c controller
        if((address >= `I2C_BASE) && (address <= (`I2C_BASE + (`I2C_SIZE - 1)))) begin
            i2cRead  = read;
            i2cWrite = write;
        end else begin
            i2cRead  = 1'b0;
            i2cWrite = 1'b0;
        end
        i2cAddress   = address[2];
    end


    always_comb begin
        validBus = {ramValid,
                    randomValid,
                    timerValid,
                    uartValid,
                    //sdramValid,
                    //sequencerValid,
                    //sampleValid,
                    //ioValid,
                    //dacSpiValid,
                    //soundValid,
                    //sdCardSpiValid,
                    i2cValid};

        case(validBus)
            5'b10000: dataIn = ramData;
            5'b01000: dataIn = randomData;
            5'b00100: dataIn = timerData;
            5'b00010: dataIn = uartData;
            //12'b000010000000: dataIn = sdramData;
            //12'b000001000000: dataIn = sequencerData;
            //12'b000000100000: dataIn = sampleData;
            //12'b000000010000: dataIn = ioData;
            //12'b000000001000: dataIn = dacSpiData;
            //12'b000000000100: dataIn = soundData;
            //12'b000010: dataIn = sdCardSpiData;
            5'b00001: dataIn = i2cData;
            default:  dataIn = 32'b0;
        endcase

        readValid = |validBus;
    end


endmodule

