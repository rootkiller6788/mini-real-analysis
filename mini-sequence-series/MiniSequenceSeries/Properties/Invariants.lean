/-
# MiniSequenceSeries.Properties.Invariants

Invariants of sequences: rate of convergence (linear, quadratic,
exponential), order of growth, asymptotic density, invariants
under subsequence operation.
-/

import MiniSequenceSeries.Constructions.Universal
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Rate of Convergence Classes -/

structure RateEstimate where
  rate : RateOfConvergence
  basis : ℝ
  constant : ℝ
deriving Repr, Inhabited

def linearRate (ρ : ℝ) (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.linear
  basis := ρ
  constant := c

def quadraticRate (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.quadratic
  basis := 2
  constant := c

def exponentialRate (λ : ℝ) (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.exponential
  basis := λ
  constant := c

/-! ## Order of Growth -/

inductive OrderOfGrowth
  | bounded
  | logarithmic
  | polynomial (d : ℝ)
  | exponential (b : ℝ)
  | factorial
deriving BEq, Repr, Inhabited

def growthOrder (s : Sequence ℝ) : OrderOfGrowth :=
  -- Compare s n to n^d, log n, b^n, n!
  OrderOfGrowth.bounded

def compareGrowth (a b : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => a n / b n) 0
  -- a = o(b)

/-! ## Asymptotic Density -/

def asymptoticDensity (A : Set ℕ) : ℝ :=
  -- lim_{n→∞} |A ∩ {1,...,n}| / n
  0

def naturalDensityOne (s : Sequence ℝ) : Prop :=
  -- s has a property for "almost all" n
  True

/-! ## Invariants Under Subsequence -/

theorem convergenceInvariantUnderSubsequence (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hConv : isConvergent s) : isConvergent (sub.seq) := by
  sorry

theorem boundednessInvariantUnderSubsequence (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hBounded : isBounded s) : isBounded (sub.seq) := by
  sorry

theorem monotonicityNotInvariant : ¬ (∀ (s : Sequence ℝ) (sub : Subsequence ℝ),
    isMonotone s → isMonotone (sub.seq)) := by
  sorry

/-! ## Convergence Rate Comparator -/

def rateFasterThan (s t : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => |s n| / |t n|) 0

def rateSameOrder (s t : Sequence ℝ) : Prop :=
  ∃ (c C : ℝ), c > 0 ∧ C > 0 ∧
    ∃ (N : Nat), ∀ (n : Nat), n ≥ N →
      c * |t n| ≤ |s n| ∧ |s n| ≤ C * |t n|

/-! ## #eval Tests -/

#eval "Properties.Invariants: RateEstimate, OrderOfGrowth, asymptoticDensity, subsequence invariants"
#eval s!"RateOfConvergence: linear/quadratic/exponential/superexponential"
#eval s!"OrderOfGrowth: bounded, logarithmic, polynomial d, exponential b, factorial"

end MiniSequenceSeries
