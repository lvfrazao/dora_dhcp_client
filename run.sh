#!/bin/sh
#
# Run dora in a container

set -e

VERSION="0.1.1"
IMAGE="lvfrazao/dora:$VERSION"

exec docker run --rm --network host $IMAGE "$@"
