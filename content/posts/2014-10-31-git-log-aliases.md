---
title: "Git log aliases"
date: 2014-10-31T00:10:22+05:00
categories: [git, alias, config, vcs, scm]
---
Here are some usefull [git](http://git-scm.com) [aliases](https://git.wiki.kernel.org/index.php/Aliases) which i use on a daily basis:  
Output samples are generated using clojure [repository](https://github.com/clojure/clojure.git)

List of one line commits

    ls = log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset'

![ls](/images/git-log-aliases/ls.png)

List of commits with changed files

    ll = log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset' --decorate --numstat

![ll](/images/git-log-aliases/ll.png)

List of commits without colors

    lnc = log --pretty=format:"%h\\ %s\\ [%cn]"

![lnc](/images/git-log-aliases/lnc.png)

Commits with dates

    ldt = log --all --pretty=format:'%Cred%h%Creset %Cgreen%ad%Creset -%C(yellow)%d%Creset %s %C(bold blue)<%an>%Creset'

![ldt](/images/git-log-aliases/ldt.png)

Commits with short dates

    lds = "!git ldt --date=short"

![lds](/images/git-log-aliases/lds.png)

Commits with relative dates

    ldr = "!git ldt --date=relative"

![ldr](/images/git-log-aliases/ldr.png)

commits with date and times

    ldi = "!git ldt --date=iso"

![ldi](/images/git-log-aliases/ldi.png)

Commit tree

    lgraph = log --all --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%ci)%Creset %C(bold blue)<%an>%Creset'

![lgraph](/images/git-log-aliases/lgraph.png)

Default look for short git log

    ldef = log --oneline --decorate

![ldef](/images/git-log-aliases/ldef.png)

Commits related to a file

    filelog = log -u
    fl = log -u

![filelog](/images/git-log-aliases/filelog.png)

Last commit

    lc = "!git ll -1"

![lc](/images/git-log-aliases/lc.png)
