// Top level module; integrates all the separate modules to drive the DDI FSM.

module top(
	input wire clk,
	input wire rst,
	input wire maintenance,
	input wire [1:0] priority,
	output wire [3:0] light_state
);

	// Interconnecting wires
	wire [1:0] current_phase;
	wire [3:0] current_light_state;
	wire proper_time_elapsed;

	// Instantiate phase controller
	phase_controller u_phase_controller (
		.clk(clk),
		.rst(rst),
		.priority(priority),
		.current_phase(current_phase),
		.light_state(light_state)
	);

	// Instantiate timing controller
	timing_controller u_timing_controller (
		.clk(clk),
		.rst(rst),
		.current_state(light_state),
		.timing_done(proper_time_elapsed)
	);

	// Instantiate DDI FSM
	light_controller u_light_controller (
		.clk(clk),
		.rst(rst),
		.phase(current_phase),
		.timing_done(proper_time_elapsed),
		.maintenance(maintenance),
		.current_state(light_state)
	);

endmodule
