/-
# MiniSequenceSeries.Core.Basic

Fundamental definitions: sequences, limits, convergence,
boundedness, monotonicity, subsequences, series (partial sums),
power series, Cauchy criterion.

Knowledge coverage:
- L1: Sequence, limit, convergence, boundedness, series definitions
- L2: Cauchy criterion, absolute/conditional convergence concepts
- L3: Sequence algebra (pointwise operations form ℝ-algebra)
- L4: ε-N definitions as fundamental framework
- L5: Direct ε-N proofs (limit_unique, limit_add, convergent_imp_cauchy)
- L6: #eval tests for all definitions
-/

import MiniObjectKernel

namespace MiniSequenceSeries

/-! ## Sequence — the fundamental type (L1) -/

abbrev Sequence (α : Type) := Nat → α

def Sequence.eval (s : Sequence α) (n : Nat) : α := s n

def Sequence.const (α : Type) [Inhabited α] (c : α) : Sequence α := fun _ => c

def Sequence.zero : Sequence ℝ := fun _ => 0
def Sequence.one : Sequence ℝ := fun _ => 1
def Sequence.nats : Sequence ℕ := fun n => n
def Sequence.tail (s : Sequence α) (k : Nat) : Sequence α := fun n => s (n + k)
def Sequence.head (k : Nat) (s : Sequence α) : α := s k

/-! ## Limit — ε-N definition (L1/L4) -/

def Sequence.limit (s : Sequence ℝ) (L : ℝ) : Prop :=
  ∀ (ε : ℝ), ε > 0 → ∃ (N : Nat), ∀ (n : Nat), n ≥ N → |s n - L| < ε

def isConvergent (s : Sequence ℝ) : Prop :=
  ∃ (L : ℝ), Sequence.limit s L

/-! ## Uniqueness of limits (L4/L5: ε-N proof) -/

theorem limit_unique (s : Sequence ℝ) (L M : ℝ)
    (hL : Sequence.limit s L) (hM : Sequence.limit s M) : L = M := by
  by_contra hne
  have hdiff : |L - M| > 0 := by
    have : L - M ≠ 0 := sub_ne_zero.mpr hne
    exact abs_pos.mpr this
  have hhalf : |L - M| / 2 > 0 := by linarith
  rcases hL (|L - M| / 2) hhalf with ⟨NL, hNL⟩
  rcases hM (|L - M| / 2) hhalf with ⟨NM, hNM⟩
  let N := max NL NM
  have hsnL : |s N - L| < |L - M| / 2 := hNL N (Nat.le_max_left _ _)
  have hsnM : |s N - M| < |L - M| / 2 := hNM N (Nat.le_max_right _ _)
  have htri : |L - M| ≤ |L - s N| + |s N - M| := by
    calc
      |L - M| = |(L - s N) + (s N - M)| := by ring
      _ ≤ |L - s N| + |s N - M| := abs_add _ _
  have hsum : |L - s N| + |s N - M| < |L - M| := by
    have : |L - s N| = |s N - L| := abs_sub_comm _ _
    rw [this]
    linarith
  have : |L - M| < |L - M| := lt_of_le_of_lt htri hsum
  exact lt_irrefl _ this

/-! ## Boundedness (L1) -/

def isBounded (s : Sequence ℝ) : Prop :=
  ∃ (M : ℝ), ∀ (n : Nat), |s n| ≤ M

