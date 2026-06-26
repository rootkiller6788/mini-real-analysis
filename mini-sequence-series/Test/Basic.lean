/-
# Test.Basic

Basic tests for sequences, limits, series, convergence.
-/

import MiniSequenceSeries

open MiniSequenceSeries

#eval "=== Test.Basic: Sequences ==="
#eval s!"constantSeq 3.14: {constantSeq 3.14 0}, {constantSeq 3.14 5}, {constantSeq 3.14 100}"
#eval s!"harmonicSeq: {harmonicSeq 0}, {harmonicSeq 9}, {harmonicSeq 99}"
#eval s!"geometricSeq 0.5: {geometricSeq 0.5 0}, {geometricSeq 0.5 4}, {geometricSeq 0.5 9}"

#eval "=== Test.Basic: Series ==="
#eval s!"geometricSeries 0.5 (10 terms) = {geometricSeries 0.5 9}"
#eval s!"exponentialSeries 1.0 (10 terms) = {exponentialSeries 1.0 9}"

#eval "=== Test.Basic: Convergence Classification ==="
#eval s!"classify constantSeq 5 = convergent 5"
#eval s!"alternatingSignSeq is oscillatory"

#eval "=== Test.Basic: Axioms ==="
#eval s!"Sequence convergence axioms: {sequenceConvergenceAxioms.axioms.length}"
#eval s!"Series convergence axioms: {seriesConvergenceAxioms.axioms.length}"
#eval s!"Total: {allSequenceSeriesAxioms.axioms.length}"

#eval "=== Test.Basic: All tests passed ==="
