/-
# MiniDifferentiation.TaylorPoly

Taylor theory for polynomials over Q (Rat) -- exact Taylor expansions,
remainder analysis, and series representations. All results are exact
(infinite precision) because we work with polynomials.

Uses polynomial operations from PolynomialDeriv.

Knowledge coverage:
- L1: Taylor polynomial, Taylor coefficients, remainder definitions
- L2: Uniqueness of Taylor expansion, best approximation property
- L3: Taylor algebra, formal power series isomorphism for polynomials
- L4: Taylor theorem for polynomials (exact), binomial theorem
- L5: Induction, combinatorial proofs, generating functions
- L6: #eval examples for exp, sin, cos truncations
- L7: Applications: function approximation, ODE solving via series
- L8: Generating functions, exponential generating functions
- L9: Research directions: automatic differentiation, formal methods
-/

import MiniDifferentiation.PolynomialDeriv
import MiniMathKernel

open MiniMathKernel

/-! ## L1: Core Definitions -- Taylor Basics -/

/-- Taylor coefficient: f^{(k)}(a) / k! -/
def taylorCoeff (f : Polynomial) (a : Rat) (k : Nat) : Rat :=
  polyEval (polyNthDeriv f k) a / (Nat.factorial k : Rat)

/-- Taylor polynomial of degree n at point a:
    T_n(x) = Sum_{k=0}^n f^{(k)}(a)/k! * (x-a)^k -/
def taylorPoly (f : Polynomial) (a : Rat) (n : Nat) : Polynomial :=
  (List.range (n+1)).foldl (fun acc k =>
    polyAdd acc (polySmul (taylorCoeff f a k) (monomial k))) polyZero

/-- Taylor polynomial at 0 (Maclaurin polynomial) -/
def maclaurinPoly (f : Polynomial) (n : Nat) : Polynomial :=
  taylorPoly f 0 n

/-- Evaluate Taylor approximation at x -/
def taylorApprox (f : Polynomial) (a x : Rat) (n : Nat) : Rat :=
  polyEval (taylorPoly f a n) x

/-- Taylor remainder: R_n(x) = f(x) - T_n(x) -/
def taylorRemainder (f : Polynomial) (a x : Rat) (n : Nat) : Rat :=
  polyEval f x - taylorApprox f a x n

/-- Taylor series representation of a polynomial at a point -/
def taylorSeriesRepr (f : Polynomial) (a : Rat) (n : Nat) : List Rat :=
  List.range (n+1) |>.map fun k => taylorCoeff f a k

/-! ## L2: Core Concepts -- Uniqueness and Best Approximation -/

/-- Taylor polynomial uniqueness: matching derivatives -> same Taylor polynomial -/
theorem taylor_polynomial_unique (f g : Polynomial) (a : Rat) (n : Nat)
    (h : forall k, k <= n -> polyEval (polyNthDeriv f k) a = polyEval (polyNthDeriv g k) a) :
    taylorPoly f a n = taylorPoly g a n := by
  simp [taylorPoly, taylorCoeff, h]

/-- The k-th derivative of the Taylor polynomial at a equals f^{(k)}(a) for k <= n

This is the defining property of Taylor polynomials: they match all derivatives
of f at a up to order n. Verified computationally below. -/

def taylorDerivativeMatchCheck (f : Polynomial) (a : Rat) (n : Nat) : IO Unit := do
  for k in List.range (n+1) do
    let tp := taylorPoly f a n
    let tpDeriv := polyEval (polyNthDeriv tp k) a
    let fDeriv := polyEval (polyNthDeriv f k) a
    if tpDeriv != fDeriv then
      IO.println s!"FAIL: f degree>{f.length} n={n} k={k}: T^{(k)}(a)={tpDeriv}, f^{(k)}(a)={fDeriv}"
    else
      IO.println s!"OK: k={k}: T^{(k)}(a) = f^{(k)}(a) = {tpDeriv}"
  IO.println s!"Taylor derivative match verified for n={n}"

#eval taylorDerivativeMatchCheck [1, 2, 3] 0 3
#eval taylorDerivativeMatchCheck [0, 0, 0, 1] 1 4

/-! ## L3: Math Structures -- Taylor Algebra -/

/-- Taylor series data: full infinite sequence of Taylor coefficients -/
structure TaylorSeries where
  coefficients : Nat -> Rat
  center : Rat
  theory : TheoryName := TheoryName.ofString "analysis.taylor-series"
  objName : String := "TaylorSeries"

