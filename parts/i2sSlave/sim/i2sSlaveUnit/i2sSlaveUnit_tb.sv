`timescale 1ns / 100ps


module i2sSlaveUnit_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          wclk;
    logic          bclk;
    logic          sampleSize;
    logic          stereoMode;
    logic          playback;
    logic  [31:0]  sampleData;
    logic          sdin;

    // output wires
    logic          readReq;
    logic          sdout;

    // inout wires


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2sSlaveUnit
    dut(
        .clk,
        .reset,
        .wclk,
        .bclk,
        .sampleSize,
        .stereoMode,
        .playback,
        .sampleData,
        .readReq,
        .sdin,
        .sdout
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
        reset      = 1'b0;
        sampleSize = 1'b1; // 8 bit
        stereoMode = 1'b1;
        playback   = 1'b0;
        sampleData = $random;
        sdin       = 1'b0;
    end


    // create clock sources
    always begin
        #5
        clk = 1'b0;
        #5
        clk = 1'b1;
    end


    always begin
        #250
        bclk = 1'b1;
        #250
        bclk = 1'b0;
    end


    always begin
        #32000
        wclk = 1'b0;
        #32000
        wclk = 1'b1;
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
        repeat(100000) @(posedge clk);

        // set mode and enable playback
        sampleSize = 1'b0; // 8 bit
        stereoMode = 1'b1; // stereo
        playback   = 1'b1;

        // set some samples
        repeat(16) begin
            @(posedge readReq);
            sampleData = $random;
        end

        // disable playback
        playback = 1'b0;

        // wait some time
        repeat(100000) @(posedge clk);

        // set mode and enable playback
        sampleSize = 1'b0; // 8 bit
        stereoMode = 1'b0; // mono
        playback   = 1'b1;

        // set some samples
        repeat(16) begin
            @(posedge readReq);
            sampleData = $random;
        end

        // disable playback
        playback = 1'b0;

        // wait some time
        repeat(100000) @(posedge clk);

        // set mode and enable playback
        sampleSize = 1'b1; // 16 bit
        stereoMode = 1'b1; // stereo
        playback   = 1'b1;

        // set some samples
        repeat(16) begin
            @(posedge readReq);
            sampleData = $random;
        end

        // disable playback
        playback = 1'b0;

        // wait some time
        repeat(100000) @(posedge clk);

        // set mode and enable playback
        sampleSize = 1'b1; // 16 bit
        stereoMode = 1'b0; // mono
        playback   = 1'b1;

        // set some samples
        repeat(16) begin
            @(posedge readReq);
            sampleData = $random;
        end

        // disable playback
        playback = 1'b0;

        // wait some time
        repeat(100000) @(posedge clk);

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
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0;
    endtask


endmodule

