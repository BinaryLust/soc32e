

// the base address the device will be mapped to
`define RAM_BASE         32'h00000000
`define UART_BASE        32'h00004010
`define RANDOM_BASE      32'h00005000
`define TIMER_BASE       32'h00005100
//`define SEQUENCER_BASE   32'h02000000
//`define SAMPLE_BASE      32'h02001000
//`define IO_BASE          32'h03000000
//`define DACSPI_BASE      32'h03001000
//`define SOUND_BASE       32'h03002000
`define SDCARDSPI_BASE   32'h03003000
`define I2C_BASE         32'h03004000
//`define OCFLASH_BASE     32'h04000000
`define ETHERNETSMI_BASE 32'h05000000
`define I2SMASTER_BASE   32'h05100000
`define ETHERNETSPI_BASE 32'h05200000
`define PS2KEYBOARD_BASE 32'h06000000
`define PS2MOUSE_BASE    32'h07000000
`define SDRAM_BASE       32'h80000000


// the device address space size in bytes
`define RAM_SIZE         32'h4000
`define UART_SIZE        32'h10
`define RANDOM_SIZE      32'h4
`define TIMER_SIZE       32'h20
//`define SEQUENCER_SIZE   32'h8
//`define SAMPLE_SIZE      32'h0200
//`define IO_SIZE          32'h4
//`define DACSPI_SIZE      32'h20
//`define SOUND_SIZE       32'h10
`define SDCARDSPI_SIZE   32'h20
`define I2C_SIZE         32'h8
//`define OCFLASH_SIZE     32'h10000
`define ETHERNETSMI_SIZE 32'h8
`define I2SMASTER_SIZE   32'h16
`define ETHERNETSPI_SIZE 32'h20
`define PS2KEYBOARD_SIZE 32'h10
`define PS2MOUSE_SIZE    32'h10
`define SDRAM_SIZE       32'h400_0000 // 32'h80_0000


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


    input   logic  [31:0]  sdramData,
    input   logic          sdramValid,
    input   logic          sdramWaitRequest,
    //output  logic          sdramChipEnable,
    output  logic          sdramRead,
    output  logic          sdramWrite,
    output  logic  [23:0]  sdramAddress,


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
    // output  logic  [2:0]   dacSpiAddress,


    // input   logic  [31:0]  soundData,
    // input   logic          soundValid,
    // //input   logic          soundWaitRequest,
    // //output  logic          soundChipEnable,
    // output  logic          soundRead,
    // output  logic          soundWrite,
    // output  logic  [1:0]   soundAddress,


    input   logic  [31:0]  sdCardSpiData,
    input   logic          sdCardSpiValid,
    //input   logic          sdCardSpiWaitRequest,
    //output  logic          sdCardSpiChipEnable,
    output  logic          sdCardSpiRead,
    output  logic          sdCardSpiWrite,
    output  logic  [2:0]   sdCardSpiAddress,


    input   logic  [31:0]  ethernetSpiData,
    input   logic          ethernetSpiValid,
    //input   logic          ethernetSpiWaitRequest,
    //output  logic          ethernetSpiChipEnable,
    output  logic          ethernetSpiRead,
    output  logic          ethernetSpiWrite,
    output  logic  [2:0]   ethernetSpiAddress,


    input   logic  [31:0]  i2cData,
    input   logic          i2cValid,
    //input   logic          i2cWaitRequest,
    //output  logic          i2cChipEnable,
    output  logic          i2cRead,
    output  logic          i2cWrite,
    output  logic          i2cAddress,


    // input   logic  [31:0]  ocFlashData,
    // input   logic          ocFlashValid,
    // input   logic          ocFlashWaitRequest,
    // //output  logic          ocFlashChipEnable,
    // output  logic          ocFlashRead,
    // //output  logic          ocFlashWrite,
    // output  logic  [13:0]  ocFlashAddress,


    input   logic  [31:0]  ethernetSmiData,
    input   logic          ethernetSmiValid,
    //input   logic          ethernetSmiWaitRequest,
    //output  logic          ethernetSmiChipEnable,
    output  logic          ethernetSmiRead,
    output  logic          ethernetSmiWrite,
    output  logic          ethernetSmiAddress,


    input   logic  [31:0]  i2sMasterData,
    input   logic          i2sMasterValid,
    //input   logic          i2sMasterWaitRequest,
    //output  logic          i2sMasterChipEnable,
    output  logic          i2sMasterRead,
    output  logic          i2sMasterWrite,
    output  logic  [1:0]   i2sMasterAddress,


    input   logic  [31:0]  ps2KeyboardData,
    input   logic          ps2KeyboardValid,
    //input   logic          ps2KeyboardWaitRequest,
    //input   logic          ps2KeyboardChipEnable,
    output  logic          ps2KeyboardRead,
    output  logic          ps2KeyboardWrite,
    output  logic  [1:0]   ps2KeyboardAddress,


    input   logic  [31:0]  ps2MouseData,
    input   logic          ps2MouseValid,
    //input   logic          ps2MouseWaitRequest,
    //input   logic          ps2MouseChipEnable,
    output  logic          ps2MouseRead,
    output  logic          ps2MouseWrite,
    output  logic  [1:0]   ps2MouseAddress,


    input   logic          clk,
    input   logic          reset,
    input   logic  [31:0]  address,
    input   logic          read,
    input   logic          write,
    output  logic          waitRequest,
    output  logic          readValid,
    output  logic  [31:0]  dataIn
    );


    // internal wiring
    logic          defaultRead;
    logic          defaultReadReg;
    logic          defaultValid;
    logic  [12:0]  chipEnable;
    logic  [12:0]  readEnable;
    logic  [12:0]  writeEnable;
    logic  [12:0]  validBus;


    // default read valid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            defaultReadReg <= 1'b0;
            defaultValid   <= 1'b0;
        end else begin
            defaultReadReg <= defaultRead;
            defaultValid   <= defaultReadReg;
        end
    end


    // address map logic
    always_comb begin
        // default values
        chipEnable  = 13'b0;
        readEnable  = 13'b0;
        writeEnable = 13'b0;

        // static ram
        if((address >= `RAM_BASE) && (address <= (`RAM_BASE + (`RAM_SIZE - 1)))) begin
            chipEnable[0]  = 1'b1;
            readEnable[0]  = read;  // chipEnable && read;
            writeEnable[0] = write; // chipEnable && write;
        end
        ramRead    = readEnable[0];
        ramWrite   = writeEnable[0];
        ramAddress = address[13:2]; // address[(size+2)>>1:2]; // won't work for 1 address lines

        // random number generator
        if((address >= `RANDOM_BASE) && (address <= (`RANDOM_BASE + (`RANDOM_SIZE - 1)))) begin
            chipEnable[1]  = 1'b1;
            readEnable[1]  = read;  // chipEnable && read;
            writeEnable[1] = write; // chipEnable && write;
        end
        randomRead  = readEnable[1];
        randomWrite = writeEnable[1];

        // timers
        if((address >= `TIMER_BASE) && (address <= (`TIMER_BASE + (`TIMER_SIZE - 1)))) begin
            chipEnable[2]  = 1'b1;
            readEnable[2]  = read;  // chipEnable && read;
            writeEnable[2] = write; // chipEnable && write;
        end
        timerRead    = readEnable[2];
        timerWrite   = writeEnable[2];
        timerAddress = address[4:2];

        // uart
        if((address >= `UART_BASE) && (address <= (`UART_BASE + (`UART_SIZE - 1)))) begin
            chipEnable[3]  = 1'b1;
            readEnable[3]  = read;  // chipEnable && read;
            writeEnable[3] = write; // chipEnable && write;
        end
        uartRead    = readEnable[3];
        uartWrite   = writeEnable[3];
        uartAddress = address[3:2];

        // sdram
        if((address >= `SDRAM_BASE) && (address <= (`SDRAM_BASE + (`SDRAM_SIZE - 1)))) begin
            chipEnable[4]  = 1'b1;
            readEnable[4]  = read;  // chipEnable && read;
            writeEnable[4] = write; // chipEnable && write;
        end
        sdramRead    = readEnable[4];
        sdramWrite   = writeEnable[4];
        sdramAddress = address[25:2];

        // adc sequencer
        // if((address >= `SEQUENCER_BASE) && (address <= (`SEQUENCER_BASE + (`SEQUENCER_SIZE - 1)))) begin
        //     chipEnable[5]  = 1'b1;
        //     readEnable[5]  = read;  // chipEnable && read;
        //     writeEnable[5] = write; // chipEnable && write;
        // end
        // sequencerRead    = readEnable[5];
        // sequencerWrite   = writeEnable[5];
        // sequencerAddress = address[2];

        // adc samples
        // if((address >= `SAMPLE_BASE) && (address <= (`SAMPLE_BASE + (`SAMPLE_SIZE - 1)))) begin
        //     chipEnable[6]  = 1'b1;
        //     readEnable[6]  = read;  // chipEnable && read;
        //     writeEnable[6] = write; // chipEnable && write;
        // end
        // sampleRead    = readEnable[6];
        // sampleWrite   = writeEnable[6];
        // sampleAddress = address[8:2];

        // generic io
        // if((address >= `IO_BASE) && (address <= (`IO_BASE + (`IO_SIZE - 1)))) begin
        //     chipEnable[7]  = 1'b1;
        //     readEnable[7]  = read;  // chipEnable && read;
        //     writeEnable[7] = write; // chipEnable && write;
        // end
        // ioRead  = readEnable[7];
        // ioWrite = writeEnable[7];

        // spi dac
        // if((address >= `DACSPI_BASE) && (address <= (`DACSPI_BASE + (`DACSPI_SIZE - 1)))) begin
        //     chipEnable[8]  = 1'b1;
        //     readEnable[8]  = read;  // chipEnable && read;
        //     writeEnable[8] = write; // chipEnable && write;
        // end
        // dacSpiRead    = readEnable[8];
        // dacSpiWrite   = writeEnable[8];
        // dacSpiAddress = address[4:2];

        // pwm sound
        // if((address >= `SOUND_BASE) && (address <= (`SOUND_BASE + (`SOUND_SIZE - 1)))) begin
        //     chipEnable[9]  = 1'b1;
        //     readEnable[9]  = read;  // chipEnable && read;
        //     writeEnable[9] = write; // chipEnable && write;
        // end
        // soundRead    = readEnable[9];
        // soundWrite   = writeEnable[9];
        // soundAddress = address[3:2];

        // spi for sd card
        if((address >= `SDCARDSPI_BASE) && (address <= (`SDCARDSPI_BASE + (`SDCARDSPI_SIZE - 1)))) begin
            chipEnable[5]  = 1'b1;
            readEnable[5]  = read;  // chipEnable && read;
            writeEnable[5] = write; // chipEnable && write;
        end
        sdCardSpiRead    = readEnable[5];
        sdCardSpiWrite   = writeEnable[5];
        sdCardSpiAddress = address[4:2];

        // spi for ethernet controller
        if((address >= `ETHERNETSPI_BASE) && (address <= (`ETHERNETSPI_BASE + (`ETHERNETSPI_SIZE - 1)))) begin
            chipEnable[6]  = 1'b1;
            readEnable[6]  = read;  // chipEnable && read;
            writeEnable[6] = write; // chipEnable && write;
        end
        ethernetSpiRead    = readEnable[6];
        ethernetSpiWrite   = writeEnable[6];
        ethernetSpiAddress = address[4:2];

        // i2c controller
        if((address >= `I2C_BASE) && (address <= (`I2C_BASE + (`I2C_SIZE - 1)))) begin
            chipEnable[7]  = 1'b1;
            readEnable[7]  = read;  // chipEnable && read;
            writeEnable[7] = write; // chipEnable && write;
        end
        i2cRead    = readEnable[7];
        i2cWrite   = writeEnable[7];
        i2cAddress = address[2];

        // on chip flash
        // if((address >= `OCFLASH_BASE) && (address <= (`OCFLASH_BASE + (`OCFLASH_SIZE - 1)))) begin
        //     chipEnable[8]  = 1'b1;
        //     readEnable[8]  = read;  // chipEnable && read;
        //     writeEnable[8] = write; // chipEnable && write;
        // end
        // ocFlashRead    = readEnable[8];
        // //ocFlashWrite   = writeEnable[8];
        // ocFlashAddress = address[15:2];

        // ethernet smi controller
        if((address >= `ETHERNETSMI_BASE) && (address <= (`ETHERNETSMI_BASE + (`ETHERNETSMI_SIZE - 1)))) begin
            chipEnable[9]  = 1'b1;
            readEnable[9]  = read;  // chipEnable && read;
            writeEnable[9] = write; // chipEnable && write;
        end
        ethernetSmiRead    = readEnable[9];
        ethernetSmiWrite   = writeEnable[9];
        ethernetSmiAddress = address[2];


        // i2s master controller
        if((address >= `I2SMASTER_BASE) && (address <= (`I2SMASTER_BASE + (`I2SMASTER_SIZE - 1)))) begin
            chipEnable[10]  = 1'b1;
            readEnable[10]  = read;  // chipEnable && read;
            writeEnable[10] = write; // chipEnable && write;
        end
        i2sMasterRead    = readEnable[10];
        i2sMasterWrite   = writeEnable[10];
        i2sMasterAddress = address[3:2];


        // ps2 keyboard controller
        if((address >= `PS2KEYBOARD_BASE) && (address <= (`PS2KEYBOARD_BASE + (`PS2KEYBOARD_SIZE - 1)))) begin
            chipEnable[11]  = 1'b1;
            readEnable[11]  = read;  // chipEnable && read;
            writeEnable[11] = write; // chipEnable && write;
        end
        ps2KeyboardRead    = readEnable[11];
        ps2KeyboardWrite   = writeEnable[11];
        ps2KeyboardAddress = address[3:2];


        // ps2 mouse controller
        if((address >= `PS2MOUSE_BASE) && (address <= (`PS2MOUSE_BASE + (`PS2MOUSE_SIZE - 1)))) begin
            chipEnable[12]  = 1'b1;
            readEnable[12]  = read;  // chipEnable && read;
            writeEnable[12] = write; // chipEnable && write;
        end
        ps2MouseRead    = readEnable[12];
        ps2MouseWrite   = writeEnable[12];
        ps2MouseAddress = address[3:2];


        // default signal
        defaultRead = read & ~|chipEnable;
    end


    // data selector
    always_comb begin
        validBus = {ramValid,
                    randomValid,
                    timerValid,
                    uartValid,
                    sdramValid,
                    //sequencerValid,
                    //sampleValid,
                    //ioValid,
                    //dacSpiValid,
                    //soundValid,
                    sdCardSpiValid,
                    ethernetSpiValid,
                    i2cValid,
                    //ocFlashValid,
                    ethernetSmiValid,
                    i2sMasterValid,
                    ps2KeyboardValid,
                    ps2MouseValid};

        case(validBus)
            13'b100000000000: dataIn = ramData;
            13'b010000000000: dataIn = randomData;
            13'b001000000000: dataIn = timerData;
            13'b000100000000: dataIn = uartData;
            13'b000010000000: dataIn = sdramData;
            //12'b000001000000: dataIn = sequencerData;
            //12'b000000100000: dataIn = sampleData;
            //12'b000000010000: dataIn = ioData;
            //12'b000000001000: dataIn = dacSpiData;
            //12'b000000000100: dataIn = soundData;
            13'b000001000000: dataIn = sdCardSpiData;
            13'b000000100000: dataIn = ethernetSpiData;
            13'b000000010000: dataIn = i2cData;
            //13'b0000000010000: dataIn = ocFlashData;
            13'b000000001000: dataIn = ethernetSmiData;
            13'b000000000100: dataIn = i2sMasterData;
            13'b000000000010: dataIn = ps2KeyboardData;
            13'b000000000001: dataIn = ps2MouseData;
            default:          dataIn = 32'b0; // default data return value
        endcase

        readValid = |validBus | defaultValid;
    end


    // wait request logic
    assign waitRequest = sdramWaitRequest;// | ocFlashWaitRequest;


endmodule

