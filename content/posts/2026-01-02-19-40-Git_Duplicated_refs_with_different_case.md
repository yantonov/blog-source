---
title: "Git: duplicated refs with different case"
date: 2026-01-02T19:40:36+01:00
categories: [ops]
tags: [git, vcs, scm]
---
Some file system are case insensitive, other are not.
When you try to checkout git repository, it's possible to face this kind of error:

> error: You're on a case-insensitive filesystem, and the remote you are 
> trying to fetch from has references that only differ in casing. It 
> is impossible to store such references with the 'files' backend. You 
> can either accept this as-is, in which case you won't be able to 
> store all remote references on disk. Or you can alternatively 
> migrate your repository to use the 'reftable' backend with the 
> following command: 
>  
>     git refs migrate --ref-format=reftable 
>  
> Please keep in mind that not all implementations of Git support this 
> new format yet. So if you use tools other than Git to access this 
> repository it may not be an option to migrate to reftables.

Root cause:
As it is mentioned above, some refs use different case.

How to find:

```bash
git ls-remote <url> | awk '{ print tolower($2) }' | sort | uniq -d
```

How to fix:
1. rename conflicting ref by adding suffix, for example
2. then delete old conflicting ref

```bash
git push origin --delete <ref-name>
```
