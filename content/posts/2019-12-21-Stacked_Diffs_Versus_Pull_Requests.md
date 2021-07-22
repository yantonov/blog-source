---
title: "Stacked diffs versus pull requests"
date: 2019-12-21T23:18:26+05:00
categories: [programming]
tags: [scm, vcs, trunk]
---
[Here](https://jg.gg/2018/09/29/stacked-diffs-versus-pull-requests/) is an interesting article 'Stacked Diffs Versus Pull Requests' written by [Jackson Gabbard](https://twitter.com/jgbbrd).

Important note about the quality of the codebase (in context of stacked diff, i.e. trunk based development):
> In this model, every commit must pass lint. It must pass unit tests. It must build. Every commit should have a test plan. A description. A meaningful title. Every. Single. Commit. This level of discipline means the code quality bar is fundamentally higher than the Pull Request world...
I didn't think a lot about it before, but it definitely seems realistic.

Overall, it seems that comparison of these two models (stacked diffs and pull requests) is more about task granularity (which is convenient by itself) and useful tooling (in terms of minimization manual mechanics).
In any case, any commit/PR must be reviewed, so it doesn't matter whether you create branch, or squash some local diff on top of master.
