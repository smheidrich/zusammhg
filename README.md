zusammhg
========

Small script to find out the relationship between two or more C functions from
stack traces gathered with gdb.

Outputs graph showing relationships as Graphviz (DOT) file.

Building GNU Autotools configuration
------------------------------------

```
autoreconf --install
```

Installation
------------

To install, use the usual GNU Autotools procedure:

```
./configure
make
# Normally as root:
make install
```

Usage
-----

```
zusammhg outfile function1 function2 ... -- command_to_debug
```

The resulting graph (``outfile``) can be viewed using any DOT viewer, e.g.

```
xdot outfile
```

Similar projects
----------------

- [Flowgraph-C](https://github.com/akumar101/Flowgraph-C)
