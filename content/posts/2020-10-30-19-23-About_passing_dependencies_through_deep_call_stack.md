---
title: "About passing dependencies through deep call stack"
date: 2020-10-30T19:23:06+05:00
categories: [programming]
tags: [dependency, context]
---
[Here](https://github.com/dry-python/returns#requirescontext-container) is another approach to pass dependencies through deep call stack.  
In a couple of words: 
1. deeply nested code not executes immediately but returns a function for the later lazy evaluation;
2. the correponding function accepts the required environment;
3. at the top level call the function returned from the nested code and pass the environment to it.
[Documentation](https://returns.readthedocs.io/en/latest/pages/context.html).  
