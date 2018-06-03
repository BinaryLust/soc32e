/* This is a Verilog template for use with the BeMicro MAX 10 development kit */
/* It is used for showing the IO pin names and directions                     */
/* Ver 0.2 10.07.2014                                                         */

/* NOTE: A VHDL version of this template is also provided with this design    */
/* example for users that prefer VHDL. This BeMicro_MAX10_top.v file would    */
/* need to be removed from the project and replaced with the                  */
/* BeMicro_MAX10_top.vhd file to switch to the VHDL template.                 */

/* The signals below are documented in the "BeMicro MAX 10 Getting Started    */
/* User Guide."  Please refer to that document for additional signal details. */

`define ENABLE_CLOCK_INPUTS
`define ENABLE_DAC_SPI_INTERFACE
`define ENABLE_TEMP_SENSOR
//`define ENABLE_ACCELEROMETER
`define ENABLE_SDRAM
//`define ENABLE_SPI_FLASH
//`define ENABLE_MAX10_ANALOG
`define ENABLE_PUSHBUTTON
`define ENABLE_LED_OUTPUT
//`define ENABLE_EDGE_CONNECTOR
`define ENABLE_HEADERS
`define ENABLE_GPIO_J3
`define ENABLE_GPIO_J4
`define ENABLE_PMOD

