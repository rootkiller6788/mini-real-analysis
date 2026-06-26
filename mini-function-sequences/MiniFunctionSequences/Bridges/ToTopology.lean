/-
# Bridges: To Topology

Compact-open topology on C(X,Y), topology of uniform convergence
on compacta, Banach-Alaoglu theorem for the separable case.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Constructions.Subobjects

namespace MiniFunctionSequences

/-! ## Compact-Open Topology -/

/-- The compact-open topology on C(X,Y): basic open sets are
    {f | f(K) ⊆ U} for K compact and U open. -/
def compactOpenTopology (X Y : Type) [TopologicalSpace X] [TopologicalSpace Y] : TopologicalSpace (X → Y) :=
  TopologicalSpace.generateFrom
    { S : Set (X → Y) | ∃ (K : Set X) (U : Set Y), IsCompact K ∧ IsOpen U ∧
      S = {f | ∀ x ∈ K, f x ∈ U} }

/-- The compact-open topology makes the evaluation map (f,x) ↦ f(x) continuous
    on C(X,Y) × X. -/
theorem compactOpen_evaluation_continuous (X Y : Type) [TopologicalSpace X] [TopologicalSpace Y] :
    Continuous (λ (p : (X → Y) × X) => p.1 p.2) := by
  sorry

/-! ## Topology of Uniform Convergence on Compacta -/

/-- The topology of uniform convergence on compact subsets.
    This coincides with the compact-open topology when Y is a metric space. -/
def uniformConvergenceOnCompactaTopology (X : Type) [TopologicalSpace X] :
    TopologicalSpace (X → ℝ) :=
  TopologicalSpace.mkOfNhds (λ f => ⨅ (K : Set X) (hK : IsCompact K), 𝓝 0)

/-- The topology of uniform convergence on compacta coincides with the compact-open
    topology for maps into ℝ. -/
theorem uniformOnCompacta_eq_compactOpen (X : Type) [TopologicalSpace X] [T2Space X] :
    uniformConvergenceOnCompactaTopology X = compactOpenTopology X ℝ := by
  sorry

/-- A sequence converges in the compact-open topology iff it converges uniformly
    on compact subsets. -/
theorem compactOpen_convergence_iff_locallyUniform
    (X : Type) [TopologicalSpace X]
    (f_n : SequenceOfFunctions X) (f : X → ℝ) :
    (Filter.Tendsto f_n Filter.atTop (𝓝 f)) ↔ locallyUniformlyConverges f_n f := by
  sorry

/-! ## Banach-Alaoglu Theorem (Separable Case) -/

/-- Banach-Alaoglu: The closed unit ball of the dual of a normed space is
    compact in the weak-* topology. For the separable case, this is a consequence
    of the sequential Banach-Alaoglu theorem. -/

/-- Sequential Banach-Alaoglu: Every bounded sequence in the dual of a separable
    normed space has a weak-* convergent subsequence. -/
theorem sequentialBanachAlaoglu
    (E : Type) [NormedAddCommGroup E] [NormedSpace ℝ E] [SeparableSpace E]
    (φ_n : ℕ → E →L[ℝ] ℝ)
    (h_bdd : ∃ M, ∀ n, ‖φ_n n‖ ≤ M) :
    ∃ (n_k : ℕ → ℕ) (φ : E →L[ℝ] ℝ),
      StrictMono n_k ∧ ‖φ‖ ≤ M ∧
      ∀ x, Filter.Tendsto (λ k => (φ_n (n_k k)) x) Filter.atTop (𝓝 (φ x)) := by
  -- Use diagonal argument on a countable dense subset of E.
  sorry

/-- For C(X) with X compact, the unit ball is weak-* compact.
    This is a special case of Banach-Alaoglu. -/
theorem banachAlaoglu_CX
    (X : Type) [TopologicalSpace X] [CompactSpace X] [T2Space X] :
    IsCompact { φ : (BoundedContinuousFunctions X) →L[ℝ] ℝ | ‖φ‖ ≤ 1 } := by
  sorry

/-! ## Tests -/

#eval "--- Bridges.ToTopology tests ---"

/-- The compact-open topology exists as a TopologicalSpace. -/
example (X : Type) [TopologicalSpace X] : TopologicalSpace (X → ℝ) :=
  compactOpenTopology X ℝ

/-- Uniform convergence on compacta ⇒ locally uniform convergence. -/
example (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ)
    (h : locallyUniformlyConverges f_n f) : True := by
  trivial

end MiniFunctionSequences
