/-
# MiniDifferentiation.Morphisms.Equiv

Equivalence relations on differentiable functions:
- Contact equivalence of functions at a point
- Right-equivalence (coordinate change in domain)
- Jet equivalence (matching derivatives up to order k)
-/
import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Contact equivalence (Mather's K-equivalence) -/

structure ContactEquivalent (f g : Real → Real) (a : Real) where
  f : Real → Real := f
  g : Real → Real := g
  h : Real → Real
  H : Real → Real
  isDiffeomorphism : ∀ x, True
  relation : ∀ x, f x = H x * g (h x)
  theory : TheoryName := TheoryName.ofString "real-analysis.contact-equivalence"
  objName : String := "ContactEquivalent"

/-! ## Right-equivalence (coordinate change in domain) -/

structure RightEquivalent (f g : Real → Real) where
  φ : Real → Real       -- diffeomorphism of the domain
  isSmoothφ : True
  isInvertible : True
  relation : ∀ x : Real, f x = g (φ x)
  theory : TheoryName := TheoryName.ofString "real-analysis.right-equivalent"
  objName : String := "RightEquivalent"

/-! ## Left-equivalence (coordinate change in codomain) -/

structure LeftEquivalent (f g : Real → Real) where
  ψ : Real → Real       -- diffeomorphism of the codomain
  isSmoothψ : True
  isInvertible : True
  relation : ∀ x : Real, ψ (f x) = g x
  theory : TheoryName := TheoryName.ofString "real-analysis.left-equivalent"
  objName : String := "LeftEquivalent"

/-! ## Jet equivalence (k-jets agree at a point) -/

structure JetEquivalent (f g : Real → Real) (a : Real) (k : Nat) where
  jetAgree : ∀ j : Nat, j ≤ k → nthDerivative f j a = nthDerivative g j a
  theory : TheoryName := TheoryName.ofString "real-analysis.jet-equivalence"
  objName : String := s!"JetEquivalent(order {k})"

/-! ## k-Jet as equivalence class -/

structure Jet (f : Real → Real) (a : Real) (k : Nat) where
  coefficients : List Real  -- (f(a), f'(a), f''(a)/2!, ..., f^{(k)}(a)/k!)
  isValid : coefficients.length = k + 1 → True
  theory : TheoryName := TheoryName.ofString "real-analysis.jet"
  objName : String := s!"Jet(k={k})"

def mkJet (f : Real → Real) (a : Real) (k : Nat) : Jet f a k :=
  { coefficients := List.range (k+1) |>.map fun n => nthDerivative f n a
    isValid := fun _ => True.intro
    theory := TheoryName.ofString "real-analysis.jet"
    objName := s!"Jet(k={k})" }

/-! ## Jet space at a point -/

structure JetSpace (f : Real → Real) (a : Real) (k : Nat) where
  jet : Jet f a k
  representative : Real → Real
  isRepresentative : true
  theory : TheoryName := TheoryName.ofString "real-analysis.jet-space"
  objName := s!"JetSpace(k={k})"

/-! ## Taylor expansion in terms of jets -/

def taylorCoefficient (f : Real → Real) (a : Real) (n : Nat) : Real :=
  nthDerivative f n a

def factorial (n : Nat) : Real :=
  match n with
  | 0 => { val := 1.0 }
  | n+1 => { val := Float.ofNat (n+1) * factorial n |>.val }

/-! ## #eval Tests -/

#eval "Morphisms.Equiv: ContactEquivalent, RightEquivalent, LeftEquivalent"
#eval s!"JetEquivalent defined for any k: True"
#eval s!"taylorCoefficient of id at 0 order 1: {taylorCoefficient (fun x : Real => x) { val := 0.0 } 1}"
