import graphviz

fsm = graphviz.Digraph(format='png', engine='dot')

# Define states
fsm.node('COUNTING_NOT_DONE', 'timing_done = 0')
fsm.node('COUNTING_DONE', 'timing_done = 1')

# Transitions
fsm.edge('COUNTING_NOT_DONE', 'COUNTING_DONE', '!(counter < threshold)')
fsm.edge('COUNTING_DONE', 'COUNTING_NOT_DONE', 'counter < threshold')
fsm.edge('COUNTING_NOT_DONE', 'COUNTING_NOT_DONE', 'counter < threshold')

fsm.render('../../docs/diagrams/timing_controller_design')
fsm.view()