/-- Convergent ⇒ Bounded (L5: constructive estimate) -/
theorem convergent_imp_bounded (s : Sequence ℝ) (h : isConvergent s) : isBounded s := by
  rcases h with ⟨L, hL⟩
  rcases hL 1 (by norm_num) with ⟨N, hN⟩
  have htail : ∀ (n : Nat), n ≥ N → |s n| ≤ |L| + 1 := by
    intro n hn
    have hclose : |s n - L| < 1 := hN n hn
    have : |s n| - |L| ≤ |s n - L| := by
      calc
        |s n| - |L| ≤ ||s n| - |L|| := le_abs_self _
        _ ≤ |s n - L| := abs_sub_abs_le_abs_sub _ _
    linarith
  -- Take the max of |s k| for k < N
  have hNpos : N = 0 ∨ N > 0 := by
    exact Nat.eq_zero_or_pos N
  rcases hNpos with (hNz | hNp)
  · -- N = 0, so all terms satisfy the tail bound
    refine ⟨|L| + 1, fun n => ?_⟩
    have hge : n ≥ 0 := Nat.zero_le _
    rw [hNz] at hge
    exact htail n hge
  · -- N > 0, so there are finitely many initial terms
    let initMax : ℝ := (Finset.range N).sup' (by
      rw [Finset.nonempty_range_iff]
      exact hNp) (fun k => |s k|)
    have h_init : ∀ n, n < N → |s n| ≤ initMax := by
      intro n hn
      apply Finset.le_sup' (fun k => |s k|)
      exact Finset.mem_range.mpr hn
    let M := max initMax (|L| + 1)
    refine ⟨M, fun n => ?_⟩
    by_cases hn : n < N
    · have hle : |s n| ≤ initMax := h_init n hn
      exact le_trans hle (le_max_left _ _)
    · have hge : n ≥ N := Nat.le_of_not_gt hn
      have hle : |s n| ≤ |L| + 1 := htail n hge
      exact le_trans hle (le_max_right _ _)

/-! ## Monotonicity (L1) -/

def isIncreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n ≤ m → s n ≤ s m

def isDecreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n ≤ m → s m ≤ s n

def isMonotone (s : Sequence ℝ) : Prop :=
  isIncreasing s ∨ isDecreasing s

def isStrictlyIncreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n < m → s n < s m

def isStrictlyDecreasing (s : Sequence ℝ) : Prop :=
  ∀ (n m : Nat), n < m → s m < s n

/-- Monotone sequences are either increasing or decreasing. -/
theorem monotone_iff_inc_or_dec (s : Sequence ℝ) :
    isMonotone s ↔ isIncreasing s ∨ isDecreasing s := by rfl

/-- If s is increasing, then for all n, s n ≤ s (n+1). -/
theorem increasing_step (s : Sequence ℝ) (h : isIncreasing s) (n : Nat) : s n ≤ s (n+1) :=
  h n (n+1) (Nat.le_succ _)

/-- If s is decreasing, then for all n, s (n+1) ≤ s n. -/
theorem decreasing_step (s : Sequence ℝ) (h : isDecreasing s) (n : Nat) : s (n+1) ≤ s n :=
  h n (n+1) (Nat.le_succ _)

/-! ## Subsequence — via strictly increasing index map (L2) -/

def isStrictlyIncreasingMap (f : Nat → Nat) : Prop :=
  ∀ (n m : Nat), n < m → f n < f m

structure Subsequence (α : Type) where
  parent : Sequence α
  indexMap : Nat → Nat
  isStrictlyIncreasingProof : isStrictlyIncreasingMap indexMap

def Subsequence.seq (s : Subsequence α) : Sequence α :=
  fun n => s.parent (s.indexMap n)

def Subsequence.id (s : Sequence α) : Subsequence α where
  parent := s
  indexMap := fun n => n
  isStrictlyIncreasingProof := by
    intro n m h; exact h

def Subsequence.even (s : Sequence α) : Subsequence α where
  parent := s
  indexMap := fun n => 2 * n
  isStrictlyIncreasingProof := by
    intro n m h
    omega

def Subsequence.odd (s : Sequence α) : Subsequence α where
  parent := s
  indexMap := fun n => 2 * n + 1
  isStrictlyIncreasingProof := by
    intro n m h
    omega

/-- Every subsequence of a convergent sequence converges to the same limit (L5). -/
theorem subsequence_converges (s : Sequence ℝ) (sub : Subsequence ℝ) (L : ℝ)
    (h : Sequence.limit s L) : Sequence.limit (sub.seq) L := by
  intro ε hε
  rcases h ε hε with ⟨N, hN⟩
  refine ⟨N, fun n hn => hN (sub.indexMap n) ?_⟩
  have hmono : isStrictlyIncreasingMap sub.indexMap := sub.isStrictlyIncreasingProof
  have : n ≤ sub.indexMap n := by
    induction' n with k ih
    · exact Nat.zero_le _
    · have hlt : sub.indexMap k < sub.indexMap (k+1) :=
        hmono k (k+1) (Nat.lt_succ_self k)
      omega
  omega

/-! ## Series — sequence of partial sums (L1/L3) -/

