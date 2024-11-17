SIM = iverilog
VVP = vvp
SRC = src/ddi_fsm.v src/sync_ctrl.v
TB = tb/ddi_fsm_tb.v
OUT = sim/compiled.out

all: simulate

simulate:
	$(SIM) -o $(OUT) $(SRC) $(TB)
	$(VVP) $(OUT)