module BeMicro_top(

    /* Clock inputs, SYS_CLK = 50MHz, USER_CLK = 24MHz */
`ifdef ENABLE_CLOCK_INPUTS
    //Voltage Level 2.5V
    input  logic  SYS_CLK,
    input  logic  USER_CLK,
`endif

`ifdef	ENABLE_DAC_SPI_INTERFACE
    /* DAC, 12-bit, SPI interface (AD5681) */
    output  logic  AD5681R_LDACn,
    output  logic  AD5681R_RSTn,
    output  logic  AD5681R_SCL,
    output  logic  AD5681R_SDA,
    output  logic  AD5681R_SYNCn,
`endif

`ifdef ENABLE_TEMP_SENSOR
    /* Temperature sensor, I2C interface (ADT7420) */
    // Voltage Level 2.5V
    input  logic  ADT7420_CT,
    input  logic  ADT7420_INT,
    //inout  logic  ADT7420_SCL,
    //inout  logic  ADT7420_SDA,
`endif

`ifdef ENABLE_ACCELEROMETER
    /* Accelerometer, 3-Axis, SPI interface (ADXL362)*/
    // Voltage Level 2.5V
    output  logic  ADXL362_CS,
    input  logic  ADXL362_INT1,
    input  logic  ADXL362_INT2,
    input  logic  ADXL362_MISO,
    output  logic  ADXL362_MOSI,
    output  logic  ADXL362_SCLK,
`endif

`ifdef ENABLE_SDRAM
    /* 8MB SDRAM, ISSI IS42S16400J-7TL SDRAM device */
    // Voltage Level 2.5V
    output  logic  [12:0] SDRAM_A,
    output  logic  [1:0] SDRAM_BA,
    output  logic  SDRAM_CASn,
    output  logic  SDRAM_CKE,
    output  logic  SDRAM_CLK,
    output  logic  SDRAM_CSn,
    inout   wire   [15:0] SDRAM_DQ,
    output  logic  SDRAM_DQMH,
    output  logic  SDRAM_DQML,
    output  logic  SDRAM_RASn,
    output  logic  SDRAM_WEn,
`endif

`ifdef ENABLE_SPI_FLASH
    /* Serial SPI Flash, 16Mbit, Micron M25P16-VMN6 */
    // Voltage Level 2.5V
    input  logic  SFLASH_ASDI,
    input  logic  SFLASH_CSn,
    inout  logic  SFLASH_DATA,
    inout  logic  SFLASH_DCLK,
`endif

`ifdef ENABLE_MAX10_ANALOG
    /* MAX10 analog inputs */
    // Voltage Level 2.5V
    input  logic  [7:0] AIN,
`endif

`ifdef ENABLE_PUSHBUTTON
    /* pushbutton switch inputs */
    // Voltage Level 2.5V
    input  logic  [4:1] PB,
`endif

`ifdef ENABLE_LED_OUTPUT
    /* LED outputs */
    // Voltage Level 2.5V
    output  logic  [8:1] USER_LED,
`endif

`ifdef ENABLE_EDGE_CONNECTOR
    /* BeMicro 80-pin Edge Connector */
    // Voltafe Level 2.5V
    inout  logic  EG_P1,
    inout  logic  EG_P10,
    inout  logic  EG_P11,
    inout  logic  EG_P12,
    inout  logic  EG_P13,
    inout  logic  EG_P14,
    inout  logic  EG_P15,
    inout  logic  EG_P16,
    inout  logic  EG_P17,
    inout  logic  EG_P18,
    inout  logic  EG_P19,
    inout  logic  EG_P2,
    inout  logic  EG_P20,
    inout  logic  EG_P21,
    inout  logic  EG_P22,
    inout  logic  EG_P23,
    inout  logic  EG_P24,
    inout  logic  EG_P25,
    inout  logic  EG_P26,
    inout  logic  EG_P27,
    inout  logic  EG_P28,
    inout  logic  EG_P29,
    inout  logic  EG_P3,
    inout  logic  EG_P35,
    inout  logic  EG_P36,
    inout  logic  EG_P37,
    inout  logic  EG_P38,
    inout  logic  EG_P39,
    inout  logic  EG_P4,
    inout  logic  EG_P40,
    inout  logic  EG_P41,
    inout  logic  EG_P42,
    inout  logic  EG_P43,
    inout  logic  EG_P44,
    inout  logic  EG_P45,
    inout  logic  EG_P46,
    inout  logic  EG_P47,
    inout  logic  EG_P48,
    inout  logic  EG_P49,
    inout  logic  EG_P5,
    inout  logic  EG_P50,
    inout  logic  EG_P51,
    inout  logic  EG_P52,
    inout  logic  EG_P53,
    inout  logic  EG_P54,
    inout  logic  EG_P55,
    inout  logic  EG_P56,
    inout  logic  EG_P57,
    inout  logic  EG_P58,
    inout  logic  EG_P59,
    inout  logic  EG_P6,
    inout  logic  EG_P60,
    inout  logic  EG_P7,
    inout  logic  EG_P8,
    inout  logic  EG_P9,
    input  logic  EXP_PRESENT,
    output  logic  RESET_EXPn,
`endif

`ifdef ENABLE_HEADERS
    /* Expansion headers (pair of 40-pin headers) */
    // Voltage Level 2.5V
    //inout  wire   GPIO_01, // used to be // inout  logic  GPIO_01,
    //inout  wire   GPIO_02, // used to be // inout  logic  GPIO_02,
    inout  logic  GPIO_03,
    inout  logic  GPIO_04,
    inout  logic  GPIO_05,
    inout  logic  GPIO_06,
    inout  logic  GPIO_07,
    inout  logic  GPIO_08,
    inout  logic  GPIO_09,
    inout  logic  GPIO_10,
    inout  logic  GPIO_11,
    inout  logic  GPIO_12,
    inout  logic  GPIO_A,
    inout  logic  GPIO_B,
    inout  logic  I2C_SCL,
    inout  logic  I2C_SDA,
`endif

`ifdef ENABLE_GPIO_J3
    //The following group of GPIO_J3_* signals can be used as differential pair
    //receivers as defined by some of the Terasic daughter card that are compatible
    //with the pair of 40-pin expansion headers. To use the differential pairs,
    //there are guidelines regarding neighboring pins that must be followed.
    //Please refer to the "Using LVDS on the BeMicro MAX 10" document for details.
    // Voltage Level 2.5V
    inout  logic  GPIO_J3_15,
    inout  logic  GPIO_J3_16,
    inout  logic  GPIO_J3_17,
    inout  logic  GPIO_J3_18,
    inout  logic  GPIO_J3_19,
    inout  logic  GPIO_J3_20,
    inout  logic  GPIO_J3_21,
    inout  logic  GPIO_J3_22,
    inout  logic  GPIO_J3_23,
    inout  logic  GPIO_J3_24,
    inout  logic  GPIO_J3_25,
    inout  logic  GPIO_J3_26,
    inout  logic  GPIO_J3_27,
    inout  logic  GPIO_J3_28,
    inout  logic  GPIO_J3_31,
    inout  logic  GPIO_J3_32,
    inout  logic  GPIO_J3_33,
    inout  logic  GPIO_J3_34,
    inout  logic  GPIO_J3_35,
    inout  logic  GPIO_J3_36,
    inout  logic  GPIO_J3_37,
    inout  logic  GPIO_J3_38,
    inout  logic  GPIO_J3_39,
    inout  logic  GPIO_J3_40,
`endif

`ifdef ENABLE_GPIO_J4
    //The following group of GPIO_J4_* signals can be used as true LVDS transmitters
    //as defined by some of the Terasic daughter card that are compatible
    //with the pair of 40-pin expansion headers. To use the differential pairs,
    //there are guidelines regarding neighboring pins that must be followed.
    //Please refer to the "Using LVDS on the BeMicro MAX 10" document for details.
    // Voltage Level 2.5V
    inout  logic  GPIO_J4_11,
    inout  logic  GPIO_J4_12,
    inout  logic  GPIO_J4_13,
    inout  logic  GPIO_J4_14,
    inout  logic  GPIO_J4_15,
    inout  logic  GPIO_J4_16,
    inout  logic  GPIO_J4_19,
    inout  logic  GPIO_J4_20,
    inout  logic  GPIO_J4_21,
    inout  logic  GPIO_J4_22,
    inout  logic  GPIO_J4_23,
    inout  logic  GPIO_J4_24,
    inout  logic  GPIO_J4_27,
    inout  logic  GPIO_J4_28,
    inout  logic  GPIO_J4_29,
    inout  logic  GPIO_J4_30,
    inout  logic  GPIO_J4_31,
    inout  logic  GPIO_J4_32,
    inout  logic  GPIO_J4_35,
    inout  logic  GPIO_J4_36,
    inout  logic  GPIO_J4_37,
    inout  logic  GPIO_J4_38,
    inout  logic  GPIO_J4_39,
    inout  logic  GPIO_J4_40,
`endif

`ifdef ENABLE_PMOD
    /* PMOD connectors */
    //Voltage Level 2.5V
    inout [3:0] PMOD_A,
    inout [3:0] PMOD_B,
    inout [3:0] PMOD_C, // change these to discrete inputs and outputs later
    inout [3:0] PMOD_D,
`endif

    inout   wire   [1:0]   scl,
    inout   wire   [1:0]   sda
);


    logic  [7:0]  ioOut;


    BeMicro_soc #(.LINES(2))
    BeMicro_soc(
        .clk                    (SYS_CLK),
        .reset                  (~PB[1]),
        .ioOut,
        .rx                     (PMOD_D[2]),
        .tx                     (PMOD_D[3]),
        .dacMiso                (1'b0),              // not used
        .dacMosi                (AD5681R_SDA),
        .dacSclk                (AD5681R_SCL),
        .dacSs                  (AD5681R_SYNCn),
        .sdCardMiso             (PMOD_C[2]),
        .sdCardMosi             (PMOD_C[1]),
        .sdCardSclk             (PMOD_C[3]),
        .sdCardSs               (PMOD_C[0]),
        .scl,
        .sda,
        .pwmOut                 (PMOD_A[0]),
        .externalSdramAddress   (SDRAM_A[11:0]),
        .externalSdramBa        (SDRAM_BA),
        .externalSdramCas       (SDRAM_CASn),
        .externalSdramCke       (SDRAM_CKE),
        .externalSdramClk       (SDRAM_CLK),
        .externalSdramCs        (SDRAM_CSn),
        .externalSdramDq        (SDRAM_DQ),
        .externalSdramDqm       ({SDRAM_DQMH, SDRAM_DQML}),
        .externalSdramRas       (SDRAM_RASn),
        .externalSdramWe        (SDRAM_WEn),
        .horizontalSync         (GPIO_J3_32),
        .verticalSync           (GPIO_J3_34),
        .red                    ({GPIO_12, GPIO_J3_16, GPIO_J3_18}),
        .green                  ({GPIO_J3_20, GPIO_J3_22, GPIO_J3_24}),
        .blue                   ({GPIO_J3_26, GPIO_J3_28})
    );

    //assign GPIO_02 = scl; // scl
    //assign GPIO_01 = sda;// sda

    // i2c address 1001000 // registers at address 0 and 1 are the tempature data
    //ADT7420_CT,
    //ADT7420_INT,
    //assign ADT7420_SCL = scl;
    //assign ADT7420_SDA = sda;


    assign USER_LED = ~ioOut;


    assign AD5681R_LDACn = 1'b0; // enable auto input register update
    assign AD5681R_RSTn  = 1'b1; // disable reset


endmodule

