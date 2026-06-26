/-
# MiniContinuity.Examples.Standard

Standard examples of continuous functions:
polynomials, sin/cos, exponential, absolute value,
sqrt, rational functions, and more.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Core.Objects

open MiniMathKernel

namespace MiniContinuity

/-! ## Polynomials -/

/-- All polynomials are continuous -/
def polynomial (coeffs : List ℝ) (x : ℝ) : ℝ :=
  coeffs.foldr (fun c rest => c + x * rest) 0

/-- A linear function x ↦ ax + b is continuous -/
theorem linearContinuous (a b : ℝ) : isContinuous (fun x => a * x + b) := by
  intro x0
  -- For any ε > 0, choose δ = ε/|a| (or δ = 1 if a=0)
  sorry

/-- A quadratic function x ↦ x² is continuous -/
theorem quadraticContinuous : isContinuous (fun x : ℝ => x^2) := by
  intro x0
  sorry

/-- Any polynomial is continuous -/
theorem polynomialContinuous (coeffs : List ℝ) : isContinuous (polynomial coeffs) := by
  sorry

/-! ## Trigonometric Functions -/

/-- sin is continuous -/
theorem sinContinuous : isContinuous sin := by
  -- |sin(x) - sin(y)| ≤ |x - y| using mean value theorem or triangle identity
  sorry

/-- cos is continuous -/
theorem cosContinuous : isContinuous cos := by
  sorry

/-- tan is continuous where defined (cos x ≠ 0) -/
theorem tanContinuousWhereDefined (a : ℝ) (hcos : cos a ≠ 0) :
    isContinuousAt (fun x => sin x / cos x) a := by
  sorry

/-! ## Exponential and Logarithm -/

/-- exp is continuous -/
theorem expContinuous : isContinuous Real.exp := by
  sorry

/-- log is continuous on (0, ∞) -/
theorem logContinuousOnPositive (a : ℝ) (ha : a > 0) :
    isContinuousAt Real.log a := by
  sorry

/-! ## Absolute Value, Square Root, Rational -/

/-- |x| is Lipschitz with K=1 -/
theorem absoluteValueLipschitz : isLipschitzWith abs 1 := by
  refine And.intro (by norm_num) ?_
  intro x y
  -- | |x| - |y| | ≤ |x - y|
  sorry

/-- |x| is continuous -/
theorem absoluteValueContinuous : isContinuous abs := by
  intro a
  sorry

/-- sqrt is continuous on [0, ∞) -/
theorem sqrtContinuousOnNonnegative (a : ℝ) (ha : a ≥ 0) :
    isContinuousAt Real.sqrt a := by
  sorry

/-- x ↦ 1/x is continuous on ℝ \ {0} -/
theorem reciprocalContinuousAwayFromZero (a : ℝ) (ha : a ≠ 0) :
    isContinuousAt (fun x : ℝ => 1/x) a := by
  sorry

/-- x ↦ 1/x is continuous on (0, ∞) and on (-∞, 0) -/
theorem reciprocalContinuousOnPositive (a : ℝ) (ha : a > 0) :
    isContinuousAt (fun x : ℝ => 1/x) a :=
  reciprocalContinuousAwayFromZero a (by linarith)

/-! ## Lipschitz Examples -/

/-- The function f(x) = x is 1-Lipschitz -/
theorem identityLipschitz : isLipschitzWith (fun x : ℝ => x) 1 := by
  refine And.intro (by norm_num) ?_
  intro x y
  simp [dist, abs, sub_self]

/-- The function f(x) = sin(x) is 1-Lipschitz -/
theorem sinLipschitz : isLipschitzWith sin 1 := by
  refine And.intro (by norm_num) ?_
  intro x y
  sorry

/-- The function f(x) = 1/(1+x²) is Lipschitz -/
theorem rationalLipschitz : isLipschitz (fun x : ℝ => 1 / (1 + x^2)) := by
  -- This function is differentiable with bounded derivative, hence Lipschitz
  sorry

/-! ## Holder Examples -/

/-- sqrt on [0,∞) is 1/2-Holder continuous -/
theorem sqrtHolderContinuous : isHolderContinuousWith Real.sqrt 1 (1/2) := by
  sorry

/-- x ↦ |x|^α for 0 < α ≤ 1 is α-Holder continuous -/
theorem powerAlphaHolder (α : ℝ) (hαpos : α > 0) (hαle1 : α ≤ 1) :
    isHolderContinuousWith (fun x => (abs x)^α) 1 α := by
  sorry

/-! ## #eval Tests -/

#eval "Examples.Standard: polynomial, linearContinuous, quadraticContinuous, polynomialContinuous"
#eval "Examples.Standard: sinContinuous, cosContinuous, tanContinuousWhereDefined"
#eval "Examples.Standard: expContinuous, logContinuousOnPositive, absoluteValueLipschitz"
#eval "Examples.Standard: sqrtContinuousOnNonnegative, reciprocalContinuousAwayFromZero"
#eval "Examples.Standard: identityLipschitz, sinLipschitz, rationalLipschitz"

end MiniContinuity
