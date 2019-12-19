---
title: "Export files changed at revision from mercurial"
date: 2014-12-07T22:59:45+05:00
categories: [mercurial, vcs, scm, export, tip, trick]
---

Sometimes (more precisely - rarely) you need to export files changed at given revision as directory tree instead of patch file.

Mercurial vcs has archive command which let you to export selected files at given revision:

``` bash
hg archive --type files --rev $REVISION -I list_of_files
```

To list files changed at revision:

``` bash
hg log -r $REVISION --template '{files}\n' | sed 's/\n / -I /g'
```

Here end of line character is used to handle the case of using space character in filename.

Combine this snippets

``` bash
#!/bin/bash

# dump all files changed at given revision into given directory

REVISION=$1
DESTINATION=$2

if [ -n "$REVISION" ] && [ -n "$DESTINATION" ]; then
    mkdir -p $DESTINATION
    hg archive --type files --rev $REVISION -I $(hg log -r $REVISION --template '{files}\n' | sed 's/\n / -I /g') $DESTINATION
else
    echo -e "`basename $0` revision outputdir"
    echo -e "\twhere revision - revision number or hash"
    echo -e "\toutputdir - destination directory (created if needed)"
fi
```
