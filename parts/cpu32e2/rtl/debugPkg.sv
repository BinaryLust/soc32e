

package debugPkg;


    typedef struct packed {

        // control line outputs
        logic                fetchCycle;       // used to signal if the cpu controller is in any fetch state
        logic                machineCycleDone; // used to signal when the cpu has gone through an entire machine cycle and has written state back


        // register file outputs
        logic  [31:0][31:0]  regfileState;


        // program counter outputs
        logic  [31:0]        nextPCState;


        // other cpu state
        logic  [3:0]         flagsState;
        logic  [7:0]         systemCallState;
        logic  [31:0]        isrBaseAddressState;
        logic                interruptEnableState;
        logic  [15:0]        exceptionMaskState;
        logic  [4:0]         causeState;

    } debugLines;


endpackage

