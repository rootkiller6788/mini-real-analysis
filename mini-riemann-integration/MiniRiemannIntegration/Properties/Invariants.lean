/-
# MiniRiemannIntegration.Properties.Invariants

Integral norms (L¹, L², L∞), oscillation of a function
on an interval, and total variation.
-/

import MiniRiemannIntegration.Core.Objects
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## L¹ norm (integral norm) -/

def L1Norm (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  riemannIntegral (fun x => |f x|) a b

def integralNorm (f : ℝ → ℝ) (a b : ℝ) : ℝ := L1Norm f a b

/-! ## L² norm -/

def L2Norm (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  ℝ.sqrt (riemannIntegral (fun x => f x * f x) a b)

/-! ## L∞ norm (sup norm) -/

def LinfNorm (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- sup_{x ∈ [a,b]} |f(x)|
  -- Stub: returns 0; real implementation uses supremum
  0

/-! ## Oscillation of a function on an interval -/

structure Oscillation (f : ℝ → ℝ) (a b : ℝ) where
  supremum : ℝ
  infimum : ℝ
  oscillation : ℝ  -- sup f - inf f on [a,b]
  osc_formula : oscillation = supremum - infimum
  deriving Repr

def oscillation (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- sup_{x ∈ [a,b]} f(x) - inf_{x ∈ [a,b]} f(x)
  -- Stub
  0

def oscillationOnInterval (f : ℝ → ℝ) (P : Partition) (i : Nat) : ℝ :=
  -- Oscillation of f on the i-th subinterval of P
  0

/-! ## Total variation of a function -/

structure TotalVariation (f : ℝ → ℝ) (a b : ℝ) where
  variation : ℝ
  supOverPartitions : Prop  -- V_a^b(f) = sup_{P} Σ |f(x_{i+1}) - f(x_i)|
  isBoundedVariation : Prop
  deriving Repr

def totalVariation (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- sup over all partitions of Σ |f(x_{i+1}) - f(x_i)|
  0

def hasBoundedVariation (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  ∃ (M : ℝ), totalVariation f a b ≤ M

/-! ## Relationship: BV ⇒ Riemann integrable -/

theorem boundedVariation_implies_riemannIntegrable (a b : ℝ) (f : ℝ → ℝ) :
  hasBoundedVariation f a b → isRiemannIntegrable f a b := by
  intro h_bv
  sorry

/-! ## Inner product on R([a,b]) -/

def L2InnerProduct (f g : ℝ → ℝ) (a b : ℝ) : ℝ :=
  riemannIntegral (fun x => f x * g x) a b

structure L2Structure (a b : ℝ) where
  inner : (ℝ → ℝ) → (ℝ → ℝ) → ℝ := L2InnerProduct a b
  norm : (ℝ → ℝ) → ℝ := L2Norm a b
  cauchySchwarz : ∀ (f g : ℝ → ℝ), |inner f g| ≤ norm f * norm g

/-! ## #eval Tests -/

#eval "Properties.Invariants: L1Norm, L2Norm, LinfNorm defined"
#eval "Properties.Invariants: Oscillation, TotalVariation, hasBoundedVariation"
#eval "Properties.Invariants: L2InnerProduct, boundedVariation_implies_riemannIntegrable (sorry)"

end MiniRiemannIntegration
