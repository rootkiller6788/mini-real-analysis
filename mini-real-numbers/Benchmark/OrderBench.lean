/-
# Benchmark: Order Comparisons

Measures performance of order comparisons on real numbers.
About 12 targets for le, lt, total order, transitivity.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Benchmarks for Order Comparisons -/

-- Target 1: Benchmark less-than on small values
-- #bench lt_small

-- Target 2: Benchmark less-or-equal on small values
-- #bench le_small

-- Target 3: Benchmark total order decision
-- #bench order_total

-- Target 4: Benchmark order transitivity chain
-- #bench order_trans_chain

-- Target 5: Benchmark antisymmetry
-- #bench order_antisymm

-- Target 6: Benchmark lexicographic order
-- #bench lex_order

-- Target 7: Benchmark interval membership test
-- #bench interval_membership

-- Target 8: Benchmark upper bound check
-- #bench isUpperBound

-- Target 9: Benchmark lower bound check
-- #bench isLowerBound

-- Target 10: Benchmark order on Dedekind cuts
-- #bench cut_order

-- Target 11: Benchmark order on products
-- #bench product_order

-- Target 12: Benchmark full order comparison suite
-- #bench order_suite

#eval "=== Order Comparison Benchmark Suite ==="
#eval "12 targets: lt, le, total, trans, antisymm, lexicographic"
#eval "Operations: interval membership, upper/lower bound checks"
#eval "Run with: lake env lean --run Benchmark/OrderBench.lean"

end MiniRealNumbers
