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

REPO_ROOT_DIR=$(cd "$SCRIPT_DIR"/.. || exit 1; pwd)

podman run \
  --rm \
  -it \
  --uidmap 1000:0:1 \
  --uidmap 0:1:1000 \
  --volume "$(echo "$REPO_ROOT_DIR:/opt/workdir:rw")" \
  "ghcr.io/potassium-os/ubiboot:latest" \
    /bin/bash -c "$*"
