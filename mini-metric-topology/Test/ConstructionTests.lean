/-
# Construction Tests: Products, Subspaces, Completions
-/

import MiniMetricTopology

open MiniMetricTopology

#eval "=== Test: Product Metric ℓ¹ ==="
#eval d ((1, 2) : ℝ × ℝ) ((4, 6) : ℝ × ℝ)

#eval "=== Test: Max Product Metric ==="
#eval d ((1, 2) : ℝ × ℝ) ((4, 1) : ℝ × ℝ)

#eval "=== Test: Subspace inclusion isometry ==="
def S : Set ℝ := {x | x ≥ 0}
def inclusion := subspaceInclusion ℝ S
#eval inclusion.distPreserving ⟨3, by norm_num⟩ ⟨7, by norm_num⟩

#eval "=== Test: Hausdorff distance ==="
#eval hausdorffDistance ({1, 3} : Set ℝ) ({5, 7} : Set ℝ)

#eval "=== Test: Cauchy sequence in ℝ ==="
#eval cauchySequence (λ n : ℕ => (0 : ℝ))

#eval "=== Test: Completion ==="
#eval Completion ℝ
