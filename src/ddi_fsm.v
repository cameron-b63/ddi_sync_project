`include "fsm_parameters.v" 

module single_ddi_fsm (	
	input wire clk,			// Clock signal
	input wire rst,			// Reset signal
	input wire timing_done,		// Timing controller input
	input wire [1:0] phase,		// Encoded phase
	input wire sync,		// Sync controller input east/west demand
	input wire maintenance, 	// Maintenance required
	output reg [3:0] current_state	// Output state
);
	
	reg [3:0] next_state;

	// Clock/reset signal logic
	always @(posedge clk or posedge rst or posedge maintenance) begin
		if (rst)
			current_state <= `ALL_RED; // Reset to full stop
		else if (maintenance)
			current_state <= `MAINTENANCE; // Go to flashing reds
		else
			current_state <= next_state; // Use next state calculed value
	end

	// State transition logic
	always @(*) begin
		case(current_state)
			`ALL_RED: begin
				case(phase)
					`PHASE_1: next_state = (timing_done) ? `PHASE_1_GREEN : `ALL_RED;
					`PHASE_2: next_state = (timing_done) ? `PHASE_2_GREEN : `ALL_RED;
					`PRIORITY: begin
						case(sync)
							`EAST_PRIORITY: next_state = (timing_done) ? `EASTBOUND_GREEN : `ALL_RED;
							`WEST_PRIORITY: next_state = (timing_done) ? `WESTBOUND_GREEN : `ALL_RED;
					
						endcase	
					end
				endcase	
			end

			`PHASE_1_GREEN: 		next_state = (timing_done) ? `PHASE_1_YELLOW 	: `PHASE_1_GREEN;
			`PHASE_1_YELLOW: 	next_state = (timing_done) ? `ALL_RED 		: `PHASE_1_YELLOW;
			`PHASE_2_GREEN: 		next_state = (timing_done) ? `PHASE_2_YELLOW 	: `PHASE_2_GREEN;
			`PHASE_2_YELLOW: 	next_state = (timing_done) ? `ALL_RED 		: `PHASE_2_YELLOW;
			`EASTBOUND_GREEN: 	next_state = (timing_done) ? `EASTBOUND_YELLOW 	: `EASTBOUND_GREEN;
			`EASTBOUND_YELLOW: 	next_state = (timing_done) ? `ALL_RED 		: `EASTBOUND_YELLOW;
			`WESTBOUND_GREEN: 	next_state = (timing_done) ? `WESTBOUND_YELLOW 	: `WESTBOUND_GREEN;
			`WESTBOUND_YELLOW: 	next_state = (timing_done) ? `ALL_RED		: `WESTBOUND_YELLOW;
			`MAINTENANCE: 		next_state = (maintenance) ? `MAINTENANCE	: `ALL_RED;
		endcase
	end
endmodule
