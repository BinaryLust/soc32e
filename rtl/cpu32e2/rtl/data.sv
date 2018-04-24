

package dataGroup;
	 
	 
	 import boolPkg::*;
	 
	 
	 // write data mux values
	 typedef enum logic [1:0] {
	     DWORD  = 2'b00,
		  WORD   = 2'b01,
		  BYTE   = 2'b10
	 } writeDataMux;
	 
	 
	 // control group structure
	 typedef struct packed {
		  bool          instructionRegEn;
		  bool          dataInEn;
		  bool          dataOutEn;
		  writeDataMux  writeDataSel;
	 } controlBus;
	 
	 
	 // control group macro values
	 localparam controlBus
	     NO_OP       = '{instructionRegEn:F, dataInEn:F, dataOutEn:F, writeDataSel:DWORD},
		  READ_INSTR  = '{instructionRegEn:T, dataInEn:F, dataOutEn:F, writeDataSel:DWORD},
		  READ_DATA   = '{instructionRegEn:F, dataInEn:T, dataOutEn:F, writeDataSel:DWORD},
		  WRITE_DWORD = '{instructionRegEn:F, dataInEn:F, dataOutEn:T, writeDataSel:DWORD},
		  WRITE_WORD  = '{instructionRegEn:F, dataInEn:F, dataOutEn:T, writeDataSel:WORD},
		  WRITE_BYTE  = '{instructionRegEn:F, dataInEn:F, dataOutEn:T, writeDataSel:BYTE};


endpackage


module data(
    input   logic                          clk,
	 input   logic                          reset,
	 input   dataGroup::controlBus          dataControl,
	 input   logic                  [31:0]  dataIn,
	 input   logic                  [31:0]  registerFileB,
	 output  logic                  [31:0]  instructionReg,
	 output  logic                  [31:0]  dataInReg,
	 output  logic                  [31:0]  dataOut
	 );
	 
	 
	 import dataGroup::*;
	 
	 
	 logic  [31:0]  dataOutNext;
	 
	 
	 // Registers
	 always_ff @(posedge clk) begin
		  if(dataControl.instructionRegEn)
		      instructionReg <= dataIn;
		  else
		      instructionReg <= instructionReg;
		  
		  
		  if(dataControl.dataInEn)
		      dataInReg      <= dataIn;
		  else
		      dataInReg      <= dataInReg;
	 end
	 
	 
	 always_ff @(posedge clk or posedge reset) begin
		  if(reset)
		      dataOut        <= 32'b0;
		  else if(dataControl.dataOutEn)
		      dataOut        <= dataOutNext;
		  else
		      dataOut        <= dataOut;
	 end
	 
	 
	 // Combinational Logic
	 always_comb begin
	     
		  // write data mux
		  case(dataControl.writeDataSel)
		      DWORD:   dataOutNext = registerFileB;
				WORD:    dataOutNext = {2{registerFileB[15:0]}};
				BYTE:    dataOutNext = {4{registerFileB[7:0]}};
		      default: dataOutNext = registerFileB;
		  endcase
		  
	 end
	 
	 
endmodule

