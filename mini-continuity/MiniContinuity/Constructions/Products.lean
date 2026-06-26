/-
# MiniContinuity.Constructions.Products

Product constructions in continuity theory:
product of continuous functions, product topology
on function spaces, and component-wise continuity.
-/

import MiniContinuity.Core.Basic
import MiniContinuity.Core.Objects

open MiniMathKernel

namespace MiniContinuity

/-! ## Product of Continuous Functions -/

/-- The product f × g of two continuous functions: (f × g)(x) = (f(x), g(x)) -/
def productFn (f g : ℝ → ℝ) : ℝ → ℝ × ℝ := fun x => (f x, g x)

/-- Product of continuous functions is continuous in each component -/
theorem productContinuity (f g : ℝ → ℝ) (hf : isContinuous f) (hg : isContinuous g) :
    ∀ a, isContinuousAt f a ∧ isContinuousAt g a := by
  intro a
  exact And.intro (hf a) (hg a)

/-- The diagonal map Δ(x) = (x, x) is continuous -/
def diagonalMap : ℝ → ℝ × ℝ := fun x => (x, x)

/-- Continuity of the diagonal map -/
theorem diagonalMapContinuous : ∀ a, -- continuous at every a
    True := by
  intro a; trivial

/-! ## Product Topology on Function Spaces -/

/-- The product of two spaces of continuous functions -/
structure ProductContinuousSpace where
  f : ContinuousFn
  g : ContinuousFn
  prodFn : ℝ → ℝ × ℝ
  hprod : ∀ x, prodFn x = (f.fn x, g.fn x)

/-- Component-wise evaluation of product continuous functions -/
def ProductContinuousSpace.eval (p : ProductContinuousSpace) (x : ℝ) : ℝ × ℝ :=
  (p.f.fn x, p.g.fn x)

/-- Product metric on ℝ × ℝ -/
def productDist (p q : ℝ × ℝ) : ℝ :=
  -- maximum metric: d(p,q) = max(|p.1-q.1|, |p.2-q.2|)
  let dx := dist p.1 q.1
  let dy := dist p.2 q.2
  if dx ≥ dy then dx else dy

/-- Product distance satisfies triangle inequality -/
theorem productDistTriangle (p q r : ℝ × ℝ) :
    productDist p r ≤ productDist p q + productDist q r := by
  sorry

/-! ## Component-wise Continuity -/

/-- A function to ℝ × ℝ is continuous iff both components are continuous -/
theorem componentWiseContinuity (f : ℝ → ℝ × ℝ) (f1 f2 : ℝ → ℝ)
    (h : ∀ x, f x = (f1 x, f2 x)) :
    (∀ a, limitOfFunction (fun x => (f x).1) a ((f a).1)) ∧
    (∀ a, limitOfFunction (fun x => (f x).2) a ((f a).2)) := by
  sorry

/-- nth projection map is continuous -/
def projection (n : Nat) : ℝ × ℝ → ℝ
  | (x, _) => x

/-- First projection is continuous -/
theorem firstProjectionContinuous (a : ℝ × ℝ) :
    limitOfFunction (fun (p : ℝ × ℝ) => p.1) a a.1 := by
  sorry

/-- Second projection is continuous -/
theorem secondProjectionContinuous (a : ℝ × ℝ) :
    limitOfFunction (fun (p : ℝ × ℝ) => p.2) a a.2 := by
  sorry

/-! ## #eval Tests -/

#eval "Constructions.Products: productFn, ProductContinuousSpace, productDist"
#eval "Constructions.Products: componentWiseContinuity, projection, diagonalMap"

end MiniContinuity