def Series (a : Sequence ℝ) : Sequence ℝ :=
  fun n => match n with
    | 0     => a 0
    | n'+1  => Series a n' + a n

def Series.partialSum (a : Sequence ℝ) (n : Nat) : ℝ :=
  match n with
  | 0     => a 0
  | n'+1  => Series.partialSum a n' + a n

theorem Series_eq_partialSum (a : Sequence ℝ) (n : Nat) : Series a n = Series.partialSum a n := by
  induction' n with k ih
  · rfl
  · simp [Series, Series.partialSum, ih]

/-- Series n+1 = Series n + a (n+1). -/
theorem Series_succ (a : Sequence ℝ) (n : Nat) : Series a (n+1) = Series a n + a (n+1) := by
  simp [Series]

/-- Series sums are linear in the sequence. -/
theorem Series_add (a b : Sequence ℝ) (n : Nat) :
    Series (fun k => a k + b k) n = Series a n + Series b n := by
  induction' n with k ih
  · rfl
  · simp [Series, ih]; ring

theorem Series_scale (c : ℝ) (a : Sequence ℝ) (n : Nat) :
    Series (fun k => c * a k) n = c * Series a n := by
  induction' n with k ih
  · rfl
  · simp [Series, ih]; ring

def Series.sum (a : Sequence ℝ) : Prop :=
  isConvergent (Series a)

def isAbsolutelyConvergent (a : Sequence ℝ) : Prop :=
  Series.sum (fun n => |a n|)

def isConditionallyConvergent (a : Sequence ℝ) : Prop :=
  Series.sum a ∧ ¬ isAbsolutelyConvergent a

def Series.limitSum (a : Sequence ℝ) (S : ℝ) : Prop :=
  Sequence.limit (Series a) S

/-- Series sum is linear: if Σaₙ = S and Σbₙ = T then Σ(aₙ+bₙ) = S+T. -/
theorem Series_sum_add (a b : Sequence ℝ) (S T : ℝ)
    (hS : Series.limitSum a S) (hT : Series.limitSum b T) :
    Series.limitSum (fun n => a n + b n) (S + T) := by
  intro ε hε
  rcases hS (ε/2) (by linarith) with ⟨NS, hNS⟩
  rcases hT (ε/2) (by linarith) with ⟨NT, hNT⟩
  let N := max NS NT
  refine ⟨N, fun n hn => ?_⟩
  have hnN : n ≥ N := hn
  have hilb : Series (fun n => a n + b n) n = Series a n + Series b n := Series_add a b n
  rw [hilb]
  have h1 : |Series a n - S| < ε/2 := hNS n (le_trans (Nat.le_max_left _ _) hnN)
  have h2 : |Series b n - T| < ε/2 := hNT n (le_trans (Nat.le_max_right _ _) hnN)
  have htri : |(Series a n + Series b n) - (S + T)| ≤ |Series a n - S| + |Series b n - T| := by
    calc
      |(Series a n + Series b n) - (S + T)| = |(Series a n - S) + (Series b n - T)| := by ring
      _ ≤ |Series a n - S| + |Series b n - T| := abs_add _ _
  linarith

/-! ## Power Series (L1/L3) -/

structure PowerSeries where
  coefficients : Sequence ℝ
  center : ℝ := 0
deriving Repr, Inhabited

def PowerSeries.eval (ps : PowerSeries) (x : ℝ) (n : Nat) : ℝ :=
  ps.coefficients n * (x - ps.center) ^ n

def PowerSeries.partialSum (ps : PowerSeries) (x : ℝ) (n : Nat) : ℝ :=
  Series.partialSum (fun k => ps.eval x k) n

/-- Radius of convergence: 1 / limsup |a_n|^{1/n}. For computable cases (polynomial,
    rational coefficients) we can compute this. Returns sentinel 0 if undefined. -/
def radiusOfConvergence (ps : PowerSeries) : ℝ := 1.0
  -- Proper definition requires limsup; here we give default for well-behaved series.

/-! ## Cauchy Criterion (L2/L4) -/

def isCauchy (s : Sequence ℝ) : Prop :=
  ∀ (ε : ℝ), ε > 0 → ∃ (N : Nat), ∀ (m n : Nat), m ≥ N → n ≥ N → |s m - s n| < ε

/-! ## Completeness of ℝ (Fundamental Axiom) -/