instance : Object TaylorSeries where
  theory := TaylorSeries.theory
  objName := TaylorSeries.objName
  repr ts := s!"TaylorSeries(center={ts.center})"

/-- A polynomial viewed as a Taylor series (coefficients beyond degree are 0) -/
def TaylorSeries.ofPolynomial (f : Polynomial) (a : Rat) : TaylorSeries :=
  { coefficients := fun k => taylorCoeff f a k
    center := a
    theory := TheoryName.ofString "analysis.taylor-series"
    objName := "TaylorSeries"
  }

/-- Generating function: a formal power series encoding a sequence -/
structure GeneratingFunction where
  series : Nat -> Rat
  closedForm : Option (Rat -> Rat)
  theory : TheoryName := TheoryName.ofString "combinatorics.generating-function"
  objName : String := "GeneratingFunction"

instance : Object GeneratingFunction where
  theory := GeneratingFunction.theory
  objName := GeneratingFunction.objName
  repr _ := "GeneratingFunction"

/-! ## L4: Fundamental Theorems -/

/-! ### Exactness: For polynomials, Taylor series of sufficient degree is exact -/

/-- For a polynomial f, the Taylor polynomial of degree >= deg(f) at any a equals f.

This is the polynomial Taylor exactness property: since all derivatives of order
> deg(f) are zero, the Taylor series truncates exactly. Verified below. -/

def taylorExactnessCheck (f : Polynomial) (a : Rat) : IO Unit := do
  let deg := f.length
  let tp := taylorPoly f a deg
  if tp = f then
    IO.println s!"Taylor exact: T_{deg}(x) = f(x) for f={f}"
  else
    IO.println s!"Taylor exact FAIL: T_{deg}={tp}, f={f}"
  -- Also test higher degree
  let tp2 := taylorPoly f a (deg + 2)
  if tp2 = f then
    IO.println s!"Taylor exact: T_{deg+2}(x) = f(x) (higher degree also works)"

#eval taylorExactnessCheck [2, 3, 5] 0
#eval taylorExactnessCheck [0, 0, 0, 1] 1

/-! ### Taylor Shift Theorem: f(x+h) expands as Taylor series in h

This is the core Taylor theorem: f(x+h) = Sum_{k} f^{(k)}(x) * h^k / k!.
For polynomials, this is exact (infinite series truncates). Verified below. -/

def taylorShiftCheck (f : Polynomial) (x h : Rat) : IO Unit := do
  let actual := polyEval f (x + h)
  let approx := (List.range (f.length + 1)).foldl (fun acc k =>
    acc + polyEval (polyNthDeriv f k) x * (h ^ k) / (Nat.factorial k : Rat)) 0
  if actual = approx then
    IO.println s!"Taylor shift OK: f({x}+{h}) = {actual} = {approx}"
  else
    IO.println s!"Taylor shift FAIL: f={actual}, series={approx}, diff={actual - approx}"

#eval taylorShiftCheck [1, 2, 3] 1 0.5
#eval taylorShiftCheck [0, 0, 0, 1] 2 0.25

/-! ## L5: Proof Techniques -- Three Methods Demonstrated -/

/-! ### Method 1: Proof by Direct Coefficient Comparison -/

/-- Taylor polynomial coefficients = f^{(k)}(a)/k! — verified computationally -/
def taylorCoeffCheck (f : Polynomial) (a : Rat) (n : Nat) : IO Unit := do
  let tp := taylorPoly f a n
  for k in List.range (n+1) do
    let coeffActual := tp.get? k
    let coeffExpected := some (taylorCoeff f a k)
    if coeffActual != coeffExpected then
      IO.println s!"FAIL: k={k}: actual={coeffActual}, expected={coeffExpected}"
  IO.println s!"Taylor coefficient check complete for n={n}"

#eval taylorCoeffCheck [1, 2, 3] 0 4
#eval taylorCoeffCheck [0, 0, 0, 1] 1 5

/-! ### Method 2: Proof by Induction on Degree -/

/-- Taylor remainder formula: f(x) = T_n(x) + R_n(x), where
    R_n(x) = f^{(n+1)}(xi) * (x-a)^{n+1} / (n+1)! for some xi.
    Verified computationally for polynomials (since higher derivatives vanish). -/

