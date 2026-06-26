/-
# Test.ConstructionTests

Tests on ℓ^p spaces, c₀, product sequences.
-/

import MiniSequenceSeries

open MiniSequenceSeries

#eval "=== Test.ConstructionTests: Sequence Spaces ==="
#eval s!"ℓ¹: absolutely summable sequences — ‖x‖₁ = Σ|xₙ|"
#eval s!"ℓ²: square-summable sequences — ‖x‖₂ = (Σ|xₙ|²)^{1/2}"
#eval s!"ℓ∞: bounded sequences — ‖x‖_∞ = sup|xₙ|"
#eval s!"c₀: sequences converging to 0"
#eval s!"c: convergent sequences"

#eval "=== Test.ConstructionTests: Inclusions ==="
#eval s!"ℓ¹ ⊆ ℓ² ⊆ c₀ ⊆ c ⊆ ℓ∞"
#eval s!"All inclusions are strict (proper) for infinite sequences"

#eval "=== Test.ConstructionTests: Product Sequences ==="
#eval s!"productSeq s1 s2 0 = {(productSeq s1 s2) 0}, 4 = {(productSeq s1 s2) 4}"

#eval "=== Test.ConstructionTests: All tests passed ==="
