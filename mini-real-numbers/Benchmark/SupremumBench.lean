/-
# Benchmark: Supremum Computation

Measures performance of supremum and infimum computation
on bounded sets. About 10 targets.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Benchmarks for Supremum Computation -/

-- Target 1: Benchmark supremum of a finite set
-- #bench sup_finite_set

-- Target 2: Benchmark infimum of a finite set
-- #bench inf_finite_set

-- Target 3: Benchmark supremum of an interval
-- #bench sup_interval

-- Target 4: Benchmark supremum of rational squares < 2
-- #bench sup_squares_lt_2

-- Target 5: Benchmark isUpperBound check
-- #bench isUpperBound_check

-- Target 6: Benchmark isSupremum verification
-- #bench isSupremum_verify

-- Target 7: Benchmark supremum on Dedekind cuts
-- #bench sup_on_cuts

-- Target 8: Benchmark nested supremum chain
-- #bench sup_nested

-- Target 9: Benchmark supremum after field operations
-- #bench sup_after_ops

-- Target 10: Benchmark full supremum pipeline
-- #bench supremum_pipeline

#eval "=== Supremum Computation Benchmark Suite ==="
#eval "10 targets: sup/inf on finite sets, intervals, Dedekind cuts"
#eval "Operations: isUpperBound, isSupremum verification, nested chains"
#eval "Run with: lake env lean --run Benchmark/SupremumBench.lean"

end MiniRealNumbers
