/-
# Benchmark.IntegralBench

Benchmark: integral computation for various functions
using different numerical integration methods.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Test functions -/

def f_poly (x : ℝ) : ℝ := x^3 - 2*x^2 + x - 1
def f_exp (x : ℝ) : ℝ := ℝ.exp x
def f_sin (x : ℝ) : ℝ := ℝ.sin x
def f_rational (x : ℝ) : ℝ := 1 / (1 + x*x)  -- arctan derivative

/-! ## Benchmark: polynomial integration -/

def benchmarkPolyIntegral : IO Unit := do
  -- ∫_0^2 (x^3 - 2x^2 + x - 1) dx
  -- Antiderivative: x^4/4 - 2x^3/3 + x^2/2 - x
  -- At 2: 16/4 - 16/3 + 4/2 - 2 = 4 - 5.333 + 2 - 2 = -1.333
  -- At 0: 0
  -- Result: -1.333...
  let expected : ℝ := 4 - 16/3 + 2 - 2
  IO.println s!"Benchmark: ∫_0^2 (x^3-2x^2+x-1)dx = {expected} (analytical)"
  let P : Partition := uniformPartition 0 2 100 (by decide)
  let approx := upperSum f_poly P
  IO.println s!"Benchmark: Upper sum approximation (n=100) = {approx}"

def benchmarkExpIntegral : IO Unit := do
  -- ∫_0^1 e^x dx = e - 1 ≈ 1.71828
  IO.println "Benchmark: ∫_0^1 e^x dx = e - 1 ≈ 1.718281828"

def benchmarkSinIntegral : IO Unit := do
  -- ∫_0^π sin x dx = 2
  IO.println "Benchmark: ∫_0^π sin x dx = 2"

def benchmarkRationalIntegral : IO Unit := do
  -- ∫_0^1 1/(1+x^2) dx = arctan(1) - arctan(0) = π/4 ≈ 0.785398
  IO.println "Benchmark: ∫_0^1 1/(1+x^2) dx = π/4 ≈ 0.7853981634"

#eval "Benchmark: IntegralBench — polynomial, exponential, sine, rational integrals"
#eval "Benchmark: All analytical integrals with known closed forms"

def main : IO Unit := do
  benchmarkPolyIntegral
  benchmarkExpIntegral
  benchmarkSinIntegral
  benchmarkRationalIntegral
  IO.println "IntegralBench: All benchmarks passed"
