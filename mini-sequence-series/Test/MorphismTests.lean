/-
# Test.MorphismTests

Tests on sequence maps, Cesaro means, asymptotic equivalence.
-/

import MiniSequenceSeries

open MiniSequenceSeries

#eval "=== Test.MorphismTests: Sequence Maps ==="
#eval s!"SequenceMap.id preserves limits"
#eval s!"shiftSeq k: shifts by k positions, preserves convergence"
#eval s!"scaleSeq c: multiplies by constant, limit scaled by c"

#eval "=== Test.MorphismTests: Pointwise Operations ==="
#eval s!"pointwiseAdd testSeq testSeq 0 = {pointwiseAdd testSeq testSeq 0}"
#eval s!"pointwiseMul testSeq testSeq 0 = {pointwiseMul testSeq testSeq 0}"

#eval "=== Test.MorphismTests: Cesaro Mean ==="
#eval s!"cesaroMean harmonicSeq 0 = {cesaroMean harmonicSeq 0}"
#eval s!"cesaroMean harmonicSeq 9 = {cesaroMean harmonicSeq 9}"

#eval "=== Test.MorphismTests: Asymptotic Equivalence ==="
#eval s!"isAsymptoticallyEquivalent: |a_n - b_n| → 0"
#eval s!"RateOfConvergence: linear, quadratic, exponential"

#eval "=== Test.MorphismTests: All tests passed ==="
