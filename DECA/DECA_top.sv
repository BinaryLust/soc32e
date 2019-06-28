// Deca Pmod Adapter Board Pinouts

// sdram pinouts
// dq0,  GPIO0_D[35], W11
// dq1,  GPIO0_D[34], W12
// dq2,  GPIO0_D[33], W13
// dq3,  GPIO0_D[32], Y11
// dq4,  GPIO0_D[31], Y13
// dq5,  GPIO0_D[30], AB10
// dq6,  GPIO0_D[29], AA11
// dq7,  GPIO0_D[28], AB11
// dqml, GPIO0_D[27], AA12
// we,   GPIO0_D[26], AB12
// cas,  GPIO0_D[25], AA13
// ras,  GPIO0_D[24], AB13
// cs,   GPIO0_D[23], AA14
// ba0,  GPIO0_D[22], AB14
// ba1,  GPIO0_D[21], AA15
// a10,  GPIO0_D[20], Y14
// a0,   GPIO0_D[19], W15
// a1,   GPIO0_D[18], AB15
// a2,   GPIO0_D[17], W16
// a3,   GPIO0_D[16], AB16
// -----------------------
// dq15, GPIO1_D[22], W3
// dq14, GPIO1_D[20], P9
// dq13, GPIO1_D[18], R9
// dq12, GPIO1_D[19], W4
// dq11, GPIO1_D[16], W9
// dq10, GPIO1_D[17], W5
// dq9,  GPIO1_D[14], V10
// dq8,  GPIO1_D[15], U7
// dqmh, GPIO1_D[12], AA6
// clk,  GPIO1_D[21], V17
// cke,  GPIO1_D[13], Y7
// a12,  GPIO1_D[10], AB6
// a11,  GPIO1_D[11], AA7
// a9,   GPIO1_D[8],  R11
// a8,   GPIO1_D[9],  AB7
// a7,   GPIO1_D[6],  AB8
// a6,   GPIO1_D[7],  V7
// a5,   GPIO1_D[4],  W8
// a4,   GPIO1_D[5],  V8

// pmod J3 pinouts
// 1,    GPIO0_D[0],  W18
// 2,    GPIO0_D[2],  Y19
// 3,    GPIO0_D[4],  AA20
// 4,    GPIO0_D[6],  AB21
// 5,    gnd
// 6,    3v3
// 7,    GPIO0_D[1],  Y18
// 8,    GPIO0_D[3],  AA17
// 9,    GPIO0_D[5],  AA19
// 10,   GPIO0_D[7],  AB20
// 11,   gnd
// 12,   3v3

// pmod J4 pinouts
// 1,    GPIO0_D[8],  AB19
// 2,    GPIO0_D[10], V16
// 3,    GPIO0_D[12], V15
// 4,    GPIO0_D[14], AB17
// 5,    gnd
// 6,    3v3
// 7,    GPIO0_D[9],  Y16
// 8,    GPIO0_D[11], AB18
// 9,    GPIO0_D[13], W17
// 10,   GPIO0_D[15], AA16
// 11,   gnd
// 12,   3v3

// pmod J5 pinouts
// 1,    GPIO0_D[36], V12
// 2,    GPIO0_D[38], V13
// 3,    GPIO0_D[40], Y17
// 4,    GPIO0_D[42], U15
// 5,    gnd
// 6,    3v3
// 7,    GPIO0_D[37], V11
// 8,    GPIO0_D[39], V14
// 9,    GPIO0_D[41], W14
// 10,   GPIO0_D[43], R13
// 11,   gnd
// 12,   3v3

// pmod J6 pinouts
// 1,    GPIO1_D[0],  Y5
// 2,    GPIO1_D[1],  Y6
// 3,    GPIO1_D[2],  W6
// 4,    GPIO1_D[3],  W7
// 5,    gnd
// 6,    3v3
// 7,    SYS_RESET_n, AA2
// 8,    nc
// 9,    nc
// 10,   nc
// 11,   gnd
// 12,   3v3


