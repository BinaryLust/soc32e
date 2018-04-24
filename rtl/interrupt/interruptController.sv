

module interruptController(
    input   logic                               clk,
	 input   logic                               reset,
	 input   logic                       [15:0]  triggerInterrupt,
	 input   logic                       [3:0]   interruptIn,
	 input   logic                               interruptAcknowledge,
	 
	 output  logic                       [3:0]   interruptOut,
	 output  logic                               interruptRequest
	 );
	 
	 
	 logic  [15:0]  resetInterrupt;
	 logic  [15:0]  triggeredInterrupts;
	 
	 
	 interruptState
	 interruptState(
        clk,
	     reset,
	     triggerInterrupt,
        resetInterrupt,
	     triggeredInterrupts
	 );
	 
	 
	 // interrupt reset decoder
	 always_comb begin
	     // default
		  resetInterrupt = 16'b0;
		  
		  if(interruptAcknowledge) begin
		      case(interruptIn)
		          4'd0:    resetInterrupt = 16'b0000_0000_0000_0001;
				    4'd1:    resetInterrupt = 16'b0000_0000_0000_0010;
					 4'd2:    resetInterrupt = 16'b0000_0000_0000_0100;
					 4'd3:    resetInterrupt = 16'b0000_0000_0000_1000;
					 4'd4:    resetInterrupt = 16'b0000_0000_0001_0000;
					 4'd5:    resetInterrupt = 16'b0000_0000_0010_0000;
					 4'd6:    resetInterrupt = 16'b0000_0000_0100_0000;
					 4'd7:    resetInterrupt = 16'b0000_0000_1000_0000;
					 4'd8:    resetInterrupt = 16'b0000_0001_0000_0000;
					 4'd9:    resetInterrupt = 16'b0000_0010_0000_0000;
					 4'd10:   resetInterrupt = 16'b0000_0100_0000_0000;
					 4'd11:   resetInterrupt = 16'b0000_1000_0000_0000;
					 4'd12:   resetInterrupt = 16'b0001_0000_0000_0000;
					 4'd13:   resetInterrupt = 16'b0010_0000_0000_0000;
					 4'd14:   resetInterrupt = 16'b0100_0000_0000_0000;
					 4'd15:   resetInterrupt = 16'b1000_0000_0000_0000;
					 default: resetInterrupt = 16'b0000_0000_0000_0000;
		      endcase
		  end
	 end
	 
	 
	 // interrupt priority encoder
	 // we could use a bit scan followed by a normal non-priority encoder if this is too slow
	 always_comb begin
	     // defaults
		  interruptRequest = 1'b0;
		  interruptOut  = 4'b0000;
		  
		  casex(triggeredInterrupts)
		      {16'bxxxx_xxxx_xxxx_xxx1}: begin interruptRequest = 1'b1; interruptOut = 4'b0000; end
            {16'bxxxx_xxxx_xxxx_xx10}: begin interruptRequest = 1'b1; interruptOut = 4'b0001; end
			   {16'bxxxx_xxxx_xxxx_x100}: begin interruptRequest = 1'b1; interruptOut = 4'b0010; end
			   {16'bxxxx_xxxx_xxxx_1000}: begin interruptRequest = 1'b1; interruptOut = 4'b0011; end
		      {16'bxxxx_xxxx_xxx1_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b0100; end
            {16'bxxxx_xxxx_xx10_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b0101; end
			   {16'bxxxx_xxxx_x100_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b0110; end
			   {16'bxxxx_xxxx_1000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b0111; end
		      {16'bxxxx_xxx1_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1000; end
            {16'bxxxx_xx10_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1001; end
			   {16'bxxxx_x100_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1010; end
			   {16'bxxxx_1000_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1011; end
		      {16'bxxx1_0000_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1100; end
            {16'bxx10_0000_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1101; end
			   {16'bx100_0000_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1110; end
		      {16'b1000_0000_0000_0000}: begin interruptRequest = 1'b1; interruptOut = 4'b1111; end
		      default:                   begin interruptRequest = 1'b0; interruptOut = 4'b0000; end
		  endcase
	 end
	 
	 
endmodule

