

// in text mode we fetch an entire line of text and store it in the the text buffer, then over the next 8 lines
// we turn this buffered text in to pixels and store the pixels in the line buffer. so we must save the current
// screen y coordinate and/or text y coordinate to keep track of which text pixels to output next.


module lineFetchController(
    input   logic          clk,
    input   logic          reset,

    input   logic  [20:0]  baseAddress,

    //input   logic          textMode,
    //input   logic  [10:0]  textWidth,
    //input   logic  [10:0]  textHeight,
    input   logic  [7:0]   textForegroundColor,
    input   logic  [7:0]   textBackgroundColor,

    input   logic  [10:0]  graphicsWidth, // graphics width >> 2
    //input   logic  [10:0]  graphicsHeight,

    input   logic          lineRequest,
    input   logic          endOfFrame,
    output  logic  [8:0]   lineAddress,
    output  logic          lineWrite,

    input   logic          waitRequest,
    input   logic          readValid,
    output  logic          read,
    output  logic  [20:0]  address
    );


    typedef  enum  logic  {IDLE = 1'b0, FETCH = 1'b1}  states;


    states          state;
    states          nextState;


    logic   [8:0]   lineAddressNext;
    logic           readNext;
    logic   [20:0]  addressNext;


    logic   [10:0]  readRequestCount;
    logic   [10:0]  readCount;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= IDLE;
        else
            state <= nextState;
    end


    // read register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            read <= 1'b0;
        else
            read <= readNext;
    end


    // address register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            address <= 21'd0;
        else
            address <= addressNext;
    end


    // line address register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            lineAddress <= 9'd0;
        else
            lineAddress <= lineAddressNext;
    end


    always_comb begin
        // defaults
        nextState       = IDLE;        // go to idle
        addressNext     = address;     // keep old value
        lineAddressNext = lineAddress; // keep old value

        case(state)
            IDLE: begin
                // output logic
                addressNext     = (endOfFrame) ? baseAddress : address; // reset address if end of frame signal is asserted
                lineAddressNext = 9'd0;   // reset address

                // next state logic
                nextState = (lineRequest) ? FETCH : IDLE;
            end

            FETCH: begin
                // output logic

                // next state logic
            end
        endcase
    end


endmodule

