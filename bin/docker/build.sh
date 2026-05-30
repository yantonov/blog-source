#!/usr/bin/env sh
set -o errexit -o nounset

docker build -t hugo-fixed .
