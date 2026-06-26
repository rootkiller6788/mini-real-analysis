/-
# Properties: Preservation

What properties are preserved under various modes of convergence:
uniform convergence preserves uniform continuity,
locally uniform convergence preserves continuity,
equicontinuous limit of continuous functions is continuous.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## Uniform Convergence Preserves Uniform Continuity -/

/-- The uniform limit of uniformly continuous functions is uniformly continuous. -/
theorem uniformConvergencePreservesUniformContinuity
    {X : Type} [PseudoMetricSpace X] (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_conv : uniformlyConvergesOnAll f_n f)
    (h_uc : ∀ n, UniformContinuous (f_n n)) : UniformContinuous f := by
  -- For ε > 0, choose N with |f_N(x) - f(x)| < ε/3 uniformly.
  -- By uniform continuity of f_N, choose δ > 0 with d(x,y) < δ ⇒ |f_N(x) - f_N(y)| < ε/3.
  -- Then |f(x) - f(y)| ≤ |f(x) - f_N(x)| + |f_N(x) - f_N(y)| + |f_N(y) - f(y)| < ε.
  sorry

/-! ## Locally Uniform Convergence Preserves Continuity -/

/-- The locally uniform limit of continuous functions is continuous. -/
theorem locallyUniformConvergencePreservesContinuity
    {X : Type} [TopologicalSpace X] (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_conv : locallyUniformlyConverges f_n f)
    (h_cont : ∀ n, Continuous (f_n n)) : Continuous f := by
  -- For each x₀, there is a compact neighborhood K.
  -- Uniform convergence on K gives continuity at x₀.
  sorry

/-! ## Equicontinuous Limits Are Continuous -/

/-- If an equicontinuous family converges pointwise to f, then f is continuous. -/
theorem equicontinuousLimitContinuous
    {X : Type} [TopologicalSpace X] (F : Set (X → ℝ)) (f : X → ℝ)
    (h_equi : isEquicontinuous F)
    (h_limit : ∀ x, Filter.Tendsto (λ g : F => g.1 x) Filter.atTop (𝓝 (f x))) :
    Continuous f := by
  sorry

/-- The set of limits of an equicontinuous family is equicontinuous. -/
theorem closureEquicontinuousIsEquicontinuous
    {X : Type} [TopologicalSpace X] (F : Set (X → ℝ))
    (h_equi : isEquicontinuous F) :
    isEquicontinuous (closure F) := by
  sorry

/-! ## Preservation of Integrability -/

/-- If f_n are integrable and converge uniformly to f on [a,b], then f is integrable
    and the integral of f_n converges to the integral of f. -/
theorem uniformConvergencePreservesIntegrability
    (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ) (a b : ℝ)
    (h_conv : uniformlyConverges f_n f (Set.Icc a b))
    (h_int : ∀ n, IntervalIntegrable (f_n n) MeasureSpace.volume a b) :
    IntervalIntegrable f MeasureSpace.volume a b ∧
    Filter.Tendsto (λ n => ∫ x in a..b, f_n n x) Filter.atTop (𝓝 (∫ x in a..b, f x)) := by
  sorry

/-! ## Preservation Under Products -/

/-- If f_n → f uniformly and each f_n is bounded, the product with a uniformly convergent
    bounded sequence is uniformly convergent. -/
theorem productPreservesUniformConvergence
    (f_n g_n : SequenceOfFunctions α) (f g : α → ℝ)
    (h_f : uniformlyConvergesOnAll f_n f) (h_g : uniformlyConvergesOnAll g_n g)
    (h_bdd_f : isBounded f) (h_bdd_g : isBounded g) :
    uniformlyConvergesOnAll (λ n x => f_n n x * g_n n x) (λ x => f x * g x) := by
  sorry

/-! ## Tests -/

#eval "--- Properties.Preservation tests ---"

/-- Uniform limit of constant functions is constant (thus uniformly continuous). -/
def const_seq (c : ℝ) : SequenceOfFunctions ℝ := λ _ _ => c
example : UniformContinuous (λ _ : ℝ => (3 : ℝ)) := by
  exact uniformContinuous_const

/-- Convergence of integrals for f_n(x) = x^n on [0, 1/2]. -/
def test_seq : SequenceOfFunctions ℝ := λ n x => x ^ n
example : Filter.Tendsto (λ n : ℕ => (1/((n:ℝ)+1)) * ((1/2 : ℝ) ^ ((n:ℕ)+1)))
    Filter.atTop (𝓝 0) := by
  sorry

end MiniFunctionSequences
