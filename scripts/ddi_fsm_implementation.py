import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Phase 1 refers to letting that traffic cross the other lane - the first light they'd encounter.
# Phase 2 refers to crossing through the intersection.

# Define states
fsm.node('ALL_RED', '0000')
fsm.node('PHASE_1_GREEN', '0001')
fsm.node('PHASE_1_YELLOW', '0010')
fsm.node('PHASE_2_GREEN', '0011')
fsm.node('PHASE_2_YELLOW', '0100')
fsm.node('EASTBOUND_GREEN', '0101')
fsm.node('EASTBOUND_YELLOW', '0110')
fsm.node('WESTBOUND_GREEN', '0111')
fsm.node('WESTBOUND_YELLOW', '1000')

# Maintenance state
fsm.node('Maintenance', '1001', shape='doublecircle', style='dashed')

# Meta-group for readability
fsm.node('meta', '', shape='point', width='0', height='0')
fsm.edge('meta', 'Maintenance', label='panic || maintenance', style='dashed')
fsm.edge('Maintenance', 'ALL_RED', label='!panic && !maintenance')

# Define transitions
fsm.edge('ALL_RED', 'PHASE_1_GREEN', 'timing == 1 && phase == 00')
fsm.edge('PHASE_1_GREEN', 'PHASE_1_YELLOW', 'timing == 1')
fsm.edge('PHASE_1_YELLOW', 'ALL_RED', 'timing == 1')
fsm.edge('ALL_RED', 'PHASE_2_GREEN', 'timing == 1 && phase == 01')
fsm.edge('PHASE_2_GREEN', 'PHASE_2_YELLOW', 'timing == 1')
fsm.edge('PHASE_2_YELLOW', 'ALL_RED', 'timing == 1')
fsm.edge('ALL_RED', 'EASTBOUND_GREEN', 'timing == 1 && phase == 10')
fsm.edge('EASTBOUND_GREEN', 'EASTBOUND_YELLOW', 'timing == 1')
fsm.edge('EASTBOUND_YELLOW', 'ALL_RED', 'timing == 1')
fsm.edge('ALL_RED', 'WESTBOUND_GREEN', 'timing == 1 && phase == 11')
fsm.edge('WESTBOUND_GREEN', 'WESTBOUND_YELLOW', 'timing == 1')
fsm.edge('WESTBOUND_YELLOW', 'ALL_RED', 'timing == 1')

# Render and display the FSM diagram
fsm.render('../docs/diagrams/ddi_fsm_implementation')
fsm.view()
