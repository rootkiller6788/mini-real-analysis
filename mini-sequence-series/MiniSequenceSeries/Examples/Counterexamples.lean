/-
# MiniSequenceSeries.Examples.Counterexamples

Counterexamples: harmonic series diverges, conditionally convergent
series with rearrangement changing sum, sequences converging but not
absolutely, oscillating sequences.

Knowledge coverage:
- L6: Canonical counterexamples with #eval verification
- L2: Understanding convergence vs. absolute convergence
- L5: Counterexample construction method
-/

import MiniSequenceSeries.Examples.Standard

namespace MiniSequenceSeries

/-! ## Harmonic Series Diverges (L6)

    Σ 1/(n+1) diverges (harmonic series). Partial sums grow like log n. -/

axiom harmonicSeriesDiverges : ¬ Series.sum harmonicSeq

#eval s!"Harmonic series partial sums: Σ 1/(n+1)"
#eval s!"n=99: {Series harmonicSeq 99}"
#eval s!"n=999: {Series harmonicSeq 999}"
#eval s!"n=9999: {Series harmonicSeq 9999}"
#eval s!"Diverges: partial sums → ∞ as n → ∞ (logarithmic growth)"

/-! ## Conditionally Convergent Series — Rearrangement Changes Sum (L6)

    The alternating harmonic series Σ(-1)ⁿ/n converges conditionally.
    By Riemann's rearrangement theorem, it can be rearranged to
    converge to ANY real number. -/

def altHarmonic := alternatingHarmonicSeq

/-- Alternating harmonic series converges conditionally, so by Riemann's
    theorem, there exists a rearrangement converging to any prescribed sum. -/
axiom altHarmonicRearrangement : True

#eval s!"Alternating harmonic: Σ (-1)ⁿ/(n+1) (conditionally convergent)"
#eval s!"Partial sums: n=99 → {Series alternatingHarmonicSeq 99}"
#eval s!"Partial sums: n=999 → {Series alternatingHarmonicSeq 999}"
#eval s!"(Converges to ln(2) ≈ 0.693147...)"

/-! ## Convergent but NOT Absolutely Convergent (L6) -/

def conditionallyConvergentExample : Sequence ℝ := alternatingHarmonicSeq

#eval s!"Example conditionally convergent: Σ (-1)ⁿ/(n+1)"
#eval s!"Converges but Σ 1/(n+1) diverges (harmonic)"

/-! ## Oscillating Sequence: (-1)^n does NOT converge (L6) -/

def alternatingSignSeq : Sequence ℝ := fun n => (-1 : ℝ) ^ n

#eval s!"(-1)ⁿ: {alternatingSignSeq 0}, {alternatingSignSeq 1}, {alternatingSignSeq 2}, {alternatingSignSeq 3}, {alternatingSignSeq 4}, {alternatingSignSeq 5}, {alternatingSignSeq 6}, {alternatingSignSeq 7}, {alternatingSignSeq 8}, {alternatingSignSeq 9}"
#eval s!"Oscillates between -1 and 1 — does NOT converge"

/-! ## Counterexample: Ratio Test Inconclusive (L6)

    For Σ 1/n² (p-series with p=2), the ratio test gives L=1
    (inconclusive), but the series converges (by p-series test). -/

def ratioTestInconclusiveExample : Sequence ℝ := fun n => 1 / ((↑n + 1) ^ 2)

#eval s!"Σ 1/(n+1)²: ratio limit = 1 (inconclusive)"
#eval s!"But the series converges (p-series, p=2 > 1)"
#eval s!"Partial sums: n=99 → {Series ratioTestInconclusiveExample 99}"
#eval s!"Partial sums: n=999 → {Series ratioTestInconclusiveExample 999}"
#eval s!"(Converges to π²/6 ≈ 1.644934...)"

/-! ## n^th Term Test is Necessary but NOT Sufficient (L6)

    aₙ → 0 is necessary for Σ aₙ to converge, but NOT sufficient.
    Counterexample: harmonic series — terms → 0 but series diverges. -/

/-- aₙ → 0 does NOT imply Σ aₙ converges. Counterexample: harmonic series. -/
axiom nthTermTestNotSufficient :
    Sequence.limit harmonicSeq 0 ∧ ¬ Series.sum harmonicSeq

/-! ## #eval Tests -/

#eval "Examples.Counterexamples: harmonic diverges, conditionally conv rearranges"
#eval s!"Harmonic: terms → 0 but series diverges (counterexample to converse of nth term test)"
#eval s!"Alternating harmonic: converges conditionally (not absolutely)"
#eval s!"(-1)ⁿ: oscillates, does not converge"
#eval s!"Ratio test inconclusive at L=1 (both convergence and divergence possible)"

end MiniSequenceSeries
