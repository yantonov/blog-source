---
title: "Delete package from Mac OS"
date: 2015-10-14T15:46:08+05:00
categories: [mac, package, automation, shell, script]
---
Sometimes you may want to delete some package (*.pkg) from your Mac OS installaction. Its assumed, you dont have uninstaller.

There is no official way to uninstall package, but you can do it manually using 'pkgutil' tool. There is some articles (you can [google it](https://www.google.ru/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#newwindow=1&q=delete+pkg+from+mac+os)) which described the process.

To automate the process i have wrote this script
uninstall-pkg.sh
``` bash
#!/bin/sh

# this script allow you to uninstall given pkg file

# ATTENTIONS!
# all delete operation are interactive, but in any way
# USE THIS SCRIPT FOR YOUR OWN RISK

SCRIPT=`basename $0`

WD=`pwd`

PACKAGE_NAME=$1

if [ -z "$PACKAGE_NAME" ]; then
    echo "[ERROR] - package is not defined"
    echo "Usage: $SCRIPT <package-name>"
    exit 0
fi

installed_packages=`pkgutil --pkgs | grep $PACKAGE_NAME`
if [ -z "$installed_packages" ]; then
    echo "[ERROR] - package '$PACKAGE_NAME' not found"
    exit 0
fi

for p in `pkgutil --pkgs | grep $PACKAGE_NAME`; do
    echo "Delete package: '$p' [y/n/other key to break] ?:"
    read -n 1 selection
    echo ""
    case "$selection" in
        y)
            echo "[INFO] - Process package: '$p'"
            volume=`pkgutil --pkg-info $p | grep -E 'volume:' | cut -d ' ' -f 2`
            location=`pkgutil --pkg-info $p | grep -E 'location:' | cut -d ' ' -f 2`
            package_path="$volume$location"
            echo '[INFO] - Go to package install location: $package_path'
            cd $package_path
            echo '[INFO] - Iterate package files:'
            for f in `pkgutil --only-files --files $p`; do
                echo 'Delete file: '$f' ? [y/n/other key to skip package]:'
                read -n 1 file_cmd
                echo ""
                case "$file_cmd" in
                    y)
                        sudo rm -i $f
                        echo "[INFO] - file '$f' deleted."
                    ;;
                    n)
                        echo "[INFO] - file '$f' skipped"
                    ;;
                    *)
                        echo "[INFO] - skip all files in package '$p'"
                        break
                    ;;
                esac
            done
            ;;
        n)
            echo '[INFO] - ok, i will skip package '%p''
            ;;
        *)
            echo '[INFO] - quit'
            exit 0
            ;;
    esac
done

cd $WD
```

[source](https://github.com/yantonov/sh/blob/master/mac/uninstall-pkg.sh)

All delete operation are interactive, but be carefull and use it for your own risk.
