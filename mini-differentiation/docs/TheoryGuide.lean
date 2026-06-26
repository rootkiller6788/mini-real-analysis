/-
# Theory Guide — mini-differentiation

## 1. Derivatives (Core/Basic, Core/Laws)

The derivative f'(a) is defined via the standard ε-δ limit:
  lim_{h→0} (f(a+h) - f(a)) / h = f'(a)

Algebraic rules (sum, product, quotient, chain) hold.
Linearity: (αf + βg)' = αf' + βg'

## 2. Mean Value Theorems (Core/Laws)

- **Fermat**: Interior local extremum ⇒ f'(a) = 0
- **Rolle**: f(a) = f(b) ⇒ ∃ c: f'(c) = 0
- **MVT**: ∃ c ∈ (a,b): f'(c) = (f(b)-f(a))/(b-a)
- **Cauchy MVT**: (f(b)-f(a))/(g(b)-g(a)) = f'(c)/g'(c)

## 3. Higher Derivatives and Smoothness (Core/Basic, Constructions)

- f ∈ C^k: all derivatives up to order k exist and are continuous
- f ∈ C^∞ (smooth): all derivatives exist
- f ∈ C^ω (analytic): f equals its Taylor series locally

Hierarchy: C^ω ⊂ C^∞ ⊂ ... ⊂ C^k ⊂ C^{k-1} ⊂ ... ⊂ C^0

## 4. Taylor Theory (Theorems/Basic, Constructions/Universal)

Taylor polynomial: P_n(x) = Σ_{k=0}^n f^{(k)}(a)/k! · (x-a)^k
- Lagrange remainder: R_n = f^{(n+1)}(ξ)/(n+1)! · (x-a)^{n+1}
- Universal property: Taylor polynomial is the best polynomial approximation of degree ≤ n

## 5. Critical Point Theory (Properties, Theorems/Classification)

- **Critical point**: f'(a) = 0
- **Classification**: local max (f''(a) < 0), local min (f''(a) > 0), saddle (higher order)
- **Morse function**: all critical points are nondegenerate (f''(a) ≠ 0)
- **Morse Lemma**: near a nondegenerate critical point, f is diffeomorphic to ±x² (1D) or Σ ±x_i² (nD)

## 6. Sard's Theorem (Theorems/Classification)

The set of critical values of a C^k map (k > max(0, n-m)) has Lebesgue measure zero.

## 7. Inverse/Implicit Function Theorems (Theorems/Basic)

- **IFT**: If f'(a) ≠ 0, then f is locally invertible with C^k inverse
- **IMT**: If ∂F/∂y is invertible, then F(x,y) = 0 locally defines y = f(x)

## 8. Bridges

- **Algebra**: Derivative = derivation on C^∞(R); C^∞(R) is a differential algebra
- **Topology**: Whitney C^k topologies on function spaces; transversality
- **Geometry**: Tangent space = derivations at a point; tangent bundle Tℝ = ℝ×ℝ
- **Computation**: FD schemes (forward O(h), central O(h²)); AD (dual numbers); Newton's method
-/

#eval "TheoryGuide: complete theoretical overview of differentiation"
