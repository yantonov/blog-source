---
title: "Docker memory limit"
date: 2020-03-30T08:16:41+05:00
categories: []
tags: [docker, memory, limit, ops]
---
There are some options to control application memory consumption.

Docker has a couple of flags to control application inside the container.
1. --memory flag defines non swap memory limit
2. --memory-swap flag defines total memory limit (swap + non swap memory)
Details can be found [here](https://docs.docker.com/config/containers/resource_constraints/#--memory-swap-details)

Moreover, there is a cgroups limit at the os level.
To check it
```bash
    cat /sys/fs/cgroup/memory/memory.limit_in_bytes
``` 

When you try to check is, in some situations you can see some huge magic number

``` bash
cat /sys/fs/cgroup/memory/memory.limit_in_bytes
9223372036854771712
```
This is a maximum 64-bit signed integer rounded to the nearest page
[Source](https://unix.stackexchange.com/a/420911)
