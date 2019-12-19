---
title: "Run automation instruments script from the command line"
date: 2015-01-24T13:38:03+05:00
categories: [ios, ui, test, automation, functional test]
---
To run ui test from command line you can use instruments app as described [here](https://developer.apple.com/library/ios/documentation/DeveloperTools/Conceptual/InstrumentsUserGuide/UsingtheAutomationInstrument/UsingtheAutomationInstrument.html).

```bash
  instruments -w deviceID -t defaultTemplateFilePath targetAppName \
  -e UIASCRIPT scriptFilePath -e UIARESULTSPATH resultsFolderPath
```

The problem is defaultTemplateFilePath depends on xcode version. Documentation says Automation.tracetemplate is located here :
```bash
/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/Library/Instruments/PlugIns/AutomationInstrument.bundle/Contents/Resources/Automation.tracetemplate
```

Since xcode 6 Automation.tracetemplate can be found:
```bash
/Applications/Xcode.app/Contents/Applications/Instruments.app/Contents/PlugIns/AutomationInstrument.xrplugin/Contents/Resources/Automation.tracetemplate
```
