# mini-function-sequences

A Lean 4 Lake package for the theory of sequences of functions, part of the
mini-everything-math ecosystem.

## Overview

This package covers:
- **Convergence modes**: pointwise, uniform, locally uniform, L^p, almost everywhere, in measure
- **Equicontinuity**: pointwise and uniform equicontinuity of families of functions
- **Arzela-Ascoli theorem**: characterization of compactness in C(X)
- **Stone-Weierstrass theorem**: density of subalgebras in C(X)
- **Dini's theorem**: monotone pointwise convergence to continuous ⇒ uniform on compact
- **Uniform Boundedness Principle**: pointwise bounded ⇒ uniformly bounded
- **Function spaces**: C_b(X), C_c(X), C_0(X), B(X)
- **Approximation theory**: Chebyshev, Bernstein polynomials, interpolation

## Dependencies

- `mini-object-kernel` — the kernel package providing the `Object` typeclass
- `mini-real-numbers` — real numbers ℝ
- `mini-metric-topology` — metric spaces and topology
- `mini-continuity` — continuous functions

## Build

```bash
lake build
```

## Usage

```lean
import MiniFunctionSequences

-- Check that the package loads correctly
#eval "mini-function-sequences loaded"
```
