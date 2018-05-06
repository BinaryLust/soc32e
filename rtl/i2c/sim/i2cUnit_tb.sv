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
    logic  [1:0]  i2cCommand;
    logic  [7:0]  i2cWriteData;
    logic         cycleDone;
    logic         i2cTransactionValid;

    // output wires
    logic  [7:0]  i2cReadData;
    logic         i2cBusy;
    logic         i2cWriteAck;
    logic         i2cReadDataValid;

    // inout wires
    wire          i2cScl;
    wire          i2cSda;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    i2cUnit
    dut(
        .clk,
        .reset,
        .i2cCommand,
        .i2cWriteData,
        .i2cReadData,
        .cycleDone,
        .i2cTransactionValid,
        .i2cBusy,
        .i2cWriteAck,
        .i2cReadDataValid,
        .i2cScl,
        .i2cSda
    );


    M24LC00
    eeprom(
        .A0       (),
        .A1       (),
        .A2       (),
        .WP       (1'b0),
        .SDA      (i2cSda),
        .SCL      (i2cScl),
        .RESET    (reset)
    );

    
    pullup(i2cScl);
    pullup(i2cSda);


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer seed    = 125376;
    integer address = 0;
    logic   ack;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset               = 1'b0;
        i2cCommand          = 2'b00;
        i2cWriteData        = 8'b0000_0000;
        i2cTransactionValid = 1'b0;
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

        // write some data the eeprom
        repeat(16) begin
            do begin
                i2cStart();                     // send start
                i2cTransmit(8'b1010_0000, ack); // send contorl byte
            end while(ack != 1'b0);

            i2cTransmit(address, ack);          // send address
            i2cTransmit($urandom(), ack);       // send data
            i2cStop();                          // send stop

            address++;                          // inrement the address

            // wait some time
            repeat(1000) @(posedge clk);
        end

        // wait some time
        repeat(5000) @(posedge clk);

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
        i2cCommand          = 2'b00; // start command
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;
        wait(!i2cBusy);
    endtask


    task i2cStop();
        i2cCommand          = 2'b01; // stop command
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;
        wait(!i2cBusy);
    endtask


    task i2cTransmit(input logic [7:0] data, output logic ackOut);
        i2cCommand          = 2'b10; // transmit command
        i2cWriteData        = data;
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;
        wait(!i2cBusy);
        ackOut              = i2cReadData[0];
    endtask


    task i2cReceive(input logic ack, output logic [7:0] data);
        i2cCommand          = 2'b11; // receive command
        i2cWriteData        = {7'b0, ack};
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;
        wait(!i2cBusy);
        data                = i2cReadData;
    endtask


endmodule

