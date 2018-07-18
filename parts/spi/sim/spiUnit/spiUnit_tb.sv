`timescale 1ns / 100ps


module spiUnit_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          clockPolarity;
    logic          clockPhase;
    logic          dataDirection;
    logic          finalCycle;
    logic  [7:0]   dataRegIn;
    logic          transmitReady;
    logic          miso;


    // output wires
    logic  [7:0]   dataReg;
    logic          coreWrite;
    logic          coreRead;
    logic          idle;
    logic          mosi;
    logic          sclk;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    spiUnit #(.DATAWIDTH(8))
    dut(
        .clk,
        .reset,
        .clockPolarity,
        .clockPhase,
        .dataDirection,
        .finalCycle,
        .dataRegIn,
        .dataReg,
        .transmitReady,
        .coreWrite,
        .coreRead,
        .idle,
        .miso,
        .mosi,
        .sclk
    );


    assign miso = mosi; // echo back the data


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer        seed = 125376;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        clockPolarity  = 1'b0;
        clockPhase     = 1'b0;
        dataDirection  = 1'b0;
        finalCycle     = 1'b0;
        dataRegIn      = 8'haa;
        transmitReady  = 1'b0;
        //miso           = 1'b1;
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    always begin
        repeat(10) @(posedge clk);
        finalCycle = 1'b1;
        @(posedge clk);
        finalCycle = 1'b0;
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

        clockPolarity = 1'b0; clockPhase = 1'b0; dataDirection = 1'b0;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b0; clockPhase = 1'b0; dataDirection = 1'b1;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b0; clockPhase = 1'b1; dataDirection = 1'b0;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b0; clockPhase = 1'b1; dataDirection = 1'b1;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b1; clockPhase = 1'b0; dataDirection = 1'b0;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b1; clockPhase = 1'b0; dataDirection = 1'b1;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b1; clockPhase = 1'b1; dataDirection = 1'b0;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

        clockPolarity = 1'b1; clockPhase = 1'b1; dataDirection = 1'b1;
        repeat(10) transceive($urandom());
        repeat(500) @(posedge clk);

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


    task transceive(input logic [7:0] data);
        wait(idle);
        dataRegIn     = data;
        transmitReady = 1'b1;
        wait(!idle);
        transmitReady = 1'b0;
    endtask


endmodule

