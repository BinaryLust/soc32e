
// Quartus Prime SystemVerilog Template
//
// Simple Dual-Port RAM with different read/write addresses and single read/write clock
// and with a control for writing single bytes into the memory word; byte enable

module testRam(
    input   logic                  clk,
    input   logic                  reset,
    input   logic                  we,
    input   logic  [9:0]           address,
    input   logic  [3:0]           bwe,
    input   logic  [31:0]          d,
    output  logic  [31:0]          q,
    output  logic  [1023:0][31:0]  ramState
    );


    logic  [1023:0][31:0]  ram;//[1023:0];
    logic  [31:0]              qReg;
    //integer i;


    // set the initial value of the memory block
    /*initial begin
        for(i = 0; i < 1024; i++)
            ram[i] = 32'b0; // reset to all zero's
     end*/


    always_ff @(posedge clk or posedge reset)	begin
        if(reset)
            ram <= {1024{32'b0}};
        else if(we) begin
            if(bwe[0]) ram[address][7:0]   <= d[7:0];
            if(bwe[1]) ram[address][15:8]  <= d[15:8];
            if(bwe[2]) ram[address][23:16] <= d[23:16];
            if(bwe[3]) ram[address][31:24] <= d[31:24];
        end
    end


    always_ff @(posedge clk) begin
        // the block above and
        // this block both fire at the same time so whatever is written above is not available
        // on the output until the next cycle
        qReg <= ram[address];
        q    <= qReg;
    end


    assign ramState = ram;


endmodule

