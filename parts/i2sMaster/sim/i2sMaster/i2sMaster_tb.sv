`timescale 1ns / 100ps


module i2sMaster_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          synthClk;
    logic          synthReset;
    logic          read;
    logic          write;
    logic  [1:0]   address;
    logic  [31:0]  dataIn;
    logic          sdin;


    // output wires
    logic          readValid;
    logic  [31:0]  dataOut;
    logic          soundIrq;
    logic          mclk;
    logic          wclk;
    logic          bclk;
    logic          sdout;


    // inout wires


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2sMaster
    dut(
        .clk,
        .reset,
        .synthClk,
        .synthReset,
        .read,
        .write,
        .address,
        .dataIn,
        .readValid,
        .dataOut,
        .soundIrq,
        .mclk,
        .wclk,
        .bclk,
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
        synthReset = 1'b0;
        read       = 1'b0;
        write      = 1'b0;
        address    = 2'd0;
        dataIn     = 32'd0;
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
        #2
        synthClk = 1'b0;
        #2
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
        repeat(100000) @(posedge clk);

        // set clock dividers
        writeData(2'd3, {10'd0, 10'd36, 4'd4, 8'd64}); // mclk = 10'd72; bclkDivider = 4'd4; wclkDivider = 8'd64;

        // write data to the sound buffer
        repeat(64) begin
            tx($random);
        end

        // configure the controller
        writeData(2'd2, 32'b0011); // 8 bit sample size, mono, playback enabled, interrupt enabled.

        // wait some time
        repeat(10000000) @(posedge clk);

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
        reset = 1'b0; synthReset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1; synthReset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0; synthReset = 1'b0;
    endtask


    task writeData(input logic [1:0] _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; dataIn = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'b0; dataIn = 32'b0;
        end
    endtask


    task readData(input logic [1:0] _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'b0;
            @(posedge readValid);
        end
    endtask


    task tx(input logic [31:0] _data);
        begin
            do begin
                readData(2'b1);            // check full flag
            end while(dataOut[9] == 1'b1); // wait for it to be not full
            writeData(2'b0, _data);        // write the data
        end
    endtask


    // task rx();
    //     begin
    //         do begin
    //             readData(1'b1);            // check receiveValid flag
    //         end while(dataOut[1] == 1'b0); // wait for it to be valid
    //         readData(1'b0);                // read the data
    //     end
    // endtask


endmodule