module DECA_top(

    //////////// CLOCK //////////
    input  logic           ADC_CLK_10,
    input  logic           MAX10_CLK1_50,
    input  logic           MAX10_CLK2_50,

    //////////// KEY //////////
    input  logic  [1:0]    KEY,

    //////////// LED //////////
    // output  logic  [7:0]   LED,

    //////////// CapSense Button //////////
    inout   wire           CAP_SENSE_I2C_SCL,
    inout   wire           CAP_SENSE_I2C_SDA,

    //////////// Audio //////////
    output  logic          AUDIO_BCLK,          // changed from inout wire to output logic
    output  logic          AUDIO_DIN_MFP1,
    input   logic          AUDIO_DOUT_MFP2,
    // inout   wire           AUDIO_GPIO_MFP5,
    output  logic          AUDIO_MCLK,
    // input   logic          AUDIO_MISO_MFP4,
    output  logic          AUDIO_RESET_n,       // changed from inout wire to output logic
    inout   wire           AUDIO_SCL_SS_n,      // changed from output logic to inout wire
    // output  logic          AUDIO_SCLK_MFP3,
    inout   wire           AUDIO_SDA_MOSI,
    output  logic          AUDIO_SPI_SELECT,
    output  logic          AUDIO_WCLK,          // changed from inout wire to output logic
    
    //////////// SDRAM //////////
    // output  logic  [14:0]  DDR3_A,
    // output  logic  [2:0]   DDR3_BA,
    // output  logic          DDR3_CAS_n,
    // inout   wire           DDR3_CK_n,
    // inout   wire           DDR3_CK_p,
    // output  logic          DDR3_CKE,
    // input   logic          DDR3_CLK_50,
    // output  logic          DDR3_CS_n,
    // output  logic  [1:0]   DDR3_DM,
    // inout   wire   [15:0]  DDR3_DQ,
    // inout   wire   [1:0]   DDR3_DQS_n,
    // inout   wire   [1:0]   DDR3_DQS_p,
    // output  logic          DDR3_ODT,
    // output  logic          DDR3_RAS_n,
    // output  logic          DDR3_RESET_n,
    // output  logic          DDR3_WE_n,

    //////////// Flash //////////
    // inout   wire   [3:0]   FLASH_DATA,
    // output  logic          FLASH_DCLK,
    // output  logic          FLASH_NCSO,
    // output  logic          FLASH_RESET_n,

    //////////// G-Sensor //////////
    // output  logic          G_SENSOR_CS_n,
    // input   logic          G_SENSOR_INT1,
    // input   logic          G_SENSOR_INT2,
    // inout   wire           G_SENSOR_SCLK,
    // inout   wire           G_SENSOR_SDI,
    // inout   wire           G_SENSOR_SDO,

    //////////// HDMI-TX //////////
    inout   wire           HDMI_I2C_SCL,
    inout   wire           HDMI_I2C_SDA,
    // inout   wire   [3:0]   HDMI_I2S,
    // inout   wire           HDMI_LRCLK,
    // inout   wire           HDMI_MCLK,
    // inout   wire           HDMI_SCLK,
    // output  logic          HDMI_TX_CLK,
    // output  logic  23:0]   HDMI_TX_D,
    // output  logic          HDMI_TX_DE,
    // output  logic          HDMI_TX_HS,
    // input   logic          HDMI_TX_INT,
    // output  logic          HDMI_TX_VS,

    //////////// Light Sensor //////////
    inout   wire           LIGHT_I2C_SCL,    // changed from output logic to inout wire
    inout   wire           LIGHT_I2C_SDA,
    // inout   wire           LIGHT_INT,

    //////////// MIPI //////////
    // output  logic          MIPI_CORE_EN,
    // inout   wire           MIPI_I2C_SCL,     // changed from output logic to inout wire
    // inout   wire           MIPI_I2C_SDA,
    // input   logic          MIPI_LP_MC_n,
    // input   logic          MIPI_LP_MC_p,
    // input   logic  [3:0]   MIPI_LP_MD_n,
    // input   logic  [3:0]   MIPI_LP_MD_p,
    // input   logic          MIPI_MC_p,
    // output  logic          MIPI_MCLK,
    // input   logic  [3:0]   MIPI_MD_p,
    // output  logic          MIPI_RESET_n,
    // output  logic          MIPI_WP,

    //////////// Ethernet //////////
    // input   logic          NET_COL,
    // input   logic          NET_CRS,
    output  logic          NET_MDC,
    inout   wire           NET_MDIO,
    output  logic          NET_PCF_EN, // if high respond to phy control frames
    output  logic          NET_RESET_n,
    // input   logic          NET_RX_CLK,
    // input   logic          NET_RX_DV,
    // input   logic          NET_RX_ER,
    // input   logic  [3:0]   NET_RXD,
    // input   logic          NET_TX_CLK,
    // output  logic          NET_TX_EN,
    // output  logic  [3:0]   NET_TXD,

    //////////// Power Monitor //////////
    // input   logic          PMONITOR_ALERT,
    inout   wire           PMONITOR_I2C_SCL, // changed from output logic to inout wire
    inout   wire           PMONITOR_I2C_SDA,

    //////////// Humidity and Temperature Sensor //////////
    // input   logic          RH_TEMP_DRDY_n,
    // inout   wire           RH_TEMP_I2C_SCL,  // changed from output logic to inout wire
    // inout   wire           RH_TEMP_I2C_SDA,

    //////////// MicroSD Card //////////
    // output  logic          SD_CLK,
    // inout   wire           SD_CMD,
    // output  logic          SD_CMD_DIR,
    // output  logic          SD_D0_DIR,
    // inout   wire           SD_D123_DIR,
    // inout   wire   [3:0]   SD_DAT,
    // input   logic          SD_FB_CLK,
    // output  logic          SD_SEL,

    //////////// SW //////////
    // input   logic  [1:0]   SW,

    //////////// Board Temperature Sensor //////////
    // output  logic          TEMP_CS_n,
    // output  logic          TEMP_SC,
    // inout   wire           TEMP_SIO,

    //////////// USB //////////
    // input   logic          USB_CLKIN,
    // output  logic          USB_CS,
    // inout   wire   [7:0]   USB_DATA,
    // input   logic          USB_DIR,
    // input   logic          USB_FAULT_n,
    // input   logic          USB_NXT,
    // output  logic          USB_RESET_n,
    // output  logic          USB_STP


    //-----------------------------------------------------------------------------------------
    // gpio custom pins -----------------------------------------------------------------------
    input   logic          rx,
    output  logic          tx,
    input   logic          sdCardMiso,
    output  logic          sdCardMosi,
    output  logic          sdCardSclk,
    output  logic          sdCardSs,
    input   logic          ethernetIrq,
    input   logic          ethernetMiso,
    output  logic          ethernetMosi,
    output  logic          ethernetSclk,
    output  logic          ethernetSs,

    output  logic          mclk,
    output  logic          bclk,
    output  logic          wclk,
    output  logic          sdout,

    output  logic  [12:0]  externalSdramAddress,
    output  logic  [1:0]   externalSdramBa,
    output  logic          externalSdramCas,
    output  logic          externalSdramCke,
    output  logic          externalSdramClk,
    output  logic          externalSdramCs,
    inout   wire   [15:0]  externalSdramDq,
    output  logic  [1:0]   externalSdramDqm,
    output  logic          externalSdramRas,
    output  logic          externalSdramWe
    );


    // dummy signals for unconnected spi outputs
    logic  [2:0]  nc1;
    logic  [2:0]  nc2;


    //assign G_SENSOR_CS_n     = 1'b1; // set high for i2c mode, set low for spi mode
    //assign G_SENSOR_SDO      = 1'b0;  // i2c lsb of address


    assign NET_PCF_EN       = 1'b0;
    assign NET_RESET_n      = 1'b1;


    assign AUDIO_RESET_n    = 1'b1;
    assign AUDIO_SPI_SELECT = 1'b0; // select i2c mode


    assign mclk             = AUDIO_MCLK;
    assign bclk             = AUDIO_BCLK;
    assign wclk             = AUDIO_WCLK;
    assign sdout            = AUDIO_DIN_MFP1;


    // the humidity/tempature sensor and the power meter can't both be connected
    // at the same time because they share the same i2c address
    DECA_soc #(.LINES(5))
    DECA_soc(
        .clk                   (MAX10_CLK1_50),
        .reset                 (~KEY[0]),
        .rx,
        .tx,
        .sdCardMiso,
        .sdCardMosi,
        .sdCardSclk,
        .sdCardSs              ({nc1, sdCardSs}),
        .ethernetIrq,
        .ethernetMiso,
        .ethernetMosi,
        .ethernetSclk,
        .ethernetSs            ({nc2, ethernetSs}),
        .scl                   ({AUDIO_SCL_SS_n, CAP_SENSE_I2C_SCL, HDMI_I2C_SCL, LIGHT_I2C_SCL, PMONITOR_I2C_SCL}),
        .sda                   ({AUDIO_SDA_MOSI, CAP_SENSE_I2C_SDA, HDMI_I2C_SDA, LIGHT_I2C_SDA, PMONITOR_I2C_SDA}),
        .mdc                   (NET_MDC),
        .mdio                  (NET_MDIO),
        .mclk                  (AUDIO_MCLK),
        .wclk                  (AUDIO_WCLK),
        .bclk                  (AUDIO_BCLK),
        .sdin                  (AUDIO_DOUT_MFP2),
        .sdout                 (AUDIO_DIN_MFP1),
        .externalSdramAddress,
        .externalSdramBa,
        .externalSdramCas,
        .externalSdramCke,
        .externalSdramClk,
        .externalSdramCs,
        .externalSdramDq,
        .externalSdramDqm,
        .externalSdramRas,
        .externalSdramWe
    );


endmodule

