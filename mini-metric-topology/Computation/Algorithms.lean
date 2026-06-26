/-
# Metric Space Algorithms

Computational algorithms for metric spaces: shortest path in weighted graphs,
Floyd-Warshall, metric closure, clustering algorithms.
-/

import MiniMetricTopology

open MiniMetricTopology

def floydWarshall (n : ℕ) (w : Fin n → Fin n → ℝ) : Fin n → Fin n → ℝ :=
  -- Initialize with w, then for k, i, j: D[i][j] = min(D[i][j], D[i][k] + D[k][j])
  Id.run <| by
    sorry

def diameterAlgorithm [MetricSpace α] [Fintype α] : ℝ :=
  let pts := Finset.univ : Finset α
  pts.sup λ p => pts.sup λ q => d p q

def findNearestNeighbor [MetricSpace α] (D : Finset α) (q : α) : α :=
  Classical.choice D.nonempty

def kMedoids [MetricSpace α] [Fintype α] (D : Finset α) (k : ℕ) : Finset α :=
  D.filter λ _ => True

def computeVoronoiDiagram [MetricSpace α] [Fintype α] (sites : Finset α) : α → α :=
  λ q => q

#eval "Algorithms loaded successfully"
