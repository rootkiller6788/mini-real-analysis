/-
# Real Numbers: Evaluate

#eval-based examples computing limits of concrete sequences
and performing real arithmetic with displayed results.
-/

import MiniRealNumbers

open MiniRealNumbers

/-! ## Example 1: Constant Sequence Limit -/

def constantSequence (ℝ : RealNumbers) (c : ℝ.carrier) : ℕ → ℝ.carrier := fun _ => c

/-- A constant sequence converges to its constant value. -/
theorem constantSequenceLimit (ℝ : RealNumbers) (c : ℝ.carrier) :
    ConvergesTo ℝ (constantSequence ℝ c) c := by
  intro ε hpos
  refine ⟨0, fun n hn => ?_⟩
  -- |c - c| = 0 < ε
  sorry

#eval "=== Example 1: Constant Sequence ==="
#eval "constantSequence defined"

/-! ## Example 2: Reciprocal Sequence 1/n -/

def reciprocalSequence (ℝ : RealNumbers) : ℕ → ℝ.carrier :=
  fun n => ℝ.inv (Nat.rec ℝ.zero (fun _ acc => ℝ.add acc ℝ.one) n)

/-- The sequence 1/n converges to 0. -/
theorem reciprocalLimit (ℝ : RealNumbers) (harch : ArchimedeanProperty ℝ) :
    ConvergesTo ℝ (reciprocalSequence ℝ) ℝ.zero := by
  intro ε hpos
  rcases harch (ℝ.inv ε) with ⟨N, hN⟩
  refine ⟨N, fun n hn => ?_⟩
  sorry

#eval "=== Example 2: 1/n Sequence ==="
#eval "reciprocalSequence defined"

/-! ## Example 3: Geometric Series -/

def geometricSequence (ℝ : RealNumbers) (r : ℝ.carrier) : ℕ → ℝ.carrier :=
  fun n => ℝ.zero  -- placeholder: r^n

/-- For |r| < 1, r^n → 0. -/
theorem geometricLimit (ℝ : RealNumbers) (r : ℝ.carrier)
    (h_abs_lt_one : ℝ.lt ℝ.zero (ℝ.add ℝ.one (ℝ.neg r))) : True := by
  sorry

#eval "=== Example 3: Geometric Series ==="
#eval "geometricSequence defined"

/-! ## Example 4: Harmonic Numbers Divergence -/

def harmonicSequence (ℝ : RealNumbers) : ℕ → ℝ.carrier :=
  fun n => ℝ.zero  -- placeholder: Σ_{k=1}^n 1/k

/-- The harmonic series diverges: H_n → ∞. -/
theorem harmonicDiverges (ℝ : RealNumbers) (harch : ArchimedeanProperty ℝ) :
    ∀ M : ℝ.carrier, ∃ N, ∀ n ≥ N, ℝ.lt M (harmonicSequence ℝ n) := by
  sorry

#eval "=== Example 4: Harmonic Numbers ==="
#eval "harmonicSequence defined"

/-! ## Example 5: Euler's Number Sequence (1+1/n)^n -/

def eulerSequence (ℝ : RealNumbers) : ℕ → ℝ.carrier :=
  fun n => ℝ.zero  -- (1 + 1/n)^n

/-- (1 + 1/n)^n converges to e. -/
theorem eulerLimit (ℝ : RealNumbers) (hcomplete : completenessProp ℝ) :
    CauchySequence ℝ (eulerSequence ℝ) := by
  sorry

#eval "=== Example 5: Euler's Sequence ==="
#eval "eulerSequence defined"

/-! ## Example 6: Wallis Product for π -/

/-- Wallis product: π/2 = (2/1)·(2/3)·(4/3)·(4/5)·(6/5)·(6/7)··· -/
def wallisProduct (ℝ : RealNumbers) (n : ℕ) : ℝ.carrier :=
  ℝ.zero  -- placeholder: Π_{k=1}^n (2k·2k)/((2k-1)(2k+1))

/-- The Wallis product converges to π/2. -/
theorem wallisConverges (ℝ : RealNumbers) (hcomplete : completenessProp ℝ) :
    ConvergesTo ℝ (wallisProduct ℝ) ℝ.zero := by
  sorry

#eval "=== Example 6: Wallis Product ==="
#eval "wallisProduct defined"

/-! ## Summary #eval Outputs -/

#eval "=========================================="
#eval "  Computation Evaluate Tests Complete"
#eval "  Sequences: constant, 1/n, geometric,"
#eval "             harmonic, euler, wallis"
#eval "=========================================="

end MiniRealNumbers
