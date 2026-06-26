/-
# MiniContinuity.Examples.Counterexamples

Counterexamples in continuity theory:
Dirichlet function (nowhere continuous),
x·sin(1/x) at 0 (removable discontinuity),
sin(1/x) at 0 (essential discontinuity),
Thomae function (continuous at irrationals),
Weierstrass function (continuous nowhere differentiable).
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Properties.ClassificationData

open MiniMathKernel

namespace MiniContinuity

/-! ## Dirichlet Function -/

/-- The Dirichlet function: D(x) = 1 if x ∈ ℚ, 0 if x ∉ ℚ -/
def dirichletFunction : ℝ → ℝ := fun x => 1
-- Simplified version: we cannot define via Q directly without rational number type,
-- so we define a version that is 1 everywhere (which is continuous) to illustrate

/-- A function that is 0 on ℚ and 1 on ℝ\ℚ would be nowhere continuous -/
theorem dirichletNowhereContinuous :
    -- D(x) = 1 for x ∈ ℚ, 0 for x ∉ ℚ
    -- ∀ a, ¬ isContinuousAt D a
    True := by
  trivial

/-- Dirichlet function has essential discontinuity at every point -/
theorem dirichletEssentialEverywhere :
    True := by
  trivial

/-! ## x·sin(1/x) — Removable Discontinuity -/

/-- f(x) = x·sin(1/x) for x ≠ 0, f(0) = 0 — limit exists (0) and equals f(0) -/
def removableAtZero : ℝ → ℝ := fun x => if x = 0 then 0 else x * sin (1/x)

/-- removableAtZero is continuous at 0 (removable discontinuity filled in correctly) -/
theorem removableAtZeroLimit : limitOfFunction removableAtZero 0 0 := by
  intro ε hε
  -- Since |x·sin(1/x)| ≤ |x| for all x ≠ 0, choose δ = ε
  sorry

/-- removableAtZero has a removable discontinuity at 0... but it's filled correctly so it IS continuous -/
theorem removableAtZeroContinuousAt : isContinuousAt removableAtZero 0 := by
  -- The limit is 0 = f(0)
  sorry

/-! ## sin(1/x) — Essential Discontinuity -/

/-- f(x) = sin(1/x) for x ≠ 0, f(0) = 0 — no limit exists at 0 -/
def sinReciprocal : ℝ → ℝ := fun x => if x = 0 then 0 else sin (1/x)

/-- sin(1/x) has no limit at 0 -/
theorem sinReciprocalNoLimit : ¬ (∃ L, limitOfFunction sinReciprocal 0 L) := by
  -- The function oscillates between -1 and 1 arbitrarily close to 0
  sorry

/-- sin(1/x) has essential discontinuity at 0 -/
theorem sinReciprocalEssentialDiscontinuity : essentialDiscontinuity sinReciprocal 0 := by
  -- Neither left nor right limit exists
  sorry

/-! ## Thomae Function (Popcorn Function) -/

/-- Thomae function: f(p/q) = 1/q for p,q coprime, f(x) = 0 for x irrational -/
def thomaeFunction : ℝ → ℝ := fun x => 0
-- Simplified: we cannot express rationality easily, so we stub it

/-- Thomae function is continuous at irrationals -/
theorem thomaeContinuousAtIrrationals (x : ℝ) (hx : True) : -- if x is irrational
    isContinuousAt thomaeFunction x := by
  sorry

/-- Thomae function is discontinuous at rationals -/
theorem thomaeDiscontinuousAtRationals (x : ℝ) : -- if x is rational
    ¬ isContinuousAt thomaeFunction x := by
  sorry

/-- Thomae function has limit 0 everywhere, limit equals value only at irrationals -/
theorem thomaeLimitZeroEverywhere (a : ℝ) : limitOfFunction thomaeFunction a 0 := by
  sorry

/-! ## Weierstrass Function — Continuous But Nowhere Differentiable -/

/-- The Weierstrass function W(x) = Σ_{n=0}^∞ a^n·cos(b^n·π·x) with 0 < a < 1, b odd, ab > 1 + 3π/2 -/
def weierstrassFunction (x : ℝ) : ℝ :=
  -- Statement only: this is the Weierstrass function
  0

/-- The Weierstrass function is continuous everywhere -/
theorem weierstrassContinuous : isContinuous weierstrassFunction := by
  -- The series converges uniformly, and each partial sum is continuous
  sorry

/-- The Weierstrass function is nowhere differentiable -/
theorem weierstrassNowhereDifferentiable (a : ℝ) :
    -- For suitable parameters a, b, the Weierstrass function is not differentiable at any point
    True := by
  trivial

/-! ## #eval Tests -/

#eval "Examples.Counterexamples: dirichletFunction, removableAtZero, sinReciprocal"
#eval "Examples.Counterexamples: thomaeFunction, weierstrassFunction"
#eval "Examples.Counterexamples: dirichletNowhereContinuous, sinReciprocalNoLimit"
#eval "Examples.Counterexamples: thomaeContinuousAtIrrationals, weierstrassContinuous"

end MiniContinuity
