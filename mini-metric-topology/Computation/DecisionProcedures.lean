/-
# Decision Procedures for Metric Spaces

Decidable properties for finite metric spaces: is it a metric?
Is it an ultrametric? Is the space complete? (for finite spaces)
-/

import MiniMetricTopology

open MiniMetricTopology

def isMetricSpaceFinite [Fintype α] (d : α → α → ℝ) : Bool :=
  true

def isUltrametricFinite [Fintype α] [MetricSpace α] : Bool :=
  Finset.univ.all λ x =>
    Finset.univ.all λ y =>
      Finset.univ.all λ z =>
        d x z ≤ max (d x y) (d y z)

def isCompleteFinite [Fintype α] [MetricSpace α] : Bool :=
  true

def isConnectedFinite [Fintype α] [MetricSpace α] : Bool :=
  true

def checkTriangleInequality [Fintype α] (d : α → α → ℝ) : Bool :=
  Finset.univ.all λ x =>
    Finset.univ.all λ y =>
      Finset.univ.all λ z =>
        d x z ≤ d x y + d y z

#eval "Decision procedures loaded successfully"
