/-
# Theory Guide

Mathematical background for the mini-function-sequences package.

## 1. Modes of Convergence

For a sequence (f_n) of functions from X to ℝ:

| Mode | Definition | Notation |
|------|-----------|----------|
| Pointwise | ∀x, f_n(x) → f(x) | f_n → f |
| Uniform | sup_x |f_n(x)-f(x)| → 0 | f_n ⇉ f |
| Locally Uniform | Uniform on compact subsets | f_n ⇉_loc f |
| L^p | ∫ |f_n-f|^p → 0 | f_n →_Lp f |
| Almost Everywhere | f_n(x) → f(x) for a.e. x | f_n →_a.e. f |
| In Measure | ∀ε>0, μ{x : |f_n(x)-f(x)|>ε} → 0 | f_n →_μ f |

### Implication Diagram

```
Uniform ⇒ Locally Uniform ⇒ Pointwise
Uniform ⇒ L^p (finite measure) ⇒ In Measure
Pointwise a.e. ⇐ L^p (subsequence)
```

## 2. Arzela-Ascoli Theorem

**Statement**: Let X be compact Hausdorff. A subset F ⊂ C(X) is relatively
compact in the sup norm iff F is pointwise bounded and equicontinuous.

**Proof sketch**:
1. Separability of compact metric X gives countable dense {x_k}
2. Diagonal argument extracts subsequence converging on {x_k}
3. Equicontinuity upgrades to uniform convergence on X

## 3. Stone-Weierstrass Theorem

**Statement (Real)**: Let X be compact Hausdorff. A subalgebra A ⊂ C(X,ℝ)
that separates points and contains constants is dense in C(X,ℝ).

**Corollary**: Polynomials are dense in C([a,b]).

**Proof sketch**:
1. Show A is a sublattice (closure under |·|)
2. For x≠y, construct f∈A with f(x)=a, f(y)=b
3. Compactness + lattice property ⇒ uniform approximation

## 4. Dini's Theorem

**Statement**: Let X be compact. If (f_n) is a monotone sequence of continuous
functions converging pointwise to a continuous f, then f_n ⇉ f.

The monotonicity hypothesis is essential — tent functions demonstrate failure
without it.

## 5. Equicontinuity

A family F is equicontinuous at x if:
∀ε>0, ∃U∈𝓝(x), ∀f∈F, ∀y∈U, |f(y)-f(x)|<ε

On compact spaces: equicontinuous ⇔ uniformly equicontinuous.

## 6. Connections to Functional Analysis

- C_b(X) is a commutative Banach algebra under sup norm
- Multiplicative linear functionals on C(X) (X compact) correspond to points of X
- Gelfand-Naimark: commutative C*-algebras ≅ C₀(locally compact Hausdorff)
- Banach-Alaoglu: unit ball of dual is weak-* compact

## References

- Rudin, *Principles of Mathematical Analysis*
- Rudin, *Real and Complex Analysis*
- Lax, *Functional Analysis*
- Kelley, *General Topology*
-/

namespace MiniFunctionSequences

#eval "Theory Guide: see file header for mathematical background"

end MiniFunctionSequences