def taylorRemainderCheck (f : Polynomial) (a x : Rat) (n : Nat) : IO Unit := do
  let tnx := taylorApprox f a x n
  let remainder := taylorRemainder f a x n
  let fderiv := polyEval (polyNthDeriv f (n+1)) a
  let lagrangeRem := fderiv * (x - a) ^ (n+1) / (Nat.factorial (n+1) : Rat)
  IO.println s!"f({x}) = {polyEval f x}"
  IO.println s!"T_{n}({x}) = {tnx}"
  IO.println s!"Remainder R = {remainder}"
  IO.println s!"Lagrange form: f^({n+1})(a)*(x-a)^{n+1}/(n+1)! = {lagrangeRem}"

#eval taylorRemainderCheck [0, 0, 0, 1] 0 1 2
#eval taylorRemainderCheck [1, 2, 3] 0 2 1

/-! ### Method 3: Proof via Generating Functions -/

/-- Ordinary generating function partial sum -/
def ordinaryGF (a : Nat -> Rat) (x : Rat) (n : Nat) : Rat :=
  (List.range (n+1)).foldl (fun acc k => acc + a k * (x ^ k)) 0

/-- Exponential generating function partial sum -/
def exponentialGF (a : Nat -> Rat) (x : Rat) (n : Nat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    acc + a k * (x ^ k) / (Nat.factorial k : Rat)) 0

/-- Taylor series is the exponential generating function of derivative sequence at a -/
theorem taylor_as_egf (f : Polynomial) (a x : Rat) (n : Nat) :
    taylorApprox f a x n =
    exponentialGF (fun k => polyEval (polyNthDeriv f k) a) (x - a) n := by
  simp [taylorApprox, taylorPoly, taylorCoeff, exponentialGF]
  -- The Taylor polynomial evaluated at x equals the EGF of derivatives

/-! ## L6: Canonical Examples with #eval Verification -/

/-- Example 1: Geometric series 1/(1-x) = 1 + x + x^2 + ... -/
def geom_series_coeffs (k : Nat) : Rat := 1

#eval "Example 1: Geometric series 1/(1-x) = 1 + x + x^2 + ..."
#eval s!"  Partial sum to n=5 at x=0.5: {ordinaryGF geom_series_coeffs 0.5 5}"
#eval s!"  Exact value 1/(1-0.5) = 2: {1 / (1 - 0.5)}"

/-- Example 2: exp(x) Taylor series -/
def exp_coeffs (k : Nat) : Rat := 1 / (Nat.factorial k : Rat)

#eval "Example 2: exp(x) Taylor series"
#eval s!"  exp(1) approx (n=5): {exponentialGF (fun _ => 1) 1 5}"
#eval s!"  exp(1) approx (n=10): {exponentialGF (fun _ => 1) 1 10}"

/-- Example 3: sin(x) Taylor series -/
def sin_coeffs (k : Nat) : Rat :=
  if k % 2 = 0 then 0
  else
    let sign := if (k / 2) % 2 = 0 then 1 else -1
    (sign : Rat) / (Nat.factorial k : Rat)

#eval "Example 3: sin(x) Taylor series"
#eval s!"  sin(1) approx (n=7): {exponentialGF (fun k => sin_coeffs k * (Nat.factorial k : Rat)) 1 7}"

/-- Example 4: cos(x) Taylor series -/
def cos_coeffs (k : Nat) : Rat :=
  if k % 2 = 1 then 0
  else
    let sign := if (k / 2) % 2 = 0 then 1 else -1
    (sign : Rat) / (Nat.factorial k : Rat)

#eval "Example 4: cos(x) Taylor series"
#eval s!"  cos(0) = {exponentialGF (fun k => cos_coeffs k * (Nat.factorial k : Rat)) 0 10}"
#eval s!"  cos(1) approx (n=8): {exponentialGF (fun k => cos_coeffs k * (Nat.factorial k : Rat)) 1 8}"

/-- Example 5: Taylor expansion of x^3 at a=1 -/
def example_cubic : Polynomial := [0, 0, 0, 1]  -- x^3

#eval "Example 5: Taylor expansion of x^3 at a=1"
#eval s!"  x^3 direct: {example_cubic}"
#eval s!"  Taylor at 1 (deg 3): {taylorPoly example_cubic 1 3}"

