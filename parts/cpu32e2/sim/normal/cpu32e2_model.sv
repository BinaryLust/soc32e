
// at the end of on instruction before we commit the results to architectural state
// we first check if an exception or interrupt has occured.
// if an interrupt has occured we finish commiting results to architectural state or
// if an exception has occured we cancel commiting results to architectural state then

// we clear the interrupt enable bit in the system registers
// we load the cause register with the interrupt vector the caused the interrupt to occur
// we save current next pc to the register file at register epc
// we load isr base addres into next pc
// clear triggered exception register if an exception occured.


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
        logic       [31:0]  resultLow;
        logic       [31:0]  resultHigh;
        logic       [31:0]  memoryData;
        logic       [31:0]  address;
        logic               carry;
        logic               zero;
        logic               overflow;
        logic               negative;
        logic       [15:0]  exceptionTriggered;
        logic       [3:0]   commitType;

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
        logic       [31:0]  imm19;
        logic       [31:0]  imm24;


        // constructor
        function new();
            doReset();
        endfunction


        function void doReset();
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

            // hidden state
            exceptionTriggered = 16'b0;
        endfunction


        function void run(
            logic  [31:0]  instruction//,
            //logic          interruptRequest,
            //logic  [3:0]   interrupt
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
                BR_RO:   execute_BrRgo();
                BREAK_R: execute_Break();
                BRL_PR:  execute_BrlPcr();
                BRL_RO:  execute_BrlRgo();
                CMP_I:   execute_CmpImm();
                CMP_R:   execute_CmpReg();
                INT_I:   execute_IntImm();
                IRET_R:  execute_IretReg();
                LDBS_PR: execute_LdbsPcr();
                LDBS_RO: execute_LdbsRgo();
                LDBS_IA: execute_LdbsIa();
                LDBS_IB: execute_LdbsIb();
                LDBU_PR: execute_LdbuPcr();
                LDBU_RO: execute_LdbuRgo();
                LDBU_IA: execute_LdbuIa();
                LDBU_IB: execute_LdbuIb();
                LDD_PR:  execute_LddPcr();
                LDD_RO:  execute_LddRgo();
                LDD_IA:  execute_LddIa();
                LDD_IB:  execute_LddIb();
                LDWS_PR: execute_LdwsPcr();
                LDWS_RO: execute_LdwsRgo();
                LDWS_IA: execute_LdwsIa();
                LDWS_IB: execute_LdwsIb();
                LDWU_PR: execute_LdwuPcr();
                LDWU_RO: execute_LdwuRgo();
                LDWU_IA: execute_LdwuIa();
                LDWU_IB: execute_LdwuIb();
                MOV_I:   execute_MovImm();
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
                STB_RO:  execute_StbRgo();
                STB_IA:  execute_StbIa();
                STB_IB:  execute_StbIb();
                STD_PR:  execute_StdPcr();
                STD_RO:  execute_StdRgo();
                STD_IA:  execute_StdIa();
                STD_IB:  execute_StdIb();
                STW_PR:  execute_StwPcr();
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

            // commitment stage
            if(exceptionTriggered) begin
                logic [3:0] exceptionVector;
                
                // figure out the highest priority exception
                for(exceptionVector = 4'd0; exceptionVector < 16; exceptionVector++)
                    if(exceptionTriggered[exceptionVector]) break;

                interruptEn        = 1'b0;                    // clear interrupt enable flag
                cause              = {1'b0, exceptionVector}; // load cause register
                regfile[EPC]       = nextPC;                  // save current pc to epc
                nextPC             = isrBaseAddress;          // load isr base address to next pc
                exceptionTriggered = 16'b0;                   // clear triggered exceptions
            end else begin //else if(interruptRequest) begin
                commit();
            end
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


        function void triggerException(input logic [3:0] number);
            if(interruptEn && exceptionMask[number]) begin
                exceptionTriggered[number] = 1'b1;
            end
        endfunction


        function void calcAddFlags();
            zero     = ~|resultLow;
            overflow = (~operandA[31] & ~operandB[31] & resultLow[31]) | (operandA[31] & operandB[31] & ~resultLow[31]);
            negative = resultLow[31];
        endfunction


        function void calcLogicFlags();
            carry    = 1'b0;
            zero     = ~|resultLow;
            overflow = 1'b0;
            negative = resultLow[31];
        endfunction


        function void calcLShiftFlags();
            carry    = (operandB[4:0] == 5'b0) ? carryFlag : operandA[32-operandB[4:0]];
            zero     = ~|resultLow;
            overflow = 1'b0;
            negative = resultLow[31];
        endfunction


        function void calcRShiftFlags();
            carry    = (operandB[4:0] == 5'b0) ? carryFlag : operandA[operandB[4:0]-1];
            zero     = ~|resultLow;
            overflow = 1'b0;
            negative = resultLow[31];
        endfunction


        function void calcMulFlags();
            carry    = 1'b0;
            zero     = ~|{resultHigh, resultLow};
            overflow = 1'b0;
            negative = resultLow[31];
        endfunction


        function void commit();
            case(commitType)
                4'd0: begin
                    regfile[drh] = resultHigh;
                    regfile[drl] = resultLow;
                    carryFlag    = carry;
                    zeroFlag     = zero;
                    overflowFlag = overflow;
                    negativeFlag = negative;
                end

                4'd1: begin
                    regfile[drh] = resultHigh;
                    regfile[drl] = resultLow;
                end

                4'd2: begin
                    regfile[drl] = resultLow;
                end

                4'd3: begin
                    regfile[sra] = address;
                end

                4'd4: begin
                    regfile[sra] = address;
                    regfile[drl] = resultLow;
                end

                4'd5: begin
                    regfile[drl] = resultLow;
                    carryFlag    = carry;
                    zeroFlag     = zero;
                    overflowFlag = overflow;
                    negativeFlag = negative;
                end

                4'd6: begin
                    carryFlag    = carry;
                    zeroFlag     = zero;
                    overflowFlag = overflow;
                    negativeFlag = negative;
                end

                4'd7: begin
                    if(checkCondition()) begin
                        regfile[LR] = nextPC;
                        nextPC      = address;
                    end
                end

                4'd8: begin
                    if(checkCondition())
                        nextPC = address;
                end

                4'd9: begin
                    case(drl)
                        5'd0:    begin negativeFlag = resultLow[3]; overflowFlag = resultLow[2]; zeroFlag = resultLow[1]; carryFlag = resultLow[0]; end
                        5'd1:    begin exceptionMask = resultLow[31:16]; interruptEn = resultLow[15]; end
                        5'd2:    isrBaseAddress = resultLow[31:0];
                        default: ; // nothing written
                    endcase
                end

                4'd10: begin
                    nextPC      = resultLow;
                    interruptEn = 1'b1;
                end

                4'd15:   ; // do nothing
                default: ; // do nothing
            endcase
        endfunction


        function void updateByteMemory();
            case(address[1:0])
                2'd0: memory[address[11:2]][31:24] = resultLow[7:0];
                2'd1: memory[address[11:2]][23:16] = resultLow[7:0];
                2'd2: memory[address[11:2]][15:8]  = resultLow[7:0];
                2'd3: memory[address[11:2]][7:0]   = resultLow[7:0];
            endcase
        endfunction


        function void updateWordMemory();
            case(address[1])
                1'd0: memory[address[11:2]][31:16] = resultLow[15:0];
                1'd1: memory[address[11:2]][15:0]  = resultLow[15:0];
            endcase
        endfunction


        function void updateDwordMemory();
            memory[address[11:2]] = resultLow;
        endfunction


        function void getByteData();
            case(address[1:0])
                2'd0: memoryData = memory[address[11:2]][31:24];
                2'd1: memoryData = memory[address[11:2]][23:16];
                2'd2: memoryData = memory[address[11:2]][15:8];
                2'd3: memoryData = memory[address[11:2]][7:0];
            endcase
        endfunction


        function void getWordData();
            case(address[1])
                1'd0: memoryData = memory[address[11:2]][31:16];
                1'd1: memoryData = memory[address[11:2]][15:0];
            endcase
        endfunction


        function void getDwordData();
            memoryData = memory[address[11:2]];
        endfunction


        function void execute_Unk();
            triggerException(4'd4);

            commitType = 4'd15;
        endfunction


        function void execute_AdcImm();
            operandA           = regfile[sra];
            operandB           = imm16a;
            {carry, resultLow} = operandA + operandB + carryFlag;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_AdcReg();
            operandA           = regfile[sra];
            operandB           = regfile[srb];
            {carry, resultLow} = operandA + operandB + carryFlag;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_AddImm();
            operandA           = regfile[sra];
            operandB           = imm16a;
            {carry, resultLow} = operandA + operandB;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_AddReg();
            operandA           = regfile[sra];
            operandB           = regfile[srb];
            {carry, resultLow} = operandA + operandB;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_UadcImm();
            operandA           = regfile[sra];
            operandB           = imm16a;
            {carry, resultLow} = operandA + operandB + carryFlag;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_UadcReg();
            operandA           = regfile[sra];
            operandB           = regfile[srb];
            {carry, resultLow} = operandA + operandB + carryFlag;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


         function void execute_UaddImm();
            operandA           = regfile[sra];
            operandB           = imm16a;
            {carry, resultLow} = operandA + operandB;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_UaddReg();
            operandA           = regfile[sra];
            operandB           = regfile[srb];
            {carry, resultLow} = operandA + operandB;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_SbbImm();
            operandA           = regfile[sra];
            operandB           = ~imm16a;
            {carry, resultLow} = (operandA + operandB) + carryFlag;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_SbbReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + carryFlag;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_SubImm();
            operandA           = regfile[sra];
            operandB           = ~imm16a;
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_SubReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd5;
        endfunction


        function void execute_UsbbImm();
            operandA           = regfile[sra];
            operandB           = ~imm16a;
            {carry, resultLow} = (operandA + operandB) + carryFlag;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_UsbbReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + carryFlag;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_UsubImm();
            operandA           = regfile[sra];
            operandB           = ~imm16a;
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_UsubReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();

            commitType = 4'd5;
        endfunction


        function void execute_CmpImm();
            operandA           = regfile[sra];
            operandB           = ~imm21a;
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd6;
        endfunction


        function void execute_CmpReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();
            if(overflow) triggerException(4'd1);

            commitType = 4'd6;
        endfunction


        function void execute_UcmpImm();
            operandA           = regfile[sra];
            operandB           = ~imm21a;
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();

            commitType = 4'd6;
        endfunction


        function void execute_UcmpReg();
            operandA           = regfile[sra];
            operandB           = ~regfile[srb];
            {carry, resultLow} = (operandA + operandB) + 1'b1;
            calcAddFlags();

            commitType = 4'd6;
        endfunction


        function void execute_SmulReg();
            operandA                = regfile[sra];
            operandB                = regfile[srb];
            {resultHigh, resultLow} = signed'(operandA) * signed'(operandB);
            calcMulFlags();

            commitType = 4'd0;
        endfunction


        function void execute_UmulReg();
            operandA                = regfile[sra];
            operandB                = regfile[srb];
            {resultHigh, resultLow} = unsigned'(operandA) * unsigned'(operandB);
            calcMulFlags();

            commitType = 4'd0;
        endfunction


        function void execute_SdivReg();
            operandA = regfile[sra];
            operandB = regfile[srb];
            if(operandB != 32'b0) begin
                resultHigh = (operandB == 32'b0) ? 32'b0 : signed'(signed'(operandA) % signed'(operandB));
                resultLow  = (operandB == 32'b0) ? 32'b0 : signed'(signed'(operandA) / signed'(operandB));
            end else begin
                triggerException(4'd0);
            end

            commitType = 4'd1;
        endfunction


        function void execute_UdivReg();
            operandA = regfile[sra];
            operandB = regfile[srb];
            if(operandB != 32'b0) begin
                resultHigh = (operandB == 32'b0) ? 32'b0 : unsigned'(unsigned'(operandA) % unsigned'(operandB));
                resultLow  = (operandB == 32'b0) ? 32'b0 : unsigned'(unsigned'(operandA) / unsigned'(operandB));
            end else begin
                triggerException(4'd0);
            end

            commitType = 4'd1;
        endfunction


        function void execute_AndImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            resultLow    = operandA & operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_AndReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA & operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_NotReg();
            operandB     = regfile[srb];
            resultLow    = ~operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_OrImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            resultLow    = operandA | operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_OrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA | operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_XorImm();
            operandA     = regfile[sra];
            operandB     = imm16a;
            resultLow    = operandA ^ operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_XorReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA ^ operandB;
            calcLogicFlags();

            commitType = 4'd5;
        endfunction


        function void execute_TeqImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            resultLow    = operandA ^ operandB;
            calcLogicFlags();

            commitType = 4'd6;
        endfunction


        function void execute_TeqReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA ^ operandB;
            calcLogicFlags();

            commitType = 4'd6;
        endfunction


        function void execute_TstImm();
            operandA     = regfile[sra];
            operandB     = imm21a;
            resultLow    = operandA & operandB;
            calcLogicFlags();

            commitType = 4'd6;
        endfunction


        function void execute_TstReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA & operandB;
            calcLogicFlags();

            commitType = 4'd6;
        endfunction


        function void execute_ShlImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = operandA << operandB[4:0];
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_ShlReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA << operandB[4:0];
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_ShrImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = operandA >> operandB[4:0];
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_ShrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = operandA >> operandB[4:0];
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_SarImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = unsigned'(signed'(operandA) >>> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_SarReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = unsigned'(signed'(operandA) >>> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RolImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = (operandA << operandB[4:0]) | (operandA >> (32-operandB[4:0]));
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RolReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = (operandA << operandB[4:0]) | (operandA >> (32-operandB[4:0]));
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RorImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = (operandA << (32-operandB[4:0])) | (operandA >> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RorReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = (operandA << (32-operandB[4:0])) | (operandA >> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RclImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = ({carryFlag, operandA} << operandB[4:0]) | ({carryFlag, operandA} >> (33-operandB[4:0])); // 32 or 33 width???
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RclReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = ({carryFlag, operandA} << operandB[4:0]) | ({carryFlag, operandA} >> (33-operandB[4:0]));
            calcLShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RcrImm();
            operandA     = regfile[sra];
            operandB     = imm5;
            resultLow    = ({carryFlag, operandA} << (33-operandB[4:0])) | ({carryFlag, operandA} >> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_RcrReg();
            operandA     = regfile[sra];
            operandB     = regfile[srb];
            resultLow    = ({carryFlag, operandA} << (33-operandB[4:0])) | ({carryFlag, operandA} >> operandB[4:0]);
            calcRShiftFlags();

            commitType = 4'd5;
        endfunction


        function void execute_NopReg();
            commitType = 4'd15;
        endfunction


        function void execute_Break();
            triggerException(4'd2);

            commitType = 4'd15;
        endfunction


        function void execute_IntImm();
            triggerException(4'd3);
            systemCall = imm16a[5:0]; // written even when interrupts are disabled

            commitType = 4'd15;
        endfunction


        function void execute_MovImm();
            resultLow    = imm21b;

            commitType = 4'd2;
        endfunction


        function void execute_MuiImm();
            resultLow    = {imm16c, regfile[srb][15:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LsrReg();
            case(srb)
                5'd0:    resultLow = {28'b0, negativeFlag, overflowFlag, zeroFlag, carryFlag};
                5'd1:    resultLow = {exceptionMask, interruptEn, 10'b0, cause};
                5'd2:    resultLow = isrBaseAddress;
                5'd3:    resultLow = {26'b0, systemCall};
                default: resultLow = 32'b0;
            endcase

            commitType = 4'd2;
        endfunction


        function void execute_SsrReg();
            resultLow = regfile[srb];

            commitType = 4'd9;
        endfunction


        function void execute_IretReg();
            resultLow = regfile[sra];

            commitType = 4'd10;
        endfunction


        function void execute_BrPcr();
            address = nextPC + imm24;

            commitType = 4'd8;
        endfunction


        function void execute_BrRgo();
            address = regfile[sra] + imm19;

            commitType = 4'd8;
        endfunction


        function void execute_BrlPcr();
            address = nextPC + imm24;

            commitType = 4'd7;
        endfunction


        function void execute_BrlRgo();
            address = regfile[sra] + imm19;

            commitType = 4'd7;
        endfunction


        function void execute_StbPcr();
            address   = nextPC + imm21c;
            resultLow = regfile[srb];
            updateByteMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StwPcr();
            address   = nextPC + imm21c;
            resultLow = regfile[srb];
            updateWordMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StdPcr();
            address   = nextPC + imm21c;
            resultLow = regfile[srb];
            updateDwordMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StbRgo();
            address   = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateByteMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StwRgo();
            address   = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateWordMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StdRgo();
            address   = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateDwordMemory();

            commitType = 4'd15;
        endfunction


        function void execute_StbIa();
            address   = regfile[sra];
            resultLow = regfile[srb];
            updateByteMemory();
            address   = regfile[sra] + imm16b;

            commitType = 4'd3;
        endfunction


        function void execute_StwIa();
            address   = regfile[sra];
            resultLow = regfile[srb];
            updateWordMemory();
            address   = regfile[sra] + imm16b;

            commitType = 4'd3;
        endfunction


        function void execute_StdIa();
            address   = regfile[sra];
            resultLow = regfile[srb];
            updateDwordMemory();
            address   = regfile[sra] + imm16b;

            commitType = 4'd3;
        endfunction


        function void execute_StbIb();
            address = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateByteMemory();

            commitType = 4'd3;
        endfunction


        function void execute_StwIb();
            address = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateWordMemory();

            commitType = 4'd3;
        endfunction


        function void execute_StdIb();
            address = regfile[sra] + imm16b;
            resultLow = regfile[srb];
            updateDwordMemory();

            commitType = 4'd3;
        endfunction


        function void execute_LdbsPcr();
            address   = nextPC + imm21b;
            getByteData();
            resultLow = {{24{memoryData[7]}}, memoryData[7:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdbuPcr();
            address   = nextPC + imm21b;
            getByteData();
            resultLow = {24'b0, memoryData[7:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdwsPcr();
            address   = nextPC + imm21b;
            getWordData();
            resultLow = {{16{memoryData[15]}}, memoryData[15:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdwuPcr();
            address   = nextPC + imm21b;
            getWordData();
            resultLow = {16'b0, memoryData[15:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LddPcr();
            address   = nextPC + imm21b;
            getDwordData();
            resultLow = memoryData;

            commitType = 4'd2;
        endfunction


        function void execute_LdbsRgo();
            address   = regfile[sra] + imm16a;
            getByteData();
            resultLow = {{24{memoryData[7]}}, memoryData[7:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdbuRgo();
            address   = regfile[sra] + imm16a;
            getByteData();
            resultLow = {24'b0, memoryData[7:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdwsRgo();
            address   = regfile[sra] + imm16a;
            getWordData();
            resultLow = {{16{memoryData[15]}}, memoryData[15:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LdwuRgo();
            address   = regfile[sra] + imm16a;
            getWordData();
            resultLow = {16'b0, memoryData[15:0]};

            commitType = 4'd2;
        endfunction


        function void execute_LddRgo();
            address   = regfile[sra] + imm16a;
            getDwordData();
            resultLow = memoryData;

            commitType = 4'd2;
        endfunction


        function void execute_LdbsIa();
            address   = regfile[sra];
            getByteData();
            resultLow = {{24{memoryData[7]}}, memoryData[7:0]};
            address   = regfile[sra] + imm16a;

            commitType = 4'd4;
        endfunction


        function void execute_LdbuIa();
            address   = regfile[sra];
            getByteData();
            resultLow = {24'b0, memoryData[7:0]};
            address   = regfile[sra] + imm16a;

            commitType = 4'd4;
        endfunction


        function void execute_LdwsIa();
            address   = regfile[sra];
            getWordData();
            resultLow = {{16{memoryData[15]}}, memoryData[15:0]};
            address   = regfile[sra] + imm16a;

            commitType = 4'd4;
        endfunction


        function void execute_LdwuIa();
            address   = regfile[sra];
            getWordData();
            resultLow = {16'b0, memoryData[15:0]};
            address   = regfile[sra] + imm16a;

            commitType = 4'd4;
        endfunction


        function void execute_LddIa();
            address   = regfile[sra];
            getDwordData();
            resultLow = memoryData;
            address   = regfile[sra] + imm16a;

            commitType = 4'd4;
        endfunction


        function void execute_LdbsIb();
            address   = regfile[sra] + imm16a;
            getByteData();
            resultLow = {{24{memoryData[7]}}, memoryData[7:0]};

            commitType = 4'd4;
        endfunction


        function void execute_LdbuIb();
            address   = regfile[sra] + imm16a;
            getByteData();
            resultLow = {24'b0, memoryData[7:0]};

            commitType = 4'd4;
        endfunction


        function void execute_LdwsIb();
            address   = regfile[sra] + imm16a;
            getWordData();
            resultLow = {{16{memoryData[15]}}, memoryData[15:0]};

            commitType = 4'd4;
        endfunction


        function void execute_LdwuIb();
            address   = regfile[sra] + imm16a;
            getWordData();
            resultLow = {16'b0, memoryData[15:0]};

            commitType = 4'd4;
        endfunction


        function void execute_LddIb();
            address   = regfile[sra] + imm16a;
            getDwordData();
            resultLow = memoryData;

            commitType = 4'd4;
        endfunction
    endclass


endpackage

