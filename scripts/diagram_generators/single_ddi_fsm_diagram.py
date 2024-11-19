import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Phase 1 refers to letting that traffic cross the other lane - the first light they'd encounter.
# Phase 2 refers to crossing through the intersection.

# Define states
fsm.node('S0', 'All Red')
fsm.node('S1', 'Both Phase 1 Green, both Phase 2 Red')
fsm.node('S2', 'Both Phase 1 Yellow, both Phase 2 Red')
fsm.node('S3', 'Both Phase 1 Red, both Phase 2 Green')
fsm.node('S4', 'Both Phase 1 Red, both Phase 2 Yellow')
fsm.node('S5', 'Eastbound Green, Westbound Red')
fsm.node('S6', 'Eastbound Yellow, Westbound Red')
fsm.node('S7', 'Eastbound Red, Westbound Green')
fsm.node('S8', 'Eastbound Red, Westbound Yellow')

# Define transitions
fsm.edge('S0', 'S1', 'Begin phase 1')
fsm.edge('S1', 'S2', 'Timing controller requires transition to Red')
fsm.edge('S2', 'S0', 'Yellow timing satisfied')
fsm.edge('S0', 'S3', 'Begin phase 2')
fsm.edge('S3', 'S4', 'Timing controller requires transition to Red')
fsm.edge('S4', 'S0', 'Yellow timing satisfied')
fsm.edge('S0', 'S5', 'Sync controller requires Eastbound through')
fsm.edge('S5', 'S6', 'Timing controller requires transition to Red')
fsm.edge('S6', 'S0', 'Yellow timing satsified')
fsm.edge('S0', 'S7', 'Sync controller requires Westbound through')
fsm.edge('S7', 'S8', 'Timing controller requires transition to Red')
fsm.edge('S8', 'S0', 'Yellow timing satisfied')

# Render and display the FSM diagram
fsm.render('../../docs/block_diagrams/ddi_fsm')
fsm.view()
