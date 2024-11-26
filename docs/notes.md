# Notes
This file defines some other things that aren't exactly FSM states.

## Phase Encodings
The "phase" of the traffic light represents what phase of traffic management is being accomplished.

 - PHASE_1 (2'b00): Represents traffic entering the interchange, but being prevented from going all the way through.
 - PHASE_2 (2'b01): Represents traffic being allowed to leave the interchange, but not enter the center of it.
 - PRIORITY (2'b10): Denotes that the lights should be managed according to priority information from the sync controller.

## Priority encodings
The priority of the interchange refers to whether east or west is being synchronized with other lights. Note that this information is unused unless the phase is in priority mode.

 - EAST_PRIORITY (1'b0): Denotes that eastbound traffic should be allowed straight through.
 - WEST_PRIORITY (1'b1): Denotes that westbound traffic should be allowed straight through.

