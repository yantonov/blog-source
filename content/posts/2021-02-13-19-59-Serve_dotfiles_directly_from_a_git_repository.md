---
title: "Serve dotfiles directly from a git repository"
date: 2021-02-13T19:59:18+01:00
categories: []
tags: [dotfiles, configuration]
---
[Here](https://www.atlassian.com/git/tutorials/dotfiles) is an interesting article which explains another way to store dotfiles.

In a couple of words:
1. store dotfiles into a git repository
2. clone your git repository using a bare more and make working directory pointing to ${HOME}
3. use dotfiles directly from the repository (without symbolic links)

The only disadvantage is that all dotfiles must be inside one repository.
It is not scalable approach in that sense that typically configuration files for the different programs are splitted into multiple repositories.
Using multiple repositories helps to effective share particular configurations.

That's why using symlinks and maybe some tools that simplifies the symlink creation are still the prefered approach for me. 

Anyway, it is interesting approach and can be useful in some cases.