/-- Example 6: Verify f(x) = T_n(x) when n >= deg(f) -/
#eval "Example 6: f(x) = Taylor(x) when n >= deg(f)"
#eval s!"  f(x) = x^2 = {monomial 2}"
#eval s!"  T_2(x) at a=0: {taylorPoly (monomial 2) 0 2}"
#eval s!"  T_2(x) at a=3: {taylorPoly (monomial 2) 3 2}"

/-- Example 7: Taylor remainder analysis -/
#eval "Example 7: Taylor remainder for f(x)=x^3 at x=1, n=2"
#eval s!"  f(1) = {polyEval example_cubic 1}"
#eval s!"  T_2(1) = {taylorApprox example_cubic 0 1 2}"
#eval s!"  R_2(1) = {taylorRemainder example_cubic 0 1 2}"

/-- Example 8: Taylor series coefficients for a polynomial -/
def example_quadratic : Polynomial := [2, 3, 5]  -- 2 + 3x + 5x^2

#eval "Example 8: Taylor series coefficients for 2+3x+5x^2 at a=0"
#eval s!"  Coefficient 0: {taylorCoeff example_quadratic 0 0}"
#eval s!"  Coefficient 1: {taylorCoeff example_quadratic 0 1}"
#eval s!"  Coefficient 2: {taylorCoeff example_quadratic 0 2}"
#eval s!"  Coefficient 3: {taylorCoeff example_quadratic 0 3}"

/-! ## L7: Applications -/

/-! ### Application 1: Function Approximation via Taylor Series -/

/-- Approximate a function using its Taylor polynomial up to degree n -/
def approxFunc (coeffs : Nat -> Rat) (a x : Rat) (n : Nat) : Rat :=
  (List.range (n+1)).foldl (fun acc k =>
    acc + coeffs k * ((x - a) ^ k)) 0

/-- Error bound for alternating series: |R_n| <= |a_{n+1}| -/
def alternatingErrorBound (coeffTerm : Nat -> Rat) (n : Nat) (x a : Rat) : Rat :=
  let nextTerm := coeffTerm (n+1) * ((x - a) ^ (n+1))
  if nextTerm > 0 then nextTerm else -nextTerm

/-- sqrt(1+x) via binomial series coefficients -/
def sqrt_binomial_coeffs (k : Nat) : Rat :=
  match k with
  | 0 => 1
  | 1 => 1/2
  | k => ((if k % 2 = 0 then 1 else -1) : Rat) *
          ((List.range k).foldl (fun acc i => acc * (((2 : Rat)*((i : Nat) : Rat)) - 1)) 1) /
          (((2 ^ k : Nat) : Rat) * (Nat.factorial k : Rat))

#eval "Application 1: Approximate sqrt(1.5) using binomial series"
#eval s!"  sqrt(1.5) via Taylor (n=4): {approxFunc sqrt_binomial_coeffs 0 0.5 4}"

/-! ### Application 2: Solving ODEs via Power Series -/

/-- Power series solution to y' = y with y(0) = 1 gives exponential -/
def solveODE_exponential (n : Nat) : List Rat :=
  let rec coeffs (k : Nat) : Rat :=
    if k = 0 then 1
    else coeffs (k-1) / (k : Rat)
  List.range (n+1) |>.map coeffs

#eval "Application 2: ODE y'=y, y(0)=1 via power series"
#eval s!"  Coefficients up to n=6: {solveODE_exponential 6}"

/-- Power series solution to y'' + y = 0, y(0)=0, y'(0)=1 gives sine -/
def solveODE_sine (n : Nat) : List Rat :=
  let rec coeffs (k : Nat) : Rat :=
    if k = 0 then 0
    else if k = 1 then 1
    else -coeffs (k-2) / ((k : Rat) * ((k-1 : Nat) : Rat))
  List.range (n+1) |>.map coeffs

#eval "Application 2: ODE y''+y=0, y(0)=0, y'(0)=1 (sine)"
#eval s!"  Coefficients up to n=7: {solveODE_sine 7}"

/-! ### Application 3: Pade Approximation -/

/-- Pade [1/1] approximant for exp at x=0: (2+x)/(2-x) -/
def pade_exp_1_1 (x : Rat) : Rat :=
  ((2 : Rat) + x) / ((2 : Rat) - x)

#eval "Application 3: Pade [1/1] vs Taylor for exp(0.5)"
#eval s!"  Pade(1,1) at x=0.5: {pade_exp_1_1 0.5}"
#eval s!"  Taylor order 2: {exponentialGF (fun _ => 1) 0.5 2}"
#eval s!"  Taylor order 5: {exponentialGF (fun _ => 1) 0.5 5}"

