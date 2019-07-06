

module ps2Core(
    input   logic          clk,
    input   logic          reset,

    input   logic          ireIn,            // data from the master interface

    input   logic          configLoadEn,     // write enable from the master interface
    input   logic          dataReadReq,      // read request from the master interface

    output  logic  [7:0]   data,             // visible state to the master interface
    output  logic          parity,           // visible state to the master interface
    output  logic          ready,            // visible state to the master interface
    output  logic          ire,              // visible state to the master interface

    output  logic          irq,              // interrupt request to the master

    input   logic          ps2Clk,
    input   logic          ps2Data
    );


    // wires
    logic  [8:0]  shift;
    logic  [7:0]  clkSync;
    logic         ps2ClkSync;
    logic         shiftEn;
    logic         regEn;


    //------------------------------------------------
    // visible registers


    // ready register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ready <= 1'b0;
        else if(regEn)
            ready <= 1'b1;
        else if(dataReadReq)
            ready <= 1'b0;
        else
            ready <= ready;
    end


    // data register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            data <= 8'b0;
        else if(regEn)
            data <= shift[7:0];
        else
            data <= data;
    end


    // parity register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            parity <= 1'b0;
        else if(regEn)
            parity <= shift[8];
        else
            parity <= parity;
    end


    // interrupt request enable register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            ire <= 1'd0;
        else if(configLoadEn)
            ire <= ireIn;
        else
            ire <= ire;
    end


    //------------------------------------------------
    // hidden registers

    
    // shift register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            shift <= 9'b0;
        else if(shiftEn)
            shift <= {ps2Data, shift[8:1]};
        else
            shift <= shift;
    end


    // clock sync register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            clkSync <= 8'b0;
        else
            clkSync <= {ps2Clk, clkSync[7:1]};
    end


    // interrupt request register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            irq <= 1'b0;
        else
            irq <= regEn && ire;
    end


    //------------------------------------------------
    // combinational logic


    assign ps2ClkSync = &clkSync;


    //------------------------------------------------
    // modules


    ps2Controller
    ps2Controller(
        .clk,
        .reset,
        .ps2ClkSync,
        .ps2Data,
        .shiftEn,
        .regEn
    );


endmodule

