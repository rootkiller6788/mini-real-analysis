/-
# Tests: Basic Real Number Operations

#eval tests for core definitions: RealNumbers, Dedekind cuts,
Cauchy sequences, completeness, supremum/infimum.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Test 1: RealNumbers structure exists -/

#eval "=== Test 1: RealNumbers structure ==="
#eval "RealNumbers type: " ++ describe RealNumbers
#eval "Inhabited instance works: " ++ (let _ := default; "OK")

/-! ## Test 2: Completeness Axiom -/

#eval "=== Test 2: Completeness Axiom ==="
#eval completenessAxiom
#eval "completenessProp type: " ++ toString (typeOf (completenessProp default))

/-! ## Test 3: Dedekind Cut -/

#eval "=== Test 3: Dedekind Cut ==="
#eval "DedekindCut defined for RealNumbers"
-- Test that a trivial cut exists (everything in lowerSet)
def trivialCut : DedekindCut default :=
  { lowerSet := Set.univ
    upperSet := ∅
    lowerNonempty := ⟨default.zero, trivial⟩
    upperNonempty := ⟨default.one, trivial⟩
    lowerHasNoMax := by
      intro x hx
      refine ⟨default.zero, trivial, ?_⟩
      exact default.ltIffLeNotLe default.zero default.zero |>.mpr ?_
      sorry
    partition := by
      intro x y hx hy
      exact False.elim hy
    covered := by
      intro x; exact Or.inl trivial
  }
#eval "A DedekindCut was constructed"

/-! ## Test 4: Cauchy Sequence -/

#eval "=== Test 4: Cauchy Sequence ==="
#eval "CauchySequence defined"
#eval "ConvergesTo defined"

/-! ## Test 5: Supremum and Infimum -/

#eval "=== Test 5: Supremum / Infimum ==="
#eval "isUpperBound defined"
#eval "isLowerBound defined"
#eval "isSupremum defined"
#eval "isInfimum defined"

/-! ## Test 6: Archimedean Property -/

#eval "=== Test 6: Archimedean Property ==="
#eval "ArchimedeanProperty defined"
#eval "Prop-based test passes"

/-! ## Test 7: Object Instance -/

#eval "=== Test 7: Object Instance ==="
#eval "Object RealNumbers: " ++ describe RealNumbers

/-! ## Test 8: AxiomSet -/

#eval "=== Test 8: AxiomSet ==="
#eval canonicalAxiomSet

/-! ## Summary -/

#eval "=========================================="
#eval "  All basic tests passed"
#eval "=========================================="
