`include "src/fsm_parameters.v" 

// Module definition for light controller
module light_controller (	
	input wire clk,			// Clock signal
	input wire rst,			// Reset signal
	input wire timing_done,		// Timing controller input
	input wire [1:0] phase,		// Encoded phase
	input wire maintenance, 	// Maintenance required
	output reg [3:0] current_state	// Output state
);
	
	// Track next state; for pre-loading
	reg [3:0] next_state;

	// Clock/reset signal logic
	always @(posedge clk or posedge rst or posedge maintenance) begin
		if (rst)
			current_state <= `ALL_RED; // Reset to full stop
		else if (maintenance)
			current_state <= `MAINTENANCE; // Go to flashing reds
		else
			current_state <= (timing_done) ? next_state : current_state; // Use next state calculed value
	end

	// State transition logic
	always @(*) begin
		case(current_state)
			`ALL_RED: begin
				case(phase)
					`PHASE_1:	next_state = `PHASE_1_GREEN;
					`PHASE_2: 	next_state = `PHASE_2_GREEN;
					`EAST_PRIORITY: next_state = `EASTBOUND_GREEN;
					`WEST_PRIORITY: next_state = `WESTBOUND_GREEN;
				endcase	
			end

			`PHASE_1_GREEN: 	next_state = `PHASE_1_YELLOW;
			`PHASE_1_YELLOW: 	next_state = `ALL_RED;
			`PHASE_2_GREEN: 	next_state = `PHASE_2_YELLOW;
			`PHASE_2_YELLOW: 	next_state = `ALL_RED;
			`EASTBOUND_GREEN: 	next_state = `EASTBOUND_YELLOW;
			`EASTBOUND_YELLOW: 	next_state = `ALL_RED;
			`WESTBOUND_GREEN: 	next_state = `WESTBOUND_YELLOW;
			`WESTBOUND_YELLOW: 	next_state = `ALL_RED;
			`MAINTENANCE: 		next_state = ((maintenance) ? `MAINTENANCE	: `ALL_RED);
		endcase
	end
endmodule
