`include "src/fsm_parameters.v"
`timescale 1ns / 1ps

module top_tb;

    	reg clk;
    	reg rst;
    	reg [1:0] priority;       // Priority input: 00 = No priority, 01 = East, 10 = West (One-hot)
    	wire [3:0] light_state;   // Traffic light outputs (Not one-hot due to large number of states)

	// Instantiate top (prefix sub-modules with 'u' if you need access)
    	top uut (
        	.clk(clk),
        	.rst(rst),
        	.priority(priority),
        	.light_state(light_state)
    	);

    	// Clock generation: 1ns (Real world 1s)
	initial clk = 0;
    	always #0.5 clk = ~clk;

    	initial begin
		// Reset for no-priority
		$display("[+] Resetting for initial test.");
        	rst = 1;	// Start with reset
        	priority = 2'b00;	// No priority initially
        	#10;		// Hold reset to make sure it goes on through
        	rst = 0;	// Release reset

		// No priority
		$display("[+] Testing no priority.");
        	#150;
		
		// Reset for east priority
		$display("[+] Resetting for east priority");
		rst = 1;
		priority = 2'b01;	// East priority
		#10;		// Again hold reset just because
		rst = 0;	// Release reset (give it back like somaliland)

		// Test east priority
		$display("[+] Testing east priority");
		#150;
		
		// Reset for west priority
		$display("[+] Resetting for west priority");
		rst = 1;
		priority = 2'b10;
		#10;
		rst = 0;

		// Test west priority
		$display("[+] Testing west priority");
		#150;

		$display("[+] Thanks for playing.");
        	$finish;            // Finish simulation
    	end

    	// Monitor outputs because that's what the feature is for (!)
    	initial begin
        	$monitor("Time: %t, priority: %b, light_state: %b, timing_done: %b", $time, priority, light_state, uut.u_timing_controller.timing_done);
		$dumpfile("sim/waveform.vcd");
		$dumpvars(0, top_tb);
    	end

endmodule
