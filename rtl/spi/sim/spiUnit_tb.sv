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
    logic  [15:0]  clocksPerCycle;
	logic          clockPolarity;
	logic          clockPhase;
	logic          dataDirection;
	logic          transmitValid;
	logic  [11:0]  dataRegIn;
	logic          miso;

	 
	// output wires
	logic  [11:0]  dataReg;
	logic          transmitReady;
	logic          receiveValid;
	logic          mosi;
	logic          sclk;
	logic          ss;

	
	/*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
	/*********************************************************************************************************************************************************/

    spiUnit #(.DATAWIDTH(12))
	dut(
        .clk,
	    .reset,
        .clocksPerCycle,
	    .clockPolarity,
	    .clockPhase,
	    .dataDirection,
	    .transmitValid,
	    .dataRegIn,
	    .dataReg,
	    .transmitReady,
	    .receiveValid,
	    .miso,
	    .mosi,
	    .sclk,
		.ss
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
        clocksPerCycle = 16'd8;
	    clockPolarity  = 1'b1;
	    clockPhase     = 1'b1;
	    dataDirection  = 1'b1;
	    transmitValid  = 1'b1;
	    dataRegIn      = 8'haa;
	    //miso           = 1'b1;
	end
	
	
	// create clock sources
	always begin
	    #5;
	    clk = 1'b0;
	    #5;
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
		
		repeat(10) begin
		    @(posedge transmitReady);
		    dataRegIn = $urandom();
			//@(posedge clk);
		end
		
		transmitValid = 1'b0;
		repeat(500) @(posedge clk);
		transmitValid = 1'b1;
		
		repeat(10) begin
		    @(posedge transmitReady);
		    dataRegIn = $urandom();
			//@(posedge clk);
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

