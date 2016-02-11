changequote(`{{{', `}}}'){{{#!/bin/bash
USAGE="zusammhg outfile function1 function2 ... -- command_to_debug"

if (("$#"<4)); then
  echo "Usage: $USAGE" 1>&2
  exit 1
fi

outfile="$1"
shift

i=0
while (("$#")); do
  if [ "$1" = "--" ]; then
    shift
    break
  fi
  args[$i]='"'"$1"'"'
  ((i++))
  shift
done

if (( "${#args[*]}" < 1 )); then
  echo "Usage: $USAGE" 1>&2
  exit 1
fi

IFS_OLD="$IFS"; IFS=","; FUNCTION_NAMES="${args[*]}"; IFS="$IFS_OLD"
echo "$FUNCTION_NAMES"
RUN_ARGS="$@"

if [ -z "$RUN_ARGS" ]; then
  echo "Usage: $USAGE" 1>&2
  exit 1
fi

PYTHON_CMD=""\
'python exec(open("}}}datadir{{{/gdb_script.py").read(), '\
'{ "FUNCTION_NAMES": ['\
"$FUNCTION_NAMES"\
'], '\
'"OUTFILE": ''"'"$outfile"'"'\
' })'
CMD='gdb -batch -ex '"$PYTHON_CMD"' -ex "run" --args '"$RUN_ARGS"
echo "$CMD"

gdb -batch -ex "$PYTHON_CMD" -ex "run" --args $RUN_ARGS}}}
