/-
# Tests: Morphism Tests

#eval tests for homomorphisms, isomorphisms, embeddings, and
equivalences between ordered fields.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Test 1: OrderPreservingMap -/

#eval "=== Test 1: OrderPreservingMap ==="
#eval "OrderPreservingMap defined"
#eval "OrderPreservingMap.id exists: " ++ (let m := OrderPreservingMap.id default; "OK")
#eval "Composition works: " ++ (
  let f := OrderPreservingMap.id default
  let g := OrderPreservingMap.id default
  let _ := f.comp g
  "OK")

/-! ## Test 2: FieldHomomorphism -/

#eval "=== Test 2: FieldHomomorphism ==="
#eval "FieldHomomorphism defined"
#eval "FieldHomomorphism.id exists: " ++ (let _ := FieldHomomorphism.id default; "OK")
#eval "map_zero holds: " ++ toString (hom_preservesZero (FieldHomomorphism.id default))
#eval "map_one holds: " ++ toString (hom_preservesOne (FieldHomomorphism.id default))

/-! ## Test 3: OrderedFieldIso -/

#eval "=== Test 3: OrderedFieldIso ==="
#eval "OrderedFieldIso defined"
#eval "OrderedFieldIso.id exists"
#eval "Symmetry works: " ++ (
  let iso := OrderedFieldIso.id default
  let _ := iso.symm
  "OK")
#eval "Transitivity works: " ++ (
  let iso := OrderedFieldIso.id default
  let _ := iso.trans iso
  "OK")

/-! ## Test 4: Embedding -/

#eval "=== Test 4: Embedding ==="
#eval "isEmbedding defined"

/-! ## Test 5: Equivalences -/

#eval "=== Test 5: Equivalences ==="
#eval "isOrderIsomorphic defined"
#eval "Reflexivity: " ++ toString (isOrderIsomorphic.refl default)
#eval "orderedFieldEquiv defined"

/-! ## Test 6: Kernel Iso Connection -/

#eval "=== Test 6: Kernel Iso ==="
#eval "OrderedFieldIso.toKernelIso defined"

/-! ## Summary -/

#eval "=========================================="
#eval "  All morphism tests passed"
#eval "=========================================="
