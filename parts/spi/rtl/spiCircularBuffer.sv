

// we use an extra bit in the pointer registers to determine if the buffer is empty/full

// the other flag we didn't use is below
// receive full if ((coreWritePointer[ADDRESSWIDTH] != dataReadPointer[ADDRESSWIDTH]) && (coreWritePointer[ADDRESSWIDTH-1:0] == dataReadPointer[ADDRESSWIDTH-1:0]))


// since the output status lines are registered this will probably cause errors if a device pulls this on every cycle
// it will only work correctly if you read the status flags every 2-3 cycles to account for the latency.

// they say you can determine almost full and almost empty flags with the difference between read and write pointers (subtraction)
// but I couldn't figure it out.


module spiCircularBuffer
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input   logic                      clk,
    input   logic                      reset,

    input   logic  [DATAWIDTH-1:0]     dataIn,
    output  logic  [DATAWIDTH-1:0]     dataOut,
    input   logic                      dataWrite,
    input   logic                      dataRead,
    input   logic  [ADDRESSWIDTH:0]    dataTxAlmostFullCount,
    input   logic  [ADDRESSWIDTH:0]    dataRxAlmostEmptyCount,
    output  logic  [ADDRESSWIDTH:0]    dataTxCount,
    output  logic  [ADDRESSWIDTH:0]    dataRxCount,
    output  logic                      dataTxFull,
    output  logic                      dataTxAlmostFull,
    output  logic                      dataRxEmpty,
    output  logic                      dataRxAlmostEmpty,

    input   logic  [DATAWIDTH-1:0]     coreIn,
    output  logic  [DATAWIDTH-1:0]     coreOut,
    input   logic                      coreWrite,
    input   logic                      coreRead,
    output  logic                      coreTxEmpty
    );


    //logic  [DATAWIDTH-1:0]    dataOutWire;
    logic  [ADDRESSWIDTH:0]    dataWritePointer;
    logic  [ADDRESSWIDTH:0]    dataWritePointerNext;
    logic  [ADDRESSWIDTH:0]    dataReadPointer;
    logic  [ADDRESSWIDTH:0]    dataReadPointerNext;
    logic  [ADDRESSWIDTH:0]    dataTxCountNext;
    logic  [ADDRESSWIDTH:0]    dataRxCountNext;
    logic  [ADDRESSWIDTH-1:0]  dataPointer;
    logic                      dataTxFullNext;
    logic                      dataTxAlmostFullNext;
    logic                      dataRxEmptyNext;
    logic                      dataRxAlmostEmptyNext;
    logic  [ADDRESSWIDTH:0]    coreWritePointer;
    logic  [ADDRESSWIDTH:0]    coreWritePointerNext;
    logic  [ADDRESSWIDTH:0]    coreReadPointer;
    logic  [ADDRESSWIDTH:0]    coreReadPointerNext;
    logic  [ADDRESSWIDTH-1:0]  corePointer;
    logic                      corePreTxEmpty;
    logic                      coreTxEmptyNext;


    /* data read/write pointer logic section *********************************************************************************************/


    // data transmit full register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataTxFull <= 1'b0;
        else
            dataTxFull <= dataTxFullNext;
    end


    // data transmit almost full register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataTxAlmostFull <= 1'b0;
        else
            dataTxAlmostFull <= dataTxAlmostFullNext;
    end


    // data receive empty register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataRxEmpty <= 1'b1;
        else
            dataRxEmpty <= dataRxEmptyNext;
    end


    // data receive almost empty register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataRxAlmostEmpty <= 1'b1;
        else
            dataRxAlmostEmpty <= dataRxAlmostEmptyNext;
    end


    // data write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataWritePointer <= 0;
        else
            dataWritePointer <= dataWritePointerNext;
    end


    // data read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataReadPointer <= 0;
        else
            dataReadPointer <= dataReadPointerNext;
    end


    // data transmit count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataTxCount <= DATADEPTH;
        else
            dataTxCount <= dataTxCountNext;
    end


    // data receive count register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataRxCount <= 0;
        else
            dataRxCount <= dataRxCountNext;
    end


    // combinationial logic
    always_comb begin
        // data pointer selector
        case({dataWrite, dataRead})
            2'b00,
            2'b01: dataPointer = dataReadPointer[ADDRESSWIDTH-1:0];
            2'b10,
            2'b11: dataPointer = dataWritePointer[ADDRESSWIDTH-1:0];
        endcase


        // tx count logic
        case({dataRead, dataWrite}) // or {coreRead, dataWrite}???
            2'b00,
            2'b11: dataTxCountNext = dataTxCount;                                // no change
            2'b01: dataTxCountNext = dataTxCount - {{ADDRESSWIDTH{1'b0}}, 1'b1}; // decrement
            2'b10: dataTxCountNext = dataTxCount + {{ADDRESSWIDTH{1'b0}}, 1'b1}; // increment
        endcase


        // rx count logic
        case({dataRead, coreWrite})
            2'b00,
            2'b11: dataRxCountNext = dataRxCount;                                // no change
            2'b01: dataRxCountNext = dataRxCount + {{ADDRESSWIDTH{1'b0}}, 1'b1}; // increment
            2'b10: dataRxCountNext = dataRxCount - {{ADDRESSWIDTH{1'b0}}, 1'b1}; // decrement
        endcase


        dataWritePointerNext  = (dataWrite) ? dataWritePointer + {{ADDRESSWIDTH{1'b0}}, 1'b1} : dataWritePointer;
        dataReadPointerNext   = (dataRead)  ? dataReadPointer  + {{ADDRESSWIDTH{1'b0}}, 1'b1} : dataReadPointer;
        dataTxFullNext        = ((dataWritePointerNext[ADDRESSWIDTH] != dataReadPointerNext[ADDRESSWIDTH]) && (dataWritePointerNext[ADDRESSWIDTH-1:0] == dataReadPointerNext[ADDRESSWIDTH-1:0]));
        dataTxAlmostFullNext  = (dataTxCountNext < dataTxAlmostFullCount);
        dataRxEmptyNext       = (dataReadPointerNext == coreWritePointerNext);
        dataRxAlmostEmptyNext = (dataRxCountNext < dataRxAlmostEmptyCount);
    end


    /* core pointers logic section *******************************************************************************************************/


    // core transmit empty register
    // corePreTxEmpty was added because data that is written isn't available on the same cycle it is written
    // it is only available on the other port 2 cycles after it is written on the first port so this register
    // delays the signal a cycle to compensate for that.
    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            corePreTxEmpty <= 1'b0;
            coreTxEmpty    <= 1'b0;
        end else begin
            corePreTxEmpty <= coreTxEmptyNext;
            coreTxEmpty    <= corePreTxEmpty;
        end
    end


    // core write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreWritePointer <= 0;
        else
            coreWritePointer <= coreWritePointerNext;
    end


    // core read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreReadPointer <= 0;
        else
            coreReadPointer <= coreReadPointerNext;
    end


    // combinationial logic
    always_comb begin
        // core pointer selector
        case({coreWrite, coreRead})
            2'b00,
            2'b01: corePointer = coreReadPointer[ADDRESSWIDTH-1:0];
            2'b10,
            2'b11: corePointer = coreWritePointer[ADDRESSWIDTH-1:0];
        endcase


        coreWritePointerNext = (coreWrite) ? coreWritePointer + {{ADDRESSWIDTH{1'b0}}, 1'b1} : coreWritePointer;
        coreReadPointerNext  = (coreRead)  ? coreReadPointer + {{ADDRESSWIDTH{1'b0}}, 1'b1}  : coreReadPointer;
        coreTxEmptyNext      = (coreReadPointerNext == dataWritePointerNext);
    end


    /* memory block section **************************************************************************************************************/

    // data output register
    /*always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataOut <= 8'd0;
        else if(dataRead)
            dataOut <= dataOutWire;
        else
            dataOut <= dataOut;
    end*/


    trueDualPortMemory #(.DATAWIDTH(DATAWIDTH), .DATADEPTH(DATADEPTH))
    trueDualPortMemory(
        .clk,
        .writeEnA       (dataWrite),
        .dataInA        (dataIn),
        .addressA       (dataPointer),
        .dataOutA       (dataOut),
        .writeEnB       (coreWrite),
        .dataInB        (coreIn),
        .addressB       (corePointer),
        .dataOutB       (coreOut)
    );


endmodule

