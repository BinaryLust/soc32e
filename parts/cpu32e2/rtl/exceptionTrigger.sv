

package exceptionTriggerGroup;


    import boolPkg::*;


    // control group structure
    typedef struct packed {
        bool                breakException;
        bool                systemException;
        bool                unknownException;
        bool                instructionAlignmentException;
        bool                dataAlignmentException;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP     = '{breakException:F, systemException:F, unknownException:F, instructionAlignmentException:F, dataAlignmentException:F},
        BREAK_EXC = '{breakException:T, systemException:F, unknownException:F, instructionAlignmentException:F, dataAlignmentException:F},
        SYS_EXC   = '{breakException:F, systemException:T, unknownException:F, instructionAlignmentException:F, dataAlignmentException:F},
        UNK_EXC   = '{breakException:F, systemException:F, unknownException:T, instructionAlignmentException:F, dataAlignmentException:F},
        INSTA_EXC = '{breakException:F, systemException:F, unknownException:F, instructionAlignmentException:T, dataAlignmentException:F},
        DATAA_EXC = '{breakException:F, systemException:F, unknownException:F, instructionAlignmentException:F, dataAlignmentException:T};


endpackage

