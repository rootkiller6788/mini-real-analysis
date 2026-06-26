# MiniRiemannIntegration

Riemann integration theory for the mini-everything-math ecosystem.

## Overview

This package provides the foundations of Riemann integration:
- **Partitions** of intervals and their meshes
- **Darboux sums** (upper and lower sums)
- **Riemann sums** with sample points
- **Riemann integral** definition and equivalence with Darboux
- **Fundamental Theorem of Calculus** (both parts)
- **Improper integrals** for unbounded intervals and unbounded functions
- **L¹ space** as quotient of Riemann integrable functions

## Dependencies

- `mini-object-kernel` — typeclass and kernel infrastructure
- `mini-real-numbers` — real number structures
- `mini-continuity` — continuity basics

## Structure

- `Core/` — Basic definitions and laws
- `Morphisms/` — Integral-preserving maps and equivalences
- `Constructions/` — Products, quotients, subobjects, universal properties
- `Properties/` — Invariants, preservation, classification data
- `Theorems/` — Main theorems
- `Examples/` — Standard examples and counterexamples
- `Bridges/` — Connections to algebra, topology, geometry, computation

## Building

```
lake build
```

## Testing

```
lake env lean --run Test/Basic.lean
```

## License

MIT
