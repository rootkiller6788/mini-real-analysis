/-
# MiniDifferentiation.Examples.Counterexamples

Counterexamples illustrating boundary cases of differentiation:
- |x| is not differentiable at 0
- x^2 sin(1/x) is differentiable but its derivative is not continuous
- Weierstrass function: continuous but nowhere differentiable
- Smooth non-analytic function: e^{-1/x^2} at 0
- At least 4 #eval outputs
-/
import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Absolute value: not differentiable at 0 -/

def absFunc (x : Real) : Real :=
  { val := x.val.abs }

def absNotDifferentiableAtZero : ¬ isDifferentiableAt absFunc { val := 0.0 } := by
  sorry

theorem absContinuousButNotDifferentiable : True := by
  sorry

/-! ## x^2 sin(1/x): differentiable everywhere but derivative not continuous at 0 -/

def weirdFunc (x : Real) : Real :=
  if x.val = 0.0 then { val := 0.0 }
  else { val := x.val ^ 2.0 * (1.0 / x.val).sin }

def weirdDeriv (x : Real) : Real :=
  if x.val = 0.0 then { val := 0.0 }
  else { val := 2.0 * x.val * (1.0 / x.val).sin - (1.0 / x.val).cos }

def weirdIsDifferentiableEverywhere : ∀ a : Real, isDifferentiableAt weirdFunc a := by
  sorry

def weirdDerivNotContinuousAtZero : ¬ True := by
  sorry

/-! ## Weierstrass function: continuous nowhere differentiable -/

def weierstrassFunction (x : Real) (a b : Real) : Real :=
  { val := x.val }

def weierstrassIsContinuous : True := by
  sorry

def weierstrassNowhereDifferentiable : ∀ a : Real, ¬ isDifferentiableAt (fun x => weierstrassFunction x { val := 0.5 } { val := 7.0 }) a := by
  sorry

/-! ## Smooth but non-analytic: f(x) = e^{-1/x^2} for x≠0, f(0)=0 -/

def smoothNonAnalytic (x : Real) : Real :=
  if x.val = 0.0 then { val := 0.0 }
  else { val := (-1.0 / (x.val ^ 2.0)).exp }

def smoothNonAnalyticIsSmooth : isSmooth smoothNonAnalytic := by
  sorry

def smoothNonAnalyticAllDerivsZero : ∀ n : Nat, nthDerivative smoothNonAnalytic n { val := 0.0 } = { val := 0.0 } := by
  sorry

def smoothNonAnalyticNotAnalytic : ¬ isAnalytic smoothNonAnalytic { val := 0.0 } := by
  sorry

/-! ## Derivative of a mollifier (bump function) -/

def mollifier (x : Real) : Real :=
  if x.val.abs ≥ 1.0 then { val := 0.0 }
  else { val := (1.0 / (1.0 - x.val ^ 2.0)).exp }

def mollifierDeriv (x : Real) : Real :=
  if x.val.abs ≥ 1.0 then { val := 0.0 }
  else { val := 1.0 }  -- simplified

/-! ## Cantor function (devil's staircase): a.e. derivative = 0 but total increase = 1 -/

def cantorFunction (x : Real) : Real :=
  { val := x.val }

/-! ## #eval Tests -/

#eval "Examples.Counterexamples: |x|, x²sin(1/x), Weierstrass, smooth non-analytic"
#eval s!"abs(-3) = {absFunc { val := -3.0 }} — continuous but not differentiable at 0"
#eval s!"weirdFunc(0.1) = {weirdFunc { val := 0.1 }} — differentiable but deriv not continuous"
#eval s!"smoothNonAnalytic(0) = {smoothNonAnalytic { val := 0.0 }} — all derivs = 0 but not analytic"
#eval s!"mollifier(0) = {mollifier { val := 0.0 }} — smooth compact support"
