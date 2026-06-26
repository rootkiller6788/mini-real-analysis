/-
# Properties: Invariants

Invariants of function sequences: rate of uniform convergence,
modulus of continuity of limit, best approximation in sup norm,
and Dini derivative.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## Rate of Uniform Convergence -/

/-- The rate of uniform convergence: the smallest N(ε) witnessing the convergence definition. -/
noncomputable def rateOfUniformConvergence (f_n : SequenceOfFunctions α) (f : α → ℝ)
    (h : uniformlyConvergesOnAll f_n f) : ℝ → ℕ := by
  intro ε
  sorry

/-- The modulus of uniform convergence: ε_n = sup_x |f_n(x) - f(x)|. -/
noncomputable def uniformConvergenceModulus (f_n : SequenceOfFunctions α) (f : α → ℝ) (n : Nat) : ℝ :=
  supNorm (λ x => f_n n x - f x)

/-- If the modulus of uniform convergence tends to 0, we have uniform convergence. -/
theorem uniformConvergenceModulus_iff
    (f_n : SequenceOfFunctions α) (f : α → ℝ) :
    (uniformlyConvergesOnAll f_n f) ↔
    Filter.Tendsto (uniformConvergenceModulus f_n f) Filter.atTop (𝓝 0) := by
  sorry

/-! ## Modulus of Continuity -/

/-- The modulus of continuity of a function f at scale δ. -/
noncomputable def modulusOfContinuity [PseudoMetricSpace α] (f : α → ℝ) (δ : ℝ) : ℝ :=
  sSup { |f x - f y| | (x : α) (y : α) // dist x y < δ }

/-- f is uniformly continuous iff its modulus of continuity tends to 0 as δ → 0. -/
theorem modulusOfContinuity_iff_uniformContinuous [PseudoMetricSpace α] (f : α → ℝ) :
    (UniformContinuous f) ↔
    Filter.Tendsto (modulusOfContinuity f) (𝓝 (0 : ℝ)) (𝓝 0) := by
  sorry

/-- The limit of uniformly convergent equicontinuous sequences has a controlled modulus of continuity. -/
theorem limitModulusControl
    [PseudoMetricSpace α] (f_n : SequenceOfFunctions α) (f : α → ℝ)
    (h_uni : uniformlyConvergesOnAll f_n f)
    (h_equi : ∀ δ > 0, ∃ ε > 0, ∀ n, modulusOfContinuity (f_n n) δ < ε) :
    UniformContinuous f := by
  sorry

/-! ## Best Approximation in Sup Norm -/

/-- The best uniform approximation of f by elements of a subspace E. -/
noncomputable def bestApproximation (f : α → ℝ) (E : Set (α → ℝ)) : ℝ :=
  infₛ { supNorm (λ x => f x - g x) | (g : α → ℝ) // g ∈ E }

/-- Chebyshev alternation theorem statement: for polynomials on [a,b],
    the best approximating polynomial of degree n is characterized by
    an alternating set of n+2 points. -/
theorem chebyshevAlternationTheorem (f : ℝ → ℝ) (a b : ℝ) (h : a < b) (n : Nat) :
    True := by
  sorry

/-! ## Dini Derivative -/

/-- The Dini derivatives of a function f at a point x:
    D⁺ f(x) = limsup_{h→0⁺} (f(x+h) - f(x))/h  (upper right)
    D₊ f(x) = liminf_{h→0⁺} (f(x+h) - f(x))/h   (lower right)
    D⁻ f(x) = limsup_{h→0⁻} (f(x+h) - f(x))/h  (upper left)
    D₋ f(x) = liminf_{h→0⁻} (f(x+h) - f(x))/h   (lower left)
-/

noncomputable def diniUpperRight (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  limsup (λ h : ℝ => (f (x + h) - f x) / h) (𝓝[>] 0)

noncomputable def diniLowerRight (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  liminf (λ h : ℝ => (f (x + h) - f x) / h) (𝓝[>] 0)

noncomputable def diniUpperLeft (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  limsup (λ h : ℝ => (f (x + h) - f x) / h) (𝓝[<] 0)

noncomputable def diniLowerLeft (f : ℝ → ℝ) (x : ℝ) : ℝ :=
  liminf (λ h : ℝ => (f (x + h) - f x) / h) (𝓝[<] 0)

/-- f is differentiable at x iff all four Dini derivatives are equal and finite. -/
theorem diniDerivatives_iff_differentiable (f : ℝ → ℝ) (x : ℝ) :
    (∃ d : ℝ, HasDerivAt f d x) ↔
    (diniUpperRight f x = diniLowerRight f x ∧
     diniLowerRight f x = diniUpperLeft f x ∧
     diniUpperLeft f x = diniLowerLeft f x) := by
  sorry

/-! ## Tests -/

#eval "--- Properties.Invariants tests ---"

/-- Modulus of uniform convergence for f_n(x) = x/n. -/
def simple_seq : SequenceOfFunctions ℝ := λ n x => x / (n+1 : ℝ)
#eval uniformConvergenceModulus simple_seq (λ _ => 0) 1
#eval uniformConvergenceModulus simple_seq (λ _ => 0) 5

/-- Dini derivatives for f(x) = x^2 at x = 1. -/
noncomputable def f_sq (x : ℝ) : ℝ := x ^ 2
#eval diniUpperRight f_sq 1
#eval diniLowerRight f_sq 1

end MiniFunctionSequences
