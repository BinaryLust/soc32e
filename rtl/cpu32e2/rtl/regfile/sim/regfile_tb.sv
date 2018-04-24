`timescale 1ns / 1ns


module regfile_tb();
	
	
	/*********************************************************************************************************************************************************/
   /*                                                                                                                                                       */
   /* wire declaration                                                                                                                                      */
   /*                                                                                                                                                       */
	/*********************************************************************************************************************************************************/
	
	
	// input wires
   logic                     clk;
	logic                     reset;
	logic                     writeEnable0;
	logic                     writeEnable1;
	logic             [4:0]   writeAddress0;
	logic             [4:0]   writeAddress1;
	logic             [31:0]  writeData0;
	logic             [31:0]  writeData1;
	logic             [4:0]   readAddress0;
	logic             [4:0]   readAddress1;
	
	
	// output wires
	logic             [31:0]  readData0;
	logic             [31:0]  readData1;
	debug::rfOutputs          debugOut;
	

	/*********************************************************************************************************************************************************/
   /*                                                                                                                                                       */
   /* test module instantiation                                                                                                                             */
   /*                                                                                                                                                       */
	/*********************************************************************************************************************************************************/
	
	
	//regfile
	regfileDebug
	dut(
      .clk,
		.reset,
	   .writeEnable0,
	   .writeEnable1,
	   .writeAddress0,
	   .writeAddress1,
	   .writeData0,
	   .writeData1,
	   .readAddress0,
	   .readAddress1,
	   .readData0,
	   .readData1,
		.debugOut
	);


	/*********************************************************************************************************************************************************/
   /*                                                                                                                                                       */
   /* test stimulus                                                                                                                                         */
   /*                                                                                                                                                       */
	/*********************************************************************************************************************************************************/
	
	
	// set initial values
	initial begin
	   reset                = 1'b0;
		writeEnable0         = 1'b0;
	   writeEnable1         = 1'b0;
	   writeAddress0        = 5'b0;
	   writeAddress1        = 5'b0;
	   writeData0           = 32'b0;
	   writeData1           = 32'b0;
	   readAddress0         = 5'b0;
	   readAddress1         = 5'b0;
	end
	
	
	// create clock sources
	initial begin
	   clk = 1'b0;
   end
	
	always begin
	   #5 clk = ~clk;
	end
	
	
	// synopsys translate_off
	integer i;
	integer r0;
	integer r1;
	
	
	// apply test stimulus	
	initial begin		
		reset = 1'b1;
		#100 reset = 1'b0;
		
		
		$display("Single port test starting");
		
		
		for(i = 0; i < 100; i = i + 2) begin
		   r0 = $random;                                 // generate random values
			r1 = $random;
			
			
			doPort0(5'd0, r0);                            // write to one port only
			repeat(2) @(posedge clk);                     // wait 2 cycles
			@(negedge clk);                               // sample result at the negative edge
			if(readData0 != r0 || readData1 != r0)        // check result
			   $error("Error on port 0, %d, %d, %d", readData0, readData1, r0);  // print an error if the result was incorrect
			
			
			doPort1(5'd0, r1);                            // write to one port only
			repeat(2) @(posedge clk);                     // wait 2 cycles
			@(negedge clk);                               // sample result at the negative edge
			if(readData0 != r1 || readData1 != r1)        // check result
			   $error("Error on port 1, %d, %d, %d", readData0, readData1, r1);  // print an error if the result was incorrect
      end
		
		
		for(i = 0; i < 100; i = i + 1) begin
		   r0 = $random;                                 // generate random values
			r1 = $random;
			
			
			doBoth(5'd0, r0, 5'd0, r1);                   // write to the same address on both ports
			repeat(2) @(posedge clk);                     // wait 2 cycles
			@(negedge clk);                               // sample result at the negative edge
			if(readData0 != r0 || readData1 != r0)        // check result
			   $error("Error when writting both ports, %d, %d, %d, %d", readData0, readData1, r0, r1);  // print an error if the result was incorrect
		end
		
		
		readAddress0  = 5'd1;
		readAddress1  = 5'd2;
		
		
		for(i = 0; i < 100; i = i + 1) begin
   	   r0 = $random;                                 // generate random values
			r1 = $random;
			
			doBoth(5'd1, r0, 5'd2, r1);                   // write to different ports
			repeat(2) @(posedge clk);                     // wait 2 cycles
			@(negedge clk);                               // sample result at the negative edge
			if(readData0 != r0 || readData1 != r1)        // check result
			   $error("Error when writting different ports, %d, %d, %d, %d", readData0, readData1, r0, r1);  // print an error if the result was incorrect
      end
		
		
		$stop;
	end
   
	// synopsys translate_on
	
	
	/*********************************************************************************************************************************************************/
   /*                                                                                                                                                       */
   /* tasks                                                                                                                                                 */
   /*                                                                                                                                                       */
	/*********************************************************************************************************************************************************/
	
	
	/*task doReset;
	   begin
		   @(posedge clk);
			reset = 1'b1;
			@(posedge clk);
			reset = 1'b0;
		end
	endtask*/
	
	
	task doPort0;
      input [4:0]   wrAddress0;
		input [31:0]  wrData0;
	   begin
         @(posedge clk);
			#1 writeEnable0  = 1'b1;
			   writeEnable1  = 1'b0;
			   writeAddress0 = wrAddress0;
				writeAddress1 = 5'd0;
			   writeData0    = wrData0;
				writeData1    = 32'd0;
			   readAddress0  = wrAddress0;
			   readAddress1  = wrAddress0;
		end
	endtask
	
	
	task doPort1;
      input [4:0]   wrAddress1;
		input [31:0]  wrData1;
	   begin
         @(posedge clk);
			#1 writeEnable0  = 1'b0;
			   writeEnable1  = 1'b1;
			   writeAddress0 = 5'd0;
				writeAddress1 = wrAddress1;
			   writeData0    = 32'd0;
				writeData1    = wrData1;
			   readAddress0  = wrAddress1;
			   readAddress1  = wrAddress1;
		end
	endtask
	
	
	task doBoth;
      input [4:0]   wrAddress0;
		input [31:0]  wrData0;
		input [4:0]   wrAddress1;
		input [31:0]  wrData1;
	   begin
         @(posedge clk);
			#1 writeEnable0  = 1'b1;
			   writeEnable1  = 1'b1;
			   writeAddress0 = wrAddress0;
				writeAddress1 = wrAddress1;
			   writeData0    = wrData0;
				writeData1    = wrData1;
		end
	endtask
	
	
endmodule

