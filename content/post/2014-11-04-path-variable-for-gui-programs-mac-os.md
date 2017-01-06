---
title: "PATH variable for gui programs (Mac Os)"
date: 2014-11-04T19:22:34+05:00
categories: [mac,shell,environment]
---
**Foreword**:  
Sometimes you need to edit PATH variable.  
Of course you edit .bash_profile, .bashrc, .profile or other scripts and this works fine **only in terminal**.  
GUI apps at Mac Os use its own PATH variable (moreover has its own environment), which can be set using 'launchctl setenv PATH <PATH_VALUE>'.  
So you need to setup PATH for GUI apps correctly, and do not forget about PATH var for terminal.

Moreover, after update to Mac Os X 10.10 Yosemite i was wondering about this:

``` bash
launchctl getenv PATH

# empty response
```

Reasons for such behaviour is unknown for me now (even after readind dozen of man pages and all latest recipes connected to this issue at stackoverflow).
So if you add something to PATH:
``` bash
OLD=`launchctl getenv PATH`
NEW=<your_path>:$OLD
launchctl setenv PATH
```
then you cant access from gui programs some applications at system directories (/bin:/sbin etc).  
I just decided to init empty PATH var by contents of /etc/paths.

The main question: what is the way to set up GUI PATH variable using script, reuse PATH variable from terminal settings, and start this script automatically.
[Daemon and agents mechanism](https://developer.apple.com/library/mac/documentation/MacOSX/Conceptual/BPSystemStartup/Chapters/CreatingLaunchdJobs.html) gives an answer.

This script to setup PATH var:

fix-gui-path.sh  
``` bash
#!/bin/bash
# patch PATH for gui (and spotlight in particular)

# save old value of PATH var
OLD_GUI_PATH=`launchctl getenv PATH`

# if initial path is empty fill it using /etc/paths, otherwise
# you cant use apps in system directories
if [[ -z "$OLD_GUI_PATH" ]]
then
    OLD_GUI_PATH=`cat /etc/paths | tr "\n" ":" | sed 's/:$//'`
fi

# load .profile (i save terminal PATH modification here)
# so i want to reuse this settings for gui applications
# all my additional paths are saved as ADDITIONAL_PATH variable
# one of my .profile file looks like
# export ADDITIONAL_PATH=...
source ~/.profile

# patch gui PATH varible
if [[ $OLD_GUI_PATH != *$ADDITIONAL_PATH* ]]
then
    NEW_GUI_PATH=$ADDITIONAL_PATH:$OLD_GUI_PATH
    launchctl setenv PATH $NEW_GUI_PATH
fi
```

Than create plist file to inform launchd daemon to start your script:

com.example.gui.path.fix  
``` xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.example.gui.path.fix</string>
    <key>ProgramArguments</key>
    <array>
        <string>***PATH_TO_SCRIPT***/fix-gui-path.sh</string>
    </array>
    <!-- to avoid absolute path
        <string>sh</string>
        <string>-c</string>
        <string>"$HOME/***RELATIVE_PATH***</string>
    -->
    <key>RunAtLoad</key>
    <true/>
    <key>ExitTimeOut</key>
    <integer>0</integer>
    <key>ProcessType</key>
    <string>Background</string>
</dict>
</plist>
```
where
***PATH_TO_SCRIPT*** - absolute path to fix-gui-path.sh script descrived above,
***RELATIVE_PATH*** - relative path inside user directory.
Place this file into ~/Library/LaunchAgents/.

Using this all your gui apps will use terminal PATH variable (no need to set PATH twice for terminal and gui apps) and the problem with gui PATH also will be solved.
