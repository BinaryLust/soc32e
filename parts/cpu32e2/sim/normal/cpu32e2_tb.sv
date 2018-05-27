`timescale 1ns / 100ps


`include "G:/My Code/on git/systemverilog/soc32e/parts/cpu32e2/rtl/globals.sv"


module cpu32e2_tb();


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* wire declaration                                                                                                                                      */
    /*                                                                                                                                                       */
     /*********************************************************************************************************************************************************/


     // input wires
    logic                                 clk;
    logic                                 reset;
    logic                                 waitRequest;
    logic                                 readValid;
    logic                                 interruptRequest;
    logic                 [3:0]           interruptIn;
    logic                 [31:0]          dataIn;


    // output wires
    debugPkg::debugLines                  debugOut;

    logic                                 interruptAcknowledge;
    logic                 [3:0]           interruptOut;
    logic                                 read;
    logic                                 write;
    logic                 [3:0]           bwe;
    logic                 [31:0]          dataOut;
    logic                 [31:0]          address;


    // debug wires
    logic                 [31:0]          ramQ;
    logic                 [31:0]          instructionData;
    logic                                 instructionWait;
    logic                                 instructionValid;
    logic                 [1023:0][31:0]  ramState;

    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test module instantiation                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    cpu32e2
    dut(
        .clk,
        .reset,
        .waitRequest,
        .readValid,
        .interruptRequest,
        .interruptIn,
        .dataIn,

        `ifdef  DEBUG
        .debugOut,
        `endif

        .interruptAcknowledge,
        .interruptOut,
        .read,
        .write,
        .bwe,
        .dataOut,
        .address
    );


    testRam
    testRam(
        .clk,
        .reset,
        .we        (write),
        .address   (address[11:2]),
        .bwe       (bwe),
        .d         (dataOut),
        .q         (ramQ),
        .ramState
    );


    // instruction injection mux
    always_comb begin
        // data in mux
        case(debugOut.fetchCycle)
            1'b0: dataIn = ramQ;            // memory block
            1'b1: dataIn = instructionData; // randomly generated instruction
        endcase


        // wait request mux
        case(debugOut.fetchCycle)
            1'b0: waitRequest = 1'b0;            // never wait
            1'b1: waitRequest = instructionWait;
        endcase


        // read valid mux
        case(debugOut.fetchCycle)
            1'b0: readValid = 1'b1;              // always valid
            1'b1: readValid = instructionValid;
        endcase
    end


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* testing variables                                                                                                                                     */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    integer        seed = 129347;
    integer        i = 0;

    // coverage variables
    int            instructionsRan = 0;
    int            cov_bins[127];
    logic    [5:0] opcode;
    logic    [5:0] rcode;

    // disassembler
    import disassembler::*;

    decoder        instructionDecoder;
    string         instructionStr;


    // cpu model
    import cpu32e2_modelPkg::*;

    cpu32e2_model  model;


    // test value size bins
    //int  unsigned  usize[10] = '{10, 100, 1000, 10000, 100000, 1000000, 10000000, 100000000, 1000000000, 4294967295};
    //int  unsigned  ssize[10] = '{20, 200, 2000, 20000, 200000, 2000000, 20000000, 200000000, 2000000000, 4294967294};


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* test stimulus                                                                                                                                         */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    // set initial values
    initial begin
        reset                        = 1'b0;
        //waitRequest                  = 1'b0;
        //readValid                    = 1'b0; //1'b1;  // set always valid
        interruptRequest             = 1'b0;
        interruptIn                  = 4'd0;
        //dataIn                       = 32'd0; //{6'd50, 5'd0, 5'd0, 16'd1}; // uadd r0, r0, 1 // UADD_I  = {6'd50, 6'd? },

        instructionData              = 32'b0;
        instructionWait              = 1'b0;
        instructionValid             = 1'b0;
    end


    // create clock sources
    always begin
        #5;
        clk = 1'b0;
        #5;
        clk = 1'b1;
    end


    // simple instruction coverage
    always begin
        // sample instruction value when valid
        @(posedge instructionValid);
        instructionsRan++;

        opcode = instructionData[31:26];
        rcode  = instructionData[5:0];

        if(opcode == 6'd0)
            cov_bins[rcode+7'd0]++;
        else
            cov_bins[opcode+7'd63]++;
    end


    // apply test stimulus
    // synopsys translate_off
    initial begin
        // set errors to zero
        //errorCount = 0;

        // set the random seed
        $urandom(seed);//x = $urandom(seed);//$srandom(seed);

        // create a new instruction decoder
        instructionDecoder = new();

        // create a new cpu model object
        model = new();

        // reset the system
        hardwareReset();

        // make sure all exceptions work
        testExceptions();

        // test 100k random instructions
        repeat(100000) begin
            // 1 out of 10 cycles will end with an interrupt
            case($urandom_range(0, 9))//randcase
                0,
                1,
                2,
                3,
                4,
                5,
                6,
                7,
                8: doTest(randInstruction(), 1'b0, 4'd0);    // normal instruction cycle test
                9: doTest(randInstruction(), 1'b1, $random); // interrupt test
            endcase
        end

        // print out instruction coverage
        $display("Instruction coverage info below------------------------------------------");
        $display("Instructions ran: %d", instructionsRan);
        for(int i = 0; i < 127; i++) begin
            if(cov_bins[i] > 0)
                $display("Instruction %d covered, %d times", i, cov_bins[i]);
            else
                $display("Instruction %d not covered", i);
        end

        // finish
        //$display("%d Errors", errorCount);
        $stop;
    end
    // synopsys translate_on


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* tasks                                                                                                                                                 */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    task hardwareReset();
        reset = 1'b0;
        wait(clk !== 1'bx);
        @(posedge clk);
        reset = 1'b1;
        repeat(10) @(posedge clk);
        reset = 1'b0;
    endtask


    // enable interrupts and all exceptions
    task turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_11111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 0ffffh
        doTest(32'b000000_00001_00000_00000_00000_100011, 1'b0, 4'd0); // ssr sys1, r0
    endtask


    task testExceptions();
        // test unknown instruction exception
        turnOnExceptions();
        doTest(32'b11111111111111111111111111111111, 1'b0, 4'd0);   // unknown instruction

        // test int exception
        turnOnExceptions();
        doTest(32'b001001_0000000000_0000000000000000, 1'b0, 4'd0); // int 0

        // test break exception
        turnOnExceptions();
        doTest(32'b000000_00000000000000000000_000100, 1'b0, 4'd0); // break

        // test overflow exception from adc reg
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b000000_00000_00000_00000_00000_000000, 1'b0, 4'd0); // adc r0, r0, r0

        // test overflow exception from adc imm
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b000001_00000_00000_0000000000000001, 1'b0, 4'd0);   // adc r0, r0, 1

        // test overflow exception from add reg
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b000000_00000_00000_00000_00000_000001, 1'b0, 4'd0); // add r0, r0, r0

        // test overflow exception from add imm
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b000010_00000_00000_0000000000000001, 1'b0, 4'd0);   // add r0, r0, 1

        // test overflow exception from sbb reg
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b011110_00001_111111111111111111110, 1'b0, 4'd0);    // mov r1, -2
        doTest(32'b000000_00000_00000_00001_00000_011100, 1'b0, 4'd0); // sbb r0, r0, r1

        // test overflow exception from sbb imm
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b100001_00000_00000_1111111111111110, 1'b0, 4'd0);   // sbb r0, r0, -2

        // test overflow exception from sub reg
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b011110_00001_111111111111111111110, 1'b0, 4'd0);    // mov r1, -2
        doTest(32'b000000_00000_00000_00001_00000_100111, 1'b0, 4'd0); // sub r0, r0, r1

        // test overflow exception from sub imm
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b101110_00000_00000_1111111111111110, 1'b0, 4'd0);   // sub r0, r0, -2

        // test overflow exception from cmp reg
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b011110_00001_111111111111111111110, 1'b0, 4'd0);    // mov r1, -2
        doTest(32'b000000_00000_00000_00001_00000_000110, 1'b0, 4'd0); // cmp r0, r1

        // test overflow exception from cmp imm
        turnOnExceptions();
        doTest(32'b011110_00000_000001111111111111111, 1'b0, 4'd0);    // mov r0, 0ffffh
        doTest(32'b011111_00000_01111_00000_11111111111, 1'b0, 4'd0);  // mui r0, r0, 07fffh
        doTest(32'b001000_11111_00000_1111111111111110, 1'b0, 4'd0);   // cmp r0, -2

        // test divide by zero exception from udiv
        turnOnExceptions();
        doTest(32'b011110_00000_000000000000000000000, 1'b0, 4'd0);    // mov r0, 0
        doTest(32'b000000_00000_00000_00000_00000_101101, 1'b0, 4'd0); // udiv r0, r0, r0, r0

        // test divide by zero exception from sdiv
        turnOnExceptions();
        doTest(32'b011110_00000_000000000000000000000, 1'b0, 4'd0);    // mov r0, 0
        doTest(32'b000000_00000_00000_00000_00000_011101, 1'b0, 4'd0); // sdiv r0, r0, r0, r0
    endtask


    task doTest(
        input  logic  [31:0]  instruction,
        input  logic          doInterrupt,
        input  logic  [3:0]   interrupt
        );

        bit missMatch;

        // decode instruction into readable string
        instructionDecoder.decode(instruction);
        instructionStr = instructionDecoder.toString();

        // run instruction on simulated model
        model.run(instruction, doInterrupt, interrupt);

        // run instruction on actual hardware
        runInstruction(instruction, doInterrupt, interrupt);

        // do checks on make sure both models are the same
        missMatch = 1'b0;

        // register file check
        for(i = 0; i < 32; i++) begin
            if(debugOut.regfileState[i] != model.regfile[i]) begin
                missMatch = 1'b1;
                $warning("Register File Miss Match! - got: %h expected: %h at register: %d - %s", debugOut.regfileState[i], model.regfile[i], i, instructionStr);
            end
        end

        // program counter check
        if(debugOut.nextPCState != model.nextPC) begin
            missMatch = 1'b1;
            $warning("Program Counter Miss Match! - got: %h expected: %h - %s", debugOut.nextPCState, model.nextPC, instructionStr);
        end

        // flags check
        if(debugOut.flagsState != {model.negativeFlag, model.overflowFlag, model.zeroFlag, model.carryFlag}) begin
            missMatch = 1'b1;
            $warning("Flags Miss Match! - got: %h expected: %h - %s", debugOut.flagsState, {model.negativeFlag, model.overflowFlag, model.zeroFlag, model.carryFlag}, instructionStr);
        end

        // system call check
        if(debugOut.systemCallState != model.systemCall) begin
            missMatch = 1'b1;
            $warning("System Call Miss Match! - got: %h expected: %h - %s", debugOut.systemCallState, model.systemCall, instructionStr);
        end

        // isr base check
        if(debugOut.isrBaseAddressState != model.isrBaseAddress) begin
            missMatch = 1'b1;
            $warning("ISR Base Address Miss Match! - got: %h expected: %h - %s", debugOut.isrBaseAddressState, model.isrBaseAddress, instructionStr);
        end

        // interrupt enable check
        if(debugOut.interruptEnableState != model.interruptEn) begin
            missMatch = 1'b1;
            $warning("Interrupt Enable Miss Match! - got: %h expected: %h - %s", debugOut.interruptEnableState, model.interruptEn, instructionStr);
        end

        // exception mask check
        if(debugOut.exceptionMaskState != model.exceptionMask) begin
            missMatch = 1'b1;
            $warning("Exception Mask Miss Match! - got: %h expected: %h - %s", debugOut.exceptionMaskState, model.exceptionMask, instructionStr);
        end

        // cause check
        if(debugOut.causeState != model.cause) begin
            missMatch = 1'b1;
            $warning("Cause Miss Match! - got: %h expected: %h - %s", debugOut.causeState, model.cause, instructionStr);
        end

        // memory check
        for(i = 0; i < 1024; i++) begin
            if(ramState[i] != model.memory[i]) begin
                missMatch = 1'b1;
                $warning("Memory Miss Match! - got: %h expected: %h at address: %d- %s", ramState[i], model.memory[i], i, instructionStr);
            end
        end

        if(missMatch == 1'b1)
            $fatal("1 or more miss matches!");
    endtask


    task runInstruction(
        input  logic  [31:0]  instruction,
        input  logic          doInterrupt,
        input  logic  [3:0]   interrupt
        );

        // wait for instruction cycle to start
        wait(debugOut.fetchCycle && read);

        // apply interrupt signals
        interruptRequest = doInterrupt;
        interruptIn      = interrupt;

        // random wait cycles
        #1 instructionWait = 1'b1;
        repeat($urandom_range(0, 3)) @(posedge clk);
        #1 instructionWait = 1'b0;

        // random cycles before ready
        instructionValid   = 1'b0;
        repeat($urandom_range(2, 4)) @(posedge clk);

        // put instruction on data in
        instructionValid = 1'b1;
        instructionData  = instruction;
        @(posedge clk);
        instructionValid = 1'b0;

        // wait for instruction to complete
        wait(debugOut.machineCycleDone);

        // reset interrupt request singal
        interruptRequest = 1'b0;

    endtask


    /*********************************************************************************************************************************************************/
    /*                                                                                                                                                       */
    /* functions                                                                                                                                             */
    /*                                                                                                                                                       */
    /*********************************************************************************************************************************************************/


    function logic [31:0] randInstruction();
        logic r;

        r = $random();

        case(r)
            1'b0: return randImmInstruction();
            1'b1: return randRegInstruction();
        endcase
    endfunction


    function logic [31:0] randImmInstruction();
        logic  [5:0]   opcode;
        logic  [25:0]  theRest;

        opcode  = $urandom_range(1, 63);
        theRest = $random();

        return {opcode, theRest};
    endfunction


    function logic [31:0] immInstruction(
        input  logic  [5:0]  opcode
        );
        logic  [25:0]  theRest;

        theRest = $random();

        return {opcode, theRest};
    endfunction


    function logic [31:0] randRegInstruction();
        logic    [5:0]   rcode;
        logic    [19:0]  theRest;

        rcode   = $urandom_range(0, 63);
        theRest = $random();

        return {6'd0, theRest, rcode};
    endfunction


    function logic [31:0] regInstruction(
        input  logic  [5:0]  rcode
        );

        logic    [5:0]   opcode;
        logic    [19:0]  theRest;

        theRest = $random();

        return {6'd0, theRest, rcode};
    endfunction


endmodule

