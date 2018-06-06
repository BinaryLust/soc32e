`timescale 1ns / 100ps


module ethernetSmi_tb();


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
    logic          address;
    logic  [31:0]  dataIn;

    // output wires
    logic          readValid;
    logic  [31:0]  dataOut;
    logic          mdc;

    // inout wires
    wire           mdio;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    ethernetSmi
    dut(
        clk,
        reset,
        read,
        write,
        address,
        dataIn,
        readValid,
        dataOut,
        mdc,
        mdio
    );


    pullup(mdio);


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer             seed     = 125376;
    //logic   [7:0]       taddress = 0;
    //logic   [15:0][7:0] tdata;
    //logic               ack;
    //logic   [7:0]       data;


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
        address        = 1'b0;
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

        // write data
        repeat(1000) begin
            tx($random);

            // wait some time
            repeat($urandom_range(1, 10000)) @(posedge clk);
        end

        // wait some time
        repeat(100000) @(posedge clk);

        // reset address
        //taddress = 0;

        // read data
        // repeat(16) begin
        //     do begin
        //         tx({21'd0, 2'b00, 1'b1, 8'd0});              // send start
        //         tx({21'd0, 2'b10, 1'b1, 8'b1010_0000});      // send contorl byte
        //         rx();                                        // read ack bit
        //     end while(dataOut[8] == 1'b1);                   // check ack bit

        //     tx({21'd0, 2'b10, 1'b1, taddress});              // send address
        //     rx();                                            // read ack bit
        //     tx({21'd0, 2'b00, 1'b1, 8'd0});                  // send start
        //     tx({21'd0, 2'b10, 1'b1, 8'b1010_0001});          // send contorl byte
        //     rx();                                            // read ack bit
        //     tx({21'd0, 2'b11, 1'b1, 8'd0});                  // receive data and transmit no ack
        //     rx();                                            // read data and ack bit
        //     tx({21'd0, 2'b01, 1'b1, 8'd0});                  // send stop

        //     $info("For address: %h we wrote: %h and read: %h", taddress[3:0], tdata[taddress[3:0]], dataOut[7:0]);

        //     taddress++;                          // inrement the address

        //     // wait some time
        //     repeat(10000) @(posedge clk);
        // end

        // wait some time
        repeat(1000000) @(posedge clk);

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


    task writeData(input logic _address, input logic [31:0] _data);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b1; address = _address; dataIn = _data;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 1'b0; dataIn = 32'b0;
        end
    endtask


    task readData(input logic _address);
        begin
            @(posedge clk); // wait for clk edge
            #1 read = 1'b1; write = 1'b0; address = _address;
            @(posedge clk); // wait for clk edge
            #1 read = 1'b0; write = 1'b0; address = 1'b0;
            @(posedge readValid);
        end
    endtask


    task tx(input logic [31:0] _data);
        begin
            do begin
                readData(1'b1);            // check transmitReady flag
            end while(dataOut[0] == 1'b0); // wait for it to be ready
            writeData(1'b0, _data);        // write the data
        end
    endtask


    task rx();
        begin
            do begin
                readData(1'b1);            // check receiveValid flag
            end while(dataOut[1] == 1'b0); // wait for it to be valid
            readData(1'b0);                // read the data
        end
    endtask


endmodule

