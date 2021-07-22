---
title: "Webpack has not enough watchers"
date: 2017-09-13T14:34:45+05:00
categories: [programming]
tags: [web, webpack, watch, watchers]
---
Not enough watchers
Verify that if you have enough available watchers in your system. If this value is too low, the file watcher in Webpack won’t recognize the changes:

```bash
cat /proc/sys/fs/inotify/max_user_watches
```
Arch users, add fs.inotify.max_user_watches=524288 to /etc/sysctl.d/99-sysctl.conf and then execute sysctl --system. 

Ubuntu users (and possibly others): 

```bash
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
```

[Source](https://webpack.github.io/docs/troubleshooting.html#windows-paths "Webpack Has not enough watchers")
