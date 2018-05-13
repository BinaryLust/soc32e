

module addressMap(
    input   logic  [31:0]  address,
    input   logic          read,
    input   logic          write,
    output  logic          waitRequest,

    //input   logic          ramWaitRequest,
    output  logic          ramChipEnable,
    output  logic          ramRead,
    output  logic          ramWrite,
    output  logic  [11:0]  ramAddress,

    //input   logic          randomWaitRequest,
    output  logic          randomChipEnable,
    output  logic          randomRead,
    output  logic          randomWrite,
    //output  logic          randomAddress,

    //input   logic          timerWaitRequest,
    output  logic          timerChipEnable,
    output  logic          timerRead,
    output  logic          timerWrite,
    output  logic  [2:0]   timerAddress,

    //input   logic          uartWaitRequest,
    output  logic          uartChipEnable,
    output  logic          uartRead,
    output  logic          uartWrite,
    output  logic  [1:0]   uartAddress,

    input   logic          sdramWaitRequest,
    output  logic          sdramChipEnable,
    output  logic          sdramRead,
    output  logic          sdramWrite,
    output  logic  [20:0]  sdramAddress,

    //input   logic          sequencerWaitRequest,
    output  logic          sequencerChipEnable,
    output  logic          sequencerRead,
    output  logic          sequencerWrite,
    output  logic          sequencerAddress,

    //input   logic          sampleWaitRequest,
    output  logic          sampleChipEnable,
    output  logic          sampleRead,
    output  logic          sampleWrite,
    output  logic  [6:0]   sampleAddress,

    //input   logic          ioWaitRequest,
    output  logic          ioChipEnable,
    output  logic          ioRead,
    output  logic          ioWrite,
    //output  logic          ioAddress

    //input   logic          dacSpiWaitRequest,
    output  logic          dacSpiChipEnable,
    output  logic          dacSpiRead,
    output  logic          dacSpiWrite,
    output  logic  [1:0]   dacSpiAddress,

    //input   logic          soundWaitRequest,
    output  logic          soundChipEnable,
    output  logic          soundRead,
    output  logic          soundWrite,
    output  logic  [1:0]   soundAddress,

    //input   logic          sdCardSpiWaitRequest,
    output  logic          sdCardSpiChipEnable,
    output  logic          sdCardSpiRead,
    output  logic          sdCardSpiWrite,
    output  logic  [1:0]   sdCardSpiAddress,

    //input   logic          i2cWaitRequest,
    output  logic          i2cChipEnable,
    output  logic          i2cRead,
    output  logic          i2cWrite,
    output  logic          i2cAddress
    );


    // wait request logic
    assign waitRequest = (sdramWaitRequest && sdramChipEnable);


    // chip enables
    always_comb begin
        // default
        ramChipEnable       = 1'b0;
        uartChipEnable      = 1'b0;
        randomChipEnable    = 1'b0;
        timerChipEnable     = 1'b0;
        sdramChipEnable     = 1'b0;
        sequencerChipEnable = 1'b0;
        sampleChipEnable    = 1'b0;
        ioChipEnable        = 1'b0;
        dacSpiChipEnable    = 1'b0;
        soundChipEnable     = 1'b0;
        sdCardSpiChipEnable = 1'b0;
        i2cChipEnable       = 1'b0;


        if((address >= 32'h00000000) && (address <= 32'h00003FFF)) ramChipEnable       = 1'b1;
        if((address >= 32'h00004010) && (address <= 32'h0000401F)) uartChipEnable      = 1'b1;
        if((address >= 32'h00005000) && (address <= 32'h00005003)) randomChipEnable    = 1'b1;
        if((address >= 32'h00005100) && (address <= 32'h0000511F)) timerChipEnable     = 1'b1;
        if((address >= 32'h01000000) && (address <= 32'h017FFFFF)) sdramChipEnable     = 1'b1;
        if((address >= 32'h02000000) && (address <= 32'h02000007)) sequencerChipEnable = 1'b1;
        if((address >= 32'h02001000) && (address <= 32'h020011FF)) sampleChipEnable    = 1'b1;
        if((address >= 32'h03000000) && (address <= 32'h03000003)) ioChipEnable        = 1'b1;
        if((address >= 32'h03001000) && (address <= 32'h0300100F)) dacSpiChipEnable    = 1'b1;
        if((address >= 32'h03002000) && (address <= 32'h0300200F)) soundChipEnable     = 1'b1;
        if((address >= 32'h03003000) && (address <= 32'h0300300F)) sdCardSpiChipEnable = 1'b1;
        if((address >= 32'h03004000) && (address <= 32'h03004007)) i2cChipEnable       = 1'b1;
    end


    // read/write signal activation
    always_comb begin
        ramRead        = ramChipEnable       && read;
        ramWrite       = ramChipEnable       && write;
        randomRead     = randomChipEnable    && read;
        randomWrite    = randomChipEnable    && write;
        timerRead      = timerChipEnable     && read;
        timerWrite     = timerChipEnable     && write;
        uartRead       = uartChipEnable      && read;
        uartWrite      = uartChipEnable      && write;
        sdramRead      = sdramChipEnable     && read;
        sdramWrite     = sdramChipEnable     && write;
        sequencerRead  = sequencerChipEnable && read;
        sequencerWrite = sequencerChipEnable && write;
        sampleRead     = sampleChipEnable    && read;
        sampleWrite    = sampleChipEnable    && write;
        ioRead         = ioChipEnable        && read;
        ioWrite        = ioChipEnable        && write;
        dacSpiRead     = dacSpiChipEnable    && read;
        dacSpiWrite    = dacSpiChipEnable    && write;
        soundRead      = soundChipEnable     && read;
        soundWrite     = soundChipEnable     && write;
        sdCardSpiRead  = sdCardSpiChipEnable && read;
        sdCardSpiWrite = sdCardSpiChipEnable && write;
        i2cRead        = i2cChipEnable       && read;
        i2cWrite       = i2cChipEnable       && write;
    end


    // address bit mapping
    always_comb begin
        ramAddress       = address[13:2];
        uartAddress      = address[3:2];
        timerAddress     = address[4:2];
        sdramAddress     = address[22:2];
        sequencerAddress = address[2];
        sampleAddress    = address[8:2];
        dacSpiAddress    = address[3:2];
        soundAddress     = address[3:2];
        sdCardSpiAddress = address[3:2];
        i2cAddress       = address[2];
    end


endmodule

