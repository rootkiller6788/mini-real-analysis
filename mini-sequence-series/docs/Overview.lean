/-
# Theory Overview — Sequence and Series Theory

## Overview

This package provides a comprehensive formalization of sequences,
series, and convergence theory in the mini-everything-math ecosystem.

## Package Structure

```
mini-sequence-series/
├── MiniSequenceSeries/          (23 source files)
│   ├── Core/                    (4 files — fundamental types and laws)
│   │   ├── Basic                — Sequence, limit, series, power series
│   │   ├── Laws                 — Convergence axioms
│   │   └── Objects              — Kernel Object instances
│   ├── Morphisms/               (3 files — transformations)
│   │   ├── Hom                  — Sequence maps, Cesaro mean
│   │   ├── Iso                  — Asymptotic equivalence
│   │   └── Equiv                — Test equivalences
│   ├── Constructions/           (4 files — space constructions)
│   │   ├── Products             — Component-wise product
│   │   ├── Quotients            — c/c₀ quotient
│   │   ├── Subobjects           — ℓ¹, ℓ², ℓ∞ spaces
│   │   └── Universal            — Universal properties
│   ├── Properties/              (3 files)
│   │   ├── Invariants           — Rate, growth, density
│   │   ├── Preservation         — What operations preserve
│   │   └── ClassificationData   — Convergence classification
│   ├── Theorems/                (4 files)
│   │   ├── Basic                — B-W, MCT, convergence tests
│   │   ├── Classification       — Riemann rearrangement
│   │   ├── Main                 — Completeness, power series
│   │   └── UniversalProperties  — Free Banach, completions
│   ├── Examples/                (2 files)
│   │   ├── Standard             — Harmonic, geometric, exponential
│   │   └── Counterexamples      — Divergence, oscillation
│   └── Bridges/                 (4 files)
│       ├── ToAlgebra            — Convolution, Cauchy product
│       ├── ToTopology           — ℓ^p metrics, weak convergence
│       ├── ToGeometry           — Curves, dynamical systems
│       └── ToComputation        — Numerical summation
├── Test/                        (3 files)
├── Benchmark/                   (6 files)
├── Computation/                 (3 files)
└── docs/                        (3 files)
```

## Key Concepts

### Sequences
- `Sequence α := ℕ → α` — order matters, terms may repeat
- `Sequence.limit s L` — standard ε-N definition
- Boundedness, monotonicity, Cauchy criterion

### Series
- `Series a` — sequence of partial sums Σ_{k=0}^n a_k
- Absolute vs conditional convergence
- Convergence tests: comparison, ratio, root, integral, Leibniz

### Power Series
- Σ a_n (x-c)^n with radius of convergence R
- Abel's theorem: continuity at the boundary of convergence
- Generating functions

### Sequence Spaces
- ℓ¹ : Σ |a_n| < ∞
- ℓ² : Σ |a_n|² < ∞
- ℓ∞ : sup |a_n| < ∞
- c₀ : a_n → 0
- c : a_n → L for some L

## Theory Dependencies
- `mini-object-kernel` — Object typeclass, TheoryName
- `mini-real-numbers` — Real numbers

## Convergence Test Hierarchy

Plain convergence terms are ordinary summable.
Cesaro summable is stricter than Abel summable.
Tauberian conditions upgrade Cesaro/Abel summability to ordinary convergence.
-/

#eval "Overview: Sequence and Series theory overview — 23 modules, 45 files"
