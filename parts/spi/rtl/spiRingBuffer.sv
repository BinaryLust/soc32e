

// we use an extra bit in the pointer registers to determine if the buffer is empty/full

// the other flag we didn't use is below
// receive full if ((coreWritePointer[ADDRESSWIDTH] != dataReadPointer[ADDRESSWIDTH]) && (coreWritePointer[ADDRESSWIDTH-1:0] == dataReadPointer[ADDRESSWIDTH-1:0]))


// since the output status lines are registered this will probably cause errors if a device pulls this on every cycle
// it will only work correctly if you read the status flags every 2-3 cycles to account for the latency.


module spiRingBuffer
    #(parameter DATAWIDTH    = 8,
      parameter DATADEPTH    = 1024,
      parameter ADDRESSWIDTH = $clog2(DATADEPTH))(
    input   logic                      clk,
    input   logic                      reset,

    input   logic  [DATAWIDTH-1:0]     dataIn,
    output  logic  [DATAWIDTH-1:0]     dataOut,
    input   logic                      dataWrite,
    input   logic                      dataRead,
    output  logic  [ADDRESSWIDTH-1:0]  dataWordCount,
    output  logic                      transmitReady, // flag to indicate there is room in buffer for transmit data
    output  logic                      receiveValid,  // flag to indicate data has been received and is waiting to be read

    input   logic  [DATAWIDTH-1:0]     coreIn,
    output  logic  [DATAWIDTH-1:0]     coreOut,
    input   logic                      coreWrite,
    input   logic                      coreRead,
    output  logic  [ADDRESSWIDTH-1:0]  coreWordCount,
    output  logic                      transmitDataReady
    );


    //logic  [DATAWIDTH-1:0]    dataOutWire;
    logic  [ADDRESSWIDTH:0]    dataWritePointer;
    logic  [ADDRESSWIDTH:0]    dataReadPointer;
    logic  [ADDRESSWIDTH-1:0]  dataPointer;
    logic  [ADDRESSWIDTH:0]    coreWritePointer;
    logic  [ADDRESSWIDTH:0]    coreReadPointer;
    logic  [ADDRESSWIDTH-1:0]  corePointer;
    logic                      transmitReadyNext;
    logic                      receiveValidNext;
    logic                      transmitDataReadyNext;


    /* data read/write pointer logic section *********************************************************************************************/


    // transmitReady register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitReady <= 1'b0;
        else
            transmitReady <= transmitReadyNext;
    end


    // receiveValid register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            receiveValid <= 1'b0;
        else
            receiveValid <= receiveValidNext;
    end


    // this is the same as transmit not full
    assign transmitReadyNext = !((dataWritePointer[ADDRESSWIDTH] != dataReadPointer[ADDRESSWIDTH]) && (dataWritePointer[ADDRESSWIDTH-1:0] == dataReadPointer[ADDRESSWIDTH-1:0]));

    // this is the same as receive not empty
    assign receiveValidNext  = !(dataReadPointer == coreWritePointer);


    // data write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataWritePointer <= 0;
        else if(dataWrite)
            dataWritePointer <= dataWritePointer + {{ADDRESSWIDTH{1'b0}}, 1'b1};
        else
            dataWritePointer <= dataWritePointer;
    end


    // data read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataReadPointer <= 0;
        else if(dataRead)
            dataReadPointer <= dataReadPointer + {{ADDRESSWIDTH{1'b0}}, 1'b1};
        else
            dataReadPointer <= dataReadPointer;
    end


    // data word counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            dataWordCount <= 0;
        else if(dataRead && !coreWrite)
            dataWordCount <= dataWordCount - {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // read but no write
        else if(coreWrite && !dataRead)
            dataWordCount <= dataWordCount + {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // write but no read
        else
            dataWordCount <= dataWordCount;         // no change if read and write at the same time or no activity
    end


    // data pointer selector
    always_comb begin
        case({dataWrite, dataRead})
            2'b00,
            2'b01: dataPointer = dataReadPointer[ADDRESSWIDTH-1:0];
            2'b10,
            2'b11: dataPointer = dataWritePointer[ADDRESSWIDTH-1:0];
        endcase
    end


    /* other pointers logic section *******************************************************************************************************/


    // transmitDataReady register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            transmitDataReady <= 1'b0;
        else
            transmitDataReady <= transmitDataReadyNext;
    end


    // this is the same as transmit not empty
    assign transmitDataReadyNext = !(coreReadPointer == dataWritePointer);


    // core write pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreWritePointer <= 0;
        else if(coreWrite)
            coreWritePointer <= coreWritePointer + {{ADDRESSWIDTH{1'b0}}, 1'b1};
        else
            coreWritePointer <= coreWritePointer;
    end


    // core read pointer
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreReadPointer <= 0;
        else if(coreRead)
            coreReadPointer <= coreReadPointer + {{ADDRESSWIDTH{1'b0}}, 1'b1};
        else
            coreReadPointer <= coreReadPointer;
    end


    // core word counter
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            coreWordCount <= 0;
        else if(coreWrite && !dataWrite)
            coreWordCount <= coreWordCount - {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // read but no write
        else if(dataWrite && !coreWrite)
            coreWordCount <= coreWordCount + {{ADDRESSWIDTH-1{1'b0}}, 1'b1}; // write but no read
        else
            coreWordCount <= coreWordCount;         // no change if read and write at the same time or no activity
    end


    // data pointer selector
    always_comb begin
        case({coreWrite, coreRead})
            2'b00,
            2'b01: corePointer = coreReadPointer[ADDRESSWIDTH-1:0];
            2'b10,
            2'b11: corePointer = coreWritePointer[ADDRESSWIDTH-1:0];
        endcase
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

