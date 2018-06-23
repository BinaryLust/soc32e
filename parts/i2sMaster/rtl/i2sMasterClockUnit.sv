

// we need a reset function so we can resync bclk and wclk at the proper edges
// use dual edge triggered flops?

// the current problem is that mclk, bclk, and wclk are default divided by 2 from clk because they only update on the
// positive edge of clk instead of both edges so it is an automatic divide by 2.
// we either need to double the input frequency so we can divide by odd number like 3, 9, 13, ect instead of just
// multiples of 2 like 4, 6, 12, 18, or somehow figure out how to double clock a flip flip inside an fpga which can't
// normally be done.


module i2sMasterClockUnit(
    input   logic          synthClk,
    input   logic          synthReset,
    input   logic          loadEn,
    input   logic  [9:0]   mclkDivider,
    input   logic  [3:0]   bclkDivider,
    input   logic  [7:0]   wclkDivider,

    output  logic          mclk,
    output  logic          bclk,
    output  logic          wclk
    );


    logic  [9:0]  mclkCounter;
    logic  [9:0]  mclkCounterNext;
    logic  [3:0]  bclkCounter;
    logic  [3:0]  bclkCounterNext;
    logic  [7:0]  wclkCounter;
    logic  [7:0]  wclkCounterNext;
    logic         mclkNext;
    logic         bclkNext;
    logic         wclkNext;
    logic         mclkFinal;
    logic         bclkFinal;
    logic         wclkFinal;


    // registers
    always_ff @(posedge synthClk or posedge synthReset) begin
        if(synthReset) begin
            mclkCounter <= 10'd72;
            bclkCounter <= 4'd4;
            wclkCounter <= 8'd64;
            mclk        <= 1'b1;
            bclk        <= 1'b0;
            wclk        <= 1'b0;
        end else begin
            mclkCounter <= mclkCounterNext;
            bclkCounter <= bclkCounterNext;
            wclkCounter <= wclkCounterNext;
            mclk        <= mclkNext;
            bclk        <= bclkNext;
            wclk        <= wclkNext;
        end
    end


    // combinationial logic
    always_comb begin
        // defaults
        mclkCounterNext = mclkCounter;         // keep old value
        mclkNext        = mclk;                // keep old value
        bclkCounterNext = bclkCounter;         // keep old value
        bclkNext        = bclk;                // keep old value
        wclkCounterNext = wclkCounter;         // keep old value
        wclkNext        = wclk;                // keep old value


        mclkFinal = (mclkCounter == 10'd1);
        bclkFinal = (bclkCounter == 4'd1);
        wclkFinal = (wclkCounter == 8'd1);


        if(loadEn) begin
            mclkCounterNext = mclkDivider;
            bclkCounterNext = bclkDivider;
            wclkCounterNext = wclkDivider;
            mclkNext        = 1'b1; // if we set these to 1 here it sync's to the positive edge
            bclkNext        = 1'b0; // if we set these to 0 it sync's to the negative edge
            wclkNext        = 1'b0;
        end else begin
            if(mclkFinal) begin
                mclkCounterNext = mclkDivider;         // reset to divider count value
                mclkNext        = !mclk;               // flip polarity of clock
            end else begin
                mclkCounterNext = mclkCounter - 10'd1; // count down
            end


            if(mclkFinal) begin
                if(bclkFinal) begin
                    bclkCounterNext = bclkDivider;        // reset to divider count value
                    bclkNext        = !bclk;              // flip polarity of clock
                end else begin
                    bclkCounterNext = bclkCounter - 4'd1; // count down
                end
            end


            if(mclkFinal && bclkFinal) begin
                if(wclkFinal) begin
                    wclkCounterNext = wclkDivider;        // reset to divider count value
                    wclkNext        = !wclk;              // flip polarity of clock
                end else begin
                    wclkCounterNext = wclkCounter - 8'd1; // count down
                end
            end
        end
    end


endmodule

