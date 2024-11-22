import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Phase 1 refers to letting that traffic cross the other lane - the first light they'd encounter.
# Phase 2 refers to crossing through the intersection.

# Define states
fsm.node('ALL_RED', 'All Red')
fsm.node('PHASE_1_GREEN', 'Both Phase 1 Green, both Phase 2 Red')
fsm.node('PHASE_1_YELLOW', 'Both Phase 1 Yellow, both Phase 2 Red')
fsm.node('PHASE_2_GREEN', 'Both Phase 1 Red, both Phase 2 Green')
fsm.node('PHASE_2_YELLOW', 'Both Phase 1 Red, both Phase 2 Yellow')
fsm.node('EASTBOUND_GREEN', 'Eastbound Green, Westbound Red')
fsm.node('EASTBOUND_YELLOW', 'Eastbound Yellow, Westbound Red')
fsm.node('WESTBOUND_GREEN', 'Eastbound Red, Westbound Green')
fsm.node('WESTBOUND_YELLOW', 'Eastbound Red, Westbound Yellow')

# Maintenance state
fsm.node('Maintenance', 'Maintenance state (Flashing Red)', shape='doublecircle', style='dashed')
fsm.node('Note', '(All states can transition here once maintenance signal received)', shape='plaintext')

fsm.edge('Maintenance', 'Note', arrowhead='none', style='dotted')

# Meta-group for readability
fsm.node('meta', '', shape='point', width='0', height='0')
fsm.edge('meta', 'Maintenance', label='Maintenance signal received', style='dashed')

# Define transitions
fsm.edge('ALL_RED', 'PHASE_1_GREEN', 'Begin phase 1')
fsm.edge('PHASE_1_GREEN', 'PHASE_1_YELLOW', 'Timing controller requires transition to Red')
fsm.edge('PHASE_1_YELLOW', 'ALL_RED', 'Yellow timing satisfied')
fsm.edge('ALL_RED', 'PHASE_2_GREEN', 'Begin phase 2')
fsm.edge('PHASE_2_GREEN', 'PHASE_2_YELLOW', 'Timing controller requires transition to Red')
fsm.edge('PHASE_2_YELLOW', 'ALL_RED', 'Yellow timing satisfied')
fsm.edge('ALL_RED', 'EASTBOUND_GREEN', 'Sync controller requires Eastbound through')
fsm.edge('EASTBOUND_GREEN', 'EASTBOUND_YELLOW', 'Timing controller requires transition to Red')
fsm.edge('EASTBOUND_YELLOW', 'ALL_RED', 'Yellow timing satsified')
fsm.edge('ALL_RED', 'WESTBOUND_GREEN', 'Sync controller requires Westbound through')
fsm.edge('WESTBOUND_GREEN', 'WESTBOUND_YELLOW', 'Timing controller requires transition to Red')
fsm.edge('WESTBOUND_YELLOW', 'ALL_RED', 'Yellow timing satisfied')

# Render and display the FSM diagram
fsm.render('../../docs/diagrams/ddi_fsm')
fsm.view()
