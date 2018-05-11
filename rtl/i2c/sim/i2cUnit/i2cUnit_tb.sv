`timescale 1ns / 100ps


module i2cUnit_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic         clk;
    logic         reset;
    logic  [1:0]  command;
    logic  [7:0]  transmitData;
    logic         transmitAck;
    logic         cycleDone;
    logic         transmitValid;

    // output wires
    logic  [7:0]  receiveData;
    logic         receiveAck;
    logic         transmitReady;
    logic         receiveValid;
    logic         busy;

    // inout wires
    wire          scl;
    wire          sda;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2cUnit
    dut(
        .clk,
        .reset,
        .command,
        .transmitData,
        .receiveData,
        .transmitAck,
        .receiveAck,
        .cycleDone,
        .transmitValid,
        .transmitReady,
        .receiveValid,
        .busy,
        .scl,
        .sda
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
    integer             address = 0;
    logic   [15:0][7:0] tdata;
    logic               ack;
    logic   [7:0]       data;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        cycleDone      = 1'b0;
        command        = 2'b00;
        transmitData   = 8'b0000_0000;
        transmitAck    = 1'b1;
        transmitValid  = 1'b0;
    end


    // create clock sources
    always begin
        #5
        clk = 1'b0;
        #5
        clk = 1'b1;
    end


    always begin
        //if(reset) begin
            //cycleDone = 1'b0;
        //end else begin
            repeat(249) @(posedge clk);
            cycleDone = 1'b1;
            @(posedge clk);
            cycleDone = 1'b0;
        //end
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

        // write data to the eeprom
        repeat(16) begin
            tdata[address] = $urandom();

            do begin
                i2cStart();                     // send start
                i2cTransmit(8'b1010_0000, ack); // send contorl byte
            end while(ack != 1'b0);

            i2cTransmit(address, ack);          // send address
            i2cTransmit(tdata[address], ack);   // send data
            i2cStop();                          // send stop

            address++;                          // inrement the address

            // wait some time
            repeat(1000) @(posedge clk);
        end

        // wait some time
        repeat(100000) @(posedge clk);

        // reset address
        address = 0;

        // read the data back from the eeprom
        repeat(16) begin
            do begin
                i2cStart();                     // send start
                i2cTransmit(8'b1010_0000, ack); // send contorl byte
            end while(ack != 1'b0);
            
            i2cTransmit(address, ack);          // send address
            i2cStart();                         // send start
            i2cTransmit(8'b1010_0001, ack);     // send contorl byte
            i2cReceive(1'b1, data);             // transmit no ack and receive data
            i2cStop();                          // send stop

            $info("For address: %h we wrote: %h and read: %h", address, tdata[address], data);

            address++;                          // inrement the address

            // wait some time
            repeat(1000) @(posedge clk);
        end

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


    task i2cStart();
        command             = 2'b00; // start command
        transmitValid       = 1'b1;
        @(posedge cycleDone);
        transmitValid       = 1'b0;
        @(negedge busy);
    endtask


    task i2cStop();
        command             = 2'b01; // stop command
        transmitValid       = 1'b1;
        @(posedge cycleDone);
        transmitValid       = 1'b0;
        @(negedge busy);
    endtask


    task i2cTransmit(input logic [7:0] data, output logic ackOut);
        command             = 2'b10; // transmit command
        transmitData        = data;
        transmitValid       = 1'b1;
        @(posedge cycleDone);
        transmitValid       = 1'b0;
        @(negedge busy);
        ackOut              = receiveAck;
    endtask


    task i2cReceive(input logic ack, output logic [7:0] data);
        command             = 2'b11; // receive command
        //transmitData        = 8'b0;  // not really needed
        transmitAck         = ack;   // ack bit
        transmitValid       = 1'b1;
        @(posedge cycleDone);
        transmitValid       = 1'b0;
        @(negedge busy);
        data                = receiveData;
    endtask


endmodule

