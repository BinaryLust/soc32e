

module interruptState(
    input  logic          clk,
    input  logic          reset,
    input  logic  [15:0]  triggerInterrupt,
    input  logic  [15:0]  resetInterrupt,

    output logic  [15:0]  triggeredInterrupts
    );


    logic  [15:0]  triggeredInterruptsNext;
    logic  [15:0]  trigger;


    // interrupt state register
    always_ff @(posedge clk or posedge reset) begin
        if(reset)
            triggeredInterrupts <= 16'b0;
        else
            triggeredInterrupts <= triggeredInterruptsNext;
    end


    // interrupt state mux
    generate

        genvar i;

        for(i = 0; i < 16; i++) begin : triggeredInterruptsMux
            always_comb begin
                case({triggerInterrupt[i], resetInterrupt[i]})
                    2'b00: triggeredInterruptsNext[i] = triggeredInterrupts[i]; // old data
                    2'b01: triggeredInterruptsNext[i] = 1'b0;                   // reset if only reset is active
                    2'b10: triggeredInterruptsNext[i] = 1'b1;                   // set if trigger is active
                    2'b11: triggeredInterruptsNext[i] = 1'b1;                   // set if trigger and reset are both active
                endcase
            end
        end

    endgenerate


endmodule

