`include "src/fsm_parameters.v"
// This file contains the phase controller, which decides which phase the
// system is in.
//
module phase_controller(
	input wire clk,
	input wire rst,
	input wire [3:0] light_state,
	input wire [1:0] priority,
	output reg [1:0] current_phase
);
	// Store the next phase for the continuous posedge assignment
	reg [1:0] next_phase;

	// rst/update
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			current_phase <= `PHASE_1;
			next_phase <= `PHASE_1;
		end else
			current_phase <= next_phase;
	end

	// actual assignment logic for the phases - depends on yellow light
	// stuff
	always @(*) begin
		case (light_state)
			`PHASE_1_YELLOW: next_phase <= `PHASE_2;
			`PHASE_2_YELLOW: begin
				// At the end of phase 2, some choices need to
				// be made.
				case (priority)
					`NONE: next_phase <= `PHASE_1;
					`EAST: next_phase <= `EAST_PRIORITY;
					`WEST: next_phase <= `WEST_PRIORITY;
					default: next_phase <= `PHASE_1;	// If simulataneous priority is requested, nobody gets it.
				endcase
			end
			`EASTBOUND_YELLOW: next_phase <= `PHASE_1;
			`WESTBOUND_YELLOW: next_phase <= `PHASE_1;
		endcase
	end
endmodule
