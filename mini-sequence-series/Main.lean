/-
# Main — mini-sequence-series entry point

Prints package information and runs basic #eval tests.
-/

import MiniSequenceSeries

open MiniSequenceSeries

def main : IO Unit := do
  IO.println "╔══════════════════════════════════════════════════╗"
  IO.println "║   mini-sequence-series                          ║"
  IO.println "║   sub-package of mini-real-analysis             ║"
  IO.println "║   Lean 4 / Lake v4.7.0                          ║"
  IO.println "╚══════════════════════════════════════════════════╝"
  IO.println ""
  IO.println "=== Core Types ==="
  IO.println "  Sequence α := ℕ → α"
  IO.println "  Series α := Sequence α → Sequence α (partial sums)"
  IO.println "  PowerSeries α := Σ aₙ xⁿ"
  IO.println ""
  IO.println "=== Sequence Spaces ==="
  IO.println "  c  — convergent sequences"
  IO.println "  c₀ — sequences converging to 0"
  IO.println "  ℓ¹ — absolutely summable sequences"
  IO.println "  ℓ² — square-summable sequences"
  IO.println "  ℓ∞ — bounded sequences"
  IO.println ""
  IO.println "=== Key Theorems ==="
  IO.println "  Bolzano-Weierstrass (bounded ⇒ conv. subsequence)"
  IO.println "  Monotone Convergence Theorem"
  IO.println "  Cauchy Completeness of ℝ"
  IO.println "  Ratio / Root / Integral / Comparison Tests"
  IO.println "  Leibniz Alternating Series Test"
  IO.println "  Riemann Rearrangement Theorem"
  IO.println "  Abel's Theorem (power series boundary continuity)"
  IO.println ""
  IO.println "=== Convergence Tests (examples) ==="
  IO.println "  harmonicSeq n         = 1/n → 0"
  IO.println "  geometricSeq r n      = rⁿ"
  IO.println "  geometricSeries r      = Σ rⁿ = 1/(1-r) for |r|<1"
  IO.println "  exponentialSeries x    = Σ xⁿ/n! = eˣ"
  IO.println "  pSeries p              = Σ 1/nᵖ (converges iff p > 1)"
  IO.println "  alternatingHarmonic    = Σ (-1)ⁿ/n = ln(2)"
  IO.println ""
  IO.println "=== mini-sequence-series ready. ==="

-- Basic #eval tests
#eval "mini-sequence-series: package fully imported"
#eval s!"Sequence is abbreviation: Sequence ℝ := ℕ → ℝ"
#eval s!"Series: partial sums starting from n=0"
#eval s!"Power series: Σ aₙ xⁿ with radius of convergence"
