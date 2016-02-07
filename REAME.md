zusammhg
========

Small script to find out the relationship between two or more C functions from
stack traces gathered with gdb.

Outputs graph showing relationships as Graphviz (DOT) file.

Usage
-----

```
zusammhg outfile function1 function2 ... -- command_to_debug
```
For now this works only from the directory in which the scripts were put.

The resulting graph (``outfile``) can be viewed using any DOT viewer, e.g.
```
xdot outfile
```
