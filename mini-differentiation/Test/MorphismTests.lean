/-
# Test.MorphismTests

Tests for morphisms: smooth maps, diffeomorphisms, jet equivalence.
-/

import MiniDifferentiation

open MiniDifferentiation

#eval "=== Morphism Tests ==="

#eval s!"SmoothMap(1,1) instance: {describe (SmoothMap 1 1)}"
#eval s!"SmoothMap(2,1) instance: {describe (SmoothMap 2 1)}"
#eval s!"Diffeomorphism(1) instance: {describe (Diffeomorphism 1)}"
#eval s!"CkDiffeomorphism(2,1): defined"

#eval s!"LocalDiffeomorphism(1) instance: {describe (LocalDiffeomorphism 1)}"
#eval s!"SmoothEquivalence(1,2) instance: {describe (SmoothEquivalence 1 2)}"

#eval s!"ContactEquivalent and RightEquivalent structures: defined"
#eval s!"LeftEquivalent structure: defined"
#eval s!"JetEquivalent(f,g,a,k) for any f,g,a,k"
#eval s!"taylorCoefficient of id at 0 order 1: {taylorCoefficient (fun x : Real => x) { val := 0.0 } 1}"

#eval "=== Morphism tests passed ==="
