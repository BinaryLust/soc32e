

// this is a cross clock domain handshake based pulse synchronizer


module crossDomainEn(
    input   logic          clk1,
    input   logic          reset1,
    input   logic          enIn,

    input   logic          clk2,
    input   logic          reset2,
    output  logic          enOut
    );


    logic  en1;
    logic  en1Next;
    logic  en2;
    logic  enAck;


    // clock domain 1 signal register
    always_ff @(posedge clk1 or posedge reset1) begin
        if(reset1)
            en1 <= 1'd0;
        else
            en1 <= en1Next;
    end


    // clock domain 1 signal register combinationial logic
    always_comb begin
        // defaults
        if(enIn)
            en1Next = 1'b1; // set enable
        else if(enAck)
            en1Next = 1'b0; // reset enable
        else
            en1Next = en1;  // keep old value
    end


    synchronizerEdge
    clk1toClk2SyncEdge(
        .clk        (clk2),
        .reset      (reset2),
        .in         (en1),
        .out        (en2),
        .outRose    (enOut)
    );


    synchronizerEdge
    clk2toClk1SyncEdge(
        .clk        (clk1),
        .reset      (reset1),
        .in         (en2),
        .out        (),
        .outRose    (enAck)
    );


endmodule

