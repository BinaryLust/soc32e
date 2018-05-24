

package decoderPkg;


    typedef enum logic [126:0] {
        XXX     = 127'b0,
        ADC_I   = 127'b1 << 0,
        ADC_R   = 127'b1 << 1,
        ADD_I   = 127'b1 << 2,
        ADD_R   = 127'b1 << 3,
        AND_I   = 127'b1 << 4,
        AND_R   = 127'b1 << 5,
        BR_PR   = 127'b1 << 6,
        BR_RO   = 127'b1 << 8,
        BREAK_R = 127'b1 << 9,
        BRL_PR  = 127'b1 << 10,
        BRL_RO  = 127'b1 << 12,
        CMP_I   = 127'b1 << 13,
        CMP_R   = 127'b1 << 14,
        INT_I   = 127'b1 << 15,
        IRET_R  = 127'b1 << 16,
        LDBS_PR = 127'b1 << 17,
        LDBS_RO = 127'b1 << 19,
        LDBS_IA = 127'b1 << 20,
        LDBS_IB = 127'b1 << 21,
        LDBU_PR = 127'b1 << 22,
        LDBU_RO = 127'b1 << 24,
        LDBU_IA = 127'b1 << 25,
        LDBU_IB = 127'b1 << 26,
        LDD_PR  = 127'b1 << 27,
        LDD_RO  = 127'b1 << 29,
        LDD_IA  = 127'b1 << 30,
        LDD_IB  = 127'b1 << 31,
        LDWS_PR = 127'b1 << 32,
        LDWS_RO = 127'b1 << 34,
        LDWS_IA = 127'b1 << 35,
        LDWS_IB = 127'b1 << 36,
        LDWU_PR = 127'b1 << 37,
        LDWU_RO = 127'b1 << 39,
        LDWU_IA = 127'b1 << 40,
        LDWU_IB = 127'b1 << 41,
        MOV_I   = 127'b1 << 42,
        MOV_R   = 127'b1 << 43,
        MUI_I   = 127'b1 << 44,
        NOP_R   = 127'b1 << 45,
        NOT_R   = 127'b1 << 46,
        OR_I    = 127'b1 << 47,
        OR_R    = 127'b1 << 48,
        RCL_I   = 127'b1 << 49,
        RCL_R   = 127'b1 << 50,
        RCR_I   = 127'b1 << 51,
        RCR_R   = 127'b1 << 52,
        ROL_I   = 127'b1 << 53,
        ROL_R   = 127'b1 << 54,
        ROR_I   = 127'b1 << 55,
        ROR_R   = 127'b1 << 56,
        LSR_R   = 127'b1 << 57,
        SAR_I   = 127'b1 << 58,
        SAR_R   = 127'b1 << 59,
        SBB_I   = 127'b1 << 60,
        SBB_R   = 127'b1 << 61,
        SDIV_R  = 127'b1 << 62,
        SHL_I   = 127'b1 << 63,
        SHL_R   = 127'b1 << 64,
        SHR_I   = 127'b1 << 65,
        SHR_R   = 127'b1 << 66,
        SMUL_R  = 127'b1 << 67,
        SSR_R   = 127'b1 << 68,
        STB_PR  = 127'b1 << 69,
        STB_RO  = 127'b1 << 71,
        STB_IA  = 127'b1 << 72,
        STB_IB  = 127'b1 << 73,
        STD_PR  = 127'b1 << 74,
        STD_RO  = 127'b1 << 76,
        STD_IA  = 127'b1 << 77,
        STD_IB  = 127'b1 << 78,
        STW_PR  = 127'b1 << 79,
        STW_RO  = 127'b1 << 81,
        STW_IA  = 127'b1 << 82,
        STW_IB  = 127'b1 << 83,
        SUB_I   = 127'b1 << 84,
        SUB_R   = 127'b1 << 85,
        TEQ_I   = 127'b1 << 86,
        TEQ_R   = 127'b1 << 87,
        TST_I   = 127'b1 << 88,
        TST_R   = 127'b1 << 89,
        UADC_I  = 127'b1 << 90,
        UADC_R  = 127'b1 << 91,
        UADD_I  = 127'b1 << 92,
        UADD_R  = 127'b1 << 93,
        UCMP_I  = 127'b1 << 94,
        UCMP_R  = 127'b1 << 95,
        UDIV_R  = 127'b1 << 96,
        UMUL_R  = 127'b1 << 97,
        USBB_I  = 127'b1 << 98,
        USBB_R  = 127'b1 << 99,
        USUB_I  = 127'b1 << 100,
        USUB_R  = 127'b1 << 101,
        XOR_I   = 127'b1 << 102,
        XOR_R   = 127'b1 << 103,

        UKN1_R   = 127'b1 << 104, // undefined instructions below here
        UKN2_R   = 127'b1 << 105,
        UKN3_R   = 127'b1 << 106,
        UKN4_R   = 127'b1 << 107,
        UKN5_R   = 127'b1 << 108,
        UKN6_R   = 127'b1 << 109,
        UKN7_R   = 127'b1 << 110,
        UKN8_R   = 127'b1 << 111,
        UKN9_R   = 127'b1 << 112,
        UKN10_R  = 127'b1 << 113,
        UKN11_R  = 127'b1 << 114,
        UKN12_R  = 127'b1 << 115,
        UKN13_R  = 127'b1 << 116,
        UKN14_R  = 127'b1 << 117,
        UKN15_R  = 127'b1 << 7,
        UKN16_R  = 127'b1 << 11,
        UKN17_R  = 127'b1 << 18,
        UKN18_R  = 127'b1 << 23,
        UKN19_R  = 127'b1 << 28,
        UKN20_R  = 127'b1 << 33,
        UKN21_R  = 127'b1 << 38,
        UKN22_R  = 127'b1 << 70,
        UKN23_R  = 127'b1 << 75,
        UKN24_R  = 127'b1 << 80,

        UKN1_I   = 127'b1 << 118,
        UKN2_I   = 127'b1 << 119,
        UKN3_I   = 127'b1 << 120,
        UKN4_I   = 127'b1 << 121,
        UKN5_I   = 127'b1 << 122,
        UKN6_I   = 127'b1 << 123,
        UKN7_I   = 127'b1 << 124,
        UKN8_I   = 127'b1 << 125,
        UKN9_I   = 127'b1 << 126
    } instructions;


