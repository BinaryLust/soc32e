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
    logic  [2:0]   address;
    logic  [31:0]  dataIn;
    logic          miso;

    // output wires
    logic          readValid;
    logic  [31:0]  dataOut;
    logic          txIrq;
    logic          rxIrq;
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
        .txIrq,
        .rxIrq,
        .miso,
        .mosi,
        .sclk,
        .ss
    );


    assign miso = !mosi; // echo negated data back


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer         seed     = 192437;
    logic   [15:0]  taddress = 0;
    logic   [7:0]   tdata[2048];


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
        address        = 3'd0;
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

        repeat(10) begin
            writeData(3'd4, {16'd5, 1'b0, 1'b0, 1'b0, 1'b1, 2'd0, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b0, 1'b0, 1'b1, 1'b1, 2'd1, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b0, 1'b1, 1'b0, 1'b1, 2'd2, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b0, 1'b1, 1'b1, 1'b1, 2'd3, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b1, 1'b0, 1'b0, 1'b1, 2'd0, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b1, 1'b0, 1'b1, 1'b1, 2'd1, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b1, 1'b1, 1'b0, 1'b1, 2'd2, 8'b0, 1'b0, 1'b0}); // configure the controller
            doTest();                                                                 // do normal test
            doIdleTest();                                                             // do idle test

            // wait some time
            repeat(1000) @(posedge clk);

            writeData(3'd4, {16'd5, 1'b1, 1'b1, 1'b1, 1'b1, 2'd3, 8'b0, 1'b0, 1'b0}); // configure the controller
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


    task writeData(input logic [2:0] _address, input logic [31:0] _data);
        repeat($urandom_range(0, 7)) @(posedge clk); // wait random cycles
        @(posedge clk); // wait for clk edge
        #1 read = 1'b0; write = 1'b1; address = _address; dataIn = _data;
        @(posedge clk); // wait for clk edge
        #1 read = 1'b0; write = 1'b0; address = 3'd0; dataIn = 32'b0;
    endtask


    task readData(input logic [2:0] _address);
        repeat($urandom_range(0, 7)) @(posedge clk); // wait random cycles
        @(posedge clk); // wait for clk edge
        #1 read = 1'b1; write = 1'b0; address = _address;
        @(posedge clk); // wait for clk edge
        #1 read = 1'b0; write = 1'b0; address = 3'd0;
        @(posedge readValid);
    endtask


    task tx(input logic [31:0] _data);
        do begin
            readData(3'd1);     // check txFull flag
        end while(dataOut[1]);  // wait for it to be not full
        writeData(3'd0, _data); // write the data
    endtask


    task idletx(input logic [31:0] _data);
        do begin
            readData(3'd1);     // check idle flag
        end while(!dataOut[0]); // wait for it to be set
        writeData(3'd0, _data); // write the data
    endtask


    task rx();
        do begin
            readData(3'd1);    // check rxEmpty flag
        end while(dataOut[3]); // wait for it to be not empty
        readData(3'd0);        // read the data
    endtask


    task doTest();
        // reset address
        taddress = 0;

        // transmit data
        repeat(1024) begin
            tdata[taddress] = $urandom();
            tx(tdata[taddress]); // send data
            taddress++; // increment the address
        end

        // reset address
        taddress = 0;

        // receive data
        repeat(1024) begin
            rx(); // read data and ack bit

            //$info("we wrote: %h and read: %h", tdata[taddress], dataOut[7:0]);

            if(~tdata[taddress] != dataOut[7:0])
                $fatal("Data missmatch! - we wrote: %h and read: %h", ~tdata[taddress], dataOut[7:0]);

            taddress++; // increment the address
        end
    endtask


    task doIdleTest();
        // reset address
        taddress = 0;

        // transmit data
        repeat(1024) begin
            tdata[taddress] = $urandom();
            idletx(tdata[taddress]); // send data
            taddress++; // increment the address
        end

        // reset address
        taddress = 0;

        // receive data
        repeat(1024) begin
            rx(); // read data and ack bit

            //$info("we wrote: %h and read: %h", !tdata[taddress], dataOut[7:0]);

            if(~tdata[taddress] != dataOut[7:0])
                $fatal("Data missmatch! - we wrote: %h and read: %h", ~tdata[taddress], dataOut[7:0]);

            taddress++; // increment the address
        end
    endtask


endmodule

