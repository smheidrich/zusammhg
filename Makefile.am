bin_SCRIPTS = zusammhg
CLEANFILES = $(bin_SCRIPTS)
EXTRA_DIST = zusammhg.m4
dist_data_DATA = gdb_script.py
dist_doc_DATA = README.md

zusammhg : zusammhg.m4 Makefile
	m4 -Ddatadir=$(datadir) < zusammhg.m4 > zusammhg
