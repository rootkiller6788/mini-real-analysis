/-
# Morphism Tests: Isometries, Contractions, Homeomorphisms
-/

import MiniMetricTopology

open MiniMetricTopology

#eval "=== Test: Identity isometry ==="
def idIso : Isometry ℝ ℝ := idIsometry ℝ
#eval idIso.distPreserving 3 5

#eval "=== Test: Contraction (x ↦ x/2) ==="
def halfCont : ContractionMapping ℝ where
  f := λ x => x / 2
  k := 1/2
  hk_pos := by norm_num
  hk_lt_one := by norm_num
  contract := by
    intro x y; dsimp
    calc
      |x/2 - y/2| = |(x - y)/2| := by ring
      _ = (1/2) * |x - y| := by
        rw [abs_div, abs_of_pos (by norm_num : (0 : ℝ) < 2)]
        ring
#eval halfCont.k

#eval "=== Test: Bi-Lipschitz equivalence ==="
-- Scale by 2 is bi-Lipschitz
#eval d ((2*3 : ℝ)) ((2*7 : ℝ))

#eval "=== Test: Discrete metric ==="
def discMetric : MetricSpace (Fin 5) := discreteMetricSpace (Fin 5)
#eval d (Fin.ofNat 0 : Fin 5) (Fin.ofNat 3 : Fin 5)
#eval d (Fin.ofNat 2 : Fin 5) (Fin.ofNat 2 : Fin 5)

#eval "=== Test: Distance matrix ==="
def dm : DistanceMatrix 3 where
  D := λ i j => if i = j then 0 else 1
  diagonal_zero := by intro i; simp
  symmetric := by intro i j; by_cases h : i = j; simp [h]; simp [h]
  triangle_inequality := by
    intro i j k; by_cases hik : i = k; simp [hik]; by_cases hij : i = j; simp [hij];
    by_cases hjk : j = k; simp [hjk]; simp [hik, hij, hjk]
#eval dm.D 0 1
#eval dm.D 0 2