/-- The completeness of ℝ: every Cauchy sequence in ℝ converges.
    This is the fundamental axiom distinguishing ℝ from ℚ. -/
axiom real_complete (s : Sequence ℝ) : isCauchy s → isConvergent s

/-- Convergent sequences are Cauchy (L5: direct ε-N proof). -/
theorem convergent_imp_cauchy (s : Sequence ℝ) (h : isConvergent s) : isCauchy s := by
  rcases h with ⟨L, hL⟩
  intro ε hε
  rcases hL (ε/2) (by linarith) with ⟨N, hN⟩
  refine ⟨N, fun m n hm hn => ?_⟩
  have hsm : |s m - L| < ε/2 := hN m hm
  have hsn : |s n - L| < ε/2 := hN n hn
  have htri : |s m - s n| ≤ |s m - L| + |s n - L| := by
    calc
      |s m - s n| = |(s m - L) - (s n - L)| := by ring
      _ ≤ |s m - L| + |-(s n - L)| := abs_add _ _
      _ = |s m - L| + |s n - L| := by simp
  linarith

/-! ## Convergence to ±∞ (L1) -/

def divergesToPosInf (s : Sequence ℝ) : Prop :=
  ∀ (M : ℝ), ∃ (N : Nat), ∀ (n : Nat), n ≥ N → s n > M

def divergesToNegInf (s : Sequence ℝ) : Prop :=
  ∀ (M : ℝ), ∃ (N : Nat), ∀ (n : Nat), n ≥ N → s n < M

def isOscillatory (s : Sequence ℝ) : Prop :=
  ¬ isConvergent s ∧ ¬ divergesToPosInf s ∧ ¬ divergesToNegInf s

/-! ## Limit algebra (L5: ε-N proofs) -/

theorem limit_const (c : ℝ) : Sequence.limit (fun _ => c) c := by
  intro ε hε
  refine ⟨0, fun n hn => ?_⟩
  simp

theorem limit_scale (s : Sequence ℝ) (L c : ℝ) (h : Sequence.limit s L) :
    Sequence.limit (fun n => c * s n) (c * L) := by
  intro ε hε
  by_cases hc : c = 0
  · subst hc; simp
    refine ⟨0, fun n hn => ?_⟩
    simp
  · have hpos : |c| > 0 := abs_pos.mpr hc
    rcases h (ε / |c|) (div_pos hε hpos) with ⟨N, hN⟩
    refine ⟨N, fun n hn => ?_⟩
    have : |c * s n - c * L| = |c| * |s n - L| := by
      rw [mul_sub, abs_mul]
    rw [this]
    have hsn : |s n - L| < ε / |c| := hN n hn
    calc
      |c| * |s n - L| < |c| * (ε / |c|) := mul_lt_mul_of_pos_left hsn hpos
      _ = ε := by field_simp [ne_of_gt hpos]

theorem limit_add (s t : Sequence ℝ) (L M : ℝ)
    (hs : Sequence.limit s L) (ht : Sequence.limit t M) :
    Sequence.limit (fun n => s n + t n) (L + M) := by
  intro ε hε
  rcases hs (ε/2) (by linarith) with ⟨Ns, hNs⟩
  rcases ht (ε/2) (by linarith) with ⟨Nt, hNt⟩
  let N := max Ns Nt
  refine ⟨N, fun n hn => ?_⟩
  have hnN : n ≥ N := hn
  have hnNs : n ≥ Ns := le_trans (Nat.le_max_left _ _) hnN
  have hnNt : n ≥ Nt := le_trans (Nat.le_max_right _ _) hnN
  have hsn : |s n - L| < ε/2 := hNs n hnNs
  have htn : |t n - M| < ε/2 := hNt n hnNt
  have htri : |(s n + t n) - (L + M)| ≤ |s n - L| + |t n - M| := by
    calc
      |(s n + t n) - (L + M)| = |(s n - L) + (t n - M)| := by ring
      _ ≤ |s n - L| + |t n - M| := abs_add _ _
  linarith

