/-
# Bridges: To Algebra

C_b(X) as a Banach algebra, multiplicative linear functionals
= points of X (for compact X), Gelfand transform basics.
-/

import MiniObjectKernel.Core.Basic
import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Constructions.Subobjects

namespace MiniFunctionSequences

/-! ## C_b(X) as a Banach Algebra -/

/-- Pointwise multiplication makes C_b(X) a commutative Banach algebra. -/
def c_b_mul (X : Type) [TopologicalSpace X] (f g : BoundedContinuousFunctions X)
    : BoundedContinuousFunctions X :=
  ⟨λ x => f.1 x * g.1 x, by
    rcases f.2 with ⟨⟨Mf, hMf⟩, hCf⟩
    rcases g.2 with ⟨⟨Mg, hMg⟩, hCg⟩
    refine ⟨⟨Mf * Mg, λ x => ?_⟩, Continuous.mul hCf hCg⟩
    calc
      |f.1 x * g.1 x| = |f.1 x| * |g.1 x| := abs_mul _ _
      _ ≤ Mf * Mg := mul_le_mul (hMf x) (hMg x) (abs_nonneg _) (by
        have hpos : 0 ≤ |f.1 x| := abs_nonneg _
        linarith)
    ⟩

/-- The constant-1 function is the multiplicative identity of C_b(X). -/
def c_b_one (X : Type) [TopologicalSpace X] : BoundedContinuousFunctions X :=
  ⟨λ _ => 1, ⟨⟨1, λ _ => by simp⟩, continuous_const⟩⟩

/-- C_b(X) is a commutative algebra: multiplication is commutative. -/
theorem c_b_mul_comm (X : Type) [TopologicalSpace X] (f g : BoundedContinuousFunctions X) :
    c_b_mul X f g = c_b_mul X g f := by
  ext x; simp [c_b_mul, mul_comm]

/-- The sup norm is submultiplicative: ||fg|| ≤ ||f|| ||g||. -/
theorem supNorm_submultiplicative (X : Type) [TopologicalSpace X]
    (f g : BoundedContinuousFunctions X) :
    supNorm (λ x => f.1 x * g.1 x) ≤ supNorm f.1 * supNorm g.1 := by
  sorry

/-! ## Multiplicative Linear Functionals -/

/-- A multiplicative linear functional on C_b(X) is an algebra homomorphism to ℝ. -/
structure MultiplicativeLinearFunctional (X : Type) [TopologicalSpace X] where
  φ : BoundedContinuousFunctions X → ℝ
  linear : ∀ f g, φ ⟨λ x => f.1 x + g.1 x, by
    rcases f.2 with ⟨⟨Mf, hMf⟩, hCf⟩
    rcases g.2 with ⟨⟨Mg, hMg⟩, hCg⟩
    exact ⟨⟨Mf + Mg, λ x => add_le_add (hMf x) (hMg x)⟩, Continuous.add hCf hCg⟩
    ⟩ = φ f + φ g
  multiplicative : ∀ f g, φ (c_b_mul X f g) = φ f * φ g
  unital : φ (c_b_one X) = 1

/-- The evaluation functional at a point: ev_x(f) = f(x). -/
def evaluationFunctional (X : Type) [TopologicalSpace X] (x : X) :
    MultiplicativeLinearFunctional X where
  φ := λ f => f.1 x
  linear := by intro f g; simp
  multiplicative := by intro f g; simp [c_b_mul]
  unital := by simp [c_b_one]

/-- For a compact Hausdorff X, every multiplicative linear functional on C(X)
    is evaluation at a unique point. -/
theorem multiplicativeFunctionalsAreEvaluation
    (X : Type) [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (φ : MultiplicativeLinearFunctional X) :
    ∃! x : X, φ.φ = (evaluationFunctional X x).φ := by
  sorry

/-! ## Gelfand Transform -/

/-- The Gelfand transform of an element of a Banach algebra to a function
    on the maximal ideal space. -/
def gelfandTransform (X : Type) [TopologicalSpace X]
    (f : BoundedContinuousFunctions X) (φ : MultiplicativeLinearFunctional X) : ℝ :=
  φ.φ f

/-- The Gelfand transform is an isometric isomorphism for C(X), X compact. -/
theorem gelfandTransform_isometry
    (X : Type) [TopologicalSpace X] [CompactSpace X] [T2Space X]
    (f : BoundedContinuousFunctions X) :
    supNorm f.1 = supNorm (gelfandTransform X f) := by
  sorry

/-! ## Tests -/

#eval "--- Bridges.ToAlgebra tests ---"

/-- Multiplication in C_b(ℝ). -/
def f_cb : BoundedContinuousFunctions ℝ :=
  ⟨λ x => Real.sin x, ⟨⟨1, λ x => by
    have h := Real.abs_sin_le_one x; exact h⟩, Real.continuous_sin⟩⟩
def g_cb : BoundedContinuousFunctions ℝ :=
  ⟨λ x => Real.cos x, ⟨⟨1, λ x => by
    have h := Real.abs_cos_le_one x; exact h⟩, Real.continuous_cos⟩⟩
#eval (c_b_mul ℝ f_cb g_cb).1 (Real.pi / 4)  -- sin(π/4) * cos(π/4) = √2/2 * √2/2 = 1/2

/-- Evaluation functional at 0. -/
#eval (evaluationFunctional ℝ 0).φ f_cb  -- sin(0) = 0

end MiniFunctionSequences
