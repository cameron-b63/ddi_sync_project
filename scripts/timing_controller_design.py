import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Define states
fsm.node('COUNTING_NOT_DONE', 'Waiting')
fsm.node('COUNTING_DONE', 'Cycle Complete')

# Transitions
fsm.edge('COUNTING_NOT_DONE', 'COUNTING_DONE', 'Counter reached appropriate limit')
fsm.edge('COUNTING_DONE', 'COUNTING_NOT_DONE', 'Counter not yet reached limit')
fsm.edge('COUNTING_NOT_DONE', 'COUNTING_NOT_DONE', 'Counter not yet reached limit')

fsm.render('../docs/diagrams/timing_controller_design')
fsm.view()
