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
        reset               = 1'b0;
        i2cCommand          = 2'b00;
        i2cWriteData        = 8'b0000_0000;
        i2cTransactionValid = 1'b0;
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    always begin
        //if(reset) begin
            //cycleDone = 1'b0;
        //end else begin
            
            repeat(15) @(posedge clk);
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

        /*for(i = 0; i < 512; i = i + 1) begin
           write(32'hff, 32'd4);
        end*/

        /*for(i = 0; i < 512; i = i + 1) begin
        //   read(32'd3);
        //	while(data_out && 32'b10) begin
        //	   read(32'd3);
        //	end

            read(32'd5);
        end*/

        wait(!i2cBusy);
        i2cCommand          = 2'b00; // send start command
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;

        // transmit some data
        repeat(10) begin
            wait(!i2cBusy);
            i2cCommand          = 2'b10;      // send transmit command
            i2cWriteData        = $urandom();
            i2cTransactionValid = 1'b1;
            wait(i2cBusy);
            i2cTransactionValid = 1'b0;
        end

        // wait some time
        repeat(50) @(posedge cycleDone);

        // send a single command
        wait(!i2cBusy);
        i2cCommand          = 2'b10;      // send transmit command
        i2cWriteData        = $urandom();
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;

        // wait some time
        repeat(50) @(posedge cycleDone);

        // transmit more data
        repeat(10) begin
            wait(!i2cBusy);
            i2cCommand          = 2'b10;      // send transmit command
            i2cWriteData        = $urandom();
            i2cTransactionValid = 1'b1;
            wait(i2cBusy);
            i2cTransactionValid = 1'b0;
        end

        // send stop command
        wait(!i2cBusy);
        i2cCommand          = 2'b01;
        i2cTransactionValid = 1'b1;
        wait(i2cBusy);
        i2cTransactionValid = 1'b0;

        // wait some time
        repeat(100) @(posedge cycleDone);

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


    /*task write;
       input [31:0] data;
        input [31:0] address;
       begin
           @(posedge iclk); // wait for clk edge
            #1 ce_in = 1'b1; mem_in = 1'b1; write_in = 1'b1; address_in = (address << 2); bwe_in = 4'b1111;
            @(posedge iclk); // wait for clk edge
            #1 data_in = data; ce_in = 1'b0; mem_in = 1'b0; write_in = 1'b0; address_in = 32'b0; bwe_in = 4'b0;
        end
    endtask*/


    /*task read;
        input [31:0] address;
       begin
           @(posedge iclk); // wait for clk edge
            #1 ce_in = 1'b1; mem_in = 1'b1; read_in = 1'b1; address_in = (address << 2);
            @(posedge iclk); // wait for clk edge
            #1 ce_in = 1'b0; mem_in = 1'b0; read_in = 1'b0; address_in = 32'b0;
        end
    endtask*/


endmodule

