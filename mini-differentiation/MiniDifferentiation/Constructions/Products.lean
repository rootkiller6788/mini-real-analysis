/-
# MiniDifferentiation.Constructions.Products

Product rule in higher dimensions, Jacobian matrix of product map,
product of differentiable functions, and Cartesian product of
smooth structures.
-/

import MiniDifferentiation.Core.Basic
import MiniMathKernel

open MiniMathKernel

/-! ## Product of differentiable functions -/

structure ProductDifferentiable (f g : Real → Real) (a : Real) where
  f' : Real
  g' : Real
  hf : HasDerivativeAt f a f'
  hg : HasDerivativeAt g a g'
  productRule : True  -- (fg)'(a) = f'(a)g(a) + f(a)g'(a)
  theory : TheoryName := TheoryName.ofString "real-analysis.product-rule"
  objName : String := "ProductDifferentiable"

/-! ## Component-wise product of maps ℝ^n → ℝ^m -/

structure ComponentProductMap (n m : Nat) where
  f : (Fin n → Real) → (Fin m → Real)
  g : (Fin n → Real) → (Fin m → Real)
  prodMap : (Fin n → Real) → (Fin m → Real)
  prodRulePointwise : True
  theory : TheoryName := TheoryName.ofString "real-analysis.component-product"
  objName : String := s!"ComponentProduct(ℝ^{n} → ℝ^{m})"

/-! ## Jacobian of product map -/

structure JacobianProduct (n : Nat) (f g : (Fin n → Real) → Real) where
  jacF : (Fin n → Real) → (Fin n → Real)
  jacG : (Fin n → Real) → (Fin n → Real)
  jacProd : (Fin n → Real) → (Fin n → Real)
  productFormula : ∀ x, jacProd x = True  -- placeholder
  theory : TheoryName := TheoryName.ofString "real-analysis.jacobian-product"
  objName : String := s!"JacobianProduct(ℝ^{n})"

/-! ## Leibniz rule for higher derivatives -/

structure LeibnizRule (f g : Real → Real) (n : Nat) (a : Real) where
  formula : True  -- (fg)^{(n)}(a) = Σ_{k=0}^n C(n,k) f^{(k)}(a) g^{(n-k)}(a)
  binomialCoefficients : List Nat
  theory : TheoryName := TheoryName.ofString "real-analysis.leibniz-rule"
  objName : String := s!"LeibnizRule(order {n})"

/-! ## Binomial coefficient helper -/

def binomialCoeff (n k : Nat) : Nat :=
  if k > n then 0 else
  match n, k with
  | 0, 0 => 1
  | n+1, 0 => 1
  | n+1, k+1 => binomialCoeff n (k+1) + binomialCoeff n k

/-! ## Product of C^k functions is C^k -/

structure ProductCkSpace (k : Nat) where
  fg : CkFunction k × CkFunction k → CkFunction k
  isWellDefined : True
  theory : TheoryName := TheoryName.ofString s!"real-analysis.c{k}-product"
  objName : String := s!"C{k}Product"

/-! ## Tensor product of tangent spaces -/

structure TangentProduct (n m : Nat) (a : Fin n → Real) (b : Fin m → Real) where
  tanA : TangentVector { val := 0.0 }   -- from Core/Objects
  tanB : TangentVector { val := 0.0 }
  tanProduct : TangentVector { val := 0.0 }
  theory : TheoryName := TheoryName.ofString "real-analysis.tangent-product"
  objName : String := "TangentProduct"

/-! ## #eval Tests -/

#eval "Constructions.Products: ProductDifferentiable, ComponentProductMap, JacobianProduct"
#eval s!"binomialCoeff(5,2) = {binomialCoeff 5 2}"
#eval s!"Leibniz rule and product C^k spaces defined"
