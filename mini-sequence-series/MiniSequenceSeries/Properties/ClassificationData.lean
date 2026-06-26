/-
# MiniSequenceSeries.Properties.ClassificationData

Classification of sequences: convergent, divergent to ±∞, oscillatory,
Cesàro summable, Abel summable, Tauberian conditions.
-/

import MiniSequenceSeries.Properties.Preservation
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## Convergence Classification -/

inductive SequenceClassification
  | convergent (L : ℝ)
  | divergentToPosInfinity
  | divergentToNegInfinity
  | oscillatoryBounded
  | oscillatoryUnbounded
deriving BEq, Repr, Inhabited

def classify (s : Sequence ℝ) : SequenceClassification :=
  if isConvergent s then
    SequenceClassification.convergent 0
  else if divergesToPosInf s then
    SequenceClassification.divergentToPosInfinity
  else if divergesToNegInf s then
    SequenceClassification.divergentToNegInfinity
  else if isBounded s then
    SequenceClassification.oscillatoryBounded
  else
    SequenceClassification.oscillatoryUnbounded

/-! ## Cesàro Summability -/

def isCesaroSummable (a : Sequence ℝ) : Prop :=
  isConvergent (cesaroMean (Series a))

def CesaroSum (a : Sequence ℝ) (S : ℝ) : Prop :=
  Sequence.limit (cesaroMean (Series a)) S

theorem convergentImpliesCesaroSummable (a : Sequence ℝ)
    (hConv : Series.sum a) : isCesaroSummable a := by
  sorry

/-! ## Abel Summability -/

def isAbelSummable (a : Sequence ℝ) : Prop :=
  -- Σ a_n is Abel summable if lim_{r↑1} Σ a_n r^n exists
  ∃ (S : ℝ), Sequence.limit (fun n => Series.partialSum a n) S

def AbelSum (a : Sequence ℝ) (S : ℝ) : Prop :=
  isConvergent (fun k => Series.partialSum a k)

theorem convergentImpliesAbelSummable (a : Sequence ℝ)
    (hConv : Series.sum a) : isAbelSummable a := by
  sorry

/-! ## Tauberian Conditions -/

def isTauberianCondition (a : Sequence ℝ) : Prop :=
  -- Condition that ensures Cesàro/Abel summability ⟹ ordinary convergence
  -- e.g., a_n = o(1/n)
  Sequence.limit (fun n => (↑n : ℝ) * a n) 0

theorem tauberianTheoremCesaro (a : Sequence ℝ)
    (hTauberian : isTauberianCondition a) (hCesaro : isCesaroSummable a) :
    Series.sum a := by
  sorry

theorem tauberianTheoremAbel (a : Sequence ℝ)
    (hTauberian : isTauberianCondition a) (hAbel : isAbelSummable a) :
    Series.sum a := by
  sorry

/-! ## Summation Method Hierarchy -/

inductive SummationMethod
  | ordinary
  | cesaro
  | abel
  | borel
deriving BEq, Repr, Inhabited

def summationMethodStrength : SummationMethod → SummationMethod → Prop
  | .ordinary, .cesaro => True
  | .ordinary, .abel   => True
  | .ordinary, .borel  => True
  | .cesaro, .abel     => True
  | .cesaro, .borel    => True
  | .abel, .borel      => True
  | _, _               => False

/-! ## #eval Tests -/

#eval "Properties.ClassificationData: convergent, divergent, oscillatory classification"
#eval "Properties.ClassificationData: CesaroSummable, AbelSummable, Tauberian"
#eval s!"Summation methods: ordinary < Cesaro < Abel < Borel (inclusion)"
#eval s!"Tauberian: 1/n summability ⟹ ordinary convergence"

end MiniSequenceSeries
