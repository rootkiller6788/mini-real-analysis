/-
# Basic Tests: Metric Spaces, Balls, Open/Closed Sets
-/

import MiniMetricTopology

open MiniMetricTopology

#eval "=== Test: MetricSpace on ℝ ==="
#eval d (3 : ℝ) (7 : ℝ)

#eval "=== Test: Open ball ==="
#eval ball (0 : ℝ) 1

#eval "=== Test: Closed ball ==="
#eval closedBall (5 : ℝ) 3

#eval "=== Test: Sphere ==="
#eval sphere (0 : ℝ) 1

#eval "=== Test: isOpen ==="
#eval isOpen (Set.univ : Set ℝ)

#eval "=== Test: isClosed ==="
#eval isClosed (Set.univ : Set ℝ)

#eval "=== Test: Product metric ==="
#eval d ((3, 5) : ℝ × ℝ) ((7, 9) : ℝ × ℝ)

#eval "=== Test: Subspace metric ==="
def nonneg : Set ℝ := {x | x ≥ 0}
#eval d (⟨3, by norm_num⟩ : nonneg) (⟨7, by norm_num⟩ : nonneg)
