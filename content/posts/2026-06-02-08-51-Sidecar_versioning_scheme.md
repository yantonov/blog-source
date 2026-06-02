---
title: "Simplifying sidecar management through bundled releases"
date: 2026-06-02T08:51:26+02:00
categories: [ops]
tags: [version, deployment, yandex, cloud]
---
Many internal Yandex Cloud services rely on sidecar components and shared configurations to provide cross-cutting functionality such as:

- Log aggregation
- Common metrics collection
- Authorization
- Other platform-level capabilities

Managing these components can become challenging as the number of services and configurations grows. To simplify debugging, improve transparency, and make changes easier to track, the following approach was introduced.

**Versioned Component Bundles**

1. Individual components (sidecars, enriched configurations, and similar artifacts) are developed, released, and versioned independently.
2. Periodically, a **bundle** is created and assigned its own version.
3. Each bundle references a specific version of every included component:

   | Component | Version |
   |-----------|----------|
   | Component A | v1 |
   | Component B | v2 |
   | Component C | v3 |

4. From a user's perspective, only the bundle version matters. Instead of managing versions of individual components, users simply upgrade the bundle (for example, from `v1` to `v2`).

This model provides a stable and easy-to-consume distribution mechanism while allowing individual components to evolve independently.

**Similar Approaches**

The same concept is widely used in other ecosystems:

- **Anaconda Distribution** — a curated bundle of Python packages and tools.
- **Haskell Stack LTS snapshots** — a set of package versions from Hackage that are tested and guaranteed to work together.
  - https://docs.haskellstack.org/en/stable/

In both cases, consumers work with a single versioned distribution rather than managing compatibility between individual components themselves.

[Youtube](https://www.youtube.com/watch?v=P7rIBkyMjyo) (russian)
