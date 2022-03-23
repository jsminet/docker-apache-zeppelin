#!/bin/bash

# echo commands to the terminal output
env
set -ex

CMD="$1"

if [[ -z "${MAVEN_PROFILE}" ]]; then
  unset ALL_MAVEN_PROFILES
else
  ALL_MAVEN_PROFILES="-P${MAVEN_PROFILE}"
fi

if [[ -z "${MAVEN_PROJECT}" ]]; then
  unset ALL_MAVEN_PROJECTS
else
  ALL_MAVEN_PROJECTS="-pl ${MAVEN_PROJECT}"
fi

case "$CMD" in
  package|install)
  shift 1
    CMD=(
    ./mvnw \
    $MAVEN_ARGS \
    $CMD \
    -DskipTests \
    $ALL_MAVEN_PROFILES \
    $ALL_MAVEN_PROJECTS \
    $@
    )
    ;;

  *)
    echo "Unknown command: $CMD" 1>&2
    exit 1
esac

exec tini -s -- "${CMD[@]}"