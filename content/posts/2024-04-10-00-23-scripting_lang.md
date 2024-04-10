---
title: "The scripting language"
date: 2024-04-10T00:23:49+02:00
categories: [programming]
tags: []
---
[source](https://joaomagfreitas.link/scripts-should-be-written-using-the-project-main-language/)

TLDR: use main language of the project to write scripts.  
+1
+2
:)

Additional couple of remarks:
1. at some moment you can think about writing tests;
2. at some moment you need to reuse something else from the project (also it's possible to duplicate\reimplement something from the project using scripting language);
3. at some moment you can think about integrating functionality implemented inside the script to the main project (admin endpoint\UI\background job\etc).

That's why it's better to write additional logic not using a script but using the main language from the very beginning.
