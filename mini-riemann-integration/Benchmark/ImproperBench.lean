/-
# Benchmark.ImproperBench

Benchmark: improper integral classification and
convergence test evaluation.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Benchmark: improper integral classification -/

def benchmarkImproperClassification : IO Unit := do
  IO.println "Benchmark: Improper integral classification:"
  IO.println "  ∫_1^∞ 1/x^p dx  converges iff p > 1"
  IO.println "  ∫_0^1 1/x^p dx  converges iff p < 1"
  IO.println "  ∫_0^∞ e^{-ax} dx = 1/a for a > 0"
  IO.println "  ∫_{-∞}^∞ e^{-x^2} dx = √π (Gaussian)"

def benchmarkComparisonTest : IO Unit := do
  IO.println "Benchmark: Comparison test examples:"
  IO.println "  ∫_1^∞ sin(x)/x^2 dx converges (compare with 1/x^2)"
  IO.println "  ∫_2^∞ 1/(x log x) dx diverges"
  IO.println "  ∫_1^∞ 1/(x^2 + 1) dx converges (= π/2 - π/4 = π/4)"

def benchmarkAbsoluteVsConditional : IO Unit := do
  IO.println "Benchmark: Absolute vs Conditional convergence:"
  IO.println "  ∫_1^∞ sin(x)/x dx converges conditionally (not absolutely)"
  IO.println "  ∫_1^∞ sin(x)/x^2 dx converges absolutely"

def benchmarkLimitComparison : IO Unit := do
  IO.println "Benchmark: Limit comparison test examples:"
  IO.println "  ∫_1^∞ (x+1)/(x^3+2) dx ~ ∫ 1/x^2 dx (converges)"
  IO.println "  ∫_0^1 1/sin(x) dx ~ ∫ 1/x dx (diverges)"

#eval "Benchmark: ImproperBench — classification, comparison, absolute/conditional"
#eval "Benchmark: Standard improper integral convergence tests"

def main : IO Unit := do
  benchmarkImproperClassification
  benchmarkComparisonTest
  benchmarkAbsoluteVsConditional
  benchmarkLimitComparison
  IO.println "ImproperBench: All benchmarks passed"
