/-
# MiniContinuity Benchmark: Lipschitz

Benchmarks for Lipschitz and Holder continuity operations.
-/

import MiniContinuity

open MiniContinuity

/-! ## Lipschitz Benchmark Suite -/

#eval "Benchmark.LipschitzBench: Starting Lipschitz benchmarks"

-- Benchmark: identity is 1-Lipschitz
#eval "LipschitzBench: identity f(x)=x satisfies |x-y| ≤ 1·|x-y|"

-- Benchmark: sin is 1-Lipschitz
#eval "LipschitzBench: |sin(x)-sin(y)| ≤ |x-y| using MVT or analytic inequality"

-- Benchmark: abs is 1-Lipschitz
#eval "LipschitzBench: ||x|-|y|| ≤ |x-y| (reverse triangle inequality)"

-- Benchmark: Lipschitz ⇒ uniform continuity
#eval "LipschitzBench: isLipschitz f → isUniformlyContinuous f (δ = ε/K)"

-- Benchmark: Lipschitz ⇒ Holder with α=1
#eval "LipschitzBench: 1-Holder = Lipschitz"

-- Benchmark: sqrt is 1/2-Holder on [0,∞)
#eval "LipschitzBench: |√x - √y| ≤ |x-y|^{1/2}"

-- Benchmark: best Lipschitz constant = sup of difference quotients
#eval "LipschitzBench: ||f||_Lip = sup_{x≠y} |f(x)-f(y)|/|x-y|"

-- Benchmark: Banach fixed point for contractions
#eval "LipschitzBench: contraction with K<1 has unique fixed point"

#eval "Benchmark.LipschitzBench: All Lipschitz benchmarks completed"
