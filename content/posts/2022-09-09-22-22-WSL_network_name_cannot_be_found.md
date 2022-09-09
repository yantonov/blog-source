---
title: "WSL network name cannot be found"
date: 2022-09-09T22:22:48+02:00
categories: [ops]
tags: [windows, wsl]
---
If you face this issue working with WSL, the root cause of the problem is invalid current directory.

How to fix it:

1. open powershell
2. select home directory

```
    wsl -d DISTRO --cd ~
```

where DISTRO is the name of the distribution, that can be obtained

```
    wsl -l
```

[Source](https://github.com/microsoft/WSL/issues/7850)
