

package executeGroup;


    import boolPkg::*;
    import aluPkg::*;
	 import shifterPkg::*;
	 //import dividerPkg::*;
	 
	 
	 // control group structure
	 typedef struct packed {
		  bool                    aluStart;
		  aluPkg::aluOpSel        aluOp;
		  bool                    shifterStart;
		  shifterPkg::shiftOpSel  shiftOp;
        bool                    sign;
		  bool                    multiplierStart;
		  bool                    dividerStart;
	 } controlBus;
	 
	 
	 // control group macro values
	 localparam controlBus
	     NO_OP   = '{aluStart:F, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_ADD  = '{aluStart:T, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_ADC  = '{aluStart:T, aluOp:ADC, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_SUB  = '{aluStart:T, aluOp:SUB, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_SBB  = '{aluStart:T, aluOp:SBB, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_AND  = '{aluStart:T, aluOp:AND, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_OR   = '{aluStart:T, aluOp:OR,  shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_XOR  = '{aluStart:T, aluOp:XOR, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_NOT  = '{aluStart:T, aluOp:NOT, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_SHL  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_SHR  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:SHR, sign:F, multiplierStart:F, dividerStart:F},
		  DO_SAR  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:SAR, sign:F, multiplierStart:F, dividerStart:F},
		  DO_ROL  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:ROL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_ROR  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:ROR, sign:F, multiplierStart:F, dividerStart:F},
		  DO_RCL  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:RCL, sign:F, multiplierStart:F, dividerStart:F},
		  DO_RCR  = '{aluStart:F, aluOp:ADD, shifterStart:T, shiftOp:RCR, sign:F, multiplierStart:F, dividerStart:F},
		  DO_UMUL = '{aluStart:F, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:T, dividerStart:F},
		  DO_SMUL = '{aluStart:F, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:T, multiplierStart:T, dividerStart:F},
		  DO_UDIV = '{aluStart:F, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:F, multiplierStart:F, dividerStart:T},
        DO_SDIV = '{aluStart:F, aluOp:ADD, shifterStart:F, shiftOp:SHL, sign:T, multiplierStart:F, dividerStart:T};
		  
		  
endpackage


module execute(
    input   logic                             clk,
	 input   logic                             reset,
	 input   executeGroup::controlBus          executeControl,
    input   logic                     [31:0]  aRegister,
	 input   logic                     [31:0]  bRegister,
	 input   logic                             carryFlag,
	 
	 output  logic                     [31:0]  aluResult,
	 output  logic                             aluCarry,
	 output  logic                             aluOverflow,
	 output  logic                             aluDone,
	 output  logic                     [31:0]  shifterResult,
	 output  logic                             shifterCarry,
	 output  logic                             shifterDone,
	 output  logic                     [31:0]  multiplierResultLow,
	 output  logic                     [31:0]  multiplierResultHigh,
	 output  logic                             multiplierDone,
	 output  logic                     [31:0]  dividerQuotient,
	 output  logic                     [31:0]  dividerRemainder,
	 output  logic                             dividerDone,
	 output  logic                             dividerError
	 );


    // alu
	 alu
	 alu(
        .clk,
	     .aluOp                  (executeControl.aluOp),
	     .aluStart               (executeControl.aluStart),
	     .carryIn                (carryFlag),
	     .operandA               (aRegister),
	     .operandB               (bRegister),
	     .aluCarry,
	     .aluResult,
	     .aluOverflow,
	     .aluDone
    );
	 
	 
	 // shifter
	 shifter
	 shifter(
        .clk,
		  .reset,
        .shiftOp                (executeControl.shiftOp),
	     .shifterStart           (executeControl.shifterStart),
	     .shiftCount             (bRegister[4:0]),
	     .carryIn                (carryFlag),
	     .operand                (aRegister),
	     .shifterCarry,
	     .shifterResult,
	     .shifterDone
	 );
	 
	 
	 // multiplier
	 multiplier
	 multiplier(
        .clk,
		  .reset,
	     .sign                   (executeControl.sign),
	     .multiplierStart        (executeControl.multiplierStart),
	     .operandA               (aRegister),
	     .operandB               (bRegister),
	     .multiplierResultHigh,
        .multiplierResultLow,
	     .multiplierDone
    );
	 

	 // divider
	 divider2
	 divider(
        .clk,
	     .reset,
	     .dividendIn             (aRegister),
	     .divisorIn              (bRegister),
	     .sign                   (executeControl.sign),
	     .dividerStart           (executeControl.dividerStart),
	     .quotientOut            (dividerQuotient),
	     .remainderOut           (dividerRemainder),
	     .dividerError,
	     .dividerDone
    );

	 
endmodule