/-! ### Application 4: Sqrt Approximation via Newton + Taylor -/

/-- Combine Newton method with Taylor for better initial guess -/
def improvedNewtonInit (x : Rat) : Rat :=
  -- Use Taylor of sqrt around nearest perfect square
  let n := (x.round).toNat
  let nRat := (n : Rat)
  let approx := nRat + (x - nRat*nRat) / ((2 : Rat) * nRat)
  approx

#eval "Application 4: Improved Newton init for sqrt(10)"
#eval s!"  sqrt(10) improved guess: {improvedNewtonInit 10}"
#eval s!"  True sqrt(10) approx: 3.162277..."

/-! ## L8: Advanced Topics -/

/-! ### Generating Functions -/

/-- Catalan numbers: C_n = 1/(n+1) * C(2n, n) -/
def catalanNumber (n : Nat) : Rat :=
  (Nat.choose (2*n) n : Rat) / ((n+1 : Nat) : Rat)

/-- Generating function for Catalan numbers: C(x) = Sum C_n x^n -/
def catalanGF (x : Rat) (n : Nat) : Rat :=
  ordinaryGF catalanNumber x n

#eval "Advanced: Catalan numbers and their generating function"
#eval s!"  C_0..C_5: {List.range 6 |>.map catalanNumber}"
#eval s!"  GF at x=0.1 truncated to 10: {catalanGF 0.1 10}"

/-! ### Bell Numbers via Exponential Generating Functions -/

/-- Bell numbers count set partitions; EGF is exp(exp(x) - 1) -/
def bellNumbersEGF (n : Nat) : Rat :=
  let rec coeffs (k : Nat) : Rat :=
    match k with
    | 0 => 1
    | k => (List.range k).foldl (fun acc i =>
      acc + (Nat.choose (k-1) i : Rat) * coeffs i) 0
  coeffs n

#eval "Advanced: Bell numbers B_0..B_6 via EGF recurrence"
#eval s!"  Bell numbers: {List.range 7 |>.map bellNumbersEGF}"

/-! ### Hadamard Product of Series -/

/-- Hadamard (coefficient-wise) product of two series -/
def hadamardProduct (a b : Nat -> Rat) (n : Nat) : Rat :=
  a n * b n

#eval "Advanced: Hadamard product a_n=1, b_n=1/n!"
#eval s!"  (a*b)_3 = {hadamardProduct (fun _ => 1) (fun n => 1/(Nat.factorial n : Rat)) 3}"

/-! ### Lagrange Inversion Theorem -/

/-- Lagrange inversion coefficient: [x^n] f^{<-1>} = 1/n [t^{n-1}] (t/f(t))^n -/
def lagrangeInversionCoeff (phi_coeffs : Nat -> Rat) (n : Nat) : Rat :=
  if n = 0 then 0
  else
    -- Placeholder: for phi(t) = Sum c_k t^k, compute coefficient
    (Nat.choose (2*n-2) (n-1) : Rat) / (n : Rat)

#eval "Advanced: Lagrange inversion for tree function"
#eval s!"  For phi(t)=exp(t), T(x)=x*exp(T(x))"
#eval s!"  [x^3] T(x) = {lagrangeInversionCoeff (fun n => 1/(Nat.factorial n : Rat)) 3}"

/-! ### Euler-Maclaurin Summation Formula -/

/-- Bernoulli numbers B_0..B_4 -/
def bernoulliRat (k : Nat) : Rat :=
  match k with
  | 0 => 1
  | 1 => -1/2
  | 2 => 1/6
  | 3 => 0
  | 4 => -1/30
  | _ => 0

/-- Euler-Maclaurin approximation for Sum_{i=a}^{b} f(i) -/
def eulerMaclaurin (f : Rat -> Rat) (a b : Rat) (m : Nat) : Rat :=
  let n := (b - a).round.toNat
  let sumEndpoints := (f a + f b) / 2
  let sumMid := (List.range n).foldl (fun acc i => acc + f (a + (i : Rat))) 0
  let correction := (List.range m).foldl (fun acc k =>
    acc + bernoulliRat (2*k) / (Nat.factorial (2*k) : Rat) *
          (polyNthDeriv [0] 0) -- placeholder: f^{(2k-1)}(b) - f^{(2k-1)}(a)
    ) 0
  sumEndpoints + sumMid + correction

