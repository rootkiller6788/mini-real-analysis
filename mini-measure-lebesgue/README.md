# MiniMeasureLebesgue

**Measure Theory and Lebesgue Integration** — sub-package of `mini-real-analysis`.

## Overview

This package provides a formalization of measure theory and Lebesgue integration
in Lean 4, built on the `MiniObjectKernel` typeclass framework.

### Core Concepts
- Sigma-algebras and measurable spaces
- Measures (countably additive, nonnegative set functions)
- Lebesgue measure on the real line (translation-invariant)
- Measurable functions and simple functions
- The Lebesgue integral and its convergence theorems

### Key Theorems (with `sorry` for deep proofs)
- Monotone Convergence Theorem (MCT)
- Dominated Convergence Theorem (DCT)
- Fatou's Lemma
- Fubini-Tonelli Theorem
- Radon-Nikodym Theorem
- Lebesgue decomposition theorem
- Luzin's Theorem and Egorov's Theorem

### Bridges
- L^1(G) as Banach algebra under convolution (algebra)
- L^p spaces as complete metric spaces (topology)
- Lebesgue measure as volume, Hausdorff measure (geometry)
- Monte Carlo integration (computation)

## Dependencies
- `mini-object-kernel` — Object typeclass framework
- `mini-real-numbers` — Real numbers ℝ
- `mini-sequence-series` — Sequences and series
- `mini-riemann-integration` — Riemann integration

## Build
```bash
lake build
lake env lean --run Main.lean
lake env lean --run Test/Basic.lean
```
