

// we can build this in a couple of ways
// 1: we simply send or receive a single piece of data each time, send the address and start sequence every time
// 2: we can send or receive single data each time, but have a fifo to queue them up for both address and data, send the start sequence every time
// 3: we can have a fifo and send or receive multiple pieces of data each time and only send the address and start sequence once

// if we receive NACK instead of ACK we should send a stop sequence, and set an error bit
// we can send start sequences one after the other without sending stop sequences, this is good for multiple master setups
// if there are multiple masters and they try driving data at the exact same time, the first master that sees a mismatch of its data on the sda line loses arbitration and waits.


// data bit changes when clock is low
// msb first

// transmit
// 1: send start sequence
// 2: send 7 bit address and write bit
// 3: send 8 bit data
// 4: send stop sequence

// receive
// 1: send start sequence
// 2: send 7 bit address and read bit
// 3: receive 8 bit data
// 4: send stop sequence

// method 1 (manual start/stop)
// have start and stop bits in the config register
// when set these force the controller to generate start or stop sequences
//
// method 2 (automatic start/stop)
// have a transfer count register when the set amount of transfers has happened the
// controller will automatically generate a stop sequence

// for clock streching
// transfer 8 data bits, on the 9th bit the slave drives the clock and may hold it low until it is ready.

// 0: data register    // read/write
// 1: address register // read/write
// 2: config register  // read/write
// 3: status register  // read only


// config register bits
// start/go bit    // starts the i2c transaction
// abort/stop bit  // stops the i2c transaction
// clocksPerCycle
// transmit interrupt enable
// receive interrupt enable
// byte/transfer count??? maybe


// status register
// busy
// error
// transmit ready??
// receive valid???


// initial sequence (common to read and write)
// wait for start bit to be set
// when set generate start sequence
// transmit address and r/w bit, release bus
// wait for slave to send ack bit, it may clock stretch

// for reads
// wait for slave to transmit data, then claim bus
// send ack or nack go to idle state and wait for data to be read by cpu, after keep looping if more data is expected
// send repeated start, or stop sequence
// to back to initial state

// for writes
// 


// sda and scl output lines should be wire as below
// assign sclOut = (sclLevel) ? 1'bz, 1'b0; // either high-z when we need a high state or pull low for low state
// assign sclIn = sclOut;
// assign sdaOut = (sdaLevel) ? 1'bz, 1'b0; // either high-z when we need a high state or pull low for low state
// assign sdaIn = sdaOut;


module i2cUnit(
    input   logic         clk,
	 input   logic         reset,

	 input   logic         i2cTransactionValid,    // this line tells this core when a transaction is ready to be processed
	 input   logic  [6:0]  i2cAddress,             // the address of the slave we want to activate
	 input   logic  [7:0]  i2cWriteData,           // the data we want to write to the slave
	 output  logic  [7:0]  i2cReadData,            // the data that was read from the slave
	 output  logic         i2cReadyForTransaction, // this signals that this core is ready to process a transaction
	 output  logic         i2cReadDataValid,       // this signals that the data on the read data lines is valid
	 
	 output  logic         i2cScl,                 // i2c clock
	 output  logic         i2cSda                  // i2c data
	 );

	 
endmodule

