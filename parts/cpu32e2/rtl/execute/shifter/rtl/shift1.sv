

module shift1(
    input   shifterPkg::shiftOpSel          shiftOp,
    input   logic                           shift,
    input   logic                           carry0,
    input   logic                   [31:0]  data0,

    output  logic                           carry1,
    output  logic                   [31:0]  data1
    );


    import shifterPkg::*;


    logic          c1;
    logic  [31:0]  d1;


    // shift 1
    always_comb begin
        casex(shiftOp)
            SHL:     begin c1 = data0[31]; d1 = {data0[30:0],        1'b0}; end // logical left shift
            SHR:     begin c1 =  data0[0]; d1 = {       1'b0, data0[31:1]}; end // logical right shift
            SAR:     begin c1 =  data0[0]; d1 = {  data0[31], data0[31:1]}; end // arithmatic right shift
            ROL:     begin c1 = data0[31]; d1 = {data0[30:0],   data0[31]}; end // left rotate
            ROR:     begin c1 =  data0[0]; d1 = {   data0[0], data0[31:1]}; end // right rotate
            RCL:     begin c1 = data0[31]; d1 = {data0[30:0],      carry0}; end // left rotate carry
            RCR:     begin c1 =  data0[0]; d1 = {     carry0, data0[31:1]}; end // right rotate carry
            default: begin c1 = 1'bx; d1 = 32'bx; end
        endcase


        {carry1, data1} = (shift) ? {c1, d1} : {carry0, data0};
    end


endmodule

