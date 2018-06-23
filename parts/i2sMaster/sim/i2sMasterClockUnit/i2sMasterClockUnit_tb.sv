`timescale 1ns / 100ps


module i2sMasterClockUnit_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          synthClk;
    logic          synthReset;
    logic          loadEn;
    logic  [9:0]   mclkDivider;
    logic  [3:0]   bclkDivider;
    logic  [7:0]   wclkDivider;

    // output wires
    logic          mclk;
    logic          bclk;
    logic          wclk;

    // inout wires


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2sMasterClockUnit
    dut(
        synthClk,
        synthReset,
        loadEn,
        mclkDivider,
        bclkDivider,
        wclkDivider,
        mclk,
        bclk,
        wclk
    );


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer seed = 125376;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        synthReset  = 1'b0;
        loadEn      = 1'b0;
        mclkDivider = 10'd72;
        bclkDivider = 4'd4;
        wclkDivider = 8'd64;
    end


    // create clock sources
    always begin
        #5
        synthClk = 1'b0;
        #5
        synthClk = 1'b1;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        // set errors to zero
        //errorCount = 0;

        // set the random seed
        $urandom(seed);//x = $urandom(seed);//$srandom(seed);

        // reset the system
        hardwareReset();

        // wait some time
        repeat(1000000) @(posedge synthClk);

        // wait some time
        repeat(10000) @(posedge synthClk);
        setDividers(10'd2, 4'd2, 8'd3);

        // wait some time
        repeat(10000) @(posedge synthClk);
        setDividers(10'd2, 4'd3, 8'd3);

        // wait some time
        repeat(10000) @(posedge synthClk);
        setDividers(10'd2, 4'd4, 8'd4);

        // wait some time
        repeat(10000) @(posedge synthClk);
        setDividers(10'd2, 4'd5, 8'd4);

        // wait some time
        repeat(10000) @(posedge synthClk);

        //$display("%d Errors", errorCount);
        $stop;
     end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardwareReset();
        synthReset = 1'b0;
        wait(synthClk !== 1'bx);
        @(posedge synthClk);
        synthReset = 1'b1;
        repeat(10) @(posedge synthClk);
        synthReset = 1'b0;
    endtask


    task setDividers(input logic [9:0] _mclkDivider, input logic [3:0] _bclkDivider, input logic [7:0] _wclkDivider);
        begin
            @(posedge synthClk); // wait for clk edge
            mclkDivider = _mclkDivider;
            bclkDivider = _bclkDivider;
            wclkDivider = _wclkDivider;
            loadEn      = 1'b1;
            @(posedge synthClk); // wait for clk edge
            loadEn      = 1'b0;
        end
    endtask


endmodule

