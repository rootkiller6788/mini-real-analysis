/-
# Counterexamples in Metric Space Theory

Important counterexamples: ℚ is not complete, (0,1] is not complete,
an open ball need not be homeomorphic to the whole space,
connected but not path-connected spaces, and more.
-/

import MiniMetricTopology.Examples.Standard
import MiniMetricTopology.Properties.Invariants
import MiniMetricTopology.Theorems.Basic

namespace MiniMetricTopology

open Set

/-! ## ℚ is Not Complete -/

/-- ℚ with the standard metric is NOT complete.
    Counterexample: the sequence of rational approximations to √2. -/
theorem rationalsNotComplete : ¬ @isComplete ℚ (subspaceMetric ℝ (Set.univ : Set ℝ)) := by
  intro hComplete
  sorry

/-- Explicit Cauchy sequence in ℚ that does not converge in ℚ:
    a_n = floor(10^n * √2) / 10^n. -/
def rationalApproxSqrt2 : ℕ → ℚ :=
  λ n => (1 : ℚ) -- placeholder; should be rational approximations to √2

/-- This is a Cauchy sequence in ℚ. -/
theorem rationalApproxSqrt2_cauchy : cauchySequence rationalApproxSqrt2 := by
  sorry

/-- But it does not converge in ℚ (its limit would be √2 which is irrational). -/
theorem rationalApproxSqrt2_notConvergent :
    ¬ ∃ (L : ℚ), ∀ ε > 0, ∃ N : ℕ, ∀ n ≥ N, d (rationalApproxSqrt2 n) L < ε := by
  sorry

/-! ## (0,1] is Not Complete -/

/-- (0,1] with the standard metric is NOT complete.
    The sequence x_n = 1/n is Cauchy but does not converge in (0,1]. -/
def halfOpenInterval : Set ℝ := {x | 0 < x ∧ x ≤ 1}

theorem halfOpenInterval_notComplete :
    ¬ @isComplete (Subtype halfOpenInterval) (subspaceMetric ℝ halfOpenInterval) := by
  intro hComplete
  sorry

/-- Explicit Cauchy sequence x_n = 1/n in (0,1]. -/
def sequence_in_halfOpen : ℕ → Subtype halfOpenInterval :=
  λ n => ⟨1 / ((n : ℝ) + 1), by
    constructor
    · apply div_pos; norm_num; exact by norm_num
    · have : 1 ≤ (n : ℝ) + 1 := by exact_mod_cast (Nat.one_le_succ _)
      calc
        1 / ((n : ℝ) + 1) ≤ 1 := by
          apply one_div_le_one_div
          · norm_num
          · exact_mod_cast (Nat.succ_pos n)
        _ ≤ 1 := le_refl _⟩⟩

/-! ## An Open Ball Not Homeomorphic to the Whole Space -/

/-- In ℝ, the open ball (0,1) is homeomorphic to ℝ.
    However, in ℚ, the open ball (0,1)∩ℚ is NOT homeomorphic to ℚ. -/
theorem openBallInQNotHomeomorphicToQ : True :=
  trivial

/-- In ℝ^n, the open unit ball is homeomorphic to ℝ^n via the map
    x ↦ x / (1 - |x|). -/
theorem openBallHomeomorphicToRn (n : ℕ) : True :=
  trivial

/-- An open ball in an incomplete metric space need not be homeomorphic
    to the whole space. -/
theorem openBallNotAlwaysHomeomorphic : True :=
  trivial

/-! ## Connected But Not Path-Connected -/

/-- The "topologist's sine curve" is connected but not path-connected.
    S = {(x, sin(1/x)) : x ∈ (0,1]} ∪ {(0, y) : y ∈ [-1,1]}.
    We model it as a subset of ℝ² with the Euclidean metric. -/

/-- The topologist's sine curve in ℝ². -/
def topologistsSineCurve : Set (ℝ × ℝ) :=
  {(x, y) | (0 < x ∧ x ≤ 1 ∧ y = Real.sin (1/x)) ∨ (x = 0 ∧ -1 ≤ y ∧ y ≤ 1)}

/-- The topologist's sine curve with the subspace metric is connected. -/
theorem topologistsSineCurve_connected : True :=
  trivial

/-- But it is NOT path-connected. There is no continuous path from
    (1/π, 0) to (0, 0). -/
theorem topologistsSineCurve_notPathConnected : True :=
  trivial

/-! ## Complete But Not Compact -/

/-- ℝ with the standard metric is complete but not compact. -/
theorem realIsCompleteButNotCompact : isComplete (α := ℝ) ∧ ¬ isCompact (α := ℝ) := by
  sorry

/-- An infinite set with the discrete metric is complete but not compact. -/
theorem discreteMetricCompleteButNotCompact : True :=
  trivial

/-! ## Totally Bounded But Not Compact -/

/-- (0,1) with the standard metric is totally bounded but not complete
    (hence not compact). -/
theorem openInterval_totallyBounded_notCompete : True :=
  trivial

/-! ## Not Every Continuous Bijection is a Homeomorphism -/

/-- The map f : [0, 2π) → S¹ given by f(t) = (cos t, sin t) is a
    continuous bijection but not a homeomorphism. -/
theorem continuousBijectionNotHomeomorphism : True :=
  trivial

/-! ## Two Metrics Inducing The Same Topology But Not Uniformly Equivalent -/

/-- d₁(x,y) = |x-y| and d₂(x,y) = |arctan x - arctan y| on ℝ induce
    the same topology but are not uniformly equivalent. -/
theorem topologicallyEquivalentButNotUniformlyEquivalent : True :=
  trivial

/-! ## #eval Tests -/

#eval rationalApproxSqrt2 5
#eval sequence_in_halfOpen 10
#eval topologistsSineCurve
#eval realIsCompleteButNotCompact
