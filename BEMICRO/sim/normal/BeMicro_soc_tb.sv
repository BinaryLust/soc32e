`timescale 1ns / 1ns


module BeMicro_soc_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          rx;
    logic          dacMiso;
    logic          sdCardMiso;


    // output wires
    logic  [7:0]   ioOut;
    logic          tx;
    logic          dacMosi;
    logic          dacSclk;
    logic          dacSs;
    logic          sdCardMosi;
    logic          sdCardSclk;
    logic          sdCardSs;
    logic          pwmOut;
    logic  [11:0]  externalSdramAddress;
    logic  [1:0]   externalSdramBa;
    logic          externalSdramCas;
    logic          externalSdramCke;
    logic          externalSdramClk;
    logic          externalSdramCs;
    logic  [1:0]   externalSdramDqm;
    logic          externalSdramRas;
    logic          externalSdramWe;
    logic          horizontalSync;
    logic          verticalSync;
    logic  [2:0]   red;
    logic  [2:0]   green;
    logic  [1:0]   blue;


    // inout wires
    wire           scl;
    wire           sda;
    wire   [15:0]  externalSdramDq;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    BeMicro_soc
    dut(
        .clk,
        .reset,
        .ioOut,
        .rx,
        .tx,
        .dacMiso,
        .dacMosi,
        .dacSclk,
        .dacSs,
        .sdCardMiso,
        .sdCardMosi,
        .sdCardSclk,
        .sdCardSs,
        .scl,
        .sda,
        .pwmOut,
        .externalSdramAddress,
        .externalSdramBa,
        .externalSdramCas,
        .externalSdramCke,
        .externalSdramClk,
        .externalSdramCs,
        .externalSdramDq,
        .externalSdramDqm,
        .externalSdramRas,
        .externalSdramWe,
        .horizontalSync,
        .verticalSync,
        .red,
        .green,
        .blue
    );


    //assign miso = mosi; // echo back the data


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset      = 1'b0;
        rx         = 1'b1;
        dacMiso    = 1'b0;
        sdCardMiso = 1'b0;
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        hardwareReset();
        repeat(100000) @(posedge clk);

        $stop;
    end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardwareReset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(20) @(posedge clk);
        reset = 1'b0;
    endtask


endmodule

