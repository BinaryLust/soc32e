

module divider2Controller(
    input   logic                              clk,
    input   logic                              reset,
    input   logic                              sign,
    input   logic                              dividerStart,
    input   logic                      [31:0]  dividendIn,
    input   logic                      [31:0]  divisorIn,
    input   logic                              wasNegative,

    output  boolPkg::bool                      dividendEn,
    output  divider2Pkg::dividendMux           dividendSel,
    output  logic                              fillerBit,
    output  boolPkg::bool                      divisorEn,
    output  divider2Pkg::divisorMux            divisorSel,
    output  boolPkg::bool                      remainderEn,
    output  divider2Pkg::remainderMux          remainderSel,
    output  logic                              dividerDone,
    output  logic                              dividerError
    );


    import boolPkg::*;
    import divider2Pkg::*;


    typedef enum logic [1:0] {LOAD, DIVIDE, FINISH} states;


    states         state;
    states         nextState;
    logic   [5:0]  bitCounter;
    logic   [5:0]  bitCounterValue;
    logic          quotientNegate;
    logic          quotientNegateValue;
    logic          remainderNegate;
    logic          remainderNegateValue;
    logic          dividerDoneValue;
    logic          dividerErrorValue;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= LOAD;
        else
            state <= nextState;
    end


    // bit counter register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            bitCounter <= 6'd0;
        else
            bitCounter <= bitCounterValue;
    end


    // quotient negation register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            quotientNegate <= 1'b0;
        else
            quotientNegate <= quotientNegateValue;
    end


    // remainder negation register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            remainderNegate <= 1'b0;
        else
            remainderNegate <= remainderNegateValue;
    end


    // combinationial logic
    always_comb begin
        // defaults
        nextState            = LOAD;
        bitCounterValue      = bitCounter;      // old value
        quotientNegateValue  = quotientNegate;  // old value
        remainderNegateValue = remainderNegate; // old value

        dividendEn           = F;
        dividendSel          = DIVIDEND_IN;
        fillerBit            = 1'b0;
        divisorEn            = F;
        divisorSel           = DIVISOR_IN;
        remainderEn          = F;
        remainderSel         = RESET_REMAINDER;
        dividerDoneValue     = 1'b0;
        dividerErrorValue    = 1'b0;


        case(state)
            LOAD: begin
                // output logic
                bitCounterValue = 6'd0;		      // reset bit counter

                if(dividerStart) begin
                    if(divisorIn == 32'b0) begin // check for divide by zero
                        // output logic
                        dividendEn    = T;               // enable dividend loading
                        dividendSel   = RESET_DIVIDEND;  // reset quotient

                        remainderEn   = T;               // enable remainder loading
                        remainderSel  = RESET_REMAINDER; // reset remainder

                        dividerDoneValue  = 1'b1;        // set done
                        dividerErrorValue = 1'b1;        // set dividerError


                        // next state logic
                        nextState = LOAD;
                    end else begin
                        // output logic
                        quotientNegateValue  = sign & (dividendIn[31] ^ divisorIn[31]); // set quotient negate if dividend and divisor sign bits don't match
                        remainderNegateValue = sign & dividendIn[31];                   // set remainder negate if dividend is negative

                        dividendEn      = T;               // enable dividend loading
                        if(sign & dividendIn[31])
                            dividendSel = NEG_DIVIDEND_IN; // if sign is set and dividend_in is negative then load negative dividend_in
                        else
                            dividendSel = DIVIDEND_IN;     // else load dividend with unmodified dividend_in

                        divisorEn       = T;               // enable divisor loading
                        if(sign & divisorIn[31])
                            divisorSel  = NEG_DIVISOR_IN;  // if sign is set and divisor_in is negative then load negative dividend_in
                        else
                            divisorSel  = DIVISOR_IN;      // else load divisor with unmodified divisor_in

                        remainderEn     = T;               // enable remainder loading
                        remainderSel    = RESET_REMAINDER; // reset remainder


                        // next state logic
                        nextState = DIVIDE;
                    end
                end else begin
                    // next state logic
                    nextState = LOAD;
                end
            end

            DIVIDE: begin
                // output logic
                bitCounterValue  = bitCounter + 6'd1;    // increment bit counter

                dividendEn       = T;                    // enable dividend loading
                dividendSel      = SHIFTED_DIVIDEND;     // load dividend with shifted dividend

                remainderEn      = T;                    // enable remainder loading
                if(wasNegative) begin
                    remainderSel = SHIFTED_REMAINDER;    // load shifted remainder
                    fillerBit    = 1'b0;                 // set filler bit to 0
                end else begin
                    remainderSel = SUBTRACTED_REMAINDER; // load remainder
                    fillerBit    = 1'b1;                 // set filler bit to 1
                end

                // for cpu division
                dividerDoneValue = (bitCounter == 6'd31) ? 1'b1 : 1'b0; // send the division done signal (cpu operation, signal is high on the same cycle the result is latched)


                // next state logic
                nextState = (bitCounter == 6'd31) ? FINISH : DIVIDE; // if bit counter is 31 we will be done with division on the next cycle else keep going
            end

            FINISH: begin
                // output logic
                if(quotientNegate) begin
                    dividendEn   = T;                    // enable dividend loading
                    dividendSel  = NEG_DIVIDEND;         // negate dividend which is now the quotient to get final result
                end

                if(remainderNegate) begin
                    remainderEn  = T;                    // enable remainder loading
                    remainderSel = NEG_REMAINDER;        // negate remainder to get final result
                end

                // for normal division
                //dividerDoneValue = 1'b1;                 // send the division done signal (normal operation, signal is high the cycle after the result is latched)


                // next state logic
                nextState = LOAD;
            end

            default: nextState = LOAD;
        endcase
    end


    // output registers
    always_ff @(posedge clk, posedge reset) begin
        if(reset) begin
            dividerDone  <= 1'b0;
            dividerError <= 1'b0;
        end	else begin
            dividerDone  <= dividerDoneValue;
            dividerError <= dividerErrorValue;
        end
    end


endmodule

