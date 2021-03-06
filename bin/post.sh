#!/bin/sh

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd $SCRIPT_DIR

if [ $# -eq 0 ]; then
    echo "usage: $0 <post_head>"
    exit 0
fi

cd ..

PREPARED=$(echo $1 | tr ' ' '_' | tr -cd '[:alnum:]_-')

CURRENT_DATE=`date "+%Y-%m-%d-%H-%M"`
POST_FILE_NAME="${CURRENT_DATE}-${PREPARED}.md"

hugo new posts/$POST_FILE_NAME

emacs content/posts/$POST_FILE_NAME
