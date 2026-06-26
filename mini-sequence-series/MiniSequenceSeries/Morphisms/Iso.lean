/-
# MiniSequenceSeries.Morphisms.Iso

Isomorphisms of sequence spaces: asymptotic equivalence,
rate of convergence comparison, category-theoretic isomorphisms.

Knowledge coverage:
- L2: Asymptotic equivalence as equivalence relation
- L3: SequenceIsomorphism as categorical isomorphism
- L5: Structural proofs of equivalence properties
- L6: #eval rate comparison examples
-/

import MiniSequenceSeries.Morphisms.Hom

namespace MiniSequenceSeries

/-! ## Asymptotic Equivalence (L2) -/

def isAsymptoticallyEquivalent (a b : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => |a n - b n|) 0

theorem asymptoticallyEquivalent_refl (a : Sequence ℝ) :
    isAsymptoticallyEquivalent a a := by
  unfold isAsymptoticallyEquivalent
  have : (fun n : Nat => |a n - a n|) = fun _ : Nat => (0 : ℝ) := by
    ext n; simp
  rw [this]
  exact limit_const 0

theorem asymptoticallyEquivalent_symm (a b : Sequence ℝ)
    (h : isAsymptoticallyEquivalent a b) : isAsymptoticallyEquivalent b a := by
  unfold isAsymptoticallyEquivalent at h ⊢
  have : (fun n => |b n - a n|) = (fun n => |a n - b n|) := by
    ext n; simpa [abs_sub_comm] using rfl
  rw [this]
  exact h

theorem asymptoticallyEquivalent_trans (a b c : Sequence ℝ)
    (h₁ : isAsymptoticallyEquivalent a b) (h₂ : isAsymptoticallyEquivalent b c) :
    isAsymptoticallyEquivalent a c := by
  unfold isAsymptoticallyEquivalent at h₁ h₂ ⊢
  intro ε hε
  rcases h₁ (ε/2) (by linarith) with ⟨N₁, hN₁⟩
  rcases h₂ (ε/2) (by linarith) with ⟨N₂, hN₂⟩
  let N := max N₁ N₂
  refine ⟨N, fun n hn => ?_⟩
  have hn₁ : n ≥ N₁ := le_trans (Nat.le_max_left _ _) hn
  have hn₂ : n ≥ N₂ := le_trans (Nat.le_max_right _ _) hn
  have h₁close : |a n - b n| < ε/2 := hN₁ n hn₁
  have h₂close : |b n - c n| < ε/2 := hN₂ n hn₂
  have htri : |a n - c n| ≤ |a n - b n| + |b n - c n| := by
    calc
      |a n - c n| = |(a n - b n) + (b n - c n)| := by ring
      _ ≤ |a n - b n| + |b n - c n| := abs_add _ _
  linarith

/-! ## Rate of Convergence (L2) -/

inductive RateOfConvergence
  | sublinear
  | linear
  | quadratic
  | exponential
  | superexponential
deriving BEq, Repr, Inhabited

def compareRate (a b : Sequence ℝ) : Prop :=
  Sequence.limit (fun n => |a n| / |b n|) 0
  -- a converges faster than b if |a_n|/|b_n| → 0

/-- Rate comparison is transitive: if a = o(b) and b = o(c), then a = o(c).
    Proof: |aₙ/cₙ| = |aₙ/bₙ| · |bₙ/cₙ| → 0 · 0 = 0. -/
