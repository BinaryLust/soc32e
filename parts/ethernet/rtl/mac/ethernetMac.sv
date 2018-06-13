

// the start of a packet will be signaled by a low to high transition on rxValid
// the end of a packet will be signaled by a high to low transition on rxValid
// if col goes high there was a collision and we should discard the current packet???
// if rxError goes high there was an error and we should discard the packet?


// the current plan for this is to have a dual port memory block that can be accessed by the cpu and by the ethernet core
// the ethernet core will transfer the packet to the memory block and signal when the entire packet has been received
// the cpu can then operate on the packet directly in the memory block or transfer it to system memory.

// packet memory layout
// size of packet or pointer to next packet
// packet
// size of next packet or pointer to the next next packet
// next packet


// the other way we could do it would be to have the ethernet core directly write the packet to system memory with dma
// we would probably want to do this in blocks of 16+ bytes at a time so we don't tie up the system with single byte writes
// all the time.


// another way could be to just have a direct fifo that collects the receive data and has an extra bit in it to signal the end of the
// packet, we could also have 2 more bits that tell us which byte of a word in the fifo is the last byte so we could read the data
// 32-bits at a time to make things more efficient. I think we would write 9 bits at a time the byte and 1 bit to specify if the byte is
// valid, at the receiving end we remap these bits so the valid bits and data bits are grouped together.


// single clock mii (scmii) would cut down on the number of clocks we have to use in the design

// we will need to detect pause frames in software or hardware (preffered), they have a special broadcast address
// there is a time parameter in these pause frames that determines how long to pause
// the pause can be undone by sending a 2nd pause frame with the pause time set to zero.


// for when bad packets are detected we could have a rollback pointer for the fifo/memory block. this pointer would point to just after
// the last valid packet so we could restart there if a bad packet is detected we would just read the packet a 2nd time and put it at
// the same address as before.


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

