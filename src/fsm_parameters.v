// Shared values for FSMs
// Phase encoding definitions (from docs/notes.md)
`define PHASE_1	2'b00
`define PHASE_2 2'b01
`define EAST_PRIORITY 2'b10
`define WEST_PRIORITY 2'b11

// Timing controller values
`define GREEN_TICKS 29
`define YELLOW_TICKS 2
`define RED_TICKS 1

// Phase controller values
`define NONE 2'b00
`define EAST 2'b01
`define WEST 2'b10

// State encoding definitions (from docs/fsm_states.md)
`define ALL_RED 4'b0000
`define PHASE_1_GREEN 4'b0001
`define PHASE_1_YELLOW 4'b0010
`define PHASE_2_GREEN 4'b0011
`define PHASE_2_YELLOW 4'b0100
`define EASTBOUND_GREEN 4'b0101
`define EASTBOUND_YELLOW 4'b0110
`define WESTBOUND_GREEN 4'b0111
`define WESTBOUND_YELLOW 4'b1000
`define MAINTENANCE 4'b1001
