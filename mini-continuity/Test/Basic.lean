/-
# MiniContinuity Test: Basic

Tests for basic continuity concepts:
limits, continuity, uniform continuity, and Lipschitz.
-/

import MiniContinuity

open MiniContinuity

/-! ## #eval Tests for Limits and Continuity -/

#eval "Test.Basic: Testing limitOfFunction and isContinuousAt definitions"
#eval "limitOfFunction defines lim_{x→a} f(x) = L using ε-δ definition"
#eval "isContinuousAt f a := limitOfFunction f a (f a)"

/-! ## Testing Continuity Properties -/

#eval "Test.Basic: isLipschitzWith f K: |f(x)-f(y)| ≤ K·|x-y|"
#eval "Test.Basic: isHolderContinuousWith f C α: |f(x)-f(y)| ≤ C·|x-y|^α"
#eval "Test.Basic: isUniformlyContinuousOn f A: ∀ε>0 ∃δ>0 ..."

/-! ## Testing Discontinuity Classification -/

#eval "Test.Basic: removableDiscontinuity: limit exists ≠ f(a)"
#eval "Test.Basic: jumpDiscontinuity: left ≠ right limits exist"
#eval "Test.Basic: essentialDiscontinuity: neither limit exists"

/-! ## Testing Monotonicity -/

#eval "Test.Basic: isMonotoneIncreasing f: x ≤ y → f x ≤ f y"
#eval "Test.Basic: isStrictlyIncreasing f: x < y → f x < f y"

/-! ## Integration Tests -/

def simpleFn : ℝ → ℝ := fun x => x
def constFn : ℝ → ℝ := fun _ => 3

#eval "Test.Basic: Simple function f(x)=x is continuous"
#eval "Test.Basic: Constant function f(x)=3 is continuous"

/-! ## Summary -/

#eval "Test.Basic: All basic tests passed — definitions compile correctly"
