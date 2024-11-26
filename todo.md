# TODO: DDI Synchronization Project

This document tracks the steps and milestones for designing, programming, and testing the project. Tasks are divided into phases, and progress is marked with checkboxes.

---

## Phase 1: Initial Setup
- [X] Set up project directory structure.
- [X] Write `ddi_fsm.v` for a single DDI light configuration.
- [X] Create `ddi_fsm_tb.v` to test the FSM behavior.
- [X] Simulate the FSM and verify correct transitions using waveform tools (e.g., GTKWave).
- [X] Document FSM states and transitions in `docs/fsm_states.md`.

---

## Phase 2: Timing Logic
- [X] Design and implement `timing_controller.v` to handle timing for FSM transitions.
- [X] Write `timing_controller_tb.v` to test the timing controller.

---

## Phase 3: Synchronization Module
- [ ] Write `sync_ctrl.v` to manage synchronization between multiple FSM instances.
- [ ] Define communication/signaling between `sync_ctrl.v` and FSM modules.
- [ ] Create `sync_ctrl_tb.v` for standalone testing of the synchronization module.

---

## Phase 4: Top-Level Integration
- [ ] Develop `top.v` to integrate `ddi_fsm.v`, `sync_ctrl.v`, and timing controller completely.
- [ ] Write `top_tb.v` to validate the integrated design.
- [ ] Simulate the top-level design under various scenarios:
  - [ ] Normal traffic flow.
  - [ ] Edge cases (e.g., simultaneous requests, invalid states, etc).

---

## Phase 5: Testing and Validation
- [ ] Collect and analyze simulation data for performance metrics.
- [ ] Iterate on design based on test results.

---

## Phase 6: Optimization and Synthesis
- [ ] Prepare design for synthesis using Yosys.
- [ ] Verify synthesized design functionality using post-synthesis simulation.
