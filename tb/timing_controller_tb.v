`timescale 1ns/1ps
`include "src/fsm_parameters.v"  // Include your parameter definitions

module tb_timing_controller;

    // Testbench signals
    reg clk;                  // Clock signal
    reg rst;                  // Reset signal
    reg [3:0] current_state;  // Current FSM state
    wire timing_done;         // Output wire to check timing completion

    // Instantiate the timing_controller module (same exact thing as before)
    timing_controller uut (
        .clk(clk),
        .rst(rst),
        .current_state(current_state),
        .timing_done(timing_done)
    );

    // Clock generation
    always begin
        #0.5 clk = ~clk; // Toggle clock every 0.5ns
    end

    // Test stimulus
    initial begin
        // Initialize signals
        clk = 0;
        rst = 0;
        current_state = `ALL_RED; // Start with ALL_RED state

        // Apply reset
	$display("[+] Applying reset");
        rst = 1;
        #10; 
	rst = 0;

        // Test all states with timing
	$display("[+] Testing PHASE_1_GREEN");
        // Phase 1 Green (Green lights for 30 ticks)
        current_state = `PHASE_1_GREEN;
        #31;

	$display("[+] Testing PHASE_1_YELLOW");
        // Phase 1 Yellow (Yellow lights for 3 ticks)
        current_state = `PHASE_1_YELLOW;
        #4;

	$display("[+] Testing PHASE_2_GREEN");
        // Phase 2 Green (Green lights for 30 ticks)
        current_state = `PHASE_2_GREEN;
        #31;

	$display("[+] Testing PHASE_2_YELLOW");
        // Phase 2 Yellow (Yellow lights for 3 ticks)
        current_state = `PHASE_2_YELLOW;
        #4;

	$display("[+] Testing ALL_RED");
        // All Red again (Red lights for 1 tick)
        current_state = `ALL_RED;
        #2;

        // Synchronized states don't need super duper special testing, as they behave
	// very similarly to the normal phase 1/2 in the eyes of the timing
	// controller
        $display("[+] Testing synchronized states");
	
	$display("[+] East");
	current_state = `EASTBOUND_GREEN;
        #31;
	current_state = `EASTBOUND_YELLOW;
	#4;
	current_state = `ALL_RED;
	#2;
	
	
	$display("[+] West");
        current_state = `WESTBOUND_GREEN;
        #31;
	current_state = `WESTBOUND_YELLOW;
	#4;
	current_state = `ALL_RED;
	#2;

	// Ensure maintenance doesn't give a single shit what the timing
	// controller thinks
	$display("[+] Testing MAINTENANCE");
	current_state = `MAINTENANCE;
	#10;
	#20;
	#30;

        $stop; // Stop simulation
    end

    // Monitor for pretty print cause i'm like that
    initial begin
        $monitor("Time: %0d | State: %b | Timing Done: %b | Timing Threshold: %d", 
                  $time, current_state, timing_done, uut.timing_threshold);
    end

endmodule

