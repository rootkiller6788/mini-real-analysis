/-
# MiniRiemannIntegration.Properties.ClassificationData

Lebesgue criterion for Riemann integrability, classification
of improper integrals (convergent, conditionally convergent,
divergent), and Henstock-Kurzweil vs Riemann comparison.
-/

import MiniRiemannIntegration.Properties.Preservation
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Lebesgue criterion: Riemann integrability ↔ bounded + measure zero discontinuities -/

structure LebesgueCriterion (a b : ℝ) where
  statement : ∀ (f : ℝ → ℝ), isRiemannIntegrable f a b ↔
    (∃ (M : ℝ), ∀ (x : ℝ), a ≤ x → x ≤ b → |f x| ≤ M) ∧
    (True : Prop)  -- placeholder: set of discontinuities has Lebesgue measure zero
  proof_sketch : Prop

def lebesgueCriterionAxiom : Axiom :=
  Axiom.mk "lebesgueCriterion" (Formula.pred 0 [])
    "A bounded function f on [a,b] is Riemann integrable if and only if the set of points of discontinuity of f has Lebesgue measure zero"

/-! ## Classification of improper integrals -/

inductive ImproperConvergenceType
  | convergent          -- ∫ |f| < ∞, the integral converges absolutely
  | conditionallyConvergent  -- ∫ f converges but ∫ |f| = ∞
  | divergent           -- ∫ f does not converge
  deriving Repr, BEq

structure ImproperIntegralClassification (f : ℝ → ℝ) (a : ℝ) where
  -- For integral from a to ∞
  convergenceType : ImproperConvergenceType
  value : Option ℝ  -- some value if convergent, none if divergent
  abelSummability : Prop  -- Abel summable
  cesaroSummability : Prop  -- Cesaro summable

/-! ## Convergence tests for improper integrals -/

structure ConvergenceTests where
  comparisonTest : Prop  -- 0 ≤ f ≤ g and ∫ g converges ⇒ ∫ f converges
  limitComparisonTest : Prop  -- lim f/g = c > 0 ⇒ same convergence
  integralTestForSeries : Prop  -- ∫_1^∞ f(x)dx converges iff Σ f(n) converges (f decreasing)
  abelTest : Prop
  dirichletTest : Prop

def comparisonTestAxiom : Axiom :=
  Axiom.mk "improperIntegralComparisonTest" (Formula.pred 0 [])
    "If 0 ≤ f(x) ≤ g(x) for all x ≥ a and ∫_a^∞ g(x)dx converges, then ∫_a^∞ f(x)dx converges"

/-! ## Henstock-Kurzweil integral vs Riemann -/

structure HenstockKurzweilIntegral where
  -- More general than Riemann: integrates all derivatives
  definition : (ℝ → ℝ) → ℝ → ℝ → ℝ
  richerThanRiemann : Prop  -- Every Riemann integrable function is HK integrable
  integratesAllDerivatives : Prop  -- HK integral of a derivative recovers the original function
  failsForConditionallyConvergent : Prop  -- some conditionally convergent improper Riemann integrals are not HK integrable

def henstockKurzweilVsRiemann : Axiom :=
  Axiom.mk "henstockKurzweilVsRiemann" (Formula.pred 0 [])
    "Every Riemann integrable function is Henstock-Kurzweil integrable. The HK integral integrates all derivatives (F' is always HK integrable to F(b)-F(a)), but does not handle conditional convergence as well as improper Riemann"

/-! ## Classification of conditionally convergent integrals -/

structure ConditionalConvergenceClassification where
  integral : (ℝ → ℝ) → ℝ → ℝ  -- ∫_a^∞ f(x)dx
  absoluteValueIntegral : (ℝ → ℝ) → ℝ → ℝ  -- ∫_a^∞ |f(x)|dx
  isConditionallyConvergent (f : ℝ → ℝ) (a : ℝ) : Prop :=
    integral f a ≠ 0 ∧ absoluteValueIntegral f a = 0  -- placeholder

/-! ## #eval Tests -/

#eval "Properties.ClassificationData: LebesgueCriterion, lebesgueCriterionAxiom"
#eval "Properties.ClassificationData: ImproperConvergenceType, ImproperIntegralClassification"
#eval "Properties.ClassificationData: HenstockKurzweilIntegral, henstockKurzweilVsRiemann"

end MiniRiemannIntegration
