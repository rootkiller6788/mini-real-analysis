/-
# Core: Laws

Fundamental theorems/laws about function sequences:
uniform convergence preserves continuity/boundedness,
Cauchy criterion for uniform convergence, Dini's theorem.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic

namespace MiniFunctionSequences

/-! ## Uniform Convergence Preserves Continuity -/

/-- The uniform limit of a sequence of continuous functions is continuous. -/
theorem uniformConvergencePreservesContinuity
    {X : Type} [TopologicalSpace X] (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_conv : uniformlyConvergesOnAll f_n f)
    (h_cont : ∀ n, Continuous (f_n n)) : Continuous f := by
  -- Standard ε/3 argument: |f(x) - f(x₀)| ≤ |f(x) - f_n(x)| + |f_n(x) - f_n(x₀)| + |f_n(x₀) - f(x₀)|
  -- Uniform convergence gives the first and third terms small for large n uniformly in x,
  -- continuity of f_n gives the middle term small for x near x₀.
  sorry

/-! ## Uniform Convergence Preserves Boundedness -/

/-- The uniform limit of a sequence of bounded functions is bounded. -/
theorem uniformConvergencePreservesBoundedness
    {X : Type} (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_conv : uniformlyConvergesOnAll f_n f)
    (h_bdd : ∀ n, isBounded (f_n n)) : isBounded f := by
  -- Choose N such that ∀ n ≥ N, ∀ x, |f_n(x) - f(x)| < 1.
  -- Then |f(x)| ≤ |f_N(x)| + 1 ≤ M_N + 1.
  sorry

/-! ## Cauchy Criterion for Uniform Convergence -/

/-- A sequence converges uniformly iff it is uniformly Cauchy. -/
theorem cauchyCriterionUniform {X : Type} (f_n : SequenceOfFunctions X) (A : Set X) :
    (∃ f : X → ℝ, uniformlyConverges f_n f A) ↔ uniformlyCauchy f_n A := by
  constructor
  · intro ⟨f, h⟩
    -- If f_n → f uniformly, then for ε > 0, choose N with |f_n(x)-f(x)| < ε/2.
    -- Then |f_m(x)-f_n(x)| ≤ |f_m(x)-f(x)| + |f(x)-f_n(x)| < ε.
    sorry
  · intro h_cauchy
    -- For each x, f_n(x) is a Cauchy sequence in ℝ (since ℝ is complete), so f_n(x) → f(x) pointwise.
    -- The uniform Cauchy condition implies that this convergence is actually uniform.
    sorry

/-! ## Dini's Theorem -/

/-- Dini's theorem: a monotone sequence of continuous functions converging pointwise
    to a continuous function on a compact set converges uniformly. -/
theorem diniTheorem {X : Type} [TopologicalSpace X] [T2Space X] (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_compact : IsCompact (Set.univ : Set X))
    (h_mono : ∀ n x, f_n n x ≤ f_n (n+1) x)
    (h_cont_n : ∀ n, Continuous (f_n n))
    (h_cont_f : Continuous f)
    (h_pointwise : pointwiseConverges f_n f) : uniformlyConvergesOnAll f_n f := by
  -- Standard proof: For ε > 0, define K_n = {x | f(x) - f_n(x) ≥ ε}.
  -- These are closed sets, decreasing to ∅, so by compactness some K_N is empty.
  sorry

/-! ## Kernel Axiom Values -/

/-- The theory name for this package. -/
def theoryName : MiniObjectKernel.TheoryName :=
  MiniObjectKernel.TheoryName.ofString "mini.real-analysis.function-sequences"

#eval "--- Core.Laws tests ---"
#eval theoryName.toString

/-- The uniform convergence predicate is a legitimate property of function sequences. -/
example : uniformlyConvergesOnAll (λ n _ => (0 : ℝ)) (λ _ => (0 : ℝ)) := by
  intro ε hε
  refine ⟨0, λ n hn x => ?_⟩
  simp

end MiniFunctionSequences
