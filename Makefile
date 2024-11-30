SIM = iverilog
VVP = vvp
SRC = src/top.v src/phase_controller.v src/timing_controller.v src/light_controller.v
TB = tb/top_tb.v
OUT = sim/compiled.out
YS = rtl.ys

all: simulate diagrams 

simulate:
	$(SIM) -o $(OUT) $(SRC) $(TB)
	$(VVP) $(OUT)

diagrams:
	yosys -s $(YS)
	netlistsvg -o docs/diagrams/top.svg docs/diagrams/top.json
