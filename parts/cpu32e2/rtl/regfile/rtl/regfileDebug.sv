

module regfileDebug(
    input   logic                clk,
    input   logic                reset,
    input   logic                writeEnableA,
    input   logic                writeEnableB,
    input   logic  [4:0]         writeAddressA,
    input   logic  [4:0]         writeAddressB,
    input   logic  [31:0]        writeDataA,
    input   logic  [31:0]        writeDataB,
    input   logic  [4:0]         readAddressA,
    input   logic  [4:0]         readAddressB,

    output  logic  [31:0][31:0]  regfileState, // for debugging
    output  logic  [31:0]        readDataA,
    output  logic  [31:0]        readDataB
    );


    // Declare the RAM variable
    logic  [31:0][31:0]  ram;


    //integer i;


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            ram <= {32{32'b0}};
        end else begin
            case({writeEnableB, writeEnableA})
                2'b00: ;//ram <= ram;// do nothing
                2'b01: ram[writeAddressA] <= writeDataA;
                2'b10: ram[writeAddressB] <= writeDataB;
                2'b11: if(writeAddressA == writeAddressB)
                           ram[writeAddressA] <= writeDataA; // grant write to write address 0 only
                       else begin
                           ram[writeAddressA] <= writeDataA;
                           ram[writeAddressB] <= writeDataB;
                       end
            endcase
        end
    end


    always_ff @(posedge clk) begin
        // Read (if read_addr == write_addr, return OLD data).	To return
        // NEW data, use = (blocking write) rather than <= (non-blocking write)
        // in the write assignment.	 NOTE: NEW data may require extra bypass
        // logic around the RAM.
        readDataA <= ram[readAddressA];
        readDataB <= ram[readAddressB];
    end


    assign regfileState = ram;


endmodule

