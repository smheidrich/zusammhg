AC_DEFUN([WF_GDB_PYTHON_VERSION],[
    if test -z $GDB;
    then
        if test -z "$2";
        then
            GDB="gdb"
        fi
    fi
    AC_MSG_CHECKING(Python version of $GDB)
    ac_gdb_python_ver="$(gdb -batch -ex 'python import sys; sys.stdout.write(".".join([ str(x) for x in sys.version_info[0:2] ]))')"
    if test $? -eq 0;
    then
        $1=$ac_gdb_python_ver
        AC_MSG_RESULT($ac_gdb_python_ver)
    else
        AC_MSG_RESULT(no)
        AC_MSG_ERROR($GDB needs to be compiled as --with-python)
    fi
])
