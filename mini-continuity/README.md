# mini-continuity

Continuity theory package — part of the mini-real-analysis collection in the
mini-everything-math ecosystem.

## Overview

This package provides a comprehensive framework for studying continuity of
real-valued functions. It covers:

- **Limits of functions**: ε-δ definition, one-sided limits
- **Continuity**: pointwise, uniform, Lipschitz, Hölder
- **Classification of discontinuities**: removable, jump, essential
- **Key theorems**: Intermediate Value Theorem, Extreme Value Theorem, Heine-Cantor
- **Function spaces**: C(X), C_b(X), C_c(X), C_0(X)
- **Morphisms**: continuous maps, homeomorphisms, isometries
- **Bridges**: connections to algebra, topology, geometry, and computation

## Dependencies

- `mini-object-kernel` — Mathematical object typeclass
- `mini-real-numbers` — Real numbers and metric spaces
- `mini-sequence-series` — Sequences and series

## Structure

```
MiniContinuity/
  Core/          — Basic definitions: limits, continuity types
  Morphisms/     — Maps between spaces: Hom, Iso, Equiv
  Constructions/ — Products, quotients, subobjects, universal properties
  Properties/    — Invariants, preservation, classification data
  Theorems/      — Main theorems: IVT, EVT, Heine-Cantor, Tietze
  Examples/      — Standard examples and counterexamples
  Bridges/       — Connections to algebra, topology, geometry, computation
Test/            — Test suites
Benchmark/       — Performance benchmarks
Computation/     — Algorithms and decision procedures
docs/            — Documentation
scripts/         — Build scripts
```
