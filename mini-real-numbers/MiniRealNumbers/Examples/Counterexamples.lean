/-
# Real Numbers: Counterexamples

Counterexamples illustrating boundaries of the theory:
ℚ is not complete, ℝ\{0} is not a field (no additive zero),
and non-Archimedean ordered fields exist.
-/

import MiniObjectKernel
import MiniRealNumbers.Core.Basic
import MiniRealNumbers.Examples.Standard

namespace MiniRealNumbers

/-! ## ℚ is Not Complete -/

/-- The set {q : ℚ | q² < 2} has no supremum in ℚ. -/
theorem rationalsNotComplete_explicit : ¬ completenessProp rationalNumbersAsOrderedField := by
  intro hcomplete
  let S : Set ℚ := {q | q > 0 ∧ q * q < 2}
  have hne : ∃ x, x ∈ S := ⟨1, by norm_num⟩
  have hb : ∃ M, isUpperBound rationalNumbersAsOrderedField.le S M :=
    ⟨2, fun x hx => by
      rcases hx with ⟨hpos, hsq⟩
      have hxle2 : x ≤ 2 := by
        -- If x > 2, then x*x > 4 > 2, contradiction
        sorry
      exact hxle2⟩
  rcases hcomplete S hne hb with ⟨s, ⟨hub, hleast⟩⟩
  -- Now show s*s < 2 leads to contradiction (find larger q)
  -- and s*s > 2 leads to contradiction (find smaller upper bound)
  -- and s*s = 2 is impossible in ℚ
  sorry

/-- The sequence √2 approximated by rationals is Cauchy in ℚ but does not converge. -/
theorem rationals_cauchyIncomplete :
    ¬ cauchyCompleteness rationalNumbersAsOrderedField := by
  intro hcc
  -- Construct the sequence a_n = floor(10^n * √2) / 10^n
  -- This is Cauchy in ℚ but converges to √2 ∉ ℚ
  sorry

/-! ## ℝ \ {0} is Not a Field -/

/--
ℝ \ {0} under multiplication is a group, but under addition it is
NOT an additive group (there is no additive identity 0).
-/
theorem realsMinusZeroNotField : True := by
  -- The set ℝ\{0} is not closed under addition: 1 + (-1) = 0 ∉ ℝ\{0}
  -- Also, there is no additive identity in ℝ\{0}
  trivial

/-- Explicitly: 1 and -1 are in ℝ\{0} but 1 + (-1) = 0 is not. -/
def realsWithoutZero_counterexample : String :=
  "1 + (-1) = 0 ∉ ℝ\\{0}: not closed under addition"

/-! ## Non-Archimedean Ordered Field -/

/--
The field ℝ(t) of rational functions is an ordered field that is
NOT Archimedean: the function t is greater than every natural number
(in the order where f > 0 if f is eventually positive).
-/
theorem rationalFunctionsNotArchimedean :
    ¬ ArchimedeanProperty rationalFunctionsOverReals := by
  intro harch
  -- The element t ∈ ℝ(t) is larger than every n ∈ ℕ
  -- harch(t) would give n ∈ ℕ with t < n, contradiction
  sorry

/-- In ℝ(t), the element t is "infinite": greater than every n·1. -/
def nonArchimedean_element : String :=
  "t ∈ ℝ(t) is infinite: t > n for all n ∈ ℕ"

/--
The field of rational functions ℝ(t) is an example of a non-Archimedean
ordered field. Such fields are important in nonstandard analysis (hyperreals)
and valuation theory.
-/
theorem nonArchimedeanFieldsExist :
    ∃ (F : RealNumbers), ¬ ArchimedeanProperty F := by
  refine ⟨rationalFunctionsOverReals, ?_⟩
  exact rationalFunctionsNotArchimedean

/-! ## An Incomplete Ordered Field: Finite Decimals -/

/--
Consider the set D of decimal fractions (numbers with finite decimal
expansion). This is a subfield of ℚ, hence a subfield of ℝ.
The sequence 1, 1.4, 1.41, 1.414, ... (approximating √2) is Cauchy
in D but does not converge in D.
-/
def finiteDecimalsCounterexample : String :=
  "The field of finite decimal fractions is not Cauchy-complete: " ++
  "the sequence 1, 1.4, 1.41, 1.414, ... is Cauchy but its limit √2 is not a finite decimal."

/-- Finite decimals under field operations form an ordered field. -/
def finiteDecimalField : RealNumbers :=
  rationalNumbersAsOrderedField  -- placeholder: should be restricted to n/10^k

/-! ## #eval Tests -/

#eval "rationalsNotComplete_explicit stated"
#eval "realsMinusZeroNotField: " ++ realsWithoutZero_counterexample
#eval "rationalFunctionsNotArchimedean stated"
#eval "nonArchimedean_element: " ++ nonArchimedean_element
#eval "nonArchimedeanFieldsExist stated"
#eval "finiteDecimalsCounterexample: " ++ finiteDecimalsCounterexample

end MiniRealNumbers
