/-
# Theory Guide — Convergence Theory

A guide to the convergence theory formalized in mini-sequence-series.

## 1. Foundations: Limits of Sequences

A sequence (a_n) converges to L if:
  ∀ ε > 0, ∃ N ∈ ℕ, ∀ n ≥ N, |a_n - L| < ε

Key properties:
- Limits are unique
- Convergent sequences are bounded
- Subsequences of convergent sequences converge to same limit
- Cauchy sequences converge (completeness of ℝ)

## 2. Monotone Convergence

A monotone increasing bounded sequence converges to its supremum.
This is equivalent to the completeness axiom of ℝ.

## 3. Bolzano-Weierstrass Theorem

Every bounded sequence has a convergent subsequence.
Proof: successive bisection using monotone subsequence extraction.

## 4. Series Convergence

A series Σ a_n converges if its sequence of partial sums converges.

### Absolute Convergence
Σ a_n converges absolutely if Σ |a_n| converges.
Absolute convergence ⇒ ordinary convergence.

### Conditional Convergence
Σ a_n converges but Σ |a_n| diverges.
Riemann rearrangement theorem: conditionally convergent series
can be rearranged to sum to any real number (or diverge).

## 5. Convergence Tests

### Comparison Test
If 0 ≤ a_n ≤ b_n and Σ b_n converges, then Σ a_n converges.

### Ratio Test (d'Alembert)
If lim |a_{n+1}/a_n| = L:
  - L < 1 ⇒ converges absolutely
  - L > 1 ⇒ diverges
  - L = 1 ⇒ inconclusive

### Root Test (Cauchy)
If limsup |a_n|^{1/n} = L:
  - L < 1 ⇒ converges absolutely
  - L > 1 ⇒ diverges
  - L = 1 ⇒ inconclusive

### Integral Test
For positive decreasing f on [1,∞):
  Σ f(n) converges ⇔ ∫_1^∞ f(x)dx converges

### Alternating Series Test (Leibniz)
If a_n decreases to 0, then Σ (-1)^n a_n converges.

### Dirichlet and Abel Tests
Generalizations for product series.

## 6. Power Series

Σ a_n (x-c)^n has radius of convergence R determined by:
  R = 1 / limsup |a_n|^{1/n}  (Cauchy-Hadamard)

Series converges absolutely for |x-c| < R, diverges for |x-c| > R.

Abel's theorem: If Σ a_n R^n converges, then the power series
function is continuous at the boundary x = c + R.

## 7. Sequence Spaces

### ℓ¹: Absolutely summable sequences
- Norm: ‖x‖₁ = Σ |x_n|
- Banach space (complete)
- Dual is ℓ∞

### ℓ²: Square-summable sequences
- Inner product: ⟨x,y⟩ = Σ x_n y_n
- Hilbert space (complete inner product space)
- Self-dual: (ℓ²)* ≅ ℓ²

### ℓ∞: Bounded sequences
- Norm: ‖x‖_∞ = sup |x_n|
- Banach space

### c and c₀
- c: convergent sequences — closed subspace of ℓ∞
- c₀: sequences converging to 0 — closed subspace of c
- c/c₀ ≅ ℝ (limit functional)

## 8. Summation Methods

### Cesaro Summation
σ_n = (s_0 + ... + s_n)/(n+1) → S
Weaker than ordinary convergence.

### Abel Summation
lim_{r→1^-} Σ a_n r^n = S
Equivalent to Cesaro summability for bounded sequences.

### Tauberian Theorems
Under additional conditions (e.g., a_n = o(1/n)),
Cesaro/Abel summability ⇒ ordinary convergence.

## 9. Applications

### Generating Functions
Formal power series ring R[[X]] with Cauchy product.

### Numerical Analysis
- Aitken's Δ² process accelerates linear convergence
- Richardson extrapolation for high-order acceleration
- Kahan summation for improved accuracy

### Dynamical Systems
Sequences as discrete orbits: x_{n+1} = f(x_n)
- Fixed points, periodic orbits, chaos (via logistic map)

### Fractal Geometry
Sequences of iterated constructions:
- Cantor set, Sierpinski triangle, Koch snowflake
- Weierstrass function: continuous nowhere-differentiable
-/

#eval "TheoryGuide: Comprehensive guide to convergence theory"
