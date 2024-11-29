import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Define states
fsm.node('PHASE_1', 'Phase 1')
fsm.node('PHASE_2', 'Phase 2')
fsm.node('PRIORITY_EAST', 'Eastbound priority')
fsm.node('PRIORITY_WEST', 'Westbound priority')

# Transitions
fsm.edge('PHASE_1', 'PHASE_2', 'Light state is phase 1 yellow')
fsm.edge('PHASE_2', 'PHASE_1', 'Light state is phase 2 yellow with no priority')
fsm.edge('PHASE_2', 'PRIORITY_EAST', 'Light state is phase 2 yellow with eastern priority')
fsm.edge('PHASE_2', 'PRIORITY_WEST', 'Light state is phase 2 yellow with western priority')
fsm.edge('PRIORITY_EAST', 'PHASE_1', 'Light state is eastbound yellow')
fsm.edge('PRIORITY_WEST', 'PHASE_1', 'Light state is westbound yellow')

fsm.render('../docs/diagrams/phase_controller_design')
fsm.view()
