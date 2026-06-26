/-
# Computation.Evaluate

Collection of #eval examples demonstrating sequence and series
computation.
-/

import MiniSequenceSeries

open MiniSequenceSeries

namespace Computation

/-! ## Evaluate: Sequence Examples -/

#eval "=== Sequence Evaluations ==="
#eval s!"constantSeq 5: 0={constantSeq 5 0}, 10={constantSeq 5 10}, 100={constantSeq 5 100}"
#eval s!"harmonicSeq: 0={harmonicSeq 0}, 1={harmonicSeq 1}, 5={harmonicSeq 5}, 10={harmonicSeq 10}"
#eval s!"geometricSeq 0.5: 0={geometricSeq 0.5 0}, 1={geometricSeq 0.5 1}, 2={geometricSeq 0.5 2}, 5={geometricSeq 0.5 5}, 10={geometricSeq 0.5 10}"
#eval s!"geometricSeq 2.0: 0={geometricSeq 2.0 0}, 1={geometricSeq 2.0 1}, 5={geometricSeq 2.0 5}"

/-! ## Evaluate: Series Examples -/

#eval ""
#eval "=== Series Evaluations ==="
#eval s!"geometricSeries 0.5: 0={geometricSeries 0.5 0}, 1={geometricSeries 0.5 1}, 2={geometricSeries 0.5 2}, 5={geometricSeries 0.5 5}, 10={geometricSeries 0.5 10}"
#eval s!"exponentialSeries 1.0: 0={exponentialSeries 1.0 0}, 1={exponentialSeries 1.0 1}, 5={exponentialSeries 1.0 5}, 10={exponentialSeries 1.0 10}"

/-! ## Evaluate: Special Sequences -/

#eval ""
#eval "=== Special Sequences ==="
#eval s!"alternatingSignSeq: {alternatingSignSeq 0}, {alternatingSignSeq 1}, {alternatingSignSeq 2}, {alternatingSignSeq 3}, {alternatingSignSeq 4}"
#eval s!"alternatingHarmonicSeries: 0={alternatingHarmonicSeries 0}, 5={alternatingHarmonicSeries 5}, 10={alternatingHarmonicSeries 10}"
#eval s!"pSeries 2.0 partials: 0={pSeriesSum 2.0 0}, 5={pSeriesSum 2.0 5}, 10={pSeriesSum 2.0 10}"

/-! ## Evaluate: Cesaro Mean -/

#eval ""
#eval "=== Cesaro Mean ==="
#eval s!"cesaroMean harmonicSeq: 0={cesaroMean harmonicSeq 0}, 5={cesaroMean harmonicSeq 5}, 10={cesaroMean harmonicSeq 10}"

/-! ## Evaluate: Factorial -/

#eval ""
#eval "=== Factorial ==="
#eval s!"fac 0 = {fac 0}"
#eval s!"fac 1 = {fac 1}"
#eval s!"fac 5 = {fac 5}"
#eval s!"fac 10 = {fac 10}"

end Computation