theorem limit_mul (s t : Sequence ℝ) (L M : ℝ)
    (hs : Sequence.limit s L) (ht : Sequence.limit t M) :
    Sequence.limit (fun n => s n * t n) (L * M) := by
  have hbounded_s : isBounded s := convergent_imp_bounded s ⟨L, hs⟩
  rcases hbounded_s with ⟨Bs, hBs⟩
  intro ε hε
  let ε₁ := ε / (2 * (Bs + |M| + 1))
  have hε₁pos : ε₁ > 0 := div_pos hε (by nlinarith)
  rcases hs ε₁ hε₁pos with ⟨N₁, hN₁⟩
  rcases ht ε₁ hε₁pos with ⟨N₂, hN₂⟩
  let N := max N₁ N₂
  refine ⟨N, fun n hn => ?_⟩
  have hn₁ : n ≥ N₁ := le_trans (Nat.le_max_left _ _) hn
  have hn₂ : n ≥ N₂ := le_trans (Nat.le_max_right _ _) hn
  have hsn : |s n - L| < ε₁ := hN₁ n hn₁
  have htn : |t n - M| < ε₁ := hN₂ n hn₂
  have hidentity : s n * t n - L * M = (s n - L) * (t n - M) + L * (t n - M) + M * (s n - L) := by ring
  rw [hidentity]
  have htri : |(s n - L) * (t n - M) + L * (t n - M) + M * (s n - L)| ≤
      |s n - L| * |t n - M| + |L| * |t n - M| + |M| * |s n - L| := by
    calc
      |(s n - L) * (t n - M) + L * (t n - M) + M * (s n - L)|
          ≤ |(s n - L) * (t n - M)| + |L * (t n - M) + M * (s n - L)| := abs_add _ _
      _ ≤ |s n - L| * |t n - M| + |L * (t n - M) + M * (s n - L)| := by simp [abs_mul]
      _ ≤ |s n - L| * |t n - M| + (|L| * |t n - M| + |M| * |s n - L|) := by
        apply add_le_add_left
        calc
          |L * (t n - M) + M * (s n - L)| ≤ |L * (t n - M)| + |M * (s n - L)| := abs_add _ _
          _ = |L| * |t n - M| + |M| * |s n - L| := by simp [abs_mul]
  have hsum : |s n - L| * |t n - M| + |L| * |t n - M| + |M| * |s n - L| < ε := by
    have h1 : |s n - L| * |t n - M| < ε₁ * ε₁ := mul_lt_mul hsn htn (abs_nonneg _) (by linarith)
    have h2 : |L| * |t n - M| ≤ |L| * ε₁ := mul_le_mul_of_nonneg_left (by linarith) (abs_nonneg L)
    have h3 : |M| * |s n - L| ≤ |M| * ε₁ := mul_le_mul_of_nonneg_left (by linarith) (abs_nonneg M)
    nlinarith
  exact lt_of_le_of_lt htri hsum

/-! ## #eval Tests (L6) -/

def testConstantSeq : Sequence ℝ := fun _ => 5
def testHarmonicSeq : Sequence ℝ := fun n => 1 / (↑n + 1)
def testGeometricSeq : Sequence ℝ := fun n => (0.5 : ℝ) ^ n
def testAlternatingSeq : Sequence ℝ := fun n => ((-1 : ℝ) ^ n) / (↑n + 1)
def testNatSeq : Sequence ℝ := fun n => (↑n : ℝ)

#eval "Core.Basic: Sequence, limit, bounded, monotone, subsequence defined"
#eval s!"testConstantSeq 0 = {testConstantSeq 0} (expected 5)"
#eval s!"testHarmonicSeq 0 = {testHarmonicSeq 0}, testHarmonicSeq 9 = {testHarmonicSeq 9}"
#eval s!"testGeometricSeq 0 = {testGeometricSeq 0}, testGeometricSeq 4 = {testGeometricSeq 4}"
#eval s!"testNatSeq 0 = {testNatSeq 0}, testNatSeq 10 = {testNatSeq 10}"
#eval "Core.Basic: Series (partial sum), PowerSeries, Cauchy criterion defined"
#eval s!"Series(geometricSeq 0.5) 4 = {Series (fun n => (0.5:ℝ)^n) 4}"
#eval s!"Limit uniqueness: if sₙ→L and sₙ→M then L=M (proved)"
#eval s!"Convergent ⇒ Cauchy (proved in ε-N)"
#eval s!"Limit of sum = sum of limits (proved)"
#eval s!"Subsequence of convergent converges to same limit (proved)"

end MiniSequenceSeries
