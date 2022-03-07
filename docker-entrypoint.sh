#!/bin/bash

# echo commands to the terminal output
set -ex

CMD="$1"
case "$CMD" in
  package)
  shift 1
    CMD=(
    ./mvnw -B package -DskipTests \
    -Pbuild-distr \
    -Pspark-3.1 \
    -Pinclude-hadoop \
    -Phadoop3 \
    -Pspark-scala-2.12 \
    -Pweb-angular \
    "$@"
    )
    ;;

  *)
    echo "Unknown command: $CMD" 1>&2
    exit 1
esac

exec tini -s -- "${CMD[@]}"