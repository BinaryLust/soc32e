

package exceptionTriggerGroup;


    import boolPkg::*;


    // control group structure
    typedef struct packed {
        bool                breakException;
        bool                systemException;
        bool                unknownException;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP     = '{breakException:F, systemException:F, unknownException:F},
        BREAK_EXC = '{breakException:T, systemException:F, unknownException:F},
        SYS_EXC   = '{breakException:F, systemException:T, unknownException:F},
        UNK_EXC   = '{breakException:F, systemException:F, unknownException:T};


endpackage

