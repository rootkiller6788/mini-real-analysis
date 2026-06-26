/-
# Overview — mini-differentiation

## Package Structure

```
mini-differentiation/
  lakefile.lean          — Lake build config
  lean-toolchain         — Lean v4.7.0
  Main.lean              — Entry point
  MiniDifferentiation.lean  — Root aggregator (imports all 23 submodules)
  MiniDifferentiation/
    Core/                — Basic, Laws, Objects
    Morphisms/           — Hom, Iso, Equiv
    Constructions/       — Products, Quotients, Subobjects, Universal
    Properties/          — Invariants, Preservation, ClassificationData
    Theorems/            — Basic, Classification, Main, UniversalProperties
    Examples/            — Standard, Counterexamples
    Bridges/             — ToAlgebra, ToTopology, ToGeometry, ToComputation
  Test/                  — Basic, ConstructionTests, MorphismTests
  Benchmark/             — DerivativeBench, TaylorBench, ChainRuleBench,
                           HigherDerivBench, JacobianBench, FullSuite
  Computation/           — Algorithms, DecisionProcedures, Evaluate
  docs/                  — APIReference, Overview, TheoryGuide
  scripts/               — build.lean, clean.lean
```

## Key Concepts

1. **Derivative** (ε-δ): The fundamental limit definition
2. **Differentiation rules**: Sum, product, quotient, chain, linearity
3. **C^k and smoothness**: Function regularity classes
4. **Taylor theory**: Polynomial approximations, remainders, universal property
5. **Critical point theory**: Classification, Morse functions, Hessian, index
6. **Jet spaces**: Equivalence classes of functions modulo k-jet
7. **Smooth maps and diffeomorphisms**: Morphisms in the smooth category
8. **Bridges**: Connections to algebra (derivations), topology (Whitney topologies),
   geometry (tangent spaces), computation (numerical/automatic differentiation)
-/

#eval "Overview: mini-differentiation package structure and key concepts"
