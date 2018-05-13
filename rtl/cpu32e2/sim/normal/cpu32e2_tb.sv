`timescale 1ns / 100ps


`include "E:/My Code/systemverilog/soc32/cpu32e2/rtl/globals.sv"


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
    debugPkg::debugLines          debugOut;

    logic                                 interruptAcknowledge;
    logic                 [3:0]           interruptOut;
    logic                                 read;
    logic                                 write;
    logic                 [3:0]           byteWriteEnable;
    logic                 [31:0]          dataOut;
    logic                 [31:0]          addressOut;


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
        .byteWriteEnable,
        .dataOut,
        .addressOut
    );


    testRam
    testRam(
        .clk,
        .reset,
        .we        (write),
        .address   (addressOut[11:2]),
        .bwe       (byteWriteEnable),
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


    integer        seed = 125376;
    integer        i = 0;


    // disassbmler
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

        // run some instructions
        repeat(100000) begin
            wait(debugOut.fetchCycle && read) doImmInstruction();

            wait(debugOut.machineCycleDone)
            model.run(instructionData);

            instructionDecoder.decode(instructionData);
            instructionStr = instructionDecoder.toString();

            // register file check
            for(i = 0; i < 32; i++)
                if(debugOut.regfileState[i] != model.regfile[i])
                    $fatal("Register File Miss Match! - got: %h expected: %h - %s", debugOut.regfileState[i], model.regfile[i], instructionStr);

            // program counter check
            if(debugOut.nextPCState != model.nextPC)   $fatal("Program Counter Miss Match! - got: %h expected: %h - %s", debugOut.nextPCState, model.nextPC, instructionStr);

            // flags check
            if(debugOut.flagsState != {model.negativeFlag, model.overflowFlag, model.zeroFlag, model.carryFlag}) $fatal("Flags Miss Match! - got: %h expected: %h - %s", debugOut.flagsState, {model.negativeFlag, model.overflowFlag, model.zeroFlag, model.carryFlag}, instructionStr);

            // system call check
            if(debugOut.systemCallState != model.systemCall) $fatal("System Call Miss Match! - got: %h expected: %h - %s", debugOut.systemCallState, model.systemCall, instructionStr);

            // isr base check
            if(debugOut.isrBaseAddressState != model.isrBaseAddress) $fatal("ISR Base Address Miss Match! - got: %h expected: %h - %s", debugOut.isrBaseAddressState, model.isrBaseAddress, instructionStr);

            // interrupt enable check
            if(debugOut.interruptEnableState != model.interruptEn) $fatal("Interrupt Enable Miss Match! - got: %h expected: %h - %s", debugOut.interruptEnableState, model.interruptEn, instructionStr);

            // exception mask check
            if(debugOut.exceptionMaskState != model.exceptionMask) $fatal("Exception Mask Miss Match! - got: %h expected: %h - %s", debugOut.exceptionMaskState, model.exceptionMask, instructionStr);

            // cause check
            if(debugOut.causeState != model.cause) $fatal("Cause Miss Match! - got: %h expected: %h - %s", debugOut.causeState, model.cause, instructionStr);

            // memory check
            for(i = 0; i < 1024; i++)
                if(ramState[i] != model.memory[i])
                    $fatal("Memory Miss Match! - got: %h expected: %h - %s", ramState[i], model.memory[i], instructionStr);
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


    task doImmInstruction();


        import architecture::*;


        opcodes          instruction;
        logic    [4:0]   dr;
        logic    [4:0]   sra;
        logic    [15:0]  imm;


        // generate random destinations and sources
        dr  = $urandom_range(0, 31);
        sra = $urandom_range(0, 31);


        // generate random immediate value
        imm = $urandom(); //$urandom_range(0, 255);


        // pick one of these instructions randomly
        case($urandom_range(0, 10))//randcase
            0:       instruction = UADC_I;
            1:       instruction = UADD_I;
            //2:       instruction = USUB_I;
            //3:       instruction = USBB_I;
            4:       instruction = ADC_I;
            5:       instruction = ADD_I;
            //6:       instruction = SBB_I;
            //7:       instruction = SUB_I;
            8:       instruction = AND_I;
            9:       instruction = OR_I;
            10:      instruction = XOR_I;
            default: instruction = UADC_I;
        endcase


        // random wait cycles
        #1 instructionWait = 1'b1;
        repeat($urandom_range(0, 3)) @(posedge clk);
        #1 instructionWait = 1'b0;


        // random cycles before ready
        instructionValid   = 1'b0;
        repeat($urandom_range(2, 4)) @(posedge clk);


        // put instruction on data in
        instructionValid = 1'b1;
        instructionData  = $urandom();//{instruction[11:6], dr, sra, imm}; // finished instruction
        @(posedge clk);
        instructionValid = 1'b0;
    endtask


    //task startOperation(
    //	input  aluOpType                    operationType,
    //	input  logic      unsigned  [31:0]  opA,
   // input  logic      unsigned  [31:0]  opB,
    //	input  logic      unsigned          carryInput
    //	);


        //@(posedge clk);
    //	wait(ready);
    //	#1 opType = operationType; carryIn = carryInput; operandA = opA; operandB = opB; validIn = 1'b1;
    //	@(posedge clk);
    //	#1 validIn = 1'b0;

        // normal check
        //wait(validOut);

        // test results after negative clock edge
        //@(negedge clk);

    //endtask


endmodule

