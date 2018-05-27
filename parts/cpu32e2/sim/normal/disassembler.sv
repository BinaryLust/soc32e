

package disassembler;


    import architecture::*;


    class decoder;

        // fields
        logic  unsigned  [5:0]   opcode;
        logic  unsigned  [5:0]   rcode;
        opcodes                  itype;
        conditions               condition;

        logic  unsigned  [4:0]   drl;
        logic  unsigned  [4:0]   drh;
        logic  unsigned  [4:0]   sra;
        logic  unsigned  [4:0]   srb;

        logic  signed    [31:0]  imm16a;
        logic  signed    [31:0]  imm16b;
        logic  unsigned  [31:0]  imm16c;
        logic  signed    [31:0]  imm21a;
        logic  signed    [31:0]  imm21b;
        logic  signed    [31:0]  imm21c;
        logic  unsigned  [31:0]  imm5;
        logic  unsigned  [31:0]  imm6;
        logic  signed    [31:0]  imm19;
        logic  signed    [31:0]  imm24;


        // constructor
        function new();

        endfunction


        // everything else
        function void decode(
            logic  [31:0]  instruction = 32'b0
            );

            // extract all sub-fields
            opcode    = instruction[31:26];
            rcode     = instruction[5:0];
            itype     = opcodes'({opcode, rcode});
            condition = conditions'(instruction[9:6]);

            drl    = instruction[25:21];
            drh    = instruction[10:6];
            sra    = instruction[20:16];
            srb    = instruction[15:11];

            imm16a = {{16{instruction[15]}}, instruction[15:0]};                                              // bits[15:0] sign extended to bits[31:0]
            imm16b = {{16{instruction[25]}}, instruction[25:21], instruction[10:0]};                          // {bits[25:21], bits[10:0]} sign extended to bits[31:0]
            imm16c = {16'b0, instruction[20:16], instruction[10:0]};                                          // {bits[20:16], bits[10:0]} zero extended to bits[31:0]
            imm21a = {{11{instruction[25]}}, instruction[25:21], instruction[15:0]};                          // {bits[25:21], bits[15:0]} sign extended to bits[31:0]
            imm21b = {{11{instruction[20]}}, instruction[20:0]};                                              // bits[20:0] sign extended to bits[31:0]
            imm21c = {{11{instruction[25]}}, instruction[25:16], instruction[10:0]};                          // {bits[25:16], bits[10:0]} sign extended to bits[31:0]
            imm5   = {27'b0, instruction[10:6]};                                                              // bits[10:6] zero extended to bits[31:0]
            imm6   = {27'b0, instruction[10:6]};                                                              // bits[10:6] zero extended to bits[31:0]
            imm19  = {{13{instruction[25]}}, instruction[25:21], instruction[15:10], instruction[5:0], 2'b0}; // {bits[25:21], bits[15:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
            imm24  = {{8{instruction[25]}}, instruction[25:10], instruction[5:0], 2'b0};                      // {bits[25:10], bits[5:0]} sign extended to bits[31:2] and bits[1:0] filled with zero's
        endfunction


        function string iTypeToString();
            string str;

            casex(itype)
                ADC_I,
                ADC_R:   str = "adc   ";
                ADD_I,
                ADD_R:   str = "add   ";
                AND_I,
                AND_R:   str = "and   ";
                BR_PR,
                BR_RO:   str = "br    ";
                BREAK_R: str = "break ";
                BRL_PR,
                BRL_RO:  str = "brl   ";
                CMP_I,
                CMP_R:   str = "cmp   ";
                INT_I:   str = "int   ";
                IRET_R:  str = "iret  ";
                LDBS_PR,
                LDBS_RO,
                LDBS_IA,
                LDBS_IB,
                LDBU_PR,
                LDBU_RO,
                LDBU_IA,
                LDBU_IB,
                LDD_PR,
                LDD_RO,
                LDD_IA,
                LDD_IB,
                LDWS_PR,
                LDWS_RO,
                LDWS_IA,
                LDWS_IB,
                LDWU_PR,
                LDWU_RO,
                LDWU_IA,
                LDWU_IB: str = "ld    ";
                MOV_I:   str = "mov   ";
                MUI_I:   str = "mui   ";
                NOP_R:   str = "nop   ";
                NOT_R:   str = "not   ";
                OR_I,
                OR_R:    str = "or    ";
                RCL_I,
                RCL_R:   str = "rcl   ";
                RCR_I,
                RCR_R:   str = "rcr   ";
                ROL_I,
                ROL_R:   str = "rol   ";
                ROR_I,
                ROR_R:   str = "ror   ";
                LSR_R:   str = "lsr   ";
                SAR_I,
                SAR_R:   str = "sar   ";
                SBB_I,
                SBB_R:   str = "sbb   ";
                SDIV_R:  str = "sdiv  ";
                SHL_I,
                SHL_R:   str = "shl   ";
                SHR_I,
                SHR_R:   str = "shr   ";
                SMUL_R:  str = "smul  ";
                SSR_R:   str = "ssr   ";
                STB_PR,
                STB_RO,
                STB_IA,
                STB_IB,
                STD_PR,
                STD_RO,
                STD_IA,
                STD_IB,
                STW_PR,
                STW_RO,
                STW_IA,
                STW_IB:  str = "st    ";
                SUB_I,
                SUB_R:   str = "sub   ";
                TEQ_I,
                TEQ_R:   str = "teq   ";
                TST_I,
                TST_R:   str = "tst   ";
                UADC_I,
                UADC_R:  str = "uadc  ";
                UADD_I,
                UADD_R:  str = "uadd  ";
                UCMP_I,
                UCMP_R:  str = "ucmp  ";
                UDIV_R:  str = "udiv  ";
                UMUL_R:  str = "umul  ";
                USBB_I,
                USBB_R:  str = "usbb  ";
                USUB_I,
                USUB_R:  str = "usub  ";
                XOR_I,
                XOR_R:   str = "xor   ";
                default: str = "unkn  ";
            endcase

            return str;
        endfunction


        function string condToString();
            string str;

            case(condition)
                UNCONDITIONAL:    str = "unc";       // unconditional
                ZERO:             str = "zr or ==";  // (zero) or (equal)
                NOTZERO:          str = "!zr or !="; // (not zero) or (not equal)
                CARRY:            str = "cr or >=u"; // (carry) or (greater than or equal (unsigned))
                NOTCARRY:         str = "!cr or <u"; // (not carry) or (less than (unsigned))
                OVERFLOW:         str = "ov";        // overflow
                NOTOVERFLOW:      str = "!ov";       // not overflow
                NEGATIVE:         str = "ng";        // negative
                NOTNEGATIVE:      str = "!ng";       // not negative
                GREATER_U:        str = ">u";        // greater than (unsigned)
                LESSOREQUAL_U:    str = "<=u";       // less than or equal (unsigned)
                GREATER_S:        str = ">";         // greater than (signed)
                LESS_S:           str = "<";         // less than (signed)
                GREATEROREQUAL_S: str = ">=";        // greater than or equal (signed)
                LESSOREQUAL_S:    str = "<=";        // less than or equal (signed)
                default:          str = "unk";       // unknown
            endcase

            return str;
        endfunction


        function string memString();
            string str;

            casex(itype)
                LDBS_PR,
                LDBS_RO,
                LDBS_IA,
                LDBS_IB: str = "signed byte";

                LDBU_PR,
                LDBU_RO,
                LDBU_IA,
                LDBU_IB: str = "unsigned byte";

                LDD_PR,
                LDD_RO,
                LDD_IA,
                LDD_IB:  str = "dword";

                LDWS_PR,
                LDWS_RO,
                LDWS_IA,
                LDWS_IB: str = "signed word";

                LDWU_PR,
                LDWU_RO,
                LDWU_IA,
                LDWU_IB: str = "unsigned word";

                STB_PR,
                STB_RO,
                STB_IA,
                STB_IB:  str = " byte";

                STD_PR,
                STD_RO,
                STD_IA,
                STD_IB:  str = " dword";

                STW_PR,
                STW_RO,
                STW_IA,
                STW_IB:  str = " word";

                default: str = "";
            endcase

            return str;
        endfunction


        function string regToString(
            logic  unsigned  [4:0]  register
            );
            string str;

            case(register)
                0:       str = "r0 ";
                1:       str = "r1 ";
                2:       str = "r2 ";
                3:       str = "r3 ";
                4:       str = "r4 ";
                5:       str = "r5 ";
                6:       str = "r6 ";
                7:       str = "r7 ";
                8:       str = "r8 ";
                9:       str = "r9 ";
                10:      str = "r10";
                11:      str = "r11";
                12:      str = "r12";
                13:      str = "r13";
                14:      str = "r14";
                15:      str = "r15";
                16:      str = "r16";
                17:      str = "r17";
                18:      str = "r18";
                19:      str = "r19";
                20:      str = "r20";
                21:      str = "r21";
                22:      str = "r22";
                23:      str = "r23";
                24:      str = "r24";
                25:      str = "r25";
                26:      str = "r26";
                27:      str = "r27";
                28:      str = "fp "; // or "r28"
                29:      str = "epc"; // or "r29"
                30:      str = "lr "; // or "r30"
                31:      str = "sp "; // or "r31"
                default: str = "";
            endcase

            return str;
        endfunction


        function string sysRegToString(
            logic  unsigned  [4:0]  register
            );
            string str;

            case(register)
                0:       str = "sys0 ";
                1:       str = "sys1 ";
                2:       str = "sys2 ";
                3:       str = "sys3 ";
                4:       str = "sys4 ";
                5:       str = "sys5 ";
                6:       str = "sys6 ";
                7:       str = "sys7 ";
                8:       str = "sys8 ";
                9:       str = "sys9 ";
                10:      str = "sys10";
                11:      str = "sys11";
                12:      str = "sys12";
                13:      str = "sys13";
                14:      str = "sys14";
                15:      str = "sys15";
                16:      str = "sys16";
                17:      str = "sys17";
                18:      str = "sys18";
                19:      str = "sys19";
                20:      str = "sys20";
                21:      str = "sys21";
                22:      str = "sys22";
                23:      str = "sys23";
                24:      str = "sys24";
                25:      str = "sys25";
                26:      str = "sys26";
                27:      str = "sys27";
                28:      str = "sys28";
                29:      str = "sys29";
                30:      str = "sys30";
                31:      str = "sys31";
                default: str = "";
            endcase

            return str;
        endfunction


        function string toString();
            string str;

            casex(itype)
                ADC_R,
                ADD_R,
                AND_R,
                OR_R,
                RCL_R,
                RCR_R,
                ROL_R,
                ROR_R,
                SAR_R,
                SBB_R,
                SHL_R,
                SHR_R,
                SUB_R,
                UADC_R,
                UADD_R,
                USBB_R,
                USUB_R,
                XOR_R:   $sformat(str, "%s  %s, %s, %s", iTypeToString(), regToString(drl), regToString(sra), regToString(srb));

                CMP_R,
                TEQ_R,
                TST_R,
                UCMP_R:  $sformat(str, "%s  %s, %s", iTypeToString(), regToString(sra), regToString(srb));

                SDIV_R,
                SMUL_R,
                UDIV_R,
                UMUL_R:  $sformat(str, "%s  %s, %s, %s, %s", iTypeToString(), regToString(drh), regToString(drl), regToString(sra), regToString(srb));

                BREAK_R,
                NOP_R:   str = iTypeToString();

                NOT_R:   $sformat(str, "%s  %s, %s", iTypeToString(), regToString(drl), regToString(srb));

                IRET_R:  $sformat(str, "%s  %s", iTypeToString(), regToString(sra));

                SSR_R:   $sformat(str, "%s  %s, %s", iTypeToString(), sysRegToString(drl), regToString(srb));

                LSR_R:   $sformat(str, "%s  %s, %s", iTypeToString(), regToString(drl), sysRegToString(srb));

                RCL_I,
                RCR_I,
                ROL_I,
                ROR_I,
                SAR_I,
                SHL_I,
                SHR_I:   $sformat(str, "%s  %s, %s, %9d", iTypeToString(), regToString(drl), regToString(sra), imm5);

                ADC_I,
                ADD_I,
                AND_I,
                OR_I,
                SBB_I,
                SUB_I,
                UADC_I,
                UADD_I,
                USBB_I,
                USUB_I,
                XOR_I:   $sformat(str, "%s  %s, %s, %9d", iTypeToString(), regToString(drl), regToString(sra), imm16a);

                CMP_I,
                TEQ_I,
                TST_I,
                UCMP_I:  $sformat(str, "%s  %s, %9d", iTypeToString(), regToString(sra), imm21a);

                BR_PR,
                BRL_PR:  $sformat(str, "%s  [npc+%9d]  %s", iTypeToString(), imm24, condToString());

                BR_RO,
                BRL_RO:  $sformat(str, "%s  [%s+%9d]  %s", iTypeToString(), regToString(sra), imm19, condToString());

                INT_I:   $sformat(str, "%s  %9d", iTypeToString(), imm16a[5:0]);

                MOV_I:   $sformat(str, "%s  %s, %9d", iTypeToString(), regToString(drl), imm21b);

                MUI_I:   $sformat(str, "%s  %s, %s, %9d", iTypeToString(), regToString(drl), regToString(srb), imm16c);

                LDBS_PR,
                LDBU_PR,
                LDD_PR,
                LDWS_PR,
                LDWU_PR: $sformat(str, "%s  %s,  [npc+%9d]  %s", iTypeToString(), regToString(drl), imm21b, memString());

                LDBS_RO,
                LDBU_RO,
                LDD_RO,
                LDWS_RO,
                LDWU_RO: $sformat(str, "%s  %s,  [%s+%9d]  %s", iTypeToString(), regToString(drl), regToString(sra), imm16a, memString());

                LDBS_IA,
                LDBU_IA,
                LDD_IA,
                LDWS_IA,
                LDWU_IA: $sformat(str, "%s  %s,  [%s+%9d]  %s  (increment after)", iTypeToString(), regToString(drl), regToString(sra), imm16a, memString());

                LDBS_IB,
                LDBU_IB,
                LDD_IB,
                LDWS_IB,
                LDWU_IB: $sformat(str, "%s  %s,  [%s+%9d]  %s  (increment before)", iTypeToString(), regToString(drl), regToString(sra), imm16a, memString());

                STB_PR,
                STD_PR,
                STW_PR:  $sformat(str, "%s  [npc+%9d], %s  %s", iTypeToString(), imm21c, regToString(srb), memString());

                STB_RO,
                STD_RO,
                STW_RO:  $sformat(str, "%s  [%s+%9d], %s  %s", iTypeToString(), regToString(sra), imm16b, regToString(srb), memString());

                STB_IA,
                STD_IA,
                STW_IA:  $sformat(str, "%s  [%s+%9d], %s  %s  (increment after)", iTypeToString(), regToString(sra), imm16b, regToString(srb), memString());

                STB_IB,
                STD_IB,
                STW_IB:  $sformat(str, "%s  [%s+%9d], %s  %s  (increment before)", iTypeToString(), regToString(sra), imm16b, regToString(srb), memString());

                default: str = "unkn";
            endcase

            return str;
        endfunction


    endclass


endpackage

