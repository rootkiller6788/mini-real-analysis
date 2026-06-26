/-
# MiniSequenceSeries.Examples.Standard

Standard examples: harmonic, geometric, exponential, p-series,
alternating harmonic, seequence types, convergence behaviors.
-/

import MiniSequenceSeries.Theorems.UniversalProperties
import MiniObjectKernel

namespace MiniSequenceSeries

/-! ## Harmonic Sequence — 1/n → 0 -/

def harmonicSeq : Sequence ℝ := fun n => 1 / (↑n + 1)

#eval s!"harmonicSeq 0 = {harmonicSeq 0}"
#eval s!"harmonicSeq 9 = {harmonicSeq 9}"
#eval s!"harmonicSeq 99 = {harmonicSeq 99}"
#eval s!"harmonicSeq 999 = {harmonicSeq 999}"

/-! ## Geometric Sequence — r^n -/

def geometricSeq (r : ℝ) : Sequence ℝ := fun n => r ^ n

#eval s!"geometricSeq 0.5 0..9: {geometricSeq 0.5 0}, {geometricSeq 0.5 1}, {geometricSeq 0.5 2}, {geometricSeq 0.5 3}, {geometricSeq 0.5 4}, {geometricSeq 0.5 5}, {geometricSeq 0.5 6}, {geometricSeq 0.5 7}, {geometricSeq 0.5 8}, {geometricSeq 0.5 9}"
#eval s!"geometricSeq 2.0 0..5: {geometricSeq 2.0 0}, {geometricSeq 2.0 1}, {geometricSeq 2.0 2}, {geometricSeq 2.0 3}, {geometricSeq 2.0 4}, {geometricSeq 2.0 5}"

/-! ## Geometric Series — Σ r^n = 1/(1-r) for |r|<1 -/

def geometricSeries (r : ℝ) : Sequence ℝ := Series (geometricSeq r)

def geometricSeriesSum (r : ℝ) : ℝ :=
  if r ≠ 1 then 1 / (1 - r) else 0

#eval s!"geometricSeries 0.5 partial sums: 0={geometricSeries 0.5 0}, 4={geometricSeries 0.5 4}, 9={geometricSeries 0.5 9}"
#eval s!"geometricSeries 0.5 sum formula = {geometricSeriesSum 0.5}"

/-! ## Exponential Series — Σ x^n/n! = eˣ -/

def fac (n : Nat) : ℝ :=
  match n with
  | 0 => 1
  | n'+1 => (↑(n'+1)) * fac n'

def exponentialTerm (x : ℝ) (n : Nat) : ℝ := x ^ n / fac n

def exponentialSeries (x : ℝ) : Sequence ℝ := Series (exponentialTerm x)

#eval s!"exponentialTerm 1.0 0..5: {exponentialTerm 1.0 0}, {exponentialTerm 1.0 1}, {exponentialTerm 1.0 2}, {exponentialTerm 1.0 3}, {exponentialTerm 1.0 4}, {exponentialTerm 1.0 5}"
#eval s!"exponentialSeries 1.0 partial sums: 0={exponentialSeries 1.0 0}, 4={exponentialSeries 1.0 4}, 9={exponentialSeries 1.0 9}"

/-! ## p-Series — Σ 1/n^p converges iff p > 1 -/

def pSeries (p : ℝ) : Sequence ℝ := fun n => 1 / ((↑n + 1) ^ p)

def pSeriesSum (p : ℝ) : Sequence ℝ := Series (pSeries p)

#eval s!"pSeries 2.0 0..5: {pSeriesSum 2.0 0}, {pSeriesSum 2.0 1}, {pSeriesSum 2.0 2}, {pSeriesSum 2.0 3}, {pSeriesSum 2.0 4}, {pSeriesSum 2.0 5}"
#eval s!"pSeries 0.5 0..5: {pSeriesSum 0.5 0}, {pSeriesSum 0.5 1}, {pSeriesSum 0.5 2}, {pSeriesSum 0.5 3}, {pSeriesSum 0.5 4}, {pSeriesSum 0.5 5}"

/-! ## Alternating Harmonic Series — Σ (-1)^n/n = ln(2) -/

def alternatingHarmonicSeq : Sequence ℝ :=
  fun n => ((-1 : ℝ) ^ n) / (↑n + 1)

def alternatingHarmonicSeries : Sequence ℝ := Series alternatingHarmonicSeq

#eval s!"alternatingHarmonicSeq 0..9: {alternatingHarmonicSeq 0}, {alternatingHarmonicSeq 1}, {alternatingHarmonicSeq 2}, {alternatingHarmonicSeq 3}, {alternatingHarmonicSeq 4}, {alternatingHarmonicSeq 5}, {alternatingHarmonicSeq 6}, {alternatingHarmonicSeq 7}, {alternatingHarmonicSeq 8}, {alternatingHarmonicSeq 9}"
#eval s!"alternatingHarmonicSeries partial sums: 0={alternatingHarmonicSeries 0}, 9={alternatingHarmonicSeries 9}, 99={alternatingHarmonicSeries 99}"

/-! ## Constant Sequence -/

def constantSeq (c : ℝ) : Sequence ℝ := fun _ => c

#eval s!"constantSeq π 0 = {constantSeq π 0}, seq 5 = {constantSeq π 5}"

end MiniSequenceSeries
