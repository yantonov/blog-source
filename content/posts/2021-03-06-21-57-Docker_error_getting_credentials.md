---
title: "Docker error: error getting credentials"
date: 2021-03-06T21:57:43+01:00
categories: [ops]
tags: [docker, error]
---
Aaaah!
Today I faced a strange error message from docker.
```
 => ERROR [internal] load metadata for docker.io/library/python:3.8-slim-buster                                                 0.6s
------
 > [internal] load metadata for docker.io/library/python:3.8-slim-buster:
------
failed to solve with frontend dockerfile.v0: failed to create LLB definition: rpc error: code = Unknown desc = error getting credentials - err: exec: "docker-credential-desktop.exe": executable file not found in $PATH, out: ``
```
Thanks to [Bertrand C](https://forums.docker.com/u/bcheronn) for the solution.  
```
    In ~/.docker/config.json change credsStore to credStore
```
[Source](https://forums.docker.com/t/docker-credential-desktop-exe-executable-file-not-found-in-path-using-wsl2/100225/4)
