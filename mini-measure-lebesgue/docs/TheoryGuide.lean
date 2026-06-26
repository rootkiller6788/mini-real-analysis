/-
# MiniMeasureLebesgue: Theory Guide

A guide to the measure-theoretic concepts formalized in this package.

## Measure Theory 101

### Motivation

Riemann integration works well for continuous functions on intervals.
But it fails for:
- Functions with many discontinuities (Dirichlet function)
- Integration over arbitrary spaces (probability, manifolds)
- Interchange of limits and integrals (need uniform convergence)

Lebesgue integration fixes all of these by partitioning the **range**
rather than the **domain**, and by using measure theory to assign
"sizes" to sets.

### Core Definitions

**Sigma-Algebra (Σ)**:
A collection of subsets closed under complement and countable union.
This is the domain of a measure — not all subsets can be measured
(axiom of choice issues).

**Measure (μ)**:
A function μ : Σ → [0, ∞] with μ(∅) = 0 and countable additivity:
μ(∪A_n) = Σ μ(A_n) for disjoint A_n.

**Lebesgue Measure (λ)**:
The unique translation-invariant measure on ℝ with λ([0,1]) = 1.
Generalizes "length" to a much larger class of sets.

**Measurable Function**:
f : X → Y such that f⁻¹(B) is measurable for all measurable B.
Continuous functions are Borel measurable.

**Simple Function**:
A finite linear combination of indicator functions:
φ = Σ a_i · 1_{A_i} where A_i are measurable and disjoint.

**Lebesgue Integral**:
∫ f dμ = sup {∫ φ dμ | φ simple, 0 ≤ φ ≤ f} for f ≥ 0.
For general f: ∫ f = ∫ f^+ - ∫ f^-.

### Key Theorems

1. **Monotone Convergence Theorem (MCT)**:
   0 ≤ f_n ↑ f ⇒ ∫ f_n ↑ ∫ f.
   Allows interchanging limit and integral for monotone sequences.

2. **Fatou's Lemma**:
   ∫ liminf f_n ≤ liminf ∫ f_n.
   A one-sided inequality that works without monotonicity.

3. **Dominated Convergence Theorem (DCT)**:
   |f_n| ≤ g ∈ L^1, f_n → f a.e. ⇒ ∫ f_n → ∫ f.
   The workhorse theorem for interchanging limits and integrals.

4. **Fubini-Tonelli**:
   ∬ f dμdν = ∫∫ f dμdν = ∫∫ f dνdμ.
   Iterated integrals in any order equal the product integral.

5. **Radon-Nikodym**:
   ν ≪ μ ⇒ ∃ dν/dμ such that ν(A) = ∫_A dν/dμ dμ.
   Generalizes the Fundamental Theorem of Calculus.

### Lebesgue vs Riemann

| Aspect | Riemann | Lebesgue |
|--------|---------|----------|
| Partition | Domain | Range |
| Limits | Uniform conv. | Pointwise a.e. (DCT) |
| Completeness | L^1 not complete | L^1 is complete |
| Dirichlet fn | Not integrable | Integrable (= 0) |
| sin(x)/x [0,∞) | Improper conv. | Not integrable |
| Abstract spaces | Only ℝ^n | Any measure space |

### L^p Spaces

L^p(X,μ) = {f measurable | ∫ |f|^p dμ < ∞} / {f = 0 a.e.}

- L^1: integrable functions
- L^2: square-integrable (Hilbert space)
- L^∞: essentially bounded
- L^p is a Banach space (complete) for 1 ≤ p ≤ ∞

### Deep Results

**Luzin's Theorem**: Measurable functions are "almost continuous" —
for any ε > 0, there is a continuous function agreeing with f except
on a set of measure < ε.

**Egorov's Theorem**: On finite measure spaces, pointwise a.e. convergence
implies "almost uniform" convergence — for any ε > 0, there is a set of
measure < ε outside which convergence is uniform.

**Lebesgue Decomposition**: Any σ-finite measure μ = μ_ac + μ_sing where
μ_ac ≪ ν and μ_sing ⟂ ν.

**Riesz Representation**: C_c(X)* ≅ Radon measures on X — every positive
linear functional comes from a measure.

### For Further Study

- Real Analysis by Royden & Fitzpatrick
- Measure Theory by Cohn
- Probability and Measure by Billingsley
- https://en.wikipedia.org/wiki/Lebesgue_integration
- https://en.wikipedia.org/wiki/Dominated_convergence_theorem
-/
