

`include "E:/My Code/on git/systemverilog/soc32e/rtl/cpu32e2/rtl/globals.sv"


package systemGroup;

	 
	 import boolPkg::*;
	 
	 
	 // flags mux values
	 typedef enum logic {
	     RESULT = 1'b0,
		  RFB    = 1'b1
	 } flagsMux;
	 
	 
	 // interrupt enable mux values
	 typedef enum logic [1:0] {
	     LOAD  = 2'b00,
		  RESET = 2'b01,
		  SET   = 2'b10
	 } interruptEnableMux;
	 
	 
	 	 // control group structure
	 typedef struct packed {
		  bool                writeEn;
		  bool                flagsEn;
		  bool                systemCallEn;
		  bool                interruptEnableEn;
		  interruptEnableMux  interruptEnableSel;
		  flagsMux            flagsSel;
	 } controlBus;
	 
	 
	 // control group macro values
	 localparam controlBus
	     NO_OP         = '{writeEn:F, flagsEn:F, systemCallEn:F, interruptEnableEn:F, interruptEnableSel:LOAD,  flagsSel:RESULT},
		  WRITE_DRL     = '{writeEn:T, flagsEn:F, systemCallEn:F, interruptEnableEn:F, interruptEnableSel:LOAD,  flagsSel:RFB},
		  WRITE_FLAGS   = '{writeEn:F, flagsEn:T, systemCallEn:F, interruptEnableEn:F, interruptEnableSel:LOAD,  flagsSel:RESULT},
		  WRITE_SYSCALL = '{writeEn:F, flagsEn:F, systemCallEn:T, interruptEnableEn:F, interruptEnableSel:LOAD,  flagsSel:RESULT},
		  RESET_INTEN   = '{writeEn:F, flagsEn:F, systemCallEn:F, interruptEnableEn:T, interruptEnableSel:RESET, flagsSel:RESULT},
		  SET_INTEN     = '{writeEn:F, flagsEn:F, systemCallEn:F, interruptEnableEn:T, interruptEnableSel:SET,   flagsSel:RESULT};
	
	
endpackage


module system(
    input   logic                            clk,
	 input   logic                            reset,
	 input   logic                            exceptionPending,
	 input   systemGroup::controlBus          systemControl,
	 input   logic                    [31:0]  instructionReg,
	 input   logic                    [3:0]   resultFlags,
	 input   logic                    [31:0]  registerFileB,
	 input   logic                    [4:0]   cause,
	 
	 `ifdef  DEBUG
	 output  logic                    [5:0]   systemCallState,
	 `endif
	 
	 output  logic                            interruptEnable,
	 output  logic                    [15:0]  exceptionMask,
	 output  logic                    [31:0]  systemRegister,
	 output  logic                    [3:0]   flags,
	 output  logic                    [31:0]  isrBaseAddress
	 );


	 import systemGroup::*;
	 
	 
	 logic         flagsEn;
	 logic         isrBaseAddressEn;
	 logic         interruptEnableEn;
	 logic         exceptionMaskEn;
	 
	 
    logic  [3:0]  flagsNext;
	 logic         interruptEnableNext;
	 logic  [5:0]  systemCall;
	 
	 
	 `ifdef  DEBUG
	 assign systemCallState = systemCall;
	 `endif
	 
	 
	 // flags register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      flags <= 4'b0;
		  else if((flagsEn && !exceptionPending) || (systemControl.flagsEn && !exceptionPending)) // can be written by either one
		      flags <= flagsNext;
		  else
		      flags <= flags;
	 end
	 
	 
	 // flags mux
	 always_comb begin
	     case(systemControl.flagsSel)
		      RESULT: flagsNext = resultFlags;
				RFB:    flagsNext = registerFileB[3:0];
		  endcase
	 end
	 
	 
	 // system call register
	 always_ff @(posedge clk or posedge reset) begin
	 	  if(reset)
		      systemCall <= 6'b0;
		  else if(systemControl.systemCallEn) // written even on exceptions
		      systemCall <= instructionReg[5:0]; // IMM6
		  else
		      systemCall <= systemCall;
	 end
	 
	 
	 // isr base address register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      isrBaseAddress <= 32'd4;
		  else if(isrBaseAddressEn && !exceptionPending)
		      isrBaseAddress <= registerFileB;
		  else
		      isrBaseAddress <= isrBaseAddress;
	 end
	 
	 
	 // interrupt enable register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      interruptEnable <= 1'b0;
		  else if((interruptEnableEn && !exceptionPending) || (systemControl.interruptEnableEn && !exceptionPending)) // can be written by either one
		      interruptEnable <= interruptEnableNext;
		  else
		      interruptEnable <= interruptEnable;
	 end
	 
	 
	 // interrupt enable mux
	 always_comb begin
	     case(systemControl.interruptEnableSel)
		      LOAD:    interruptEnableNext = registerFileB[15];
				RESET:   interruptEnableNext = 1'b0;
				SET:     interruptEnableNext = 1'b1;
				default: interruptEnableNext = registerFileB[15];
		  endcase
	 end
	 
	 
	 // exception mask register
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      exceptionMask <= 16'b0;
		  else if(exceptionMaskEn && !exceptionPending)
		      exceptionMask <= registerFileB[31:16];
		  else
		      exceptionMask <= exceptionMask;
	 end
	 

	 // write decoder
	 always_comb begin
	     // defaults
		  flagsEn = 1'b0;
		  interruptEnableEn = 1'b0;
		  exceptionMaskEn = 1'b0;
		  isrBaseAddressEn = 1'b0;
		  
	     case({systemControl.writeEn, instructionReg[25:21]}) // DRL
		      {1'b1, 5'd0}: flagsEn = 1'b1;               // sys0 - flags
				{1'b1, 5'd1}: begin
			                     interruptEnableEn = 1'b1;
				                  exceptionMaskEn   = 1'b1;
								  end                           // sys1 - interrupt enable, exception mask
				{1'b1, 5'd2}: isrBaseAddressEn = 1'b1;      // sys2 - isr base address
				default:      begin flagsEn = 1'b0; interruptEnableEn = 1'b0; exceptionMaskEn = 1'b0; isrBaseAddressEn = 1'b0; end
		  endcase
	 end
	 
	 
	 // read mux
	 always_comb begin
	     // default
		  systemRegister = 32'b0;
		  
	     case(instructionReg[15:11]) // SRB
		      5'd0:    systemRegister = {28'b0, flags};
				5'd1:    systemRegister = {exceptionMask, interruptEnable, 10'b0, cause};
				5'd2:    systemRegister = isrBaseAddress;
				5'd3:    systemRegister = {26'b0, systemCall}; // sys3 - system call number
				default: systemRegister = 32'b0;
		  endcase
	 end
	 
	 
endmodule

