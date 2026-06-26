/-
# Theorems: Main

Arzela-Ascoli as characterization of compactness in C(X),
Stone-Weierstrass: polynomials dense in C([a,b]),
Bernstein polynomials proof sketch.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Theorems.Basic

namespace MiniFunctionSequences

/-! ## Arzela-Ascoli as a Compactness Characterization -/

/-- Full Arzela-Ascoli: For X compact Hausdorff, a subset of C(X) is relatively compact
    in the sup norm iff it is pointwise bounded and equicontinuous. -/
theorem arzelaAscoli_characterization
    {X : Type} [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (F : Set (X → ℝ)) (h_cont : ∀ f ∈ F, Continuous f) :
    (IsCompact (closure F)) ↔
      ((∀ x, ∃ M, ∀ f ∈ F, |f x| ≤ M) ∧ isEquicontinuous F) := by
  constructor
  · intro h_compact
    -- Compactness in sup norm gives uniform boundedness and equicontinuity
    sorry
  · intro ⟨h_pointwise_bdd, h_equi⟩
    -- From pointwise bounded + equicontinuous + compact domain,
    -- get uniform boundedness, then Arzela-Ascoli gives compact closure
    sorry

/-! ## Stone-Weierstrass: Polynomials Dense in C([a,b]) -/

/-- The Stone-Weierstrass theorem implies that polynomials are dense in C([a,b])
    under the sup norm. -/
theorem polynomials_dense_in_C_interval (a b : ℝ) (h : a < b) :
    ∀ (f : ℝ → ℝ), ContinuousOn f (Set.Icc a b) →
    ∀ ε > 0, ∃ (p : Polynomial ℝ),
      ∀ x ∈ Set.Icc a b, |f x - p.eval x| < ε := by
  intro f h_cont_f ε hε
  -- Polynomials form a subalgebra of C([a,b]) that separates points (x ↦ x separates)
  -- and contains constants. Apply Stone-Weierstrass.
  sorry

/-- Corollary: Any continuous function on [0,1] can be uniformly approximated by polynomials. -/
theorem weierstrassApproximationTheorem (f : ℝ → ℝ) (h_cont : ContinuousOn f (Set.Icc 0 1)) :
    ∀ ε > 0, ∃ (p : Polynomial ℝ), ∀ x ∈ Set.Icc (0 : ℝ) 1, |f x - p.eval x| < ε :=
  polynomials_dense_in_C_interval 0 1 (by norm_num) f h_cont

/-! ## Bernstein Polynomials -/

/-- The n-th Bernstein polynomial for f on [0,1]:
    B_n(f)(x) = Σ_{k=0}^n f(k/n) · C(n,k) · x^k · (1-x)^{n-k} -/
noncomputable def bernsteinPolynomial (f : ℝ → ℝ) (n : Nat) (x : ℝ) : ℝ :=
  (Finset.range (n+1)).sum λ k =>
    let k' := (k : ℝ)
    let n' := (n : ℝ)
    f (k' / n') * ((Nat.choose n k : ℝ) * (x ^ k) * ((1 - x) ^ (n - k)))

/-- Bernstein's theorem: B_n(f) → f uniformly on [0,1] for continuous f. -/
theorem bernsteinConvergence (f : ℝ → ℝ) (h_cont : ContinuousOn f (Set.Icc 0 1)) :
    uniformlyConverges
      (λ n x => bernsteinPolynomial f n x) f (Set.Icc 0 1) := by
  -- Proof uses Chebyshev's inequality and the fact that
  -- B_n is a positive linear operator with B_n(1)=1, B_n(x)=x, B_n(x^2)=x^2 + x(1-x)/n.
  sorry

/-- Constructive proof of Weierstrass approximation via Bernstein polynomials. -/
theorem weierstrassViaBernstein (f : ℝ → ℝ) (h_cont : ContinuousOn f (Set.Icc 0 1)) :
    ∀ ε > 0, ∃ (n : Nat), ∀ x ∈ Set.Icc (0 : ℝ) 1, |f x - bernsteinPolynomial f n x| < ε := by
  intro ε hε
  -- From bernsteinConvergence, we get uniform convergence, which gives the result.
  have h_uniform := bernsteinConvergence f h_cont
  rcases h_uniform ε hε with ⟨N, hN⟩
  exact ⟨N, λ x hx => hN N (le_refl N) x hx⟩

/-! ## Tests -/

#eval "--- Theorems.Main tests ---"

/-- Bernstein polynomial of degree 3 for f(x) = x^2. -/
noncomputable def f_sq_main (x : ℝ) : ℝ := x ^ 2
#eval bernsteinPolynomial f_sq_main 3 (0.5 : ℝ)
#eval bernsteinPolynomial f_sq_main 3 (0.0 : ℝ)
#eval bernsteinPolynomial f_sq_main 3 (1.0 : ℝ)

/-- Bernstein polynomial of degree 5 for f(x) = sin(πx). -/
noncomputable def f_sin (x : ℝ) : ℝ := Real.sin (Real.pi * x)
#eval bernsteinPolynomial f_sin 5 (0.5 : ℝ)

end MiniFunctionSequences
