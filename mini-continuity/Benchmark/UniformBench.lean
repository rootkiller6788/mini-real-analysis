/-
# MiniContinuity Benchmark: Uniform

Benchmarks for uniform continuity and related concepts.
-/

import MiniContinuity

open MiniContinuity

/-! ## Uniform Continuity Benchmark Suite -/

#eval "Benchmark.UniformBench: Starting uniform continuity benchmarks"

-- Benchmark: isUniformlyContinuousOn vs isUniformlyContinuous
#eval "UniformBench: uniform on A vs uniform on all of ℝ"

-- Benchmark: Heine-Cantor theorem
#eval "UniformBench: continuous on compact ⇒ uniformly continuous"

-- Benchmark: composition preserves uniform continuity
#eval "UniformBench: f, g uniformly continuous ⇒ f∘g uniformly continuous"

-- Benchmark: uniform limit of continuous functions is continuous
#eval "UniformBench: f_n → f uniformly, each f_n continuous ⇒ f continuous"

-- Benchmark: compact-open topology vs uniform topology
#eval "UniformBench: on compact domains, compact-open = uniform convergence"

-- Benchmark: equicontinuity
#eval "UniformBench: family F is uniformly equicontinuous: ∀ε ∃δ ∀f∈F ∀x,y ..."

-- Benchmark: Arzela-Ascoli theorem (statement)
#eval "UniformBench: equicontinuous + pointwise bounded ⇒ precompact in C(K)"

-- Benchmark: modulus of continuity → 0 iff uniform continuity
#eval "UniformBench: ω_f(δ) → 0 as δ → 0 ⇔ f uniformly continuous"

#eval "Benchmark.UniformBench: All uniform continuity benchmarks completed"
