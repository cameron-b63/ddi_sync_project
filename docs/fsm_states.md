# FSM States
This file documents the states for each FSM in the project.

## Single DDI (Diverging Diamond Interchange) Controller
 - **ALL_RED** (4'0000)
     - *Initial state; Each yellow cycle falls back to this state. It is also the state set when a `RST` signal is issued.*
 - **PHASE_1_GREEN** (4'b0001)
     - *Begin normal cycle; Only entered from ALL_RED*
 - **PHASE_1_YELLOW** (4'b0010)
     - *End of Phase 1 - transitions back to ALL_RED*
 - **PHASE_2_GREEN** (4'b0011)
     - *Begin Phase 2 (clear center of intersection)*
 - **PHASE_2_YELLOW** (4'b0100)
     - *End of Phase 2 - transitions back to ALL_RED*
 - **EASTBOUND_GREEN** (4'b0101)
     - *Eastbound has priority from sync controller - Westbound remains red*
 - **EASTBOUND_YELLOW** (4'b0110)
     - *End of Eastbound only signal*
 - **WESTBOUND_GREEN** (4'b0111)
     - *Westbound has priority from sync controller*
 - **WESTBOUND_YELLOW** (4'b1000)
     - *End of Westbound only signal*
 - **MAINTENANCE** (4'b1001)
     - *Special state - can be entered from anywhere once maintenance signal received, returns to ALL_RED once maintenance exited*
