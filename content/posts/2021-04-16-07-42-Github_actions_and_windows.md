---
title: "Github actions and windows"
date: 2021-04-16T07:42:29+02:00
categories: [software]
tags: [github, ci, windows]
---
Be careful while using Github actions for Windows.

By default Windows uses Powershell not bash, but you may prefer to explicitly choose bash as a shell.  
See Github action [documentation](https://docs.github.com/en/actions/reference/workflow-syntax-for-github-actions#jobsjob_iddefaultsrun)

You can find some details about using Powershell [here](https://github.community/t/environmental-files-on-windows/137631/2)
