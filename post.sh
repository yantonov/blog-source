#!/bin/sh

SCRIPT_DIR=$(cd `dirname $0` && pwd)

cd $SCRIPT_DIR

if [ $# -eq 0 ]; then
    echo "usage: $0 <post_head>"
    exit 0
fi

CURRENT_DATE=`date "+%Y-%m-%d"`
POST_FILE_NAME="${CURRENT_DATE}-$1.md"

hugo new post/$POST_FILE_NAME
