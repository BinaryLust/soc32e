

module shifter(
    input   logic                           clk,
	 input   logic                           reset,
    input   shifterPkg::shiftOpSel          shiftOp,
	 input   logic                           shifterStart,
	 input   logic                   [4:0]   shiftCount,
	 input   logic                           carryIn,
	 input   logic                   [31:0]  operand,
	
	 output  logic                           shifterCarry,
	 output  logic                   [31:0]  shifterResult,
	 output  logic                           shifterDone
	 );

	
	 import shifterPkg::*;
	
	
	 logic          carry0;
	 logic          carry1;
	 logic          carry2;
	 logic          carry4;
	 logic          carry8;
	 logic          carry16;
	 logic  [31:0]  data0;
	 logic  [31:0]  data1;
	 logic  [31:0]  data2;
	 logic  [31:0]  data4;
	 logic  [31:0]  data8;
	 logic  [31:0]  data16;

	 
	 // one cycle latency
	 always_ff @(posedge clk or posedge reset) begin
	     if(reset)
		      shifterDone <= 1'b0;
		  else if(shifterStart)
		      shifterDone <= !shifterDone; // done is set every 2nd cycle
		  else
		      shifterDone <= shifterDone;
	 end
	 
	 
	 // assign inputs
	 assign carry0 = carryIn;
	 assign data0  = operand;
	
	
	 // registers
	 always_ff @(posedge clk) begin
	     if(shifterDone) begin
		      shifterCarry  <= carry16;
		      shifterResult <= data16;
		  end else begin
		      shifterCarry  <= shifterCarry;
				shifterResult <= shifterResult;
		  end
	 end
	 
	 
	 shift1
	 shift1(
	     .shiftOp,
		  .shift(shiftCount[0]),
	     .carry0,
	     .data0,
	     .carry1,
	     .data1
	 );
	
	
	 shift2
	 shift2(
	     .shiftOp,
		  .shift(shiftCount[1]),
	     .carry1,
	     .data1,
	     .carry2,
	     .data2
	 );
	
	
	 shift4
	 shift4(
	     .shiftOp,
		  .shift(shiftCount[2]),
	     .carry2,
	     .data2,
	     .carry4,
	     .data4
	 );
	
	
	 shift8
	 shift8(
	     .shiftOp,
		  .shift(shiftCount[3]),
	     .carry4,
	     .data4,
	     .carry8,
	     .data8
	 );
	
	
	 shift16
	 shift16(
	     .shiftOp,
		  .shift(shiftCount[4]),
	     .carry8,
	     .data8,
	     .carry16,
	     .data16
	 );
	
	
endmodule

