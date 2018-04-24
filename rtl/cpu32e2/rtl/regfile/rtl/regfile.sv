

/*********************************************************************************************************************************************************/
/* if you do a (rdw) read-during-write access you will get the old data out instead of the new data unless you forward the data                          */
/* if you do a (raw) read-after-write access you will get the new data out                                                                               */
/* no forwarding has been implemented here yet                                                                                                           */
/* there is a 2 cycle delay between when a value is latched on the inputs and when it shows up on the outputs                                            */
/* when using this in a pipeline we might have to add forwarding to it                                                                                   */
/*********************************************************************************************************************************************************/


module regfile(
    input   logic          clk,
	 input   logic          reset,
	 input   logic          writeEnableA,
	 input   logic          writeEnableB,
	 input   logic  [4:0]   writeAddressA,
	 input   logic  [4:0]   writeAddressB,
	 input   logic  [31:0]  writeDataA,
	 input   logic  [31:0]  writeDataB,
	 input   logic  [4:0]   readAddressA,
	 input   logic  [4:0]   readAddressB,
	
	 output  logic  [31:0]  readDataA,
	 output  logic  [31:0]  readDataB
	 );

	
	 logic          writeEnableAReg;
	 logic          writeEnableBReg;
	 logic  [4:0]   writeAddressAReg;
	 logic  [4:0]   writeAddressBReg;
	 logic  [4:0]   readAddressAReg;
	 logic  [4:0]   readAddressBReg;
	 logic          bankSelectA;
	 logic          bankSelectB;
    logic  [31:0]  bankADataA;
	 logic  [31:0]  bankADataB;
	 logic  [31:0]  bankBDataA;
	 logic  [31:0]  bankBDataB;
	
	
	 regfileInputRegisters
	 regfileInputRegisters(
        .clk,
	     .reset,
	     .writeEnableA,
	     .writeEnableB,
	     .writeAddressA,
	     .writeAddressB,
	     .readAddressA,
	     .readAddressB,
	     .writeEnableAReg,
	     .writeEnableBReg,
	     .writeAddressAReg,
	     .writeAddressBReg,
	     .readAddressAReg,
	     .readAddressBReg
	 );
	
	
	 regfileLiveValueTable
	 regfileLiveValueTable(
        .clk,
		  .reset,
	     .writeEnableA   (writeEnableAReg),
	     .writeEnableB   (writeEnableBReg),
	     .writeAddressA  (writeAddressAReg),
	     .writeAddressB  (writeAddressBReg),
	     .readAddressA   (readAddressAReg),
	     .readAddressB   (readAddressBReg),
	     .bankSelectA,
	     .bankSelectB
	 );
	
	
    regfileBank
	 regfileBankA(
        .clk,
	     .writeEnable    (writeEnableA),
	     .writeAddress   (writeAddressA),
	     .writeData      (writeDataA),
	     .readAddressA,
	     .readAddressB,
	     .readDataA      (bankADataA),
	     .readDataB      (bankADataB)
	 );
	
	
	 regfileBank
	 regfileBankB(
        .clk,
	     .writeEnable    (writeEnableB),
	     .writeAddress   (writeAddressB),
	     .writeData      (writeDataB),
	     .readAddressA,
	     .readAddressB,
	     .readDataA      (bankBDataA),
	     .readDataB      (bankBDataB)
	 );
	
	
	 assign readDataA = (bankSelectA) ? bankBDataA : bankADataA;
	 assign readDataB = (bankSelectB) ? bankBDataB : bankADataB;
	
	
endmodule

