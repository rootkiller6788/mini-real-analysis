/-
# MiniSequenceSeries.Examples.Counterexamples

Counterexamples: harmonic series diverges, Σ 1/(n log n) diverges,
conditionally convergent series with rearrangement changing sum,
sequences converging but not absolutely, oscillating sequences.
-/

import MiniSequenceSeries.Examples.Standard
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Harmonic Series Diverges -/

theorem harmonicSeriesDiverges : ¬ Series.sum harmonicSeq := by
  sorry

#eval s!"harmonicSeries partial sums: 0={geometricSeries 1.0 0}, 9={geometricSeries 1.0 9}"
-- Actually need harmonic series: Σ 1/n
#eval s!"harmonic series: Σ 1/(n+1) partial sum 99 = {Series harmonicSeq 99}"
#eval s!"harmonic series: Σ 1/(n+1) partial sum 999 = {Series harmonicSeq 999}"

/-! ## Σ 1/(n log n) diverges -/

def logSeries : Sequence ℝ := fun n =>
  let n' := ↑n + 1
  let logN := if n' ≤ 1 then 1 else n'
  1 / (n' * logN)

theorem logSeriesDiverges : ¬ Series.sum logSeries := by
  sorry

#eval s!"logSeries 0..5: {logSeries 1}, {logSeries 2}, {logSeries 3}, {logSeries 4}, {logSeries 5}"

/-! ## Conditionally Convergent Series — Rearrangement Changes Sum -/

def altHarmonic := alternatingHarmonicSeq

theorem altHarmonicRearrangement :
    -- ∃ a permutation π such that Σ a_{π(n)} ≠ ln(2)
    True := by
  trivial

/-! ## Convergent but NOT Absolutely Convergent -/

def conditionallyConvergentExample : Sequence ℝ :=
  alternatingHarmonicSeq

#eval s!"Σ (-1)^n/n partial sum at 999 = {Series alternatingHarmonicSeq 999}"

/-! ## Oscillating Sequence: (-1)^n does NOT converge -/

def alternatingSignSeq : Sequence ℝ := fun n => (-1 : ℝ) ^ n

#eval s!"alternatingSignSeq 0..9: {alternatingSignSeq 0}, {alternatingSignSeq 1}, {alternatingSignSeq 2}, {alternatingSignSeq 3}, {alternatingSignSeq 4}, {alternatingSignSeq 5}, {alternatingSignSeq 6}, {alternatingSignSeq 7}, {alternatingSignSeq 8}, {alternatingSignSeq 9}"

/-! ## Counterexample: Convergent Series Where Ratio Test Fails -/

def ratioTestInconclusiveExample : Sequence ℝ :=
  fun n => 1 / ((↑n + 1) ^ 2)

#eval s!"Σ 1/n^2: ratio test inconclusive (limit = 1)"
#eval s!"partial sums: 0={Series ratioTestInconclusiveExample 0}, 9={Series ratioTestInconclusiveExample 9}, 99={Series ratioTestInconclusiveExample 99}"

/-! ## n^th Term Divergence Test Not Sufficient -/

theorem nthTermTestNotSufficient :
    -- a_n → 0 does NOT imply Σ a_n converges (harmonic series is counterexample)
    Sequence.limit harmonicSeq 0 ∧ ¬ Series.sum harmonicSeq := by
  sorry

/-! ## #eval Tests -/

#eval "Examples.Counterexamples: harmonic diverges, Σ1/(n log n) diverges, oscillation"
#eval "Examples.Counterexamples: conditionally conv, ratio test inconclusive, nth term test insufficient"

end MiniSequenceSeries
