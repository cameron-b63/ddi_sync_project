SIM = iverilog
VVP = vvp
SRC = src/timing_controller.v# src/sync_ctrl.v
TB = tb/timing_controller_tb.v
OUT = sim/compiled.out

all: simulate

simulate:
	$(SIM) -o $(OUT) $(SRC) $(TB)
	$(VVP) $(OUT)
