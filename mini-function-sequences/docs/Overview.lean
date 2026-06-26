/-
# Package Overview

`mini-function-sequences` provides the theory of sequences of functions
valued in ℝ, covering multiple modes of convergence, equicontinuity,
and the major approximation theorems.

## Theme

The central theme is the study of convergence of sequences of functions.
Unlike sequences of numbers, sequences of functions admit several distinct
and inequivalent convergence modes. The relationships among these modes
are subtle and form a central topic in real analysis.

## Three Big Theorems

1. **Arzela-Ascoli**: Equicontinuity + uniform boundedness ⇔ relative compactness in C(X)
2. **Stone-Weierstrass**: Subalgebras that separate points are dense in C(X)
3. **Dini's Theorem**: Monotone pointwise ⇒ uniform (on compact with continuous limit)

## Package Structure

```
mini-function-sequences/
├── MiniFunctionSequences/
│   ├── Core/          — Basic definitions, laws, objects
│   ├── Morphisms/     — Convergence-preserving maps, summation methods
│   ├── Constructions/ — Products, quotients, subobjects, universal constructions
│   ├── Properties/    — Invariants, preservation, classification data
│   ├── Theorems/      — Main theorems and their proofs
│   ├── Examples/      — Standard examples and counterexamples
│   └── Bridges/       — Connections to algebra, topology, geometry, computation
├── Test/              — Test suites
├── Benchmark/         — Performance benchmarks
├── Computation/       — Numerical algorithms
├── docs/              — Documentation
└── scripts/           — Build scripts
```

## Key Definitions

- **SequenceOfFunctions α** = `ℕ → (α → ℝ)`
- **pointwiseConverges**: ∀x, f_n(x) → f(x)
- **uniformlyConverges**: ∀ε>0, ∃N, ∀n≥N, ∀x, |f_n(x)-f(x)|<ε
- **isEquicontinuous**: family shares a common modulus of continuity
-/

namespace MiniFunctionSequences

#eval "See file header for package overview"

end MiniFunctionSequences
