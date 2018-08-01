
//=======================================================
//  This code is generated by Terasic System Builder
//=======================================================

module DECA_top(

    //////////// CLOCK //////////
    input   logic          ADC_CLK_10,
    input   logic          MAX10_CLK1_50,
    input   logic          MAX10_CLK2_50,

    //////////// KEY //////////
    input   logic  [1:0]   KEY,

    //////////// LED //////////
    // output  logic  [7:0]   LED,

    //////////// CapSense Button //////////
    //inout   wire           CAP_SENSE_I2C_SCL,
    //inout   wire           CAP_SENSE_I2C_SDA,

    //////////// Audio //////////
    output  logic          AUDIO_BCLK,
    output  logic          AUDIO_DIN_MFP1,
    input   logic          AUDIO_DOUT_MFP2,
    // inout   logic          AUDIO_GPIO_MFP5,
    output  logic          AUDIO_MCLK,
    // input   logic          AUDIO_MISO_MFP4,
    output  logic          AUDIO_RESET_n,
    // output  logic          AUDIO_SCLK_MFP3,
    output  logic          AUDIO_SPI_SELECT,
    output  logic          AUDIO_WCLK,

    //////////// SDRAM //////////
    // output  logic  [14:0]  DDR3_A,
    // output  logic   [2:0]  DDR3_BA,
    // output  logic          DDR3_CAS_n,
    // inout   logic          DDR3_CK_n,
    // inout   logic          DDR3_CK_p,
    // output  logic          DDR3_CKE,
    // input   logic          DDR3_CLK_50,
    // output  logic          DDR3_CS_n,
    // output  logic   [1:0]  DDR3_DM,
    // inout   logic  [15:0]  DDR3_DQ,
    // inout   logic   [1:0]  DDR3_DQS_n,
    // inout   logic   [1:0]  DDR3_DQS_p,
    // output  logic          DDR3_ODT,
    // output  logic          DDR3_RAS_n,
    // output  logic          DDR3_RESET_n,
    // output  logic          DDR3_WE_n,

    //////////// Flash //////////
    // inout   logic   [3:0]  FLASH_DATA,
    // output  logic          FLASH_DCLK,
    // output  logic          FLASH_NCSO,
    // output  logic          FLASH_RESET_n,

    //////////// G-Sensor //////////
    ////output  logic          G_SENSOR_CS_n, // set high for i2c mode, set low for spi mode
    // input   logic          G_SENSOR_INT1,
    // input   logic          G_SENSOR_INT2,
    //inout   logic          G_SENSOR_SCLK, // i2c scl
    //inout   logic          G_SENSOR_SDI,  // i2c sda
    ////inout   logic          G_SENSOR_SDO,  // i2c lsb of address

    //////////// HDMI-TX //////////
    // inout   logic          HDMI_I2C_SCL,
    // inout   logic          HDMI_I2C_SDA,
    // inout   logic   [3:0]  HDMI_I2S,
    // inout   logic          HDMI_LRCLK,
    // inout   logic          HDMI_MCLK,
    // inout   logic          HDMI_SCLK,
    // output  logic          HDMI_TX_CLK,
    // output  logic  [23:0]  HDMI_TX_D,
    // output  logic          HDMI_TX_DE,
    // output  logic          HDMI_TX_HS,
    // input   logic          HDMI_TX_INT,
    // output  logic          HDMI_TX_VS,

    //////////// Light Sensor //////////
    //inout   wire           LIGHT_I2C_SCL,
    //inout   wire           LIGHT_I2C_SDA,
    // inout   logic          LIGHT_INT,

    //////////// MIPI //////////
    // output  logic          MIPI_CORE_EN,
    // output  logic          MIPI_I2C_SCL,
    // inout   logic          MIPI_I2C_SDA,
    // input   logic          MIPI_LP_MC_n,
    // input   logic          MIPI_LP_MC_p,
    // input   logic   [3:0]  MIPI_LP_MD_n,
    // input   logic   [3:0]  MIPI_LP_MD_p,
    // input   logic          MIPI_MC_p,
    // output  logic          MIPI_MCLK,
    // input   logic   [3:0]  MIPI_MD_p,
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
    // input   logic   [3:0]  NET_RXD,
    // input   logic          NET_TX_CLK,
    // output  logic          NET_TX_EN,
    // output  logic   [3:0]  NET_TXD,

    // //////////// Power Monitor //////////
    // input   logic          PMONITOR_ALERT,
    //inout   wire           PMONITOR_I2C_SCL,
    //inout   wire           PMONITOR_I2C_SDA,

    //////////// Humidity and Temperature Sensor //////////
    // input   logic          RH_TEMP_DRDY_n,
    //inout   wire           RH_TEMP_I2C_SCL,
    //inout   wire           RH_TEMP_I2C_SDA,

    //////////// MicroSD Card //////////
    // output  logic          SD_CLK,
    // inout   logic          SD_CMD,
    // output  logic          SD_CMD_DIR,
    // output  logic          SD_D0_DIR,
    // inout   logic          SD_D123_DIR,
    // inout   logic   [3:0]  SD_DAT,
    // input   logic          SD_FB_CLK,
    // output  logic          SD_SEL,

    //////////// SW //////////
    // input   logic   [1:0]  SW,

    //////////// Board Temperature Sensor //////////
    // output  logic          TEMP_CS_n,
    // output  logic          TEMP_SC,
    // inout   logic          TEMP_SIO,

    //////////// USB //////////
    // input   logic          USB_CLKIN,
    // output  logic          USB_CS,
    // inout   logic   [7:0]  USB_DATA,
    // input   logic          USB_DIR,
    // input   logic          USB_FAULT_n,
    // input   logic          USB_NXT,
    // output  logic          USB_RESET_n,
    // output  logic          USB_STP,

    //////////// BBB Conector //////////
    // input   logic          BBB_PWR_BUT,
    // input   logic          BBB_SYS_RESET_n,
    //inout   wire   [43:0]  GPIO0_D
    //inout   logic  [22:0]  GPIO1_D

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

    inout   wire   [4:0]   scl,
    inout   wire   [4:0]   sda,//,
    //output  logic          mdc,
    //inout   wire           mdio

    output  logic          mclk,
    output  logic          bclk,
    output  logic          wclk,
    output  logic          sdout
    );


    logic  [3:0]  ss1;
    logic  [3:0]  ss2;


    // the humidity/tempature sensor and the power meter can't both be connected
    // at the same time because they share the same i2c address


    //assign G_SENSOR_CS_n     = 1'b1; // set high for i2c mode, set low for spi mode
    //assign G_SENSOR_SDO      = 1'b0;  // i2c lsb of address


    //assign NET_MDC,
    //assign NET_MDIO,
    assign NET_PCF_EN = 1'b0;
    assign NET_RESET_n = 1'b1;


    assign AUDIO_RESET_n    = 1'b1;
    assign AUDIO_SPI_SELECT = 1'b0; // select i2c mode


    assign mclk  = AUDIO_MCLK;
    assign bclk  = AUDIO_BCLK;
    assign wclk  = AUDIO_WCLK;
    assign sdout = AUDIO_DIN_MFP1;


    assign sdCardSs   = ss1[0];
    assign ethernetSs = ss2[0];


    DECA_soc #(.LINES(5))
    DECA_soc(
        .clk           (MAX10_CLK1_50),
        .reset         (~KEY[0]),
        .rx,
        .tx,
        .sdCardMiso,
        .sdCardMosi,
        .sdCardSclk,
        .sdCardSs      (ss1),
        .ethernetIrq,
        .ethernetMiso,
        .ethernetMosi,
        .ethernetSclk,
        .ethernetSs    (ss2),
        .scl,
        .sda,
        .mdc           (NET_MDC),
        .mdio          (NET_MDIO),
        .mclk          (AUDIO_MCLK),
        .wclk          (AUDIO_WCLK),
        .bclk          (AUDIO_BCLK),
        .sdin          (AUDIO_DOUT_MFP2),
        .sdout         (AUDIO_DIN_MFP1)
    );


endmodule

