import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')
fsm.attr(rankdir='TB', ranksep='1.5')

# Phase 1 refers to letting that traffic cross the other lane - the first light they'd encounter.
# Phase 2 refers to crossing through the intersection.

# Define states
fsm.node('ALL_RED', 'All Red')
fsm.node('PHASE_1_GREEN', 'Both Phase 1 Green,\nboth Phase 2 Red')
fsm.node('PHASE_1_YELLOW', 'Both Phase 1 Yellow,\nboth Phase 2 Red')
fsm.node('PHASE_2_GREEN', 'Both Phase 1 Red,\nboth Phase 2 Green')
fsm.node('PHASE_2_YELLOW', 'Both Phase 1 Red,\nboth Phase 2 Yellow')
fsm.node('EASTBOUND_GREEN', 'Eastbound Green,\nWestbound Red')
fsm.node('EASTBOUND_YELLOW', 'Eastbound Yellow,\nWestbound Red')
fsm.node('WESTBOUND_GREEN', 'Eastbound Red,\nWestbound Green')
fsm.node('WESTBOUND_YELLOW', 'Eastbound Red,\nWestbound Yellow')

# Maintenance state
fsm.node('Maintenance', 'Maintenance state\n(Flashing Red)', shape='doublecircle', style='dashed')
fsm.node('Note', '(All states can transition here\nonce maintenance signal received)', shape='plaintext')


with fsm.subgraph() as s:
	s.attr(rank='sink')
	s.edge('Maintenance', 'Note', arrowhead='none', style='dotted')
	s.node('meta', '', shape='point', width='0', height='0')
	s.edge('meta', 'Maintenance', label='Maintenance signal received', style='dashed')

# Define transitions
fsm.edge('ALL_RED', 'PHASE_1_GREEN', 'Begin phase 1')
fsm.edge('PHASE_1_GREEN', 'PHASE_1_YELLOW', 'Green timing satisfied')
fsm.edge('PHASE_1_YELLOW', 'ALL_RED', 'Yellow timing satisfied')
fsm.edge('ALL_RED', 'PHASE_2_GREEN', 'Begin phase 2')
fsm.edge('PHASE_2_GREEN', 'PHASE_2_YELLOW', 'Green timing satisfied')
fsm.edge('PHASE_2_YELLOW', 'ALL_RED', 'Yellow timing satisfied')
fsm.edge('ALL_RED', 'EASTBOUND_GREEN', 'Phase controller requires\nEastbound through')
fsm.edge('EASTBOUND_GREEN', 'EASTBOUND_YELLOW', 'Green timing satisfied')
fsm.edge('EASTBOUND_YELLOW', 'ALL_RED', 'Yellow timing satsified')
fsm.edge('ALL_RED', 'WESTBOUND_GREEN', 'Phase controller requires\nWestbound through')
fsm.edge('WESTBOUND_GREEN', 'WESTBOUND_YELLOW', 'Green timing satisfied')
fsm.edge('WESTBOUND_YELLOW', 'ALL_RED', 'Yellow timing satisfied')

# Render and display the FSM diagram
fsm.render('../../docs/diagrams/ddi_fsm_design')
fsm.view()
