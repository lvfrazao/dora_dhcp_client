#!/bin/sh
#
# Run dora in a container

set -e

VERSION="0.1.3"
IMAGE="lvfrazao/dora:$VERSION"

exec docker build -t $IMAGE .
