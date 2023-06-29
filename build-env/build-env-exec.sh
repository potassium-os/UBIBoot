#!/usr/bin/env bash

# debug mode = set -x = loud
DEBUG="${DEBUG:-false}"
if $DEBUG; then
  set -exu
else
  set -eu
fi

# where this .sh file lives
DIRNAME=$(dirname "$0")
SCRIPT_DIR=$(cd "$DIRNAME" || exit 1; pwd)
cd "$SCRIPT_DIR" || exit 1

podman run \
  --rm \
  -it \
  --uidmap 1000:0:1 \
  --uidmap 0:1:1000 \
  --volume "/home/epers/repos/UBIBoot:/opt/workdir:rw" \
  "localhost/ubi-build-env:dev" \
    /bin/bash
