---
title: "Git find all alias definitions and their sources"
date: 2026-10-14T15:07:05+02:00
categories: [ops]
tags: [alias, git, config]
---
To list all definitions of a Git alias and identify their source config files:

```bash
git config --show-origin --get-all alias.co
```

- `--show-origin`: Shows the config file where each alias is defined.
- `--get-all`: Displays all definitions, including duplicates.
- `alias.co`: The alias to inspect.

Useful for debugging conflicting aliases across **local**, **global**, and **system** Git configurations.