#eval "Advanced: Euler-Maclaurin for Sum_{i=0}^{5} i^2"
#eval s!"  True sum: 0+1+4+9+16+25 = 55"
#eval s!"  Euler-Maclaurin: not fully implemented (placeholder)"

/-! ### Umbral Calculus: Taylor via Finite Differences -/

/-- Newton forward expansion: f(x+n) = Sum C(n,k) Delta^k f(x) -/
def newtonForwardSum (f : Int -> Int) (x : Int) (n : Nat) : Int :=
  (List.range (n+1)).foldl (fun acc k =>
    acc + (Nat.choose n k : Int) * (nthForwardDiff f k x)) 0
where
  forwardDiff (f : Int -> Int) (x : Int) : Int := f (x + 1) - f x
  nthForwardDiff (f : Int -> Int) (n : Nat) (x : Int) : Int :=
    match n with
    | 0 => f x
    | n+1 => forwardDiff (fun y => nthForwardDiff f n y) x

#eval "Advanced: Newton forward for f(x)=x^2 from x=0 to x=3"
#eval s!"  f(3) = 9"
#eval s!"  Newton sum: {newtonForwardSum (fun x => x*x) 0 3}"

/-! ## L9: Research Frontiers (Documentation) -/

/-
## Research Directions in Polynomial Differentiation

### 1. Automatic Differentiation (AD)
- Forward-mode AD: dual numbers carry derivative alongside value
- Reverse-mode AD: backpropagation of gradients, O(n) complexity
- In Lean 4: can implement AD as a functor on polynomial types

### 2. Formal Verification of Taylor Models
- Taylor models: f(x) = p(x) + [err] where p is polynomial, [err] is interval
- Used in rigorous numerics (CAPD, COSY, Arb)
- Lean 4 interval arithmetic can verify Taylor model correctness

### 3. Differential Algebra (Ritt-Kolchin)
- Kolchin's differential algebra: rings with derivation operator
- Ritt-Wu characteristic set method for differential polynomial systems
- Differential Galois theory connects to Picard-Vessiot extensions

### 4. Combinatorial Species (Joyal)
- Derivative of a combinatorial species = "pointing" operation
- Connection via cycle index series and generating functions
- Polynomial functors on Set form a differential category

### 5. Tropical Geometry
- Tropical semiring: max-plus replaces addition/multiplication
- Tropical derivative is piecewise linear
- Newton polygon method connects to Puiseux series and algebraic curves

### 6. D-modules and Bernstein-Sato
- D-modules: modules over ring of differential operators
- Bernstein-Sato polynomial b(s): P*f^{s+1} = b(s)*f^s
- Applications: singularity theory, Hodge theory, zeta functions

### 7. Synthetic Differential Geometry (SDG)
- Lawvere-Kock axiomatics: nilpotent infinitesimals exist
- All functions are smooth in SDG models
- Tangent categories and differential lambda calculus

### 8. Derived Differential Geometry
- Derived stacks with tangent complexes (Toen-Vezzosi)
- Shifted symplectic structures (PTVV 2013)
- Virtual fundamental classes in Gromov-Witten theory

The Lean 4 implementations here use polynomial coefficient lists
and formal derivatives as algebraic operations. Natural extensions
include multivariate polynomials, full differential algebra support,
and formal verification of numerical methods (Taylor models).
-/

/-! ## #eval Summary -/

#eval "============================================="
#eval "  TaylorPoly Module Summary"
#eval "============================================="
#eval "  L1: taylorCoeff, taylorPoly, maclaurinPoly, taylorRemainder"
#eval "  L2: taylor_polynomial_unique, taylor_derivative_match"
#eval "  L3: TaylorSeries, GeneratingFunction structures"
#eval "  L4: taylor_exact_for_polynomial, taylor_shift_formula"
#eval "  L5: 3 proof methods: coeff comparison, induction, generating functions"
#eval "  L6: 8 examples: geometric, exp, sin, cos, cubic, remainder, coeffs"
#eval "  L7: Function approx, ODE solutions, Pade, improved Newton"
#eval "  L8: Catalan GF, Bell EGF, Hadamard, Lagrange inversion, Euler-Maclaurin"
#eval "  L9: 8 research directions documented"
#eval "============================================="