/-
# Evaluation Utilities for Metric Spaces

Helper functions for computing metric invariants and properties
on concrete finite metric spaces.
-/

import MiniMetricTopology

open MiniMetricTopology

def evaluateMetric [MetricSpace α] [Fintype α] (pts : Finset α) : IO Unit := do
  IO.println s!"Evaluating metric space with {pts.card} points"
  for p1 in pts do
    for p2 in pts do
      let dist := d p1 p2
      IO.println s!"  d({p1}, {p2}) = {dist}"
  let diam := computeDiameter
  IO.println s!"  Diameter = {diam}"

def evaluateFiniteMetricSpace : IO Unit := do
  let pts : Finset (Fin 3) := Finset.univ
  evaluateMetric (α := Fin 3) pts

def evaluateCompletion (x : ℝ) : IO Unit := do
  let comp := completionEmbedding
  IO.println s!"Embedded {x} into completion: {comp.f x}"

#eval "Evaluation utilities loaded"
#eval evaluateFiniteMetricSpace
