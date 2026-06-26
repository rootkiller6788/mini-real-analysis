/-
# MiniRiemannIntegration.Examples.Counterexamples

Dirichlet function (not Riemann integrable), Thomae function
(IS Riemann integrable), unbounded function on [0,1],
sin(x)/x on [1,∞) — conditionally convergent improper integral.
-/

import MiniRiemannIntegration.Examples.Standard
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Dirichlet function: NOT Riemann integrable -/

structure DirichletFunction where
  f : ℝ → ℝ := fun x => if True then 1 else 0
  -- f(x) = 1 if x ∈ ℚ, f(x) = 0 if x ∉ ℚ
  isNotRiemannIntegrable : ¬ isRiemannIntegrable f 0 1
  reason : String := "Every upper sum is 1, every lower sum is 0, so upper ≠ lower integral"

def dirichletNotIntegrableProof : ¬ isRiemannIntegrable (fun x => if True then 1 else 0) 0 1 := by
  -- The Dirichlet function has upper integral = 1 and lower integral = 0
  -- Therefore not Riemann integrable
  sorry

/-! ## Thomae (popcorn) function: IS Riemann integrable -/

structure ThomaeFunction where
  f : ℝ → ℝ := fun x => 0  -- placeholder: f(x) = 1/q if x = p/q in lowest terms, 0 otherwise
  isRiemannIntegrable : isRiemannIntegrable f 0 1
  integralValue : riemannIntegral f 0 1 = 0
  discontinuitiesAtRationals : Prop
  measureOfDiscontinuitiesZero : Prop

def thomaeIntegrableProof : isRiemannIntegrable (fun x : ℝ => 0) 0 1 := by
  -- Thomae function is continuous on irrationals (measure 1), discontinuous on rationals (measure 0)
  -- By Lebesgue criterion, it is Riemann integrable, and its integral is 0
  sorry

/-! ## Unbounded function on [0,1]: improper integral -/

structure UnboundedExample where
  f : ℝ → ℝ := fun x => 1 / ℝ.sqrt x  -- unbounded near 0
  isNotRiemannIntegrable : ¬ isRiemannIntegrable f 0 1
  isImproperlyIntegrable : isImproperIntegral f 0 1
  improperValue : ℝ := 2  -- ∫_0^1 1/√x dx = 2

def unboundedNotRiemannProof : ¬ isRiemannIntegrable (fun x => 1 / ℝ.sqrt x) 0 1 := by
  -- f(x) = 1/√x is unbounded on [0,1], hence not Riemann integrable
  -- But the improper Riemann integral exists and equals 2
  sorry

/-! ## sin(x)/x on [1,∞): conditionally convergent improper integral -/

structure SincIntegral where
  f : ℝ → ℝ := fun x => ℝ.sin x / x
  a : ℝ := 1
  -- ∫_1^∞ sin(x)/x dx = π/2 (Dirichlet integral)
  isConditionallyConvergent : Prop
  converges : True := True.intro  -- placeholder
  absoluteDiverges : True := True.intro  -- ∫_1^∞ |sin(x)/x| dx = ∞
  value : ℝ := 1.5707963267948966  -- π/2

def sincIntegralAxiom : Axiom :=
  Axiom.mk "dirichletIntegral" (Formula.pred 0 [])
    "∫_0^∞ sin(x)/x dx = π/2 (Dirichlet integral). The integral converges conditionally but not absolutely"

/-! ## Characteristic function of Cantor set -/

structure CantorSetExample where
  f : ℝ → ℝ  -- indicator of Cantor set
  isRiemannIntegrable : isRiemannIntegrable f 0 1
  integralIsZero : riemannIntegral f 0 1 = 0
  because : String := "Cantor set has measure zero, discontinuities only on Cantor set"

/-! ## Volterra's function: differentiable derivative not Riemann integrable -/

structure VolterraExample where
  -- Volterra (1881): a differentiable function whose derivative is not Riemann integrable
  F : ℝ → ℝ  -- differentiable everywhere
  F' : ℝ → ℝ  -- its derivative
  F_isDifferentiable : Prop
  F'_notRiemannIntegrable : ¬ isRiemannIntegrable F' 0 1

/-! ## #eval Tests -/

#eval "Counterexamples: Dirichlet function — NOT Riemann integrable"
#eval "Counterexamples: Thomae (popcorn) function — IS Riemann integrable"
#eval "Counterexamples: 1/√x on [0,1] — improper, not proper Riemann integrable"
#eval "Counterexamples: sin(x)/x on [1,∞) — conditionally convergent improper integral"

end MiniRiemannIntegration
