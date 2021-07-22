---
title: "Entity component system"
date: 2020-10-31T13:09:03+05:00
categories: [programming]
tags: [design, composition, enheritance, gamedev, architecture]
---
```
Entity–component–system (ECS) is an architectural pattern that is mostly used in game development.
```

Main points:
1. every entity has unique id;
2. every logic aspect is a component - raw data linked to the corresponding entity by id;
3. system performs actions on entities having corresponding aspects/components;
4. diffenent components can be stored separately;
5. systems can track entities by using observer pattern.

More details can be found [here](https://en.wikipedia.org/wiki/Entity_component_system).
