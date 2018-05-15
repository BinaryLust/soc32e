

// all addresses are 32 bits

// address 0 - timer 1 count       // read/write
// address 1 - timer 2 count       // read/write
// address 2 - timer 3 count       // read/write
// address 3 - timer 1 reset value // read/write
// address 4 - timer 2 reset value // read/write
// address 5 - timer 3 reset value // read/write
// address 6 - control register    // read/write  interrupt generation enable
// address 7 - not used


// other features we could add
// running, triggered
// milli/micro second mode select

// use a reference 1 MHz clock and an edge detector like before to keep the timing the same no matter the bus frequency

module timer(
    input   logic          clk,
    input   logic          reset,
    input   logic          read,
    input   logic          write,
    input   logic  [2:0]   address,
    input   logic  [31:0]  dataIn,

    output  logic          readValid,
    output  logic  [31:0]  dataOut,
    output  logic  [2:0]   irq
    );


    // control lines/registers
    logic  [31:0]  dataInReg;
    logic          readReg;
    logic          writeReg;
    logic  [2:0]   addressReg;
    logic  [31:0]  readMux;



    // write enable lines
    logic          timer1CountLoadEn;
    logic          timer2CountLoadEn;
    logic          timer3CountLoadEn;
    logic          timer1ResetValueLoadEn;
    logic          timer2ResetValueLoadEn;
    logic          timer3ResetValueLoadEn;
    logic          interruptEnableLoadEn;


    // read data lines
    logic  [31:0]  timer1Count;
    logic  [31:0]  timer2Count;
    logic  [31:0]  timer3Count;
    logic  [31:0]  timer1ResetValue;
    logic  [31:0]  timer2ResetValue;
    logic  [31:0]  timer3ResetValue;
    logic  [2:0]   interruptEnable;


    // control registers
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            readReg       <= 1'b0;
            writeReg      <= 1'b0;
            readValid     <= 1'b0;
            addressReg    <= 3'd0;
        end else begin
            readReg       <= read;
            writeReg      <= write;
            readValid     <= readReg;
            addressReg    <= address;
        end
    end


    // data input/output registers
    always_ff @(posedge clk) begin
        dataInReg <= dataIn;
        dataOut   <= readMux;
    end


    // write decoder
    always_comb begin
        // defaults
        timer1CountLoadEn      = 1'b0;
        timer2CountLoadEn      = 1'b0;
        timer3CountLoadEn      = 1'b0;
        timer1ResetValueLoadEn = 1'b0;
        timer2ResetValueLoadEn = 1'b0;
        timer3ResetValueLoadEn = 1'b0;
        interruptEnableLoadEn  = 1'b0;

        if(writeReg) begin
            case(addressReg)
                3'd0: timer1CountLoadEn      = 1'b1;
                3'd1: timer2CountLoadEn      = 1'b1;
                3'd2: timer3CountLoadEn      = 1'b1;
                3'd3: timer1ResetValueLoadEn = 1'b1;
                3'd4: timer2ResetValueLoadEn = 1'b1;
                3'd5: timer3ResetValueLoadEn = 1'b1;
                3'd6: interruptEnableLoadEn  = 1'b1;
                default: ;
            endcase
        end
    end


    // read mux
    always_comb begin
        // default
        readMux = 32'd0;

        case(addressReg)
            3'd0: readMux = timer1Count;
            3'd1: readMux = timer2Count;
            3'd2: readMux = timer3Count;
            3'd3: readMux = timer1ResetValue;
            3'd4: readMux = timer2ResetValue;
            3'd5: readMux = timer3ResetValue;
            3'd6: readMux = {29'd0, interruptEnable};
            default: ;
        endcase
    end


    timerCore
    timerCore(
        .clk,
        .reset,
        .timer1CountIn            (dataInReg),
        .timer2CountIn            (dataInReg),
        .timer3CountIn            (dataInReg),
        .timer1ResetValueIn       (dataInReg),
        .timer2ResetValueIn       (dataInReg),
        .timer3ResetValueIn       (dataInReg),
        .interruptEnableIn        (dataInReg[2:0]),
        .timer1CountLoadEn,
        .timer2CountLoadEn,
        .timer3CountLoadEn,
        .timer1ResetValueLoadEn,
        .timer2ResetValueLoadEn,
        .timer3ResetValueLoadEn,
        .interruptEnableLoadEn,
        .timer1Count,
        .timer2Count,
        .timer3Count,
        .timer1ResetValue,
        .timer2ResetValue,
        .timer3ResetValue,
        .interruptEnable,
        .irq
    );


endmodule