endpackage


module instructionDecoder(
    input   architecture::opcodes     opcode,

    output  decoderPkg::instructions  instruction
    );


    always_comb begin
        // defaults
        instruction = decoderPkg::XXX;


        casex(opcode)
            architecture::ADC_I:    instruction = decoderPkg::ADC_I;
            architecture::ADC_R:    instruction = decoderPkg::ADC_R;
            architecture::ADD_I:    instruction = decoderPkg::ADD_I;
            architecture::ADD_R:    instruction = decoderPkg::ADD_R;
            architecture::AND_I:    instruction = decoderPkg::AND_I;
            architecture::AND_R:    instruction = decoderPkg::AND_R;
            architecture::BR_PR:    instruction = decoderPkg::BR_PR;
            architecture::BR_RO:    instruction = decoderPkg::BR_RO;
            architecture::BREAK_R:  instruction = decoderPkg::BREAK_R;
            architecture::BRL_PR:   instruction = decoderPkg::BRL_PR;
            architecture::BRL_RO:   instruction = decoderPkg::BRL_RO;
            architecture::CMP_I:    instruction = decoderPkg::CMP_I;
            architecture::CMP_R:    instruction = decoderPkg::CMP_R;
            architecture::INT_I:    instruction = decoderPkg::INT_I;
            architecture::IRET_R:   instruction = decoderPkg::IRET_R;
            architecture::LDBS_PR:  instruction = decoderPkg::LDBS_PR;
            architecture::LDBS_RO:  instruction = decoderPkg::LDBS_RO;
            architecture::LDBS_IA:  instruction = decoderPkg::LDBS_IA;
            architecture::LDBS_IB:  instruction = decoderPkg::LDBS_IB;
            architecture::LDBU_PR:  instruction = decoderPkg::LDBU_PR;
            architecture::LDBU_RO:  instruction = decoderPkg::LDBU_RO;
            architecture::LDBU_IA:  instruction = decoderPkg::LDBU_IA;
            architecture::LDBU_IB:  instruction = decoderPkg::LDBU_IB;
            architecture::LDD_PR:   instruction = decoderPkg::LDD_PR;
            architecture::LDD_RO:   instruction = decoderPkg::LDD_RO;
            architecture::LDD_IA:   instruction = decoderPkg::LDD_IA;
            architecture::LDD_IB:   instruction = decoderPkg::LDD_IB;
            architecture::LDWS_PR:  instruction = decoderPkg::LDWS_PR;
            architecture::LDWS_RO:  instruction = decoderPkg::LDWS_RO;
            architecture::LDWS_IA:  instruction = decoderPkg::LDWS_IA;
            architecture::LDWS_IB:  instruction = decoderPkg::LDWS_IB;
            architecture::LDWU_PR:  instruction = decoderPkg::LDWU_PR;
            architecture::LDWU_RO:  instruction = decoderPkg::LDWU_RO;
            architecture::LDWU_IA:  instruction = decoderPkg::LDWU_IA;
            architecture::LDWU_IB:  instruction = decoderPkg::LDWU_IB;
            architecture::MOV_I:    instruction = decoderPkg::MOV_I;
            architecture::MOV_R:    instruction = decoderPkg::MOV_R;
            architecture::MUI_I:    instruction = decoderPkg::MUI_I;
            architecture::NOP_R:    instruction = decoderPkg::NOP_R;
            architecture::NOT_R:    instruction = decoderPkg::NOT_R;
            architecture::OR_I:     instruction = decoderPkg::OR_I;
            architecture::OR_R:     instruction = decoderPkg::OR_R;
            architecture::RCL_I:    instruction = decoderPkg::RCL_I;
            architecture::RCL_R:    instruction = decoderPkg::RCL_R;
            architecture::RCR_I:    instruction = decoderPkg::RCR_I;
            architecture::RCR_R:    instruction = decoderPkg::RCR_R;
            architecture::ROL_I:    instruction = decoderPkg::ROL_I;
            architecture::ROL_R:    instruction = decoderPkg::ROL_R;
            architecture::ROR_I:    instruction = decoderPkg::ROR_I;
            architecture::ROR_R:    instruction = decoderPkg::ROR_R;
            architecture::LSR_R:    instruction = decoderPkg::LSR_R;
            architecture::SAR_I:    instruction = decoderPkg::SAR_I;
            architecture::SAR_R:    instruction = decoderPkg::SAR_R;
            architecture::SBB_I:    instruction = decoderPkg::SBB_I;
            architecture::SBB_R:    instruction = decoderPkg::SBB_R;
            architecture::SDIV_R:   instruction = decoderPkg::SDIV_R;
            architecture::SHL_I:    instruction = decoderPkg::SHL_I;
            architecture::SHL_R:    instruction = decoderPkg::SHL_R;
            architecture::SHR_I:    instruction = decoderPkg::SHR_I;
            architecture::SHR_R:    instruction = decoderPkg::SHR_R;
            architecture::SMUL_R:   instruction = decoderPkg::SMUL_R;
            architecture::SSR_R:    instruction = decoderPkg::SSR_R;
            architecture::STB_PR:   instruction = decoderPkg::STB_PR;
            architecture::STB_RO:   instruction = decoderPkg::STB_RO;
            architecture::STB_IA:   instruction = decoderPkg::STB_IA;
            architecture::STB_IB:   instruction = decoderPkg::STB_IB;
            architecture::STD_PR:   instruction = decoderPkg::STD_PR;
            architecture::STD_RO:   instruction = decoderPkg::STD_RO;
            architecture::STD_IA:   instruction = decoderPkg::STD_IA;
            architecture::STD_IB:   instruction = decoderPkg::STD_IB;
            architecture::STW_PR:   instruction = decoderPkg::STW_PR;
            architecture::STW_RO:   instruction = decoderPkg::STW_RO;
            architecture::STW_IA:   instruction = decoderPkg::STW_IA;
            architecture::STW_IB:   instruction = decoderPkg::STW_IB;
            architecture::SUB_I:    instruction = decoderPkg::SUB_I;
            architecture::SUB_R:    instruction = decoderPkg::SUB_R;
            architecture::TEQ_I:    instruction = decoderPkg::TEQ_I;
            architecture::TEQ_R:    instruction = decoderPkg::TEQ_R;
            architecture::TST_I:    instruction = decoderPkg::TST_I;
            architecture::TST_R:    instruction = decoderPkg::TST_R;
            architecture::UADC_I:   instruction = decoderPkg::UADC_I;
            architecture::UADC_R:   instruction = decoderPkg::UADC_R;
            architecture::UADD_I:   instruction = decoderPkg::UADD_I;
            architecture::UADD_R:   instruction = decoderPkg::UADD_R;
            architecture::UCMP_I:   instruction = decoderPkg::UCMP_I;
            architecture::UCMP_R:   instruction = decoderPkg::UCMP_R;
            architecture::UDIV_R:   instruction = decoderPkg::UDIV_R;
            architecture::UMUL_R:   instruction = decoderPkg::UMUL_R;
            architecture::USBB_I:   instruction = decoderPkg::USBB_I;
            architecture::USBB_R:   instruction = decoderPkg::USBB_R;
            architecture::USUB_I:   instruction = decoderPkg::USUB_I;
            architecture::USUB_R:   instruction = decoderPkg::USUB_R;
            architecture::XOR_I:    instruction = decoderPkg::XOR_I;
            architecture::XOR_R:    instruction = decoderPkg::XOR_R;

            architecture::UKN1_R:   instruction = decoderPkg::UKN1_R; // undefined instructions below here
            architecture::UKN2_R:   instruction = decoderPkg::UKN2_R;
            architecture::UKN3_R:   instruction = decoderPkg::UKN3_R;
            architecture::UKN4_R:   instruction = decoderPkg::UKN4_R;
            architecture::UKN5_R:   instruction = decoderPkg::UKN5_R;
            architecture::UKN6_R:   instruction = decoderPkg::UKN6_R;
            architecture::UKN7_R:   instruction = decoderPkg::UKN7_R;
            architecture::UKN8_R:   instruction = decoderPkg::UKN8_R;
            architecture::UKN9_R:   instruction = decoderPkg::UKN9_R;
            architecture::UKN10_R:  instruction = decoderPkg::UKN10_R;
            architecture::UKN11_R:  instruction = decoderPkg::UKN11_R;
            architecture::UKN12_R:  instruction = decoderPkg::UKN12_R;
            architecture::UKN13_R:  instruction = decoderPkg::UKN13_R;
            architecture::UKN14_R:  instruction = decoderPkg::UKN14_R;
            architecture::UKN15_R:  instruction = decoderPkg::UKN15_R;
            architecture::UKN16_R:  instruction = decoderPkg::UKN16_R;
            architecture::UKN17_R:  instruction = decoderPkg::UKN17_R;
            architecture::UKN18_R:  instruction = decoderPkg::UKN18_R;
            architecture::UKN19_R:  instruction = decoderPkg::UKN19_R;
            architecture::UKN20_R:  instruction = decoderPkg::UKN20_R;
            architecture::UKN21_R:  instruction = decoderPkg::UKN21_R;
            architecture::UKN22_R:  instruction = decoderPkg::UKN22_R;
            architecture::UKN23_R:  instruction = decoderPkg::UKN23_R;
            architecture::UKN24_R:  instruction = decoderPkg::UKN24_R;

            architecture::UKN1_I:   instruction = decoderPkg::UKN1_I;
            architecture::UKN2_I:   instruction = decoderPkg::UKN2_I;
            architecture::UKN3_I:   instruction = decoderPkg::UKN3_I;
            architecture::UKN4_I:   instruction = decoderPkg::UKN4_I;
            architecture::UKN5_I:   instruction = decoderPkg::UKN5_I;
            architecture::UKN6_I:   instruction = decoderPkg::UKN6_I;
            architecture::UKN7_I:   instruction = decoderPkg::UKN7_I;
            architecture::UKN8_I:   instruction = decoderPkg::UKN8_I;
            architecture::UKN9_I:   instruction = decoderPkg::UKN9_I;

            default:                instruction = decoderPkg::XXX;
        endcase
    end


endmodule

