#!/bin/bash

# echo commands to the terminal output
set -ex

CMD="$1"

if [[ -z "${MAVEN_PROFILE}" ]]; then
  unset ALL_MAVEN_PROFILE
else
  ALL_MAVEN_PROFILE="--activate-profiles ${MAVEN_PROFILE}"
fi

if [[ -z "${MAVEN_PROJECT}" ]]; then
  unset ALL_MAVEN_PROJECT
else
  ALL_MAVEN_PROJECT="--projects ${MAVEN_PROJECT}"
fi

case "$CMD" in
  package|install)
  shift 1
    CMD=(
    ./mvnw \
    "$MAVEN_ARGS" \
    "$CMD" \
    -DskipTests \
    "$ALL_MAVEN_PROFILE" \
    "$ALL_MAVEN_PROJECT" \
    "$@"
    )
    ;;

  *)
    echo "Unknown command: $CMD" 1>&2
    exit 1
esac

exec tini -s -- "${CMD[@]}"