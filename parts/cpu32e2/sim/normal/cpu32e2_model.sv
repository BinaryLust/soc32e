

package cpu32e2_modelPkg;


    import architecture::*;


    class cpu32e2_model;


        // machine state
        logic  [31:0][31:0]    regfile;
        logic  [31:0]          nextPC;
        logic                  carryFlag;
        logic                  zeroFlag;
        logic                  overflowFlag;
        logic                  negativeFlag;
        logic  [4:0]           cause;
        logic                  interruptEn;
        logic  [15:0]          exceptionMask;
        logic  [5:0]           systemCall;
        logic  [31:0]          isrBaseAddress;


        // memory state
        logic  [1023:0][31:0]  memory;


        // hidden state
        logic       [31:0]  operandA;
        logic       [31:0]  operandB;
        logic       [63:0]  result;
        logic       [31:0]  address;

        // instruction fields
        logic       [5:0]   opcode;
        logic       [5:0]   rcode;
        conditions          condition;

        logic       [4:0]   drl;
        logic       [4:0]   drh;
        logic       [4:0]   sra;
        logic       [4:0]   srb;

        logic       [31:0]  imm16a;
        logic       [31:0]  imm16b;
        logic       [15:0]  imm16c;
        logic       [31:0]  imm21a;
        logic       [31:0]  imm21b;
        logic       [31:0]  imm21c;
        logic       [31:0]  imm5;
        logic       [5:0]   imm6;
        logic       [31:0]  imm19;
        logic       [31:0]  imm24;


        // constructor
        function new();
            doReset();
        endfunction


        function doReset();
            // reset all machine state and memory state
            regfile        = {32{32'b0}};
            nextPC         = 32'b0;
            carryFlag      = 1'b0;
            zeroFlag       = 1'b0;
            overflowFlag   = 1'b0;
            negativeFlag   = 1'b0;
            cause          = 5'b0;
            interruptEn    = 1'b0;
            exceptionMask  = 16'b0;
            systemCall     = 6'b0;
            isrBaseAddress = 32'd4;

            memory         = {4096{32'b0}};
        endfunction


        function run(
            logic  [31:0]  instruction = 32'b0
            );
            // fetching is skipped because we are directly feeding an instruction in
            // always write regfile[srb] first so that if regfile[sra] writes the same address it will get final priority and overwrites the value


            // extract data from instruction fields
            opcode    = instruction[31:26];
            rcode     = instruction[5:0];
            condition = conditions'(instruction[9:6]);
            drl       = instruction[25:21];
            drh       = instruction[10:6];
            sra       = instruction[20:16];
            srb       = instruction[15:11];

            imm16a = {{16{instruction[15]}}, instruction[15:0]};                                              // bits[15:0] sign extended to bits[31:0]
            imm16b = {{16{instruction[25]}}, instruction[25:21], instruction[10:0]};                          // {bits[25:21], bits[10:0]} sign extended to bits[31:0]
            imm16c = {instruction[20:16],    instruction[10:0]};                                              // {bits[20:16], bits[10:0]}
            imm21a = {{11{instruction[25]}}, instruction[25:21], instruction[15:0]};                          // {bits[25:21], bits[15:0]} sign extended to bits[31:0]
            imm21b = {{11{instruction[20]}}, instruction[20:0]};                                              // bits[20:0] sign extended to bits[31:0]
            imm21c = {{11{instruction[25]}}, instruction[25:16], instruction[10:0]};                          // {bits[25:16], bits[10:0]} sign extended to bits[31:0]
            imm5   = {27'b0, instruction[10:6]};                                                              // bits[10:6] zero extended to bits[31:0]
            imm6   = instruction[5:0];
            imm19  = {{13{instruction[25]}}, instruction[25:21], instruction[15:10], instruction[5:0], 2'b0}; // {bits[25:21], bits[15:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            imm24  = {{8{instruction[25]}},  instruction[25:10], instruction[5:0], 2'b0};                     // {bits[25:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's

            // increment next pc
            nextPC += 32'd4;

            // decode and run
            casex({opcode, rcode})
                ADC_I:   execute_AdcImm();
                ADC_R:   execute_AdcReg();
                ADD_I:   execute_AddImm();
                ADD_R:   execute_AddReg();
                AND_I:   execute_AndImm();
                AND_R:   execute_AndReg();
                BR_PR:   execute_BrPcr();
                BR_R:    execute_BrReg();
                BR_RO:   execute_BrRgo();
                BREAK_R: execute_Break();
                BRL_PR:  execute_BrlPcr();
                BRL_R:   execute_BrlReg();
                BRL_RO:  execute_BrlRgo();
                CMP_I:   execute_CmpImm();
                CMP_R:   execute_CmpReg();
                INT_I:   execute_IntImm();
                IRET_R:  execute_IretReg();
                LDBS_PR: execute_LdbsPcr();
                LDBS_R:  execute_LdbsReg();
                LDBS_RO: execute_LdbsRgo();
                LDBS_IA: execute_LdbsIa();
                LDBS_IB: execute_LdbsIb();
                LDBU_PR: execute_LdbuPcr();
                LDBU_R:  execute_LdbuReg();
                LDBU_RO: execute_LdbuRgo();
                LDBU_IA: execute_LdbuIa();
                LDBU_IB: execute_LdbuIb();
                LDD_PR:  execute_LddPcr();
                LDD_R:   execute_LddReg();
                LDD_RO:  execute_LddRgo();
                LDD_IA:  execute_LddIa();
                LDD_IB:  execute_LddIb();
                LDWS_PR: execute_LdwsPcr();
                LDWS_R:  execute_LdwsReg();
                LDWS_RO: execute_LdwsRgo();
                LDWS_IA: execute_LdwsIa();
                LDWS_IB: execute_LdwsIb();
                LDWU_PR: execute_LdwuPcr();
                LDWU_R:  execute_LdwuReg();
                LDWU_RO: execute_LdwuRgo();
                LDWU_IA: execute_LdwuIa();
                LDWU_IB: execute_LdwuIb();
                MOV_I:   execute_MovImm();
                MOV_R:   execute_MovReg();
                MUI_I:   execute_MuiImm();
                NOP_R:   execute_NopReg();
                NOT_R:   execute_NotReg();
                OR_I:    execute_OrImm();
                OR_R:    execute_OrReg();
                RCL_I:   execute_RclImm();
                RCL_R:   execute_RclReg();
                RCR_I:   execute_RcrImm();
                RCR_R:   execute_RcrReg();
                ROL_I:   execute_RolImm();
                ROL_R:   execute_RolReg();
                ROR_I:   execute_RorImm();
                ROR_R:   execute_RorReg();
                LSR_R:   execute_LsrReg();
                SAR_I:   execute_SarImm();
                SAR_R:   execute_SarReg();
                SBB_I:   execute_SbbImm();
                SBB_R:   execute_SbbReg();
                SDIV_R:  execute_SdivReg();
                SHL_I:   execute_ShlImm();
                SHL_R:   execute_ShlReg();
                SHR_I:   execute_ShrImm();
                SHR_R:   execute_ShrReg();
                SMUL_R:  execute_SmulReg();
                SSR_R:   execute_SsrReg();
                STB_PR:  execute_StbPcr();
                STB_R:   execute_StbReg();
                STB_RO:  execute_StbRgo();
                STB_IA:  execute_StbIa();
                STB_IB:  execute_StbIb();
                STD_PR:  execute_StdPcr();
                STD_R:   execute_StdReg();
                STD_RO:  execute_StdRgo();
                STD_IA:  execute_StdIa();
                STD_IB:  execute_StdIb();
                STW_PR:  execute_StwPcr();
                STW_R:   execute_StwReg();
                STW_RO:  execute_StwRgo();
                STW_IA:  execute_StwIa();
                STW_IB:  execute_StwIb();
                SUB_I:   execute_SubImm();
                SUB_R:   execute_SubReg();
                TEQ_I:   execute_TeqImm();
                TEQ_R:   execute_TeqReg();
                TST_I:   execute_TstImm();
                TST_R:   execute_TstReg();
                UADC_I:  execute_UadcImm();
                UADC_R:  execute_UadcReg();
                UADD_I:  execute_UaddImm();
                UADD_R:  execute_UaddReg();
                UCMP_I:  execute_UcmpImm();
                UCMP_R:  execute_UcmpReg();
                UDIV_R:  execute_UdivReg();
                UMUL_R:  execute_UmulReg();
                USBB_I:  execute_UsbbImm();
                USBB_R:  execute_UsbbReg();
                USUB_I:  execute_UsubImm();
                USUB_R:  execute_UsubReg();
                XOR_I:   execute_XorImm();
                XOR_R:   execute_XorReg();
                default: execute_Unk();
            endcase
        endfunction


        function bit checkCondition();
            bit conditionResult;

            case(condition)
                UNCONDITIONAL:    conditionResult = 1'b1;
                ZERO:             conditionResult = (zeroFlag)                                    ? 1'b1 : 1'b0;
                NOTZERO:          conditionResult = (!zeroFlag)                                   ? 1'b1 : 1'b0;
                CARRY:            conditionResult = (carryFlag)                                   ? 1'b1 : 1'b0;
                NOTCARRY:         conditionResult = (!carryFlag)                                  ? 1'b1 : 1'b0;
                OVERFLOW:         conditionResult = (overflowFlag)                                ? 1'b1 : 1'b0;
                NOTOVERFLOW:      conditionResult = (!overflowFlag)                               ? 1'b1 : 1'b0;
                NEGATIVE:         conditionResult = (negativeFlag)                                ? 1'b1 : 1'b0;
                NOTNEGATIVE:      conditionResult = (!negativeFlag)                               ? 1'b1 : 1'b0;
                GREATER_U:        conditionResult = (carryFlag && !zeroFlag)                      ? 1'b1 : 1'b0;
                LESSOREQUAL_U:    conditionResult = (!carryFlag || zeroFlag)                      ? 1'b1 : 1'b0;
                GREATER_S:        conditionResult = (!zeroFlag && (negativeFlag == overflowFlag)) ? 1'b1 : 1'b0;
                LESS_S:           conditionResult = (negativeFlag != overflowFlag)                ? 1'b1 : 1'b0;
                GREATEROREQUAL_S: conditionResult = (negativeFlag == overflowFlag)                ? 1'b1 : 1'b0;
                LESSOREQUAL_S:    conditionResult = (zeroFlag && (negativeFlag != overflowFlag))  ? 1'b1 : 1'b0;
                default:          conditionResult = 1'b0;
            endcase

            return conditionResult;
        endfunction


        function logic addFlags();
            carryFlag    = result[32];
            zeroFlag     = ~|result[31:0];
            overflowFlag = (operandA[31] & operandB[31] & ~result[31]) | (~operandA[31] & ~operandB[31] & result[31]);
            negativeFlag = result[31];
        endfunction


        function logic subFlags();
            carryFlag    = ~result[32];
            zeroFlag     = ~|result[31:0];
            overflowFlag = (operandA[31] & ~operandB[31] & ~result[31]) | (~operandA[31] & operandB[31] & result[31]);
            negativeFlag = result[31];
        endfunction


        function logic logicFlags();
            carryFlag    = 1'b0;
            zeroFlag     = ~|result[31:0];
            overflowFlag = 1'b0;
            negativeFlag = result[31];
        endfunction


        function logic lShiftFlags();
            carryFlag    = (operandB[4:0] == 5'b0) ? carryFlag : operandA[32-operandB[4:0]];
            zeroFlag     = ~|result[31:0];
            overflowFlag = 1'b0;
            negativeFlag = result[31];
        endfunction


        function logic rShiftFlags();
            carryFlag    = (operandB[4:0] == 5'b0) ? carryFlag : operandA[operandB[4:0]-1];
            zeroFlag     = ~|result[31:0];
            overflowFlag = 1'b0;
            negativeFlag = result[31];
        endfunction


        function logic mulFlags();
            carryFlag    = 1'b0;
            zeroFlag     = ~|result[63:0];
            overflowFlag = 1'b0;
            negativeFlag = result[63];
        endfunction


        function execute_Unk();

        endfunction


        function execute_AdcImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA + operandB + carryFlag;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_AdcReg();
             operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA + operandB + carryFlag;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


         function execute_AddImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA + operandB;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_AddReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = operandA + operandB;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_UadcImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA + operandB + carryFlag;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_UadcReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA + operandB + carryFlag;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


         function execute_UaddImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA + operandB;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_UaddReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = operandA + operandB;

            regfile[drl] = result[31:0];
            addFlags();
        endfunction


        function execute_SbbImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = (operandA + ~operandB) + carryFlag;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_SbbReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + carryFlag;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_SubImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = (operandA + ~operandB) + 1'b1;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_SubReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + 1'b1;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_UsbbImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = (operandA + ~operandB) + carryFlag;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_UsbbReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + carryFlag;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_UsubImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = (operandA + ~operandB) + 1'b1;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_UsubReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + 1'b1;

            regfile[drl] = result[31:0];
            subFlags();
        endfunction


        function execute_CmpImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            result       = (operandA + ~operandB) + 1'b1;

            subFlags();
        endfunction


        function execute_CmpReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + 1'b1;

            subFlags();
        endfunction


        function execute_UcmpImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            result       = (operandA + ~operandB) + 1'b1;

            subFlags();
        endfunction


        function execute_UcmpReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
             result       = (operandA + ~operandB) + 1'b1;

            subFlags();
        endfunction


        function execute_SmulReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = signed'(operandA) * signed'(operandB);

            regfile[drh] = result[63:32];
            regfile[drl] = result[31:0];
            mulFlags();
        endfunction


        function execute_UmulReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = unsigned'(operandA) * unsigned'(operandB);

            regfile[drh] = result[63:32];
            regfile[drl] = result[31:0];
            mulFlags();
        endfunction


        function execute_SdivReg();
            operandA      = regfile[sra];
            operandB      = regfile[srb];
              result[63:32] = (operandB == 32'b0) ? 32'b0 : signed'(signed'(operandA) % signed'(operandB));
            result[31:0]  = (operandB == 32'b0) ? 32'b0 : signed'(signed'(operandA) / signed'(operandB));

            regfile[drh]  = result[63:32];
            regfile[drl]  = result[31:0];
        endfunction


        function execute_UdivReg();
            operandA      = regfile[sra];
            operandB      = regfile[srb];
              result[63:32] = (operandB == 32'b0) ? 32'b0 : unsigned'(unsigned'(operandA) % unsigned'(operandB));
            result[31:0]  = (operandB == 32'b0) ? 32'b0 : unsigned'(unsigned'(operandA) / unsigned'(operandB));

            regfile[drh]  = result[63:32];
            regfile[drl]  = result[31:0];
        endfunction


        function execute_AndImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA & operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_AndReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA & operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_NotReg();
            operandB     = regfile[srb];
            result       = ~operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_OrImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA | operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_OrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA | operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_XorImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            result       = operandA ^ operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_XorReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA ^ operandB;

            regfile[drl] = result[31:0];
            logicFlags();
        endfunction


        function execute_TeqImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            result       = operandA ^ operandB;

            logicFlags();
        endfunction


        function execute_TeqReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA ^ operandB;

            logicFlags();
        endfunction


        function execute_TstImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            result       = operandA & operandB;

            logicFlags();
        endfunction


        function execute_TstReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA & operandB;

            logicFlags();
        endfunction


        function execute_ShlImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = operandA << operandB[4:0];

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_ShlReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA << operandB[4:0];

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_ShrImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = operandA >> operandB[4:0];

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_ShrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = operandA >> operandB[4:0];

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_SarImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = unsigned'(signed'(operandA) >>> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_SarReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = unsigned'(signed'(operandA) >>> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_RolImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = (operandA << operandB[4:0]) | (operandA >> (32-operandB[4:0]));

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_RolReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = (operandA << operandB[4:0]) | (operandA >> (32-operandB[4:0]));

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_RorImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = (operandA << (32-operandB[4:0])) | (operandA >> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_RorReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = (operandA << (32-operandB[4:0])) | (operandA >> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_RclImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = ({carryFlag, operandA} << operandB[4:0]) | ({carryFlag, operandA} >> (33-operandB[4:0])); // 32 or 33 width???

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_RclReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = ({carryFlag, operandA} << operandB[4:0]) | ({carryFlag, operandA} >> (33-operandB[4:0]));

            regfile[drl] = result[31:0];
            lShiftFlags();
        endfunction


        function execute_RcrImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            result       = ({carryFlag, operandA} << (33-operandB[4:0])) | ({carryFlag, operandA} >> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_RcrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            result       = ({carryFlag, operandA} << (33-operandB[4:0])) | ({carryFlag, operandA} >> operandB[4:0]);

            regfile[drl] = result[31:0];
            rShiftFlags();
        endfunction


        function execute_NopReg();

        endfunction


        function execute_Break();

        endfunction


        function execute_IntImm();
            systemCall   = imm6; // written even when interrupts are disabled
        endfunction


        function execute_MovImm();
            operandB     = imm21b;

            regfile[drl] = operandB;
        endfunction


        function execute_MovReg();
            operandB     = regfile[srb];

            regfile[drl] = operandB;
        endfunction


        function execute_MuiImm();
            operandB     = {imm16c, regfile[srb][15:0]};

            regfile[drl] = operandB;
        endfunction


        function execute_LsrReg();
            case(sra)
                5'd0:    operandA = {28'b0, negativeFlag, overflowFlag, zeroFlag, carryFlag};
                5'd1:    operandA = {exceptionMask, interruptEn, 10'b0, cause};
                5'd2:    operandA = isrBaseAddress;
                5'd3:    operandA = {26'b0, systemCall};
                default: operandA = 32'b0;
            endcase

            regfile[drl] = operandA;
        endfunction


        function execute_SsrReg();
            operandA = regfile[sra];

            case(drl)
                5'd0:    begin negativeFlag = operandA[3]; overflowFlag = operandA[2]; zeroFlag = operandA[1]; carryFlag = operandA[0]; end
                5'd1:    begin exceptionMask = operandA[31:16]; interruptEn = operandA[15]; end
                5'd2:    isrBaseAddress = operandA[31:0];
                default: ; // nothing written
            endcase
        endfunction


        function execute_IretReg();
            nextPC      = regfile[sra];
            interruptEn = 1'b1;
        endfunction


        function execute_BrPcr();
            if(checkCondition())
                nextPC = nextPC + imm24;
        endfunction


        function execute_BrReg();
            if(checkCondition())
                nextPC = regfile[sra];
        endfunction


        function execute_BrRgo();
            if(checkCondition())
                nextPC = regfile[sra] + imm19;
        endfunction


        function execute_BrlPcr();
            if(checkCondition()) begin
                operandA = nextPC;
                operandB = imm24;
                address = operandA + operandB;

                regfile[LR] = nextPC;
                nextPC = address;
            end
        endfunction


        function execute_BrlReg();
            if(checkCondition()) begin
                address = regfile[sra];
                regfile[LR] = nextPC;
                nextPC = address;
            end
        endfunction


        function execute_BrlRgo();
            if(checkCondition()) begin
                operandA = regfile[sra];
                operandB = imm19;
                address = operandA + operandB;

                regfile[LR] = nextPC;
                nextPC = address;
            end
        endfunction


        function execute_StbPcr();
            address = nextPC + imm21c;

            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = regfile[srb][7:0];
                2'd1: memory[address[11:2]][23:16] = regfile[srb][7:0];
                2'd2: memory[address[11:2]][15:8]  = regfile[srb][7:0];
                2'd3: memory[address[11:2]][7:0]   = regfile[srb][7:0];
            endcase
        endfunction


        function execute_StwPcr();
            address = nextPC + imm21c;

            case(address[1])
                1'd0: memory[address[11:2]][31:16] = regfile[srb][15:0];
                1'd1: memory[address[11:2]][15:0]  = regfile[srb][15:0];
            endcase
        endfunction


        function execute_StdPcr();
            address = nextPC + imm21c;

            memory[address[11:2]] = regfile[srb];
        endfunction


        function execute_StbReg();
            address = regfile[sra];

            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = regfile[srb][7:0];
                2'd1: memory[address[11:2]][23:16] = regfile[srb][7:0];
                2'd2: memory[address[11:2]][15:8]  = regfile[srb][7:0];
                2'd3: memory[address[11:2]][7:0]   = regfile[srb][7:0];
            endcase
        endfunction


        function execute_StwReg();
            address = regfile[sra];

            case(address[1])
                1'd0: memory[address[11:2]][31:16] = regfile[srb][15:0];
                1'd1: memory[address[11:2]][15:0]  = regfile[srb][15:0];
            endcase
        endfunction


        function execute_StdReg();
            address = regfile[sra];

            memory[address[11:2]] = regfile[srb];
        endfunction


        function execute_StbRgo();
            address = regfile[sra] + imm16b;

            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = regfile[srb][7:0];
                2'd1: memory[address[11:2]][23:16] = regfile[srb][7:0];
                2'd2: memory[address[11:2]][15:8]  = regfile[srb][7:0];
                2'd3: memory[address[11:2]][7:0]   = regfile[srb][7:0];
            endcase
        endfunction


        function execute_StwRgo();
            address = regfile[sra] + imm16b;

            case(address[1])
                1'd0: memory[address[11:2]][31:16] = regfile[srb][15:0];
                1'd1: memory[address[11:2]][15:0]  = regfile[srb][15:0];
            endcase
        endfunction


        function execute_StdRgo();
            address = regfile[sra] + imm16b;

            memory[address[11:2]] = regfile[srb];
        endfunction


        function execute_StbIa();
            address = regfile[sra];

            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = regfile[srb][7:0];
                2'd1: memory[address[11:2]][23:16] = regfile[srb][7:0];
                2'd2: memory[address[11:2]][15:8]  = regfile[srb][7:0];
                2'd3: memory[address[11:2]][7:0]   = regfile[srb][7:0];
            endcase

            address = regfile[sra] + imm16b;

            regfile[sra] = address[31:0];
        endfunction


        function execute_StwIa();
            address = regfile[sra];

            case(address[1])
                1'd0: memory[address[11:2]][31:16] = regfile[srb][15:0];
                1'd1: memory[address[11:2]][15:0]  = regfile[srb][15:0];
            endcase

            address = regfile[sra] + imm16b;

            regfile[sra] = address[31:0];
        endfunction


        function execute_StdIa();
            address = regfile[sra];

            memory[address[11:2]] = regfile[srb];

            address = regfile[sra] + imm16b;

            regfile[sra] = address[31:0];
        endfunction


        function execute_StbIb();
            address = regfile[sra] + imm16b;

            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = regfile[srb][7:0];
                2'd1: memory[address[11:2]][23:16] = regfile[srb][7:0];
                2'd2: memory[address[11:2]][15:8]  = regfile[srb][7:0];
                2'd3: memory[address[11:2]][7:0]   = regfile[srb][7:0];
            endcase

            regfile[sra] = address[31:0];
        endfunction


        function execute_StwIb();
            address = regfile[sra] + imm16b;

            case(address[1])
                1'd0: memory[address[11:2]][31:16] = regfile[srb][15:0];
                1'd1: memory[address[11:2]][15:0]  = regfile[srb][15:0];
            endcase

            regfile[sra] = address[31:0];
        endfunction


        function execute_StdIb();
            address = regfile[sra] + imm16b;

            memory[address[11:2]] = regfile[srb];
            regfile[sra] = address[31:0];
        endfunction


        function execute_LdbsPcr();
            address = nextPC + imm21b;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {{24{result[7]}}, result[7:0]};
        endfunction


        function execute_LdbuPcr();
            address = nextPC + imm21b;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {24'b0, result[7:0]};
        endfunction


        function execute_LdwsPcr();
            address = nextPC + imm21b;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {{16{result[15]}}, result[15:0]};
        endfunction


        function execute_LdwuPcr();
            address = nextPC + imm21b;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {16'b0, result[15:0]};
        endfunction


        function execute_LddPcr();
            address = nextPC + imm21b;
            result = memory[address[11:2]];

            regfile[drl] = result[31:0];
        endfunction


        function execute_LdbsReg();
            address = regfile[sra];

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {{24{result[7]}}, result[7:0]};
        endfunction


        function execute_LdbuReg();
            address = regfile[sra];

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {24'b0, result[7:0]};
        endfunction


        function execute_LdwsReg();
            address = regfile[sra];

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {{16{result[15]}}, result[15:0]};
        endfunction


        function execute_LdwuReg();
            address = regfile[sra];

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {16'b0, result[15:0]};
        endfunction


        function execute_LddReg();
            address = regfile[sra];
            result = memory[address[11:2]];

            regfile[drl] = result[31:0];
        endfunction


        function execute_LdbsRgo();
            address = regfile[sra] + imm16a;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {{24{result[7]}}, result[7:0]};
        endfunction


        function execute_LdbuRgo();
            address = regfile[sra] + imm16a;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[drl] = {24'b0, result[7:0]};
        endfunction


        function execute_LdwsRgo();
            address = regfile[sra] + imm16a;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {{16{result[15]}}, result[15:0]};
        endfunction


        function execute_LdwuRgo();
            address = regfile[sra] + imm16a;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[drl] = {16'b0, result[15:0]};
        endfunction


        function execute_LddRgo();
            address = regfile[sra] + imm16a;
            result = memory[address[11:2]];

            regfile[drl] = result[31:0];
        endfunction


        function execute_LdbsIa();
            address = regfile[sra];

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            address = regfile[sra] + imm16a;

            regfile[sra] = address;
            regfile[drl] = {{24{result[7]}}, result[7:0]};
        endfunction


        function execute_LdbuIa();
            address = regfile[sra];

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            address = regfile[sra] + imm16a;

            regfile[sra] = address;
            regfile[drl] = {24'b0, result[7:0]};
        endfunction


        function execute_LdwsIa();
            address = regfile[sra];

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            address = regfile[sra] + imm16a;

            regfile[sra] = address;
            regfile[drl] = {{16{result[15]}}, result[15:0]};
        endfunction


        function execute_LdwuIa();
            address = regfile[sra];

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            address = regfile[sra] + imm16a;

            regfile[sra] = address;
            regfile[drl] = {16'b0, result[15:0]};
        endfunction


        function execute_LddIa();
            address = regfile[sra];
            result = memory[address[11:2]];

            address = regfile[sra] + imm16a;

            regfile[sra] = address;
            regfile[drl] = result[31:0];
        endfunction


        function execute_LdbsIb();
            address = regfile[sra] + imm16a;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[sra] = address;
            regfile[drl] = {{24{result[7]}}, result[7:0]};
        endfunction


        function execute_LdbuIb();
            address = regfile[sra] + imm16a;

            case(address[1:0])
                2'd0: result = memory[address[11:2]][31:24];
                2'd1: result = memory[address[11:2]][23:16];
                2'd2: result = memory[address[11:2]][15:8];
                2'd3: result = memory[address[11:2]][7:0];
            endcase

            regfile[sra] = address;
            regfile[drl] = {24'b0, result[7:0]};
        endfunction


        function execute_LdwsIb();
            address = regfile[sra] + imm16a;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[sra] = address;
            regfile[drl] = {{16{result[15]}}, result[15:0]};
        endfunction


        function execute_LdwuIb();
            address = regfile[sra] + imm16a;

            case(address[1])
                1'd0: result = memory[address[11:2]][31:16];
                1'd1: result = memory[address[11:2]][15:0];
            endcase

            regfile[sra] = address;
            regfile[drl] = {16'b0, result[15:0]};
        endfunction


        function execute_LddIb();
            address = regfile[sra] + imm16a;
            result = memory[address[11:2]];

            regfile[sra] = address;
            regfile[drl] = result[31:0];
        endfunction
    endclass


endpackage

