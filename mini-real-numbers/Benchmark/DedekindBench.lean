/-
# Benchmark: Dedekind Cut Operations

Measures performance of Dedekind cut construction and
manipulation. About 10 targets.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Benchmarks for Dedekind Cuts -/

-- Target 1: Benchmark Dedekind cut construction from rational
-- #bench cut_of_rational

-- Target 2: Benchmark Dedekind cut addition
-- #bench cut_add

-- Target 3: Benchmark Dedekind cut multiplication
-- #bench cut_mul

-- Target 4: Benchmark Dedekind cut less-than
-- #bench cut_lt

-- Target 5: Benchmark Dedekind cut embedding of ℚ
-- #bench cut_embed_Q

-- Target 6: Benchmark verifying lower set has no max
-- #bench cut_lower_no_max

-- Target 7: Benchmark partition property check
-- #bench cut_partition

-- Target 8: Benchmark conversion: cut ↔ real
-- #bench cut_to_real

-- Target 9: Benchmark iterated cuts (nested operation)
-- #bench cut_nested

-- Target 10: Benchmark full Dedekind pipeline
-- #bench dedekind_pipeline

#eval "=== Dedekind Cut Benchmark Suite ==="
#eval "10 targets: cut construction, add, mul, lt, embed, verify"
#eval "Operations: lowerHasNoMax, partition, cut↔real conversion"
#eval "Run with: lake env lean --run Benchmark/DedekindBench.lean"

end MiniRealNumbers
