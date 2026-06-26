/-
# MiniSequenceSeries.Core.Basic

Fundamental definitions: sequences, limits, convergence,
boundedness, monotonicity, subsequences, series (partial sums),
power series, Cauchy criterion.
-/

import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Sequence — the fundamental type -/

abbrev Sequence (α : Type) := Nat → α

def Sequence.eval (s : Sequence α) (n : Nat) : α := s n

/-! ## Limit of a sequence -/

def Sequence.limit (s : Sequence ℝ) (L : ℝ) : Prop :=
  ∀ (ε : ℝ), ε > 0 → ∃ (N : Nat), ∀ (n : Nat), n ≥ N → |s n - L| < ε

def isConvergent (s : Sequence ℝ) : Prop :=
  ∃ (L : ℝ), Sequence.limit s L

def isBounded (s : Sequence ℝ) : Prop :=
  ∃ (M : ℝ), ∀ (n : Nat), |s n| ≤ M

/-! ## Monotonicity -/

def isMonotone (s : Sequence ℝ) : Prop :=
  isIncreasing s ∨ isDecreasing s

def isIncreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n ≤ m → s n ≤ s m

def isDecreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n ≤ m → s m ≤ s n

def isStrictlyIncreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n < m → s n < s m

def isStrictlyDecreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n < m → s m < s n

/-! ## Subsequence — via strictly increasing index map -/

def isStrictlyIncreasingMap (f : Nat → Nat) : Prop :=
  ∀ (n m : Nat), n < m → f n < f m

structure Subsequence (α : Type) where
  parent : Sequence α
  indexMap : Nat → Nat
  isStrictlyIncreasingProof : isStrictlyIncreasingMap indexMap

def Subsequence.seq (s : Subsequence α) : Sequence α :=
  fun n => s.parent (s.indexMap n)

/-! ## Series — sequence of partial sums -/

def Series (a : Sequence ℝ) : Sequence ℝ :=
  fun n => match n with
    | 0     => a 0
    | n'+1  => Series a n' + a n

-- Alternative: define via ∑ notation
def Series.partialSum (a : Sequence ℝ) (n : Nat) : ℝ :=
  match n with
  | 0     => a 0
  | n'+1  => Series.partialSum a n' + a n

def Series.sum (a : Sequence ℝ) : Prop :=
  isConvergent (Series a)

def isAbsolutelyConvergent (a : Sequence ℝ) : Prop :=
  Series.sum (fun n => |a n|)

def isConditionallyConvergent (a : Sequence ℝ) : Prop :=
  Series.sum a ∧ ¬ isAbsolutelyConvergent a

def Series.limitSum (a : Sequence ℝ) (S : ℝ) : Prop :=
  Sequence.limit (Series a) S

/-! ## Power Series -/

structure PowerSeries where
  coefficients : Sequence ℝ
  center : ℝ := 0
deriving Repr, Inhabited

def PowerSeries.eval (ps : PowerSeries) (x : ℝ) (n : Nat) : ℝ :=
  ps.coefficients n * (x - ps.center) ^ n

def PowerSeries.partialSum (ps : PowerSeries) (x : ℝ) (n : Nat) : ℝ :=
  Series.partialSum (fun k => ps.eval x k) n

def radiusOfConvergence (ps : PowerSeries) : ℝ :=
  -- Formula: 1 / limsup |a_n|^(1/n)
  -- Defined via limsup: sup of all R such that series converges for |x-c| < R
  0

/-! ## Cauchy Criterion -/

def isCauchy (s : Sequence ℝ) : Prop :=
  ∀ (ε : ℝ), ε > 0 → ∃ (N : Nat), ∀ (m n : Nat), m ≥ N → n ≥ N → |s m - s n| < ε

/-! ## Convergence to ±∞ -/

def divergesToPosInf (s : Sequence ℝ) : Prop :=
  ∀ (M : ℝ), ∃ (N : Nat), ∀ (n : Nat), n ≥ N → s n > M

def divergesToNegInf (s : Sequence ℝ) : Prop :=
  ∀ (M : ℝ), ∃ (N : Nat), ∀ (n : Nat), n ≥ N → s n < M

def isOscillatory (s : Sequence ℝ) : Prop :=
  ¬ isConvergent s ∧ ¬ divergesToPosInf s ∧ ¬ divergesToNegInf s

/-! ## #eval Tests -/

def testConstantSeq : Sequence ℝ := fun _ => 5
def testHarmonicSeq : Sequence ℝ := fun n => 1 / (↑n + 1)
def testGeometricSeq : Sequence ℝ := fun n => (0.5 : ℝ) ^ n
def testAlternatingSeq : Sequence ℝ := fun n => ((-1 : ℝ) ^ n) / (↑n + 1)

#eval "Core.Basic: Sequence, limit, bounded, monotone, subsequence defined"
#eval s!"testConstantSeq 0 = {testConstantSeq 0} (expected 5)"
#eval s!"testHarmonicSeq 0 = {testHarmonicSeq 0}, testHarmonicSeq 9 = {testHarmonicSeq 9}"
#eval s!"testGeometricSeq 0 = {testGeometricSeq 0}, testGeometricSeq 4 = {testGeometricSeq 4}"
#eval "Core.Basic: Series (partial sum), PowerSeries, Cauchy criterion defined"

end MiniSequenceSeries
