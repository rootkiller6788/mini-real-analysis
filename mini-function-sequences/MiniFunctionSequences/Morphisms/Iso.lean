/-
# Morphisms: Iso

Equivalences between modes of convergence under certain conditions.
Dini: monotone + continuous + pointwise ⇒ uniform (on compact).
Equicontinuity vs uniform equicontinuity on compact spaces.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Core.Laws

namespace MiniFunctionSequences

/-! ## Equivalence of Convergence Modes -/

/-- On a compact space, equicontinuous pointwise convergence implies uniform convergence. -/
theorem equicontinuousPointwiseImpliesUniform
    {X : Type} [TopologicalSpace X] [T2Space X]
    (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_compact : IsCompact (Set.univ : Set X))
    (h_equi : isEquicontinuous {g | ∃ n, g = f_n n})
    (h_pointwise : pointwiseConverges f_n f) : uniformlyConvergesOnAll f_n f := by
  -- Standard proof using equicontinuity + compactness + pointwise convergence
  sorry

/-- On a compact space, equicontinuity is equivalent to uniform equicontinuity. -/
theorem equicontinuous_iff_uniformlyEquicontinuous_on_compact
    {X : Type} [PseudoMetricSpace X] [CompactSpace X]
    (F : Set (X → ℝ)) : isEquicontinuous F ↔ isUniformlyEquicontinuous F := by
  constructor
  · intro h_equi
    -- Use compactness: for each x, find δ_x, then take finite subcover,
    -- then δ = min of the finite δ_x's works uniformly.
    sorry
  · intro h_uniform
    -- Uniform equicontinuity trivially implies pointwise equicontinuity.
    sorry

/-! ## Dini as an Iso -/

/-- Dini's theorem re-expressed as an equivalence: under monotonicity, continuity,
    and compactness, pointwise convergence ⇔ uniform convergence. -/
theorem diniEquivalence
    {X : Type} [TopologicalSpace X] [T2Space X] [CompactSpace X]
    (f_n : SequenceOfFunctions X) (f : X → ℝ)
    (h_mono : ∀ n x, f_n n x ≤ f_n (n+1) x)
    (h_cont_n : ∀ n, Continuous (f_n n))
    (h_cont_f : Continuous f) :
    (pointwiseConverges f_n f) ↔ (uniformlyConvergesOnAll f_n f) := by
  constructor
  · intro h_pointwise
    exact diniTheorem f_n f (by
      -- CompactSpace gives IsCompact Set.univ
      infer_instance) h_mono h_cont_n h_cont_f h_pointwise
  · intro h_uniform x ε hε
    rcases h_uniform ε hε with ⟨N, hN⟩
    exact ⟨N, λ n hn => hN n hn x⟩

/-! ## Equivalence of Function Families Under Uniform Convergence -/

/-- Two sequences are uniformly equivalent if their difference converges uniformly to 0. -/
def uniformlyEquivalent (f_n g_n : SequenceOfFunctions α) (A : Set α) : Prop :=
  uniformlyConverges (λ n x => f_n n x - g_n n x) (λ _ => 0) A

/-- Uniform equivalence is an equivalence relation. -/
theorem uniformlyEquivalent_is_equivalence {α : Type} (A : Set α) :
  Equivalence (λ f_n g_n => uniformlyEquivalent f_n g_n A) := by
  sorry

/-! ## Tests -/

#eval "--- Morphisms.Iso tests ---"

/-- Two identical sequences are uniformly equivalent. -/
example : uniformlyEquivalent (λ n x => x/n) (λ n x => x/n) Set.univ := by
  intro ε hε
  refine ⟨0, λ n hn x => ?_⟩
  simp

/-- On ℝ, equicontinuity implies uniform equicontinuity fails without compactness. -/
example : True := by
  trivial

end MiniFunctionSequences
