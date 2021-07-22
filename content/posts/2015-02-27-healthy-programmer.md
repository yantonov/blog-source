---
title: "Stand up every 20 minutes (mac os)"
date: 2015-02-27T00:33:33+05:00
categories: [health]
tags: [macos, automation]
---
*Foreword* : Inspired by [excellent post](http://blog.jdevelop.com/software/lifehack/health/standing/linux/2015/02/25/standing-task-20.html)

Initial task: creating notification every 20 minutes can be decomposed into two parts:  
1. create notification  
2. scheduled launch  

First subtask can be solved using this trivial script.

standup.sh:

```bash
#!/bin/sh

# stand up notification

osascript -e 'display notification "Stand up" with title "Healthy programmer"'

say "Stand up"
```

Second subtask (scheduled launch) can be solved using: [daemon and agent mechanism](http://launchd.info/).

Create file: com.example.stand.up.plist and place it into **~/Library/LaunchAgents/**.

com.example.stand.up.plist
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Label</key>
  <string>com.example.stand.up</string>

  <key>ProgramArguments</key>
  <array>
    <string>sh</string>
    <string>-c</string>
    <string>**PATH_TO_STAND_UP_SCRIPT_DESCRIBED_ABOVE**"</string>
  </array>

  <key>StartInterval</key>
  <integer>1200</integer>

  <key>ExitTimeOut</key>
  <integer>0</integer>

  <key>ProcessType</key>
  <string>Standard</string>
</dict>
</plist>
```

To start using this file (add to scheduler):

```bash
launchctl load ~/Library/LaunchAgents/com.example.start.up.plist
```

To stop using this file (remove from scheduler):

```bash
launchctl unload ~/Library/LaunchAgents/com.example.start.up.plist
```

To list scheduled tasks

```bash
launchctl list
```

After reboot this file com.example.start.up.plist will be used automatically.
