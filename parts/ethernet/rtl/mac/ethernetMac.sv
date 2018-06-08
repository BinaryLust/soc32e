

module ethernetMacCore(
    input   logic          clk,
    input   logic          reset,

    // input   logic  [31:0]  transmitDataIn,     // data from the master interface

    // input   logic          transmitDataLoadEn, // write enable from the master interface
    // input   logic          receiveDataReadReq, // read request from the master interface

    // output  logic  [15:0]  receiveData,        // visible state to the master interface
    // output  logic          receiveValid,       // visible state to the master interface
    // output  logic          transmitReady,      // visible state to the master interface

    input   logic          txClk,
    input   logic          txReset,
    output  logic          txEn,
    output  logic  [3:0]   txData,

    input   logic          rxClk,
    input   logic          rxReset,
    input   logic          rxValid,
    input   logic          rxError,
    input   logic  [3:0]   rxData,

    input   logic          crs,
    input   logic          col
    );

endmodule

