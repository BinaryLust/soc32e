

module grayToBinary
    #(parameter WIDTH  = 1)(

    input   logic  [WIDTH-1:0]  gray,
    output  logic  [WIDTH-1:0]  binary
    );


    generate

        genvar i;

        for(i = 0; i < WIDTH; i++) begin : g2b
            assign binary[i] = ^(gray >> i);
        end

    endgenerate


endmodule

