

module adc(
    input   logic          clk,
    input   logic          reset,

    input   logic          adcClk,
    input   logic          adcClkLocked,

    input   logic  [31:0]  adcDataIn,

    input   logic          sequencerAddress,
    input   logic          sequencerRead,
    input   logic          sequencerWrite,
    output  logic  [31:0]  sequencerDataOut,
    output  logic          sequencerValid,

    input   logic  [6:0]   sampleAddress,
    input   logic          sampleRead,
    input   logic          sampleWrite,
    output  logic  [31:0]  sampleDataOut,
    output  logic          sampleValid,

    output  logic          sampleIrq
    );


    logic  sequencerReadReg;
    logic  sampleReadReg;


    always_ff @(posedge clk or posedge reset) begin
        if(reset) begin
            sequencerReadReg <= 1'b0;
            sequencerValid   <= 1'b0;
            sampleReadReg    <= 1'b0;
            sampleValid      <= 1'b0;
        end else begin
            sequencerReadReg <= sequencerRead;
            sequencerValid   <= sequencerReadReg;
            sampleReadReg    <= sampleRead;
            sampleValid      <= sampleReadReg;
        end
    end


    soc32e_modular_adc_0
    soc32e_modular_adc_0(
        .clock_clk                      (clk),                  //            clock.clk
        .reset_sink_reset_n             (!reset),               //       reset_sink.reset_n
        .adc_pll_clock_clk              (adcClk),               //    adc_pll_clock.clk
        .adc_pll_locked_export          (adcClkLocked),         //   adc_pll_locked.export
        .sequencer_csr_address          (sequencerAddress),     //    sequencer_csr.address
        .sequencer_csr_read             (sequencerRead),        //                 .read
        .sequencer_csr_write            (sequencerWrite),       //                 .write
        .sequencer_csr_writedata        (adcDataIn),            //                 .writedata
        .sequencer_csr_readdata         (sequencerDataOut),     //                 .readdata
        .sample_store_csr_address       (sampleAddress),        // sample_store_csr.address
        .sample_store_csr_read          (sampleRead),           //                 .read
        .sample_store_csr_write         (sampleWrite),          //                 .write
        .sample_store_csr_writedata     (adcDataIn),            //                 .writedata
        .sample_store_csr_readdata      (sampleDataOut),        //                 .readdata
        .sample_store_irq_irq           (sampleIrq)             // sample_store_irq.irq
    );


endmodule

