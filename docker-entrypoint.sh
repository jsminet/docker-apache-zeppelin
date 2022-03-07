#!/bin/bash

# echo commands to the terminal output
set -ex

CMD="$1"
case "$CMD" in
  package|install)
  shift 1
    CMD=(
    ./mvnw "$CMD" \
    -DskipTests \
    -P"$MAVEN_PROFILE" \
    -pl '"$MAVEN_PROJECT"' \
    "$MAVEN_ARGS"
    "$@"
    )
    ;;

  *)
    echo "Unknown command: $CMD" 1>&2
    exit 1
esac

exec tini -s -- "${CMD[@]}"