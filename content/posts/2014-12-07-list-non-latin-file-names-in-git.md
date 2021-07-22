---
title: "List non latin file names in git"
date: 2014-12-07T23:32:31+05:00
categories: [programming]
tags: [git, vcs, scm, tip, trick, filename, encoding]
---

Imagine you have commited file which name contain non latin letters.

``` bash
git init test-repo
cd test-repo

echo "test" > тест.тэхэтэ
git add .
git commit -m "initial commit"
```

Ok, lets list files changed at revision

``` bash
git log -p
```

Here you can see escaped file name, and obvious its hard to read.

```
diff --git "a/\321\202\320\265\321\201\321\202.\321\202\321\215\321\205\321\215\
new file mode 100644
index 0000000..9daeafb
--- /dev/null
+++ "b/\321\202\320\265\321\201\321\202.\321\202\321\215\321\205\321\215\321\202
@@ -0,0 +1 @@
+test
```

To handle this case there is config options 'core.quotepath'
The documentations (man git-config 1) says:

```
The commands that output paths (e.g.  ls-files, diff), when not
given the -z option, will quote "unusual" characters in the
pathname by enclosing the pathname in a double-quote pair and with
backslashes the same way strings in C source code are quoted. If
this variable is set to false, the bytes higher than 0x80 are not
quoted but output as verbatim. Note that double quote, backslash
and control characters are always quoted without -z regardless of
the setting of this variable.
```

Try to use it:

``` bash
git config --bool core.quotepath false
git log -p
```

```
iff --git a/тест.тэхэтэ b/тест.тэхэтэ
new file mode 100644
index 0000000..9daeafb
--- /dev/null
+++ b/тест.тэхэтэ
@@ -0,0 +1 @@
+test
```

Nice, no escaped paths!
