

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
    input   logic          i2cValid,
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
    input   logic  [31:0]  i2cData,

    output  logic          readValid,
    output  logic  [31:0]  dataIn
    );


    always_comb begin
        case({i2cValid, sdCardSpiValid, soundValid, dacSpiValid, sampleValid, sequencerValid, sdramValid, timerValid, randomValid, uartValid, ioValid, ramValid})
            12'b000000000001: dataIn = ramData;
            12'b000000000010: dataIn = ioData;
            12'b000000000100: dataIn = uartData;
            12'b000000001000: dataIn = randomData;
            12'b000000010000: dataIn = timerData;
            12'b000000100000: dataIn = sdramData;
            12'b000001000000: dataIn = sequencerData;
            12'b000010000000: dataIn = sampleData;
            12'b000100000000: dataIn = dacSpiData;
            12'b001000000000: dataIn = soundData;
            12'b010000000000: dataIn = sdCardSpiData;
            12'b100000000000: dataIn = i2cData;
            default:          dataIn = 32'bx;
        endcase

        readValid = ramValid | ioValid | uartValid | randomValid | timerValid | sdramValid | sequencerValid | sampleValid | dacSpiValid | soundValid | sdCardSpiValid | i2cValid;
    end


endmodule

