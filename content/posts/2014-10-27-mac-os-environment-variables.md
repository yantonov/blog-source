---
date: 2014-10-27T02:36:04+05:00
title: "Mac os environment variables"
categories: [mac, environment, shell]
---
Suppose you install some program into your home directory (i had installed [mercurial](http://mercurial.selenic.com/ "mercurial") from source). To use it you have to patch PATH variable.

To achieve this, you needed to modify, for example, local .profile file (its undesirable to modify global config like etc/profile). So your .profile file contains something like this:

``` bash 
export PATH=$ADDITIONAL_PATH:$PATH
```

It wokrs great from terminal. But you cant use variable defined such way from programs launched throught spotlight, because all apps started from gui interface of Mac Os has its own list of environemnt variables (independent from terminal). In my case i cant access mercurial from [emacs](http://www.gnu.org/software/emacs/ "emacs") launched from spotlight.

You can access environment variables used by gui apps in such way:

``` bash
$ launchctl getenv PATH
```

To change it:

``` bash
$ launchctl setenv PATH $SOME_PATH
```

Its reasonable to preserve original PATH while patching. So you want to add your $ADDITIONAL_PATH into gui PATH

``` bash
# save old path
OLD_GUI_PATH=`launchctl getenv PATH`
# construct new path
NEW_GUI_PATH=$ADDITIONAL_PATH:$OLD_GUI_PATH
# update gui path
launchctl setenv PATH $NEW_GUI_PATH
```

These changes are not persisted, so you will miss it after restart.
Hhhhaaa, add this into .profile.

But .profile is evaluated at every launch of terminal.

So you have conditionally patch your environent variables, in other words .profile must be idempotent. Multiple evaluation of .profile must have same effect as single evaluation, othewise after terminal app launches several times, your PATH looks like this:

``` bash
ADDITIONAL_PATH:ADDITIONAL_PATH:ADDITIONAL_PATH...:$PATH
```

So final version of the script:

``` bash
# patch PATH for terminal programs
# check variable hasnt already patched
if [[ $PATH != *$ADDITIONAL_PATH* ]]
then
    export PATH=$ADDITIONAL_PATH:$PATH
fi

# patch PATH for gui (and spotlight in particular)
# preserve old values
OLD_GUI_PATH=`launchctl getenv PATH`
# check if has not already patched
if [[ $OLD_GUI_PATH != *$ADDITIONAL_PATH* ]]
then
    NEW_GUI_PATH=$ADDITIONAL_PATH:$OLD_GUI_PATH
    launchctl setenv PATH $NEW_GUI_PATH
fi
```

Looks like a little bit cumbersome, but works !
If there is easier way, i would be glad to know.

**Update:** There is problem with this solution. launchctl settings are updated during first load of .profile file. So if you has not opened terminal app yes (for example after restart), you cant use this customization.  
Updated solution can be found [here](/blog/2014/11/04/path-variable-for-gui-programs-mac-os).
