---
title: "Move WSL to another drive"
date: 2022-04-07T10:22:12+02:00
categories: [ops]
tags: [windows, wsl]
---
[Here](https://avinal.space/posts/development/wsl1.html) is a nice instruction how to migrate wsl to another drive.

A couple of nuances:
1. When you export the image there is no need to define the version of WSL.
   But for the import you should do it (if you use version 2 for example), by using the version parameter, otherwise, you will get a confusing error about an incorrect parameter.
2. To define the default user you should use the command that may vary depending on the os version. For example, for Ubuntu 20.04 the command looks like ubuntu 2004, not ubuntu.
