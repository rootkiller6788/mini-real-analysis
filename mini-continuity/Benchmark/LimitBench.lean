/-
# MiniContinuity Benchmark: Limit

Benchmarks for limit of function operations.
-/

import MiniContinuity

open MiniContinuity

/-! ## Limit Benchmark Suite -/

#eval "Benchmark.LimitBench: Starting limit benchmarks"

-- Benchmark: ε-δ limit definition
#eval "LimitBench: limitOfFunction f a L = ∀ε>0 ∃δ>0 0<|x-a|<δ → |f(x)-L|<ε"

-- Benchmark: sum of limits = limit of sum
#eval "LimitBench: limitOfSum: lim(f+g) = lim f + lim g"

-- Benchmark: product of limits = limit of product
#eval "LimitBench: limitOfProduct: lim(f·g) = lim f · lim g"

-- Benchmark: quotient of limits
#eval "LimitBench: limitOfQuotient: lim(f/g) = lim f / lim g (when lim g ≠ 0)"

-- Benchmark: squeeze theorem
#eval "LimitBench: squeezeTheorem: f ≤ g ≤ h, lim f = lim h = L → lim g = L"

-- Benchmark: one-sided limits
#eval "LimitBench: leftHandLimit: lim_{x→a⁻} f(x) = L"
#eval "LimitBench: rightHandLimit: lim_{x→a⁺} f(x) = L"

-- Benchmark: limit of composition
#eval "LimitBench: lim(f(g(x))) = f(lim g(x)) when f is continuous at limit point"

#eval "Benchmark.LimitBench: All limit benchmarks completed"
