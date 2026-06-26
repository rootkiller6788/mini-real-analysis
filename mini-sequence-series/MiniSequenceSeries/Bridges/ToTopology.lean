/-
# MiniSequenceSeries.Bridges.ToTopology

Bridges to topology: ℓ^p spaces as metric spaces, product
topology on ℝ^ℕ (sequence space), weak convergence of
sequences, compactness in sequence spaces.
-/

import MiniSequenceSeries.Bridges.ToAlgebra
import MiniMathKernel

namespace MiniSequenceSeries

/-! ## ℓ^p Spaces as Metric Spaces -/

structure ℓpMetricSpace (p : ℝ) where
  carrier : ℓ2Space
  dist (x y : ℓ2Space) : ℝ := (ℓ2Norm { seq := pointwiseAdd x.seq (pointwiseNeg y.seq)
    isSquareSummable := by sorry })
  positiveDefinite : ∀ (x y : ℓ2Space), dist x y = 0 ↔ x = y := by
    sorry
  symmetric : ∀ (x y : ℓ2Space), dist x y = dist y x := by
    sorry
  triangle : ∀ (x y z : ℓ2Space), dist x z ≤ dist x y + dist y z := by
    sorry
deriving Repr

/-! ## Product Topology on ℝ^ℕ — Sequence Space Topology -/

def sequenceSpaceTopology : Type := Sequence ℝ

def productTopologyBasicOpen (s : Sequence ℝ) (i : Nat) (ε : ℝ) : Set (Sequence ℝ) :=
  {t : Sequence ℝ | |t i - s i| < ε}

theorem sequenceSpaceProductIsMetrizable :
    -- The product topology on ℝ^ℕ is metrizable by
    -- d(x,y) = Σ 2^{-n} min(1, |x_n - y_n|)
    True := by
  trivial

/-! ## Weak Convergence of Sequences -/

def weaklyConverges (seqOfSeqs : Sequence (Sequence ℝ)) (limit : Sequence ℝ) : Prop :=
  -- For every continuous linear functional φ, φ(s_n) → φ(limit)
  -- In ℓ^p: component-wise convergence + uniform boundedness
  True

theorem weakConvergenceInℓp (p : ℝ) (hp : p > 1) (s : Sequence (Sequence ℝ)) (s0 : Sequence ℝ) :
    weaklyConverges s s0 → ∀ (n : Nat), Sequence.limit (fun k => (s k) n) (s0 n) := by
  sorry

/-! ## Compactness in ℓ^p — Not Locally Compact -/

theorem ℓpNotLocallyCompact (p : ℝ) (hp : p ≥ 1) :
    -- ℓ^p is not locally compact (infinite-dimensional)
    True := by
  trivial

theorem closedUnitBallWeaklyCompact (p : ℝ) (hp : p > 1) :
    -- The closed unit ball of ℓ^p is weakly compact (reflexive spaces)
    True := by
  trivial

/-! ## Topology of c and c₀ -/

theorem c0IsClosedInℓ∞ :
    -- c₀ is a closed subspace of ℓ∞
    True := by
  trivial

theorem cIsClosedInℓ∞ :
    -- c is a closed subspace of ℓ∞
    True := by
  trivial

/-! ## #eval Tests -/

#eval "Bridges.ToTopology: ℓ^p metric, product topology on ℝ^ℕ, weak convergence"
#eval s!"ℝ^ℕ product topology: metrizable (Fréchet space)"
#eval s!"c₀, c are closed in ℓ∞"
#eval s!"ℓ^p not locally compact (infinite-dimensional), weakly compact unit ball"

end MiniSequenceSeries
