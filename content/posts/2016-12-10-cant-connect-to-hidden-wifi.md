---
title: "Can not connect to hidden wifi (ubuntu 16.04 lts)"
date: 2016-12-10T21:38:41+05:00
categories: [ops]
tags: [ubuntu, wifi, connection, problem]
---
Problem: its impossible to connect to hidden wifi network (connect button is disabled)
Solution: execute in terminal (where sid - wifi network id):
```bash
nmcli c up id <sid>
```

[bug status](https://bugs.launchpad.net/ubuntu/+source/network-manager/+bug/1542733)
