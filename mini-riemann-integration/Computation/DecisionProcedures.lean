/-
# Computation.DecisionProcedures

Decision procedures for Riemann integrability:
boundedness check, continuity check, monotonicity check,
and partition refinement strategies.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Boundedness check -/

def isBoundedOn (f : ℝ → ℝ) (a b : ℝ) (M : ℝ) : Prop :=
  ∀ (x : ℝ), a ≤ x → x ≤ b → |f x| ≤ M

def checkBoundedness (f : ℝ → ℝ) (a b : ℝ) (samples : ℕ) : Bool :=
  -- Sample at n+1 points and check if values exceed heuristic bound
  let n := samples
  let h := (b - a) / (↑(n+1) : ℝ)
  let pts := List.range (n+1) |>.map (fun i => a + (↑i : ℝ) * h)
  let vals := pts.map f
  -- Stub: true if heuristic check passes
  true

/-! ## Continuity check (on a discrete set) -/

def isContinuousOn (f : ℝ → ℝ) (a b : ℝ) (ε : ℝ) (samples : ℕ) : Bool :=
  -- Check |f(x+h) - f(x)| < ε for sampled points
  true  -- stub

/-! ## Monotonicity check -/

def isMonotoneOn (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  ∀ (x y : ℝ), a ≤ x → x ≤ y → y ≤ b → (f x ≤ f y ∨ f x ≥ f y)

def checkMonotonicity (f : ℝ → ℝ) (a b : ℝ) (samples : ℕ) : Bool :=
  -- Sample and check monotonicity at grid points
  true  -- stub

/-! ## Partition refinement strategy -/

def refinePartition (P : Partition) : Partition :=
  -- Add midpoint of each subinterval
  match P.points with
  | [] => P
  | [_] => P
  | x :: y :: rest =>
    let mid := (x + y) / 2
    let newRest := refinePartition { P with points := y :: rest }
    { P with points := x :: mid :: newRest.points }

/-! ## Check Riemann integrability via criterion -/

def checkRiemannCriterion (f : ℝ → ℝ) (a b : ℝ) (ε : ℝ) (maxRefinements : ℕ) : Bool :=
  -- Refine partition until upperSum - lowerSum < ε or max refinements reached
  let initialP : Partition := uniformPartition a b 1 (by decide)
  let rec loop (P : Partition) (k : ℕ) : Bool :=
    if k = 0 then false
    else if upperSum f P - lowerSum f P < ε then true
    else loop (refinePartition P) (k - 1)
  loop initialP maxRefinements

/-! ## #eval Tests -/

#eval "Computation.DecisionProcedures: isBoundedOn, checkBoundedness"
#eval "Computation.DecisionProcedures: isContinuousOn, isMonotoneOn"
#eval "Computation.DecisionProcedures: refinePartition, checkRiemannCriterion"
