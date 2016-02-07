import gdb
from graphviz import Digraph

# FUNCTION_NAMES and OUTFILE are passed in from outside via execfile arguments

class CallTracer:
  def __init__(self, function_names, graph_name=None):
    self.function_names = function_names
    self.breakpoints = {}
    for fn in function_names:
      self.breakpoints[fn] = TracerBreakpoint(fn, internal=True, tracer=self)
    self.dg = Digraph(graph_name)
    self.nodes = set(function_names)
    self.edges = set()
    self.direct_connection_found = False
    gdb.events.exited.connect(self.on_exit)
  def on_breakpoint(self, breakpoint):
    name = None
    previous_name = None
    f = gdb.newest_frame()
    leaf_name = f.name()
    while f is not None:
      previous_name = name
      name = f.name()
      if not name:
        name = "0x{:x}".format(f.pc())
      if name not in self.nodes:
        self.dg.node(name)
        self.nodes.add(name)
      if previous_name is not None and (name, previous_name) not in self.edges:
        self.dg.edge(name, previous_name)
        self.edges.add((name, previous_name))
      if name != leaf_name and name in self.function_names:
        self.direct_connection_found = True
        break
      f = f.older()
  def on_exit(self, event):
    if self.direct_connection_found:
      gdb.write("Direct connection found.\n")
    else:
      gdb.write("No direct connection between functions.\n")
    self.dg.save(OUTFILE)

class TracerBreakpoint(gdb.Breakpoint):
  def __init__(self, *args, **kwargs):
    self.tracer = kwargs.pop("tracer")
    gdb.Breakpoint.__init__(self, *args, **kwargs)
  def stop(self):
    try:
      self.tracer.on_breakpoint(self)
    finally:
      return False

c = CallTracer(FUNCTION_NAMES, "test_graph")
