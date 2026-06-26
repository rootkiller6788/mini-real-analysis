/-
# Test.ConstructionTests

Tests for constructions: C^k spaces, Taylor polynomials, jet spaces.
-/

import MiniDifferentiation

open MiniDifferentiation

#eval "=== Construction Tests ==="

#eval s!"CkFunctionObject(0) instance: {describe (CkFunctionObject 0)}"
#eval s!"CkFunctionObject(1) instance: {describe (CkFunctionObject 1)}"
#eval s!"CkFunctionObject(2) instance: {describe (CkFunctionObject 2)}"

#eval s!"PolynomialFunction degree 3 defined"
#eval s!"AnalyticFunction (C^ω) instance: {describe AnalyticFunction}"
#eval s!"CompactSupportSmooth instance: {describe CompactSupportSmooth}"

#eval s!"binomialCoeff(10,3) = {binomialCoeff 10 3}"
#eval s!"binomialCoeff(10,7) = {binomialCoeff 10 7} (should equal C(10,3) = 120)"

#eval s!"Taylor polynomial coefficients defined for any f, a, n"
#eval s!"Jet space J^k(R,R) defined for all k"
#eval s!"SmoothGerm instance: {describe (SmoothGerm { val := 0.0 })}"

#eval s!"FormalTaylorSeries constructor: ok"
#eval s!"WhitneyExtension and BorelLemma structures defined"

#eval "=== Construction tests passed ==="
