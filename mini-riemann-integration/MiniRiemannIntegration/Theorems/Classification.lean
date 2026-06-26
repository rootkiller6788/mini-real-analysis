/-
# MiniRiemannIntegration.Theorems.Classification

Riemann integrability criterion (Lebesgue), improper integral
convergence tests, and comparison test for improper integrals.
-/

import MiniRiemannIntegration.Theorems.Basic
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Lebesgue criterion for Riemann integrability -/

theorem lebesgueCriterion (a b : ℝ) (f : ℝ → ℝ) :
  isRiemannIntegrable f a b ↔
    (∃ (M : ℝ), ∀ (x : ℝ), a ≤ x → x ≤ b → |f x| ≤ M) ∧ True := by
  -- True is placeholder for "the set of discontinuities of f has measure zero"
  constructor
  · intro h_int
    constructor
    · -- Riemann integrable ⇒ bounded
      sorry
    · trivial
  · intro ⟨h_bdd, h_measureZero⟩
    -- bounded + measure zero discontinuities ⇒ Riemann integrable
    sorry

/-! ## Riemann criterion (ε-partition formulation) -/

theorem riemannCriterion (a b : ℝ) (f : ℝ → ℝ) :
  isRiemannIntegrable f a b ↔
    ∀ (ε : ℝ), ε > 0 → ∃ (P : Partition), upperSum f P - lowerSum f P < ε := by
  constructor
  · intro h_int ε hε
    sorry
  · intro h_criterion
    sorry

/-! ## Comparison test for improper integrals -/

theorem comparisonTestImproper (f g : ℝ → ℝ) (a : ℝ) :
  (∀ (x : ℝ), x ≥ a → 0 ≤ f x) →
  (∀ (x : ℝ), x ≥ a → f x ≤ g x) →
  (∃ (I : ℝ), True) →  -- placeholder: ∫_a^∞ g converges
  (∃ (I : ℝ), True) := by  -- then ∫_a^∞ f converges
  intro h_nonneg h_bound h_conv
  sorry

/-! ## Limit comparison test -/

theorem limitComparisonTest (f g : ℝ → ℝ) (a : ℝ) :
  (∀ (x : ℝ), x ≥ a → f x > 0) →
  (∀ (x : ℝ), x ≥ a → g x > 0) →
  (∃ (c : ℝ), c > 0) →  -- placeholder: lim_{x→∞} f(x)/g(x) = c > 0
  ((∃ (I : ℝ), True) ↔ (∃ (I : ℝ), True)) := by  -- ∫_a^∞ f converges iff ∫_a^∞ g converges
  intro h_fpos h_gpos h_limit
  sorry

/-! ## Integral test for series convergence -/

theorem integralTest (f : ℝ → ℝ) :
  (∀ (x : ℝ), x ≥ 1 → f x ≥ 0) →
  (∀ (x y : ℝ), 1 ≤ x → x ≤ y → f y ≤ f x) →  -- f decreasing
  ((∃ (I : ℝ), True) ↔ (∃ (S : ℝ), True)) := by  -- placeholder: ∫_1^∞ f converges iff Σ f(n) converges
  intro h_nonneg h_decreasing
  sorry

/-! ## Dirichlet test for improper integrals -/

theorem dirichletTestImproper (f g : ℝ → ℝ) (a : ℝ) :
  True := by  -- placeholder
  sorry

/-! ## Abel test for improper integrals -/

theorem abelTestImproper (f g : ℝ → ℝ) (a : ℝ) :
  True := by  -- placeholder
  sorry

/-! ## #eval Tests -/

#eval "Theorems.Classification: lebesgueCriterion (sorry)"
#eval "Theorems.Classification: riemannCriterion, comparisonTestImproper (sorry)"
#eval "Theorems.Classification: limitComparisonTest, integralTest, dirichletTest, abelTest"

end MiniRiemannIntegration
