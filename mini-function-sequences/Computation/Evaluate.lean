/-
# Computation: Evaluate

Numerical evaluation utilities: function sequence evaluators,
convergence metric computation, visualization data generators.
-/

import MiniFunctionSequences.Core.Basic
import MiniFunctionSequences.Theorems.Main

namespace MiniFunctionSequences.Computation

#eval "=== Computation: Evaluate ==="

/-! ## Function Sequence Evaluator -/

/-- Evaluate a function sequence at a list of points and return a table. -/
def evaluateSequence (f_n : SequenceOfFunctions ℝ) (n_max : Nat) (points : List ℝ) : List (List ℝ) :=
  (List.range n_max).map λ n =>
    points.map λ x => f_n n x

#eval "Evaluate x/n at points [0, 1, 5] for n = 1,2,3:"
let f_n : SequenceOfFunctions ℝ := λ n x => x / ((n : ℝ) + 1)
evaluateSequence f_n 3 [0.0, 1.0, 5.0]

/-! ## Convergence Metric -/

/-- Compute the sup-norm distance between f_n and f on a set represented by sample points. -/
noncomputable def convergenceMetric (f_n : SequenceOfFunctions ℝ) (f : ℝ → ℝ)
    (samplePoints : List ℝ) (n : Nat) : ℝ :=
  match samplePoints with
  | [] => 0
  | xs => xs.foldl (λ maxErr x => max maxErr (|f_n n x - f x|)) 0

#eval "Convergence metric for x/n to 0 at [0,1,5], n=5:"
let f_n : SequenceOfFunctions ℝ := λ n x => x / ((n : ℝ) + 1)
convergenceMetric f_n (λ _ => 0) [0.0, 1.0, 5.0] 5

/-! ## Bernstein Coefficients Extractor -/

/-- Extract the Bernstein coefficients of degree n from a function f
    (sampled at points k/n for k=0,...,n). -/
def bernsteinCoefficients (f : ℝ → ℝ) (n : Nat) : List ℝ :=
  (List.range (n+1)).map λ k =>
    let k' := (k : ℝ)
    let n' := (n : ℝ)
    f (k' / n')

#eval "Bernstein coefficients of x^2, degree 3:"
bernsteinCoefficients (λ x => x ^ 2) 3

#eval "Bernstein coefficients of sin(pi*x), degree 4:"
bernsteinCoefficients (λ x => Real.sin (Real.pi * x)) 4

/-! ## Bernstein Polynomial Evaluator -/

/-- Evaluate a Bernstein polynomial given its coefficients. -/
noncomputable def evalBernstein (coeffs : List ℝ) (t : ℝ) : ℝ :=
  let n := coeffs.length - 1
  (List.range coeffs.length).sum λ k =>
    let k' := (k : ℝ)
    let n' := (n : ℝ)
    let binom := (Nat.choose n k : ℝ)
    coeffs.get? k |>.getD 0 * binom * (t ^ k) * ((1 - t) ^ (n - k))

#eval "Bernstein evaluation of [0, 0.25, 1] at t=0.5:"
-- Coefficients from x^2 at degree 2: f(0)=0, f(0.5)=0.25, f(1)=1
evalBernstein [0.0, 0.25, 1.0] 0.5

/-! ## Visualization Data Generator -/

/-- Generate (x, f_n(x)) pairs for plotting. -/
def generatePlotData (f_n : SequenceOfFunctions ℝ) (ns : List Nat)
    (xStart xEnd : ℝ) (numPoints : Nat) : List (Nat × List (ℝ × ℝ)) :=
  let dx := (xEnd - xStart) / (numPoints : ℝ)
  let xs := (List.range (numPoints+1)).map λ i => xStart + (i : ℝ) * dx
  ns.map λ n => (n, xs.map λ x => (x, f_n n x))

#eval "Plot data for x^n, n=1,3,5 on [0,1] with 10 points:"
let f_n : SequenceOfFunctions ℝ := λ n x => x ^ n
generatePlotData f_n [1, 3, 5] 0 1 10

#eval "--- Evaluate complete ---"

end MiniFunctionSequences.Computation
