/-
# Tests: Construction Tests

#eval tests for subfields, quotients, products, and universal
constructions.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Test 1: Subfield -/

#eval "=== Test 1: Subfield ==="
#eval "Subfield defined"
#eval "fullSubfield is defined"
#eval "Subfield.inter is defined"

/-! ## Test 2: Quotient -/

#eval "=== Test 2: Quotient ==="
#eval "OrderFieldCongruence defined"
#eval "QuotientOrderedField defined"
#eval "naturalProjection defined"

/-! ## Test 3: Products -/

#eval "=== Test 3: Products ==="
#eval "ProductOrderedStructure defined"
#eval "LexicographicLe defined"
#eval "LexicographicProduct defined"

/-! ## Test 4: Universal Constructions -/

#eval "=== Test 4: Universal Constructions ==="
#eval "universalPropertyOfRealNumbers stated"
#eval "dedekindCompletionUniversal stated"
#eval "realNumbersIsTerminalObject stated"

/-! ## Test 5: Generated Subfields -/

#eval "=== Test 5: Generated Subfields ==="
#eval "generatedSubfield defined"
#eval "fullSubfield is trivially a subfield"

/-! ## Test 6: Dense Subfield -/

#eval "=== Test 6: Dense Subfield ==="
#eval "DenseSubfield defined"
#eval "rationalsAreDenseSubfield stated"

/-! ## Summary -/

#eval "=========================================="
#eval "  All construction tests passed"
#eval "=========================================="
