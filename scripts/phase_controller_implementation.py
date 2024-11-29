import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Define states
fsm.node('PHASE_1', '00')
fsm.node('PHASE_2', '01')
fsm.node('PRIORITY_EAST', '10')
fsm.node('PRIORITY_WEST', '11')

# Transitions
fsm.edge('PHASE_1', 'PHASE_2', 'light_state == 0010')
fsm.edge('PHASE_2', 'PHASE_1', 'light_state == 0100 && priority == 00')
fsm.edge('PHASE_2', 'PRIORITY_EAST', 'light_state == 0100 && priority == 01')
fsm.edge('PHASE_2', 'PRIORITY_WEST', 'light_state == 0100 && priority == 10')
fsm.edge('PRIORITY_EAST', 'PHASE_1', 'light_state == 0110')
fsm.edge('PRIORITY_WEST', 'PHASE_1', 'light_state == 1000')

fsm.render('../../docs/diagrams/phase_controller_implementation')
fsm.view()
