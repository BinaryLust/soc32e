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
    logic          miso;


    // output wires
    logic  [7:0]   ioOut;
    logic          tx;
    logic          mosi;
    logic          sclk;
    logic          ss;
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


    // inout wires
    wire  [15:0]  externalSdramDq;


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
        .miso,
        .mosi,
        .sclk,
        .ss,
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
        .externalSdramWe
    );


    assign miso = mosi; // echo back the data


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
        reset = 1'b0;
        rx    = 1'b1;
        //miso  = 1'b0;
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

