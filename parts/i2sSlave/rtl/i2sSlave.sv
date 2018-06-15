
// we need a bit to select stereo/mono
// we need a bit to select playback and a bit to select record
// we could do both at the same time if they are both active
// we need a bit to select 8-bit/16-bit
// mono will be done by just sending the same data to the left and right channel for audio output
// and capturing only one channel on audio input (probably the left channel in both cases)
// maybe have a bit to select which channel to store for audio input

// in 8 bit mode add 8 bits per sample, in 16 bit mode add 16 bits per sample
// if the bit counter reaches 32 grab new data from the buffer and reset the bit counter
// idle state would also fetch new data and reset the bit counter


// memory map
// 2'd0: {bufferData}                                 // data register   // write only
// 2'd1: {22'd0, full, wordCount}                     // status register // read only
// 2'd2: {sampleSize, stereoMode, playback, soundIre} // config register // read/write


module i2sSlave(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [1:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,

    output  logic          soundIrq,

    input   logic          wclk,
    input   logic          bclk,
    input   logic          sdin,
    output  logic          sdout
    );


    // control lines/registers
    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic  [1:0]   addressReg;
    logic  [31:0]  readMux;


    // write enable lines
    logic          bufferLoadEn;
    logic          configLoadEn;


    // read data lines
    logic  [8:0]   wordCount;
    logic          full;
    logic          sampleSize;
    logic          stereoMode;
    logic          playback;
    logic          soundIre;


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
        bufferLoadEn = 1'b0;
        configLoadEn = 1'b0;

        if(writeReg) begin
            case(addressReg)
                2'd0: bufferLoadEn = 1'b1;
                2'd2: configLoadEn = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            2'd1:    readMux = {22'd0, full, wordCount};
            2'd2:    readMux = {28'd0, sampleSize, stereoMode, playback, soundIre};
            default: readMux = 32'b0;
        endcase
    end


    i2sSlaveCore
    i2sSlaveCore(
        .clk,
        .reset,
        .bufferDataIn    (dataInReg),     // data from the master interface
        .sampleSizeIn    (dataInReg[3]),  // data from the master interface
        .stereoModeIn    (dataInReg[2]),  // data from the master interface
        .playbackIn      (dataInReg[1]),  // data from the master interface
        .soundIreIn      (dataInReg[0]),  // data from the master interface
        .bufferLoadEn,                    // write enable from the master interface
        .configLoadEn,                    // write enable from the master interface
        .wordCount,        // visible state to the master interface
        .full,             // visible state to the master interface
        .sampleSize,       // visible state to the master interface
        .stereoMode,       // visible state to the master interface
        .playback,         // visible state to the master interface
        .soundIre,         // visible state to the master interface
        .soundIrq,
        .wclk,
        .bclk,
        .sdin,
        .sdout
    );


endmodule

