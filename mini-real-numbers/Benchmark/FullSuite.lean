/-
# Benchmark: Full Suite

Aggregate benchmark that runs all individual benchmark modules.
-/

import MiniRealNumbers

-- Import all benchmark modules
import MiniRealNumbersBenchmarkFieldOps := Benchmark.FieldOps
import MiniRealNumbersBenchmarkOrderBench := Benchmark.OrderBench
import MiniRealNumbersBenchmarkSupremumBench := Benchmark.SupremumBench
import MiniRealNumbersBenchmarkDedekindBench := Benchmark.DedekindBench
import MiniRealNumbersBenchmarkCauchyBench := Benchmark.CauchyBench

open MiniRealNumbers

/-! ## Full Benchmark Suite -/

/--
Running the full benchmark suite:
  1. FieldOps      — 15 targets: field operations
  2. OrderBench    — 12 targets: order comparisons
  3. SupremumBench — 10 targets: supremum/infimum
  4. DedekindBench — 10 targets: Dedekind cuts
  5. CauchyBench   — 10 targets: Cauchy sequences
  Total: ~57 targets
-/

#eval "============================================================"
#eval "  MiniRealNumbers Full Benchmark Suite"
#eval "  Components: FieldOps, OrderBench, SupremumBench,"
#eval "             DedekindBench, CauchyBench"
#eval "  Approx. 57 targets total"
#eval "============================================================"
#eval ""
#eval "To run individual benchmarks:"
#eval "  lake env lean --run Benchmark/FieldOps.lean"
#eval "  lake env lean --run Benchmark/OrderBench.lean"
#eval "  lake env lean --run Benchmark/SupremumBench.lean"
#eval "  lake env lean --run Benchmark/DedekindBench.lean"
#eval "  lake env lean --run Benchmark/CauchyBench.lean"
#eval ""
#eval "Run comprehensive benchmark with:"
#eval "  lake env lean --run Benchmark/FullSuite.lean"

/-!
Note: For actual #bench measurements, uncomment the benchmark
annotations in the individual files. The current targets serve
as the specification of what to measure.
-/

#eval "FullSuite benchmark framework loaded successfully"

end MiniRealNumbers
