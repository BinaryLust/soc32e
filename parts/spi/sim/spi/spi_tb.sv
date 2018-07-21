`timescale 1ns / 100ps


module spi_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic          clk;
    logic          reset;
    logic          read;
    logic          write;
    logic  [1:0]   address;
    logic  [31:0]  dataIn;
    logic          miso;

    // output wires
    logic          readValid;
    logic  [31:0]  dataOut;
    logic          transmitIrq;
    logic          receiveIrq;
    logic          mosi;
    logic          sclk;
    logic  [3:0]   ss;

    // inout wires


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    spi #(.DATAWIDTH(8), .BUFFERDEPTH(1024))
    dut(
        .clk,
        .reset,
        .read,
        .write,
        .address,
        .dataIn,
        .readValid,
        .dataOut,
        .transmitIrq,
        .receiveIrq,
        .miso,
        .mosi,
        .sclk,
        .ss
    );


    assign miso = mosi; // echo data back


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer             seed     = 125376;
    logic   [7:0]       taddress = 0;
    logic   [15:0][7:0] tdata;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        read           = 1'b0;
        write          = 1'b0;
        address        = 2'd0;
        dataIn         = 32'd0;
    end


    // create clock sources
    always begin
        #5
        clk = 1'b0;
        #5
        clk = 1'b1;
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

        repeat(1000) begin
            writeData(2'd3, {16'd5, 1'b0, 1'b0, 1'b0, 1'b1, 2'd0, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b0, 1'b0, 1'b1, 1'b1, 2'd1, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b0, 1'b1, 1'b0, 1'b1, 2'd2, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b0, 1'b1, 1'b1, 1'b1, 2'd3, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b1, 1'b0, 1'b0, 1'b1, 2'd0, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b1, 1'b0, 1'b1, 1'b1, 2'd1, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b1, 1'b1, 1'b0, 1'b1, 2'd2, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(2'd3, {16'd5, 1'b1, 1'b1, 1'b1, 1'b1, 2'd3, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);
        end

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


    task writeData(input logic [1:0] _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; dataIn = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'd0; dataIn = 32'b0;
        end
    endtask


    task readData(input logic [1:0] _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 2'd0;
            @(posedge readValid);
        end
    endtask


    task tx(input logic [31:0] _data);
        begin
            do begin
                readData(2'd2);            // check transmitReady flag
            end while(dataOut[0] == 1'b0); // wait for it to be ready
            writeData(2'd0, _data);        // write the data
        end
    endtask


    task idletx(input logic [31:0] _data);
        begin
            do begin
                readData(2'd2);            // check idle flag
            end while(dataOut[2] == 1'b0); // wait for it to be set
            writeData(2'd0, _data);        // write the data
        end
    endtask


    task rx();
        begin
            do begin
                readData(2'd2);            // check receiveValid flag
            end while(dataOut[1] == 1'b0); // wait for it to be valid
            readData(2'd1);                // read the data
        end
    endtask


    task doTest();
        // reset address
        taddress = 0;

        // transmit data
        repeat(16) begin
            tdata[taddress[3:0]] = $urandom();
            tx(tdata[taddress[3:0]]); // send data
            taddress++; // inrement the address
        end

        // reset address
        taddress = 0;

        // receive data
        repeat(16) begin
            rx(); // read data and ack bit

            //$info("we wrote: %h and read: %h", tdata[taddress[3:0]], dataOut[7:0]);

            if(tdata[taddress[3:0]] != dataOut[7:0])
                $fatal("Data missmatch! - we wrote: %h and read: %h", tdata[taddress[3:0]], dataOut[7:0]);

            taddress++; // inrement the address
        end
    endtask


    task doIdleTest();
        // reset address
        taddress = 0;

        // transmit data
        repeat(16) begin
            tdata[taddress[3:0]] = $urandom();
            idletx(tdata[taddress[3:0]]); // send data
            taddress++; // inrement the address
        end

        // reset address
        taddress = 0;

        // receive data
        repeat(16) begin
            rx(); // read data and ack bit

            //$info("we wrote: %h and read: %h", tdata[taddress[3:0]], dataOut[7:0]);

            if(tdata[taddress[3:0]] != dataOut[7:0])
                $fatal("Data missmatch! - we wrote: %h and read: %h", tdata[taddress[3:0]], dataOut[7:0]);

            taddress++; // inrement the address
        end
    endtask


endmodule

