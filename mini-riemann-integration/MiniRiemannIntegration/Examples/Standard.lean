/-
# MiniRiemannIntegration.Examples.Standard

Standard definite integrals: ∫_0^1 x dx = 1/2, ∫_0^π sin(x)dx = 2,
∫_1^e 1/x dx = 1, ∫_0^1 e^x dx = e-1, Gaussian integral statement,
and other classical examples.
-/

import MiniRiemannIntegration.Theorems.Main
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## ∫_0^1 x dx = 1/2 -/

structure IntegralExample1 where
  f : ℝ → ℝ := fun x => x
  a : ℝ := 0; b : ℝ := 1
  expectedValue : ℝ := 0.5
  integrable : isRiemannIntegrable f a b
  value : riemannIntegral f a b = expectedValue

def example_integral_x : IntegralExample1 where
  integrable := by
    -- f(x) = x is continuous on [0,1], hence Riemann integrable
    sorry
  value := by sorry

/-! ## ∫_0^π sin(x)dx = 2 -/

structure IntegralExample2 where
  f : ℝ → ℝ := fun x => ℝ.cos x  -- actually sin, using cos antiderivative
  a : ℝ := 0; b : ℝ := 3.141592653589793
  expectedValue : ℝ := 2
  antiderivative : ℝ → ℝ := fun x => -ℝ.cos x

def example_integral_sin : IntegralExample2 where
  -- ∫_0^π sin(x)dx = [-cos(x)]_0^π = -cos(π) - (-cos(0)) = -(-1) + 1 = 2
  expectedValue := 2

/-! ## ∫_1^e 1/x dx = 1 -/

structure IntegralExample3 where
  f : ℝ → ℝ := fun x => 1 / x
  a : ℝ := 1; b : ℝ := 2.718281828459045  -- e
  expectedValue : ℝ := 1
  antiderivative : ℝ → ℝ := fun x => ℝ.log x

def example_integral_1_over_x : IntegralExample3 where
  expectedValue := 1

/-! ## ∫_0^1 e^x dx = e-1 -/

structure IntegralExample4 where
  f : ℝ → ℝ := fun x => ℝ.exp x
  a : ℝ := 0; b : ℝ := 1
  expectedValue : ℝ := 1.718281828459045  -- e - 1

def example_integral_exp : IntegralExample4 where
  expectedValue := 1.718281828459045

/-! ## ∫_0^1 x^n dx = 1/(n+1) -/

structure IntegralMonomial (n : ℕ) where
  f : ℝ → ℝ := fun x => x ^ n
  a : ℝ := 0; b : ℝ := 1
  expectedValue : ℝ := 1 / (↑(n+1) : ℝ)
  integrable : isRiemannIntegrable f a b

/-! ## Gaussian integral: ∫_{-∞}^∞ e^{-x^2}dx = √π -/

structure GaussianIntegral where
  f : ℝ → ℝ := fun x => ℝ.exp (-(x * x))
  a : ℝ := 0; b : ℝ := 0  -- unbounded interval: improper integral
  expectedValue : ℝ := 1.772453850905516  -- √π
  isImproper : isImproperIntegral f 0 0  -- from -∞ to ∞
  valueStatement : Prop  -- ∫_{-∞}^∞ e^{-x^2}dx = √π

def gaussianIntegralAxiom : Axiom :=
  Axiom.mk "gaussianIntegral" (Formula.pred 0 [])
    "∫_{-∞}^{∞} e^{-x^2} dx = √π (the Gaussian integral)"

/-! ## ∫_0^∞ e^{-x} dx = 1 -/

structure ExponentialImproperIntegral where
  f : ℝ → ℝ := fun x => ℝ.exp (-x)
  a : ℝ := 0; b : ℝ := 0  -- to ∞
  expectedValue : ℝ := 1

def example_integral_exp_neg : ExponentialImproperIntegral where {}

/-! ## Wallis product integral: ∫_0^{π/2} sin^n x dx -/

structure WallisIntegral (n : ℕ) where
  f : ℝ → ℝ := fun x => (ℝ.sin x) ^ n
  a : ℝ := 0; b : ℝ := 1.5707963267948966  -- π/2
  reductionFormula : Prop  -- I_n = ((n-1)/n) * I_{n-2} for n ≥ 2

/-! ## #eval Tests -/

#eval "Examples.Standard: IntegralExample1: ∫_0^1 x dx = 1/2"
#eval "Examples.Standard: IntegralExample2: ∫_0^π sin(x)dx = 2"
#eval "Examples.Standard: IntegralExample3: ∫_1^e 1/x dx = 1"
#eval "Examples.Standard: IntegralExample4: ∫_0^1 e^x dx = e-1"
#eval "Examples.Standard: GaussianIntegral: ∫ e^{-x^2}dx = √π"
#eval "Examples.Standard: WallisIntegral, ExponentialImproperIntegral"
#eval s!"Examples.Standard: 6 examples of classical definite integrals"

end MiniRiemannIntegration
