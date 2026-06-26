/-
# MiniContinuity Theory Guide

## Continuity Theory in a Nutshell

A function f: ℝ → ℝ is **continuous** at a point a if small changes in input
produce small changes in output. Formally:

  ∀ ε > 0, ∃ δ > 0, |x - a| < δ → |f(x) - f(a)| < ε

### Types of Continuity (increasing strength)

1. **Continuity** — ε-δ at each point
2. **Uniform continuity** — same δ works for all x
3. **Lipschitz continuity** — |f(x)-f(y)| ≤ K·|x-y|
4. **Holder continuity** — |f(x)-f(y)| ≤ C·|x-y|^α
5. **Differentiability** — limit of difference quotient exists

Continuity ⇒ uniform continuity (on compact sets)
Lipschitz ⇒ uniform continuity ⇒ continuity

### Key Theorems

1. **Intermediate Value Theorem**: continuous f attains all values between f(a) and f(b)
2. **Extreme Value Theorem**: continuous f on [a,b] attains max and min
3. **Heine-Cantor**: continuous on compact ⇒ uniformly continuous
4. **Darboux**: derivatives have the intermediate value property
5. **Brouwer (1D)**: continuous f: [0,1] → [0,1] has a fixed point
6. **Tietze Extension**: continuous f on closed set extends to ℝ
7. **Banach Fixed Point**: contraction mapping has unique fixed point

### Classification of Discontinuities

- **Removable**: limit exists but ≠ f(a)
- **Jump**: left and right limits exist but differ
- **Essential**: at least one one-sided limit does not exist

### Function Spaces

- **C(X)**: all continuous functions
- **C_b(X)**: bounded continuous functions (Banach space under sup norm)
- **C_c(X)**: compactly supported continuous functions
- **C₀(X)**: continuous functions vanishing at infinity

Inclusion chain: C_c ⊆ C₀ ⊆ C_b ⊆ C

### Bridges

- **Algebra**: C(X) is a commutative ℝ-algebra
- **Topology**: compact-open topology, uniform convergence
- **Geometry**: curves, homotopy, deformation retracts
- **Computation**: piecewise linear approximation, interval analysis
-/
