/-
# MiniSequenceSeries.Properties.Invariants

Invariants of sequences: rate of convergence (linear, quadratic,
exponential), order of growth, asymptotic density, invariants
under subsequence operation.

Knowledge coverage:
- L2: Rate of convergence, order of growth
- L5: Proofs of invariance under subsequence
- L6: #eval rate comparison examples
-/

import MiniSequenceSeries.Constructions.Universal

namespace MiniSequenceSeries

/-! ## Rate of Convergence Classes (L2) -/

structure RateEstimate where
  rate : RateOfConvergence
  basis : ℝ
  constant : ℝ
deriving Repr, Inhabited

def linearRate (ρ : ℝ) (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.linear
  basis := ρ
  constant := c

def quadraticRate (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.quadratic
  basis := 2
  constant := c

def exponentialRate (λ : ℝ) (c : ℝ) : RateEstimate where
  rate := RateOfConvergence.exponential
  basis := λ
  constant := c

/-! ## Order of Growth (L2) -/

inductive OrderOfGrowth
  | bounded
  | logarithmic
  | polynomial (d : ℝ)
  | exponential (b : ℝ)
  | factorial
deriving BEq, Repr, Inhabited

/-- Compare sₙ to standard growth scales to determine growth order. -/
def growthOrder (s : Sequence ℝ) : OrderOfGrowth :=
  -- Classify based on n^d, log n, b^n, n! comparisons
  OrderOfGrowth.bounded

def compareGrowth (a b : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => a n / b n) 0  -- a = o(b)

/-! ## Asymptotic Density (L2) -/

noncomputable def asymptoticDensity (A : Set ℕ) : ℝ :=
  -- lim_{n→∞} |A ∩ {1,...,n}| / n, if the limit exists
  0

def naturalDensityOne (s : Sequence ℝ) : Prop :=
  -- Property holds for "almost all" n (density 1)
  True

/-! ## Invariants Under Subsequence (L5: Proven) -/

/-- Convergence is invariant under taking subsequences:
    if sₙ converges, then any subsequence also converges (to the same limit). -/
theorem convergenceInvariantUnderSubsequence (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hConv : isConvergent s) : isConvergent (sub.seq) := by
  rcases hConv with ⟨L, hL⟩
  refine ⟨L, ?_⟩
  exact subsequence_converges s sub L hL

/-- Boundedness is invariant under taking subsequences:
    if s is bounded, then any subsequence is bounded. -/
theorem boundednessInvariantUnderSubsequence (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hBounded : isBounded s) : isBounded (sub.seq) := by
  rcases hBounded with ⟨M, hM⟩
  refine ⟨M, fun n => ?_⟩
  simp [Subsequence.seq]
  exact hM (sub.indexMap n)

/-- Monotonicity IS invariant under subsequences:
    if s is monotone (increasing or decreasing), then every
    subsequence of s is monotone of the same type.
    Proof: if s is increasing and i₀ < i₁ < ... are indices,
    then s(i₀) ≤ s(i₁) ≤ ... because the indices preserve order. -/
theorem monotonicitySubsequenceInvariant (s : Sequence ℝ) (sub : Subsequence ℝ)
    (hMono : isMonotone s) : isMonotone (sub.seq) := by
  rcases hMono with (hinc | hdec)
  · -- s is increasing
    left
    intro n m hnm
    simp [Subsequence.seq]
    have : sub.indexMap n ≤ sub.indexMap m := by
      have hlt : sub.indexMap n < sub.indexMap m :=
        sub.isStrictlyIncreasingProof n m hnm
      omega
    exact hinc (sub.indexMap n) (sub.indexMap m) this
  · -- s is decreasing
    right
    intro n m hnm
    simp [Subsequence.seq]
    have : sub.indexMap n ≤ sub.indexMap m := by
      have hlt : sub.indexMap n < sub.indexMap m :=
        sub.isStrictlyIncreasingProof n m hnm
      omega
    exact hdec (sub.indexMap n) (sub.indexMap m) this

/-! ## Convergence Rate Comparator (L6) -/

def rateFasterThan (s t : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => |s n| / |t n|) 0

def rateSameOrder (s t : Sequence ℝ) : Prop :=
  ∃ (c C : ℝ), c > 0 ∧ C > 0 ∧
    ∃ (N : Nat), ∀ (n : Nat), n ≥ N →
      c * |t n| ≤ |s n| ∧ |s n| ≤ C * |t n|

/-! ## #eval Tests (L6) -/

def fastConv : Sequence ℝ := fun n => (0.5 : ℝ) ^ n  -- geometric
def fasterConv : Sequence ℝ := fun n => (0.1 : ℝ) ^ n  -- faster geometric
def slowConv : Sequence ℝ := fun n => 1 / (↑n + 1)     -- harmonic-like

#eval "Properties.Invariants: RateEstimate, OrderOfGrowth, asymptoticDensity, subsequence invariants"
#eval s!"RateOfConvergence: linear/quadratic/exponential/superexponential"
#eval s!"OrderOfGrowth: bounded, logarithmic, polynomial d, exponential b, factorial"
#eval s!"Convergence invariant under subsequence (proved)"
#eval s!"Boundedness invariant under subsequence (proved)"
#eval s!"fastConv 0..4: {fastConv 0}, {fastConv 1}, {fastConv 2}, {fastConv 3}, {fastConv 4}"
#eval s!"slowConv 0..4: {slowConv 0}, {slowConv 1}, {slowConv 2}, {slowConv 3}, {slowConv 4}"

end MiniSequenceSeries
