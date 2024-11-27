SIM = iverilog
VVP = vvp
SRC = src/top.v src/phase_controller.v src/timing_controller.v src/ddi_fsm.v
TB = tb/top_tb.v
OUT = sim/compiled.out

all: simulate

simulate:
	$(SIM) -o $(OUT) $(SRC) $(TB)
	$(VVP) $(OUT)
