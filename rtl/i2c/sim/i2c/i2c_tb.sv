`timescale 1ns / 100ps


module i2c_tb();


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

    // inout wires
    wire           scl;             // i2c clock
    wire           sda;             // i2c data


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2c
    dut(
        .clk,
        .reset,
        .read,
        .write,
        .address,
        .dataIn,
        .readValid,
        .dataOut,
        .scl,             // i2c clock
        .sda              // i2c data
    );


    M24LC00
    eeprom(
        .A0       (),
        .A1       (),
        .A2       (),
        .WP       (1'b0),
        .SDA      (sda),
        .SCL      (scl),
        .RESET    (reset)
    );


    pullup(sda);
    pullup(scl);


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer             seed    = 125376;
    //integer             address = 0;
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

        writeData(1'b0, {21'd0, 2'b00, 1'b1, 8'd0});
        writeData(1'b0, {21'd0, 2'b00, 1'b1, 8'd0});
        writeData(1'b0, {21'd0, 2'b01, 1'b1, 8'd0});
        writeData(1'b0, {21'd0, 2'b01, 1'b1, 8'd0});
        // write data to the eeprom
        // repeat(16) begin
        //     tdata[address] = $urandom();

        //     do begin
        //         i2cStart();                     // send start
        //         i2cTransmit(8'b1010_0000, ack); // send contorl byte
        //     end while(ack != 1'b0);

        //     i2cTransmit(address, ack);          // send address
        //     i2cTransmit(tdata[address], ack);   // send data
        //     i2cStop();                          // send stop

        //     address++;                          // inrement the address

        //     // wait some time
        //     repeat(1000) @(posedge clk);
        // end

        // // wait some time
        // repeat(100000) @(posedge clk);

        // // reset address
        // address = 0;

        // // read the data back from the eeprom
        // repeat(16) begin
        //     do begin
        //         i2cStart();                     // send start
        //         i2cTransmit(8'b1010_0000, ack); // send contorl byte
        //     end while(ack != 1'b0);

        //     i2cTransmit(address, ack);          // send address
        //     i2cStart();                         // send start
        //     i2cTransmit(8'b1010_0001, ack);     // send contorl byte
        //     i2cReceive(1'b1, data);             // transmit no ack and receive data
        //     i2cStop();                          // send stop

        //     $info("For address: %h we wrote: %h and read: %h", address, tdata[address], data);

        //     address++;                          // inrement the address

        //     // wait some time
        //     repeat(1000) @(posedge clk);
        // end

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


    task writeData(input logic [31:0] _data, input logic _address);
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
        end
    endtask


    // task i2cStart();
    //     command             = 2'b00; // start command
    //     transmitValid       = 1'b1;
    //     @(posedge cycleDone);
    //     transmitValid       = 1'b0;
    //     @(negedge busy);
    // endtask


    // task i2cStop();
    //     command             = 2'b01; // stop command
    //     transmitValid       = 1'b1;
    //     @(posedge cycleDone);
    //     transmitValid       = 1'b0;
    //     @(negedge busy);
    // endtask


    // task i2cTransmit(input logic [7:0] data, output logic ackOut);
    //     command             = 2'b10; // transmit command
    //     transmitData        = data;
    //     transmitValid       = 1'b1;
    //     @(posedge cycleDone);
    //     transmitValid       = 1'b0;
    //     @(negedge busy);
    //     ackOut              = receiveAck;
    // endtask


    // task i2cReceive(input logic ack, output logic [7:0] data);
    //     command             = 2'b11; // receive command
    //     //transmitData        = 8'b0;  // not really needed
    //     transmitAck         = ack;   // ack bit
    //     transmitValid       = 1'b1;
    //     @(posedge cycleDone);
    //     transmitValid       = 1'b0;
    //     @(negedge busy);
    //     data                = receiveData;
    // endtask


endmodule

