`timescale 1ns / 1ps

module tb_single_ddi_fsm;

    // Inputs
    reg clk;
    reg rst;
    reg timing_done;
    reg [1:0] phase;
    reg sync;
    reg maintenance;

    // Output
    wire [3:0] current_state;

    // Instantiate the FSM module
    single_ddi_fsm uut (
        .clk(clk),
        .rst(rst),
        .timing_done(timing_done),
        .phase(phase),
        .sync(sync),
        .maintenance(maintenance),
        .current_state(current_state)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Testbench procedure
    initial begin
        // Initialize inputs
        clk = 0;
        rst = 0;
        timing_done = 0;
        phase = 2'b00;
        sync = 0;
        maintenance = 0;

        // Monitor state changes
        $monitor("Time: %0d | State: %b | Phase: %b | Timing_Done: %b | Sync: %b | Maintenance: %b | Reset: %b", 
                 $time, current_state, phase, timing_done, sync, maintenance, rst);

        // Apply reset
	$display("[+] Applying reset signal.");
        rst = 1;
        #10;
        rst = 0;

        // Test phase transitions
	#20;
	$display("[+] Testing Phase 1 light cycle (cars enter interchange)");
	phase = 2'b00; timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;

	#20;
	$display("[+] Testing Phase 2 light cycle (cars exit interchange)"); 
	phase = 2'b01; timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;

	#20;
	$display("[+] Testing synchronization control:");
	$display("[+] East priority");
        phase = 2'b10; sync = 0; timing_done = 1; #10; timing_done = 0; // East priority
	timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;
        
	#20;
	$display("[+] West priority");
	phase = 2'b10; sync = 1; timing_done = 1; #10; timing_done = 0; // West priority
	timing_done = 1; #10; timing_done = 0;
	timing_done = 1; #10; timing_done = 0;

        // Test maintenance mode
	#20;
	$display("[+] Enter maintenance mode");
        maintenance = 1;

	#20;
	$display("[+] Exit maintenance mode");
        maintenance = 0;

        // Test reset while in a different state
	#20;
	$display("[+] Test reset in a non-trivial state");
        phase = 2'b00; timing_done = 1; #10; timing_done = 0;
        #10; rst = 1; #10; rst = 0;

        // End simulation
        #50;
	$display("[+] Thanks for playing!");
	$stop;
    end

endmodule

