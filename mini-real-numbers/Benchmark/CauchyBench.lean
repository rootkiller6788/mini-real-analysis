/-
# Benchmark: Cauchy Sequence Convergence

Measures performance of Cauchy sequence construction,
convergence checking, and limit computation. About 10 targets.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Benchmarks for Cauchy Sequences -/

-- Target 1: Benchmark constant sequence convergence
-- #bench cauchy_const

-- Target 2: Benchmark 1/n sequence convergence
-- #bench cauchy_one_div_n

-- Target 3: Benchmark geometric sequence convergence
-- #bench cauchy_geometric

-- Target 4: Benchmark verifying Cauchy condition
-- #bench cauchy_verify

-- Target 5: Benchmark convergence to limit verification
-- #bench converge_verify

-- Target 6: Benchmark limit computation
-- #bench limit_compute

-- Target 7: Benchmark sequence addition (pointwise)
-- #bench seq_pointwise_add

-- Target 8: Benchmark sequence mapping
-- #bench seq_map

-- Target 9: Benchmark completion construction
-- #bench completion

-- Target 10: Benchmark full Cauchy pipeline
-- #bench cauchy_pipeline

#eval "=== Cauchy Sequence Benchmark Suite ==="
#eval "10 targets: constant, 1/n, geometric sequences"
#eval "Operations: Cauchy verify, converge verify, limit compute"
#eval "Run with: lake env lean --run Benchmark/CauchyBench.lean"

end MiniRealNumbers
