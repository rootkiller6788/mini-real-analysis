/-
# MiniContinuity Overview

## Purpose
The mini-continuity package provides a comprehensive Lean 4 formalization
of continuity theory for real-valued functions. It covers everything from
basic ε-δ definitions to advanced theorems like Tietze extension and
Stone-Weierstrass.

## Package Structure
The package follows the standard mini-everything-math architecture:

- **Core/**: Fundamental definitions
  - Basic.lean — Limits, continuity types, discontinuities, monotonicity
  - Objects.lean — ContinuousFn, C(X), C_b(X), C_c(X), C₀(X)
  - Laws.lean — Algebraic laws, IVT, EVT, Heine-Cantor as kernel axioms

- **Morphisms/**: Maps between spaces
  - Hom.lean — ContinuousMap, UniformlyContinuousMap, LipschitzMap, Homeomorphism
  - Iso.lean — isHomeomorphism, isIsometry, isDilatation
  - Equiv.lean — topological/uniform/Lipschitz equivalence

- **Constructions/**: Product, quotient, subobject, universal constructions
- **Properties/**: Invariants, preservation, classification data
- **Theorems/**: IVT, EVT, Heine-Cantor, Darboux, Brouwer, Tietze, Banach fixed point
- **Examples/**: Standard examples and counterexamples
- **Bridges/**: Connections to algebra, topology, geometry, computation

## Key Formalization Decisions
- Limits defined via ε-δ (not via filters) for accessibility
- Continuity defined on ℝ (extensible to metric spaces)
- `sorry` used for deep analytic proofs
- Kernel `Axiom` values for key theorems
-/
