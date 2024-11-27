`include "src/fsm_parameters.v"

module timing_controller (
	input wire clk,               // Clock input
	input wire rst,               // Reset signal
	input wire [3:0] current_state, // Current light FSM state
	output reg timing_done        // Timing completion flag
);

	reg [7:0] counter;            // 8-bit counter register
	reg [7:0] timing_threshold;   // Threshold for current state (this is kind of an expensive component i won't hold you)

	// Determine threshold based on FSM state
	always @(*) begin
        	case (current_state)
			// Grin
            		`PHASE_1_GREEN: timing_threshold = `GREEN_TICKS;
            		`PHASE_2_GREEN: timing_threshold = `GREEN_TICKS;
			`EASTBOUND_GREEN: timing_threshold = `GREEN_TICKS;
			`WESTBOUND_GREEN: timing_threshold = `GREEN_TICKS;
			// Yeller
            		`PHASE_1_YELLOW: timing_threshold = `YELLOW_TICKS;
            		`PHASE_2_YELLOW: timing_threshold = `YELLOW_TICKS;
			`EASTBOUND_YELLOW: timing_threshold = `YELLOW_TICKS;
			`WESTBOUND_YELLOW: timing_threshold = `YELLOW_TICKS;
            		// Marlboro reds
			`ALL_RED: timing_threshold = `RED_TICKS;
            		// Maintenance no give shit
			default: timing_threshold = 0;
        	endcase
    	end

    	// Counter logic
    	always @(posedge clk or posedge rst) begin
        	if (rst) begin
            		counter <= 0;
            		timing_done <= 0;
        	end else if (counter < timing_threshold) begin
            		counter <= counter + 1;
            		timing_done <= 0;
		end else begin
            		timing_done <= 1;
            		counter <= 0;    // Reset counter for next cycle
        	end
    	end
endmodule