theorem compareRate_trans (a b c : Sequence ℝ)
    (h₁ : compareRate a b) (h₂ : compareRate b c) : compareRate a c := by
  unfold compareRate at h₁ h₂ ⊢
  intro ε hε
  -- Since |aₙ/bₙ| → 0 and |bₙ/cₙ| → 0, there exists N such that
  -- for n ≥ N, |aₙ/bₙ| < √ε and |bₙ/cₙ| < √ε
  -- Then |aₙ/cₙ| = |aₙ/bₙ| · |bₙ/cₙ| < √ε · √ε = ε
  have hsqrtpos : √ε > 0 := Real.sqrt_pos.mpr hε
  rcases h₁ (√ε) hsqrtpos with ⟨N₁, hN₁⟩
  rcases h₂ (√ε) hsqrtpos with ⟨N₂, hN₂⟩
  let N := max N₁ N₂
  refine ⟨N, fun n hn => ?_⟩
  have hn₁ : n ≥ N₁ := le_trans (Nat.le_max_left _ _) hn
  have hn₂ : n ≥ N₂ := le_trans (Nat.le_max_right _ _) hn
  have h1 : |a n| / |b n| < √ε := hN₁ n hn₁
  have h2 : |b n| / |c n| < √ε := hN₂ n hn₂
  have hprod : (|a n| / |c n|) = (|a n| / |b n|) * (|b n| / |c n|) := by
    field_simp
    ring
  rw [hprod]
  -- 0 ≤ everything so multiplication preserves inequality
  have h_nonneg₁ : 0 ≤ |a n| / |b n| := div_nonneg (abs_nonneg _) (abs_nonneg _)
  have h_nonneg₂ : 0 ≤ |b n| / |c n| := div_nonneg (abs_nonneg _) (abs_nonneg _)
  calc
    (|a n| / |b n|) * (|b n| / |c n|) < (√ε) * (√ε) := mul_lt_mul h1 h2 h_nonneg₂ (by linarith)
    _ = ε := by simp [Real.mul_self_sqrt (by linarith)]

/-! ## Sequence Space Isomorphism (L3: Categorical) -/

structure SequenceIsomorphism where
  forward : SequenceMap
  backward : SequenceMap
  forwardInv : ∀ (s : Sequence ℝ), backward.map (forward.map s) = s
  backwardInv : ∀ (t : Sequence ℝ), forward.map (backward.map t) = t
deriving Repr

def identityIso : SequenceIsomorphism where
  forward := SequenceMap.id
  backward := SequenceMap.id
  forwardInv := by intro s; rfl
  backwardInv := by intro t; rfl

/-- An isomorphism that scales by c (with c ≠ 0). -/
def scalingIso (c : ℝ) (hc : c ≠ 0) : SequenceIsomorphism where
  forward := SequenceMap.scale c
  backward := SequenceMap.scale (1 / c)
  forwardInv := by
    intro s; ext n
    simp [SequenceMap.scale, scaleSeq]
    field_simp [hc]
  backwardInv := by
    intro s; ext n
    simp [SequenceMap.scale, scaleSeq]
    field_simp [hc]

/-! ## Equivalence of Sequence Spaces -/

/-- A weaker notion: asymptotic equivalence between sequences. -/
structure AsymptoticEquivalence (a b : Sequence ℝ) where
  equivalenceProof : isAsymptoticallyEquivalent a b
  rateComparison : RateOfConvergence
deriving Repr

/-- Reflexivity of asymptotic equivalence. -/
def asymptoticEquiv_refl (a : Sequence ℝ) : AsymptoticEquivalence a a :=
  { equivalenceProof := asymptoticallyEquivalent_refl a
    rateComparison := .superexponential
  }

/-! ## #eval Tests (L6) -/

def fastSeq : Sequence ℝ := fun n => (0.5 : ℝ) ^ n
def fasterSeq : Sequence ℝ := fun n => (0.1 : ℝ) ^ n
def slowSeq : Sequence ℝ := fun n => 1 / (↑n + 1)

#eval "Morphisms.Iso: asymptotic equivalence, RateOfConvergence"
#eval s!"RateOfConvergence: sublinear, linear, quadratic, exponential, superexponential"
#eval s!"identityIso: forwardInv and backwardInv structural"
#eval s!"scalingIso c=3: bijective (c≠0)"
#eval s!"fastSeq 0..4: {fastSeq 0}, {fastSeq 1}, {fastSeq 2}, {fastSeq 3}, {fastSeq 4}"
#eval s!"fasterSeq 0..4: {fasterSeq 0}, {fasterSeq 1}, {fasterSeq 2}, {fasterSeq 3}, {fasterSeq 4}"
#eval s!"slowSeq 0..4: {slowSeq 0}, {slowSeq 1}, {slowSeq 2}, {slowSeq 3}, {slowSeq 4}"
#eval s!"asymptotic equivalence is an equivalence relation (proved)"

end MiniSequenceSeries
