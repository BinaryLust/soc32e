`timescale 1ns / 100ps


module ethernetSmiUnit_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // input wires
    logic               clk;
    logic               reset;
    logic  [31:0]       transmitData;
    logic               finalCycle;
    logic               transmitValid;


    // output wires
    logic  [15:0]       receiveData;
    logic               transmitReady;
    logic               receiveValid;
    logic               busy;
    logic               mdc;


    // inout wires
    wire                mdio;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    ethernetSmiUnit
    dut(
        .clk,
        .reset,
        .transmitData,
        .receiveData,
        .finalCycle,
        .transmitValid,
        .transmitReady,
        .receiveValid,
        .busy,
        .mdc,
        .mdio
    );


    pullup(mdio);


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer          seed     = 125376;
    logic    [27:0]  rdata;


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset          = 1'b0;
        finalCycle     = 1'b0;
        transmitData   = 32'b0000_0000;
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
            //finalCycle = 1'b0;
        //end else begin
            repeat(249) @(posedge clk);
            finalCycle = 1'b1;
            @(posedge clk);
            finalCycle = 1'b0;
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

        // write data
        transmit(32'b0);
        transmit(32'hffffffff);

        repeat(16) begin
            rdata = $random;
            transmit({2'b01, 2'b00, rdata});
            rdata = $random;
            transmit({2'b01, 2'b01, rdata});
            rdata = $random;
            transmit({2'b01, 2'b11, rdata});

            // wait some time
            //repeat(1000) @(posedge clk);
        end

        // read data
        repeat(16) begin
            rdata = $random;
            transmit({2'b01, 2'b10, rdata});

            // wait some time
            //repeat(1000) @(posedge clk);
        end

        // wait some time
        repeat(100000) @(posedge clk);

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


    task transmit(input logic [31:0] data);
        transmitData        = data;
        transmitValid       = 1'b1;
        @(posedge transmitReady);
        transmitValid       = 1'b0;
        @(negedge busy);
    endtask


    task receive(input logic [31:0] data);//, output logic [31:0] dataOut);
        transmitData        = data;
        transmitValid       = 1'b1;
        @(posedge transmitReady);
        transmitValid       = 1'b0;
        @(negedge busy);
        //dataOut                = receiveData;
    endtask


endmodule

