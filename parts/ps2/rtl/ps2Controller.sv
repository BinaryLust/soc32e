

module ps2Controller(
    input   logic          clk,
    input   logic          reset,
    input   logic          ps2ClkSync,
    input   logic          ps2Data,

    output  logic          shiftEn,
    output  logic          regEn
    );


    typedef  enum  logic  [2:0] {
        WAITSTART = 3'b000,
        DATA      = 3'b001, // read data bits and parity bit after neg clk edge
        WAITNE    = 3'b010, // wait for next neg clk edge
        WAITPE    = 3'b011, // wait for next pos clk edge
        SETREADY  = 3'b100  // set ready flag and load the data in to the registers
    } states;


    states          state;
    states          nextState;
    logic   [3:0]   bitCount;
    logic   [3:0]   nextBitCount;
    logic           prevClk;
    logic           negClkEdge;
    logic           posClkEdge;


    // state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            state <= WAITSTART;
        else
            state <= nextState;
    end


    // bit count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            bitCount <= 4'd1;
        else
            bitCount <= nextBitCount;
    end

	// clk edge detection register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            prevClk = 1'b0;
        else
            prevClk = ps2ClkSync;
    end

    // clk edge detection
	assign negClkEdge = prevClk & ~ps2ClkSync;
	assign posClkEdge = ~prevClk & ps2ClkSync;


    // combinationial logic
    always_comb begin
        // default values
        nextState    = WAITSTART;
        shiftEn      = 1'b0;
        regEn        = 1'b0;
        nextBitCount = bitCount; // keep old value


        case(state)
            WAITSTART: begin
                nextState = (!ps2ClkSync && !ps2Data) ? DATA : WAITSTART;
            end

            DATA: begin
                if(negClkEdge) begin
                    shiftEn      = 1'b1;
                    nextBitCount = (bitCount == 4'd9) ? 4'd1 : bitCount + 4'd1;
                end

                nextState = ((bitCount == 4'd9) && negClkEdge) ? WAITNE : DATA;
            end

            WAITNE: begin
                nextState = (negClkEdge) ? WAITPE : WAITNE;
            end
            
            WAITPE: begin
                nextState = (posClkEdge) ? SETREADY : WAITPE;
            end

            SETREADY: begin
                regEn        = 1'b1;

                nextState    = WAITSTART;
            end

            default: ;
        endcase
    end


endmodule

