#!/usr/bin/env sh
set -o errexit -o nounset

docker run --rm hugo-fixed version
