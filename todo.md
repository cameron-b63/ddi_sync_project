# TODO: DDI Synchronization Project

This document tracks the steps and milestones for designing, programming, and testing the project. Tasks are divided into phases, and progress is marked with checkboxes.

---

## Phase 1: Initial Setup
- [X] Set up project directory structure.
- [X] Write `ddi_fsm.v` for a single DDI light configuration.
- [X] Create `ddi_fsm_tb.v` to test the FSM behavior.
- [X] Simulate the FSM and verify correct transitions using waveform tools (e.g., GTKWave).
- [ ] Document FSM states and transitions in `docs/fsm_states.md`.

---

## Phase 2: Timing Logic
- [ ] Design and implement `clk_divider.v` to handle timing for FSM transitions.
- [ ] Integrate clock divider with `ddi_fsm.v`.
- [ ] Update `ddi_fsm_tb.v` to test timing integration.
- [ ] Verify timing and FSM interaction via simulation.

---

## Phase 3: Synchronization Module
- [ ] Write `sync_ctrl.v` to manage synchronization between multiple FSM instances.
- [ ] Define communication/signaling between `sync_ctrl.v` and FSM modules.
- [ ] Create `sync_ctrl_tb.v` for standalone testing of the synchronization module.
- [ ] Simulate multiple FSMs controlled by `sync_ctrl.v` and verify behavior.

---

## Phase 4: Top-Level Integration
- [ ] Develop `top.v` to integrate `ddi_fsm.v`, `sync_ctrl.v`, and any other supporting modules.
- [ ] Write `top_tb.v` to validate the integrated design.
- [ ] Simulate the top-level design under various scenarios:
  - [ ] Normal traffic flow.
  - [ ] Pedestrian crossings.
  - [ ] Edge cases (e.g., simultaneous requests).

---

## Phase 5: Testing and Validation
- [ ] Automate testbench generation for different traffic flow scenarios.
- [ ] Test scalability with multiple DDI configurations.
- [ ] Collect and analyze simulation data for performance metrics.
- [ ] Iterate on design based on test results.

---

## Phase 6: Optimization and Synthesis
- [ ] Optimize FSM and synchronization logic for resource efficiency.
- [ ] Prepare design for synthesis using Yosys.
- [ ] Verify synthesized design functionality using post-synthesis simulation.

---

## General Maintenance
- [ ] Keep simulation logs and waveforms organized in the `sim/` directory.
- [ ] Update `docs/` with any design changes or insights.
- [ ] Maintain clear commit messages and version history in Git.

---

## Notes
- Tasks are modular to allow independent work on FSM, synchronization, and testbenches.
- Future phases may add tasks as the project evolves.

