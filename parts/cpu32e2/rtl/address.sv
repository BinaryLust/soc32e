

package addressGroup;


    import boolPkg::*;


    // address mux values
    typedef enum logic [1:0] {
        NEXTPC   = 2'b00,
        REGFILEA = 2'b01,
        APLUSB   = 2'b10
    } addressMux;


    // control group structure
    typedef struct packed {
        bool        addressOutEn;
        bool        calculatedAddressEn;
        addressMux  addressSel;
    } controlBus;


    // control group macro values
    localparam controlBus
        NO_OP       = '{addressOutEn:F, calculatedAddressEn:F, addressSel:NEXTPC},
        PC_ADDR     = '{addressOutEn:T, calculatedAddressEn:F, addressSel:NEXTPC},
        RFA_ADDR    = '{addressOutEn:T, calculatedAddressEn:T, addressSel:REGFILEA},
        APLUSB_ADDR = '{addressOutEn:T, calculatedAddressEn:T, addressSel:APLUSB},
        RFA_CALC    = '{addressOutEn:F, calculatedAddressEn:T, addressSel:REGFILEA};


endpackage


module addressUnit(
    input   logic                             clk,
    input   logic                             reset,
    input   addressGroup::controlBus          addressControl,
    input   logic                     [31:0]  nextPC,
    input   logic                     [31:0]  registerFileA,
    input   logic                     [31:0]  aRegister,
    input   logic                     [31:0]  bRegister,
    output  logic                     [1:0]   dataSelectBits,
    output  logic                     [31:0]  address,
    output  logic                     [31:0]  calculatedAddress
    );


    import addressGroup::*;


    logic  [31:0]  addressNext;
    logic  [31:0]  calculatedAddressNext;


    // Registers
    always_ff @(posedge clk) begin
        if(addressControl.addressOutEn)
            dataSelectBits    <= addressNext[1:0];
        else
            dataSelectBits    <= dataSelectBits;


        if(addressControl.calculatedAddressEn)
            calculatedAddress <= calculatedAddressNext;
        else
            calculatedAddress <= calculatedAddress;
    end


    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            address           <= 32'b0;
        else if(addressControl.addressOutEn)
            address           <= addressNext;
        else
            address           <= address;
    end


    // Combinational Logic
    always_comb begin

        // adder
        calculatedAddressNext = aRegister + bRegister;

        // address mux
        case(addressControl.addressSel)
            NEXTPC:   addressNext = nextPC;
            REGFILEA: addressNext = registerFileA;
            APLUSB:   addressNext = calculatedAddressNext;
            default:  addressNext = nextPC;
        endcase

    end


endmodule

