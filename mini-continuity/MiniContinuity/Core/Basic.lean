/-
# MiniContinuity.Core.Basic

Core definitions for continuity theory:
limit of a function, continuity, uniform continuity,
Lipschitz and Holder continuity, one-sided limits,
monotonicity, and classification of discontinuities.
-/

import MiniMathKernel

open MiniMathKernel

namespace MiniContinuity

/-! ## Metric and order preliminaries

We assume a metric space structure on ℝ and ℝⁿ via the standard distance.
The absolute value `|x|` is the distance from x to 0.
-/

def abs (x : ℝ) : ℝ := if x ≥ 0 then x else -x

def dist (x y : ℝ) : ℝ := abs (x - y)

/-! ## Limit of a function (ε-δ definition) -/

/-- The limit of f(x) as x approaches a is L:
    ∀ ε > 0, ∃ δ > 0, 0 < |x - a| < δ → |f(x) - L| < ε -/
def limitOfFunction (f : ℝ → ℝ) (a L : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, 0 < dist x a ∧ dist x a < δ → dist (f x) L < ε

/-- Left-hand limit: limit as x → a⁻ -/
def leftHandLimit (f : ℝ → ℝ) (a L : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, x < a ∧ dist x a < δ → dist (f x) L < ε

/-- Right-hand limit: limit as x → a⁺ -/
def rightHandLimit (f : ℝ → ℝ) (a L : ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x, x > a ∧ dist x a < δ → dist (f x) L < ε

/-- One-sided limit exists (either side) -/
inductive oneSidedLimit (f : ℝ → ℝ) (a : ℝ) : Type
  | left  (L : ℝ) : leftHandLimit f a L → oneSidedLimit f a
  | right (L : ℝ) : rightHandLimit f a L → oneSidedLimit f a

/-! ## Continuity -/

/-- f is continuous at a point a: lim_{x→a} f(x) = f(a) -/
def isContinuousAt (f : ℝ → ℝ) (a : ℝ) : Prop :=
  limitOfFunction f a (f a)

/-- f is continuous on a set A: continuous at every point of A -/
def isContinuousOn (f : ℝ → ℝ) (A : Set ℝ) : Prop :=
  ∀ a ∈ A, isContinuousAt f a

/-- f is continuous on all of ℝ -/
def isContinuous (f : ℝ → ℝ) : Prop :=
  ∀ a : ℝ, isContinuousAt f a

/-- f is uniformly continuous on A -/
def isUniformlyContinuousOn (f : ℝ → ℝ) (A : Set ℝ) : Prop :=
  ∀ ε > 0, ∃ δ > 0, ∀ x ∈ A, ∀ y ∈ A, dist x y < δ → dist (f x) (f y) < ε

/-- f is uniformly continuous on all of ℝ -/
def isUniformlyContinuous (f : ℝ → ℝ) : Prop :=
  isUniformlyContinuousOn f Set.univ

/-! ## Lipschitz and Holder continuity -/

/-- f is K-Lipschitz: |f(x) - f(y)| ≤ K·|x - y| -/
def isLipschitzWith (f : ℝ → ℝ) (K : ℝ) : Prop :=
  K ≥ 0 ∧ ∀ x y, dist (f x) (f y) ≤ K * dist x y

/-- f is Lipschitz for some K -/
def isLipschitz (f : ℝ → ℝ) : Prop :=
  ∃ K, isLipschitzWith f K

/-- f is α-Holder continuous: |f(x) - f(y)| ≤ C·|x - y|^α -/
def isHolderContinuousWith (f : ℝ → ℝ) (C α : ℝ) : Prop :=
  C ≥ 0 ∧ α > 0 ∧ ∀ x y, dist (f x) (f y) ≤ C * (dist x y) ^ α

/-- f is Holder continuous for some C, α -/
def isHolderContinuous (f : ℝ → ℝ) (α : ℝ) : Prop :=
  ∃ C, isHolderContinuousWith f C α

/-! ## Monotonicity -/

/-- f is monotone increasing: x ≤ y → f(x) ≤ f(y) -/
def isMonotoneIncreasing (f : ℝ → ℝ) : Prop :=
  ∀ x y, x ≤ y → f x ≤ f y

/-- f is monotone decreasing: x ≤ y → f(x) ≥ f(y) -/
def isMonotoneDecreasing (f : ℝ → ℝ) : Prop :=
  ∀ x y, x ≤ y → f x ≥ f y

/-- f is strictly increasing -/
def isStrictlyIncreasing (f : ℝ → ℝ) : Prop :=
  ∀ x y, x < y → f x < f y

/-- f is strictly decreasing -/
def isStrictlyDecreasing (f : ℝ → ℝ) : Prop :=
  ∀ x y, x < y → f x > f y

/-! ## Classification of discontinuities -/

/-- A removable discontinuity: the limit exists but doesn't equal f(a) -/
def removableDiscontinuity (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ¬ isContinuousAt f a ∧ ∃ L, limitOfFunction f a L

/-- A jump discontinuity: left and right limits exist but are different -/
def jumpDiscontinuity (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ∃ L R, leftHandLimit f a L ∧ rightHandLimit f a R ∧ L ≠ R

/-- An essential discontinuity: neither left nor right limit exists -/
def essentialDiscontinuity (f : ℝ → ℝ) (a : ℝ) : Prop :=
  ¬ (∃ L, leftHandLimit f a L) ∧ ¬ (∃ R, rightHandLimit f a R)

/-- Discontinuity classification type -/
inductive DiscontinuityType (f : ℝ → ℝ) (a : ℝ) : Type
  | removable : removableDiscontinuity f a → DiscontinuityType f a
  | jump      : jumpDiscontinuity f a → DiscontinuityType f a
  | essential : essentialDiscontinuity f a → DiscontinuityType f a

/-! ## #eval Tests -/

#eval "Core.Basic: limitOfFunction, isContinuousAt, isContinuousOn, isUniformlyContinuousOn"
#eval "Core.Basic: isLipschitz, isHolderContinuous, oneSidedLimit, DiscontinuityType"
#eval "Core.Basic: isMonotoneIncreasing, isMonotoneDecreasing, isStrictlyIncreasing, isStrictlyDecreasing"

end MiniContinuity
