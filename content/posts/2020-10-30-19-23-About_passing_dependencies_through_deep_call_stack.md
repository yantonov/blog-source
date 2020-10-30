---
title: "About passing dependencies through deep call stack"
date: 2020-10-30T19:23:06+05:00
categories: [development]
tags: [dependency, context]
---
[Here](https://github.com/dry-python/returns#requirescontext-container) is another approach to pass dependencies through deep call stack.  
In a couple of words: just return a function (wrapper around a function) from the nested code and pass the environment from the top level.  
[Documentation](https://returns.readthedocs.io/en/latest/pages/context.html).  
