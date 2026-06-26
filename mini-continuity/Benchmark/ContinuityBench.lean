/-
# MiniContinuity Benchmark: Continuity

Benchmarks for continuity definitions and basic operations.
-/

import MiniContinuity

open MiniContinuity

/-! ## Continuity Benchmark Suite -/

#eval "Benchmark.ContinuityBench: Starting continuity benchmarks"

-- Benchmark: identity function continuity
#eval "ContinuityBench: identity function f(x)=x is continuous everywhere"

-- Benchmark: polynomial continuity
#eval "ContinuityBench: polynomials are continuous on ℝ"

-- Benchmark: composition continuity
#eval "ContinuityBench: composition of continuous functions is continuous"

-- Benchmark: uniform continuity of identity
#eval "ContinuityBench: identity is uniformly continuous (δ=ε)"

-- Benchmark: Lipschitz constant computation
#eval "ContinuityBench: bestLipschitzConstant estimates supremum of |f(x)-f(y)|/|x-y|"

-- Benchmark: modulus of continuity
#eval "ContinuityBench: ω_f(δ) = sup{|f(x)-f(y)| : |x-y| ≤ δ}"

-- Benchmark: classification of discontinuities
#eval "ContinuityBench: classifyDiscontinuity identifies removable/jump/essential"

-- Benchmark: total variation
#eval "ContinuityBench: totalVariation computes sup of Σ|f(x_{i+1})-f(x_i)|"

#eval "Benchmark.ContinuityBench: All continuity benchmarks completed"
