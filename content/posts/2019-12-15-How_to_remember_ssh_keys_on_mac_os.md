---
title: "How to remember ssh keys on mac os"
date: 2019-12-15T19:04:37+05:00
categories: [ops]
tags: [mac, ssh, terminal, automation]
---
Got tired to enter ssh passphrases on mac os and want to know how easily force ssh-agent to remember ssh keys?

Add this snippet to ~/.ssh/config file:
```bash
Host *
     AddKeysToAgent yes
     UseKeychain yes
```

[Source](https://developer.apple.com/library/archive/technotes/tn2449/_index.html)

