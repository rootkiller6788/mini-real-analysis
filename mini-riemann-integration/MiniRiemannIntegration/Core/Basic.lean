/-
# MiniRiemannIntegration.Core.Basic

Partitions, Darboux sums, Riemann sums, Riemann integral,
Darboux integral, and improper integrals.
-/

import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Partition of an interval -/

structure Partition where
  points : List ℝ
  a : ℝ
  b : ℝ
  sorted : Prop  -- a = x₀ < x₁ < ... < xₙ = b
  covers : Prop  -- points.head = a, points.last = b
  nonempty : points.length ≥ 2
  deriving Repr, Inhabited

def Partition.mesh (P : Partition) : ℝ :=
  -- Maximum subinterval width: max_{i} (x_{i+1} - x_i)
  match P.points with
  | [] => 0
  | [_] => 0
  | x :: y :: rest =>
    let diff := y - x
    let restPart : Partition := { P with points := y :: rest }
    ℝ.max diff (mesh restPart)

def Partition.numSubintervals (P : Partition) : Nat :=
  P.points.length - 1

/-! ## Darboux sums -/

def upperSum (f : ℝ → ℝ) (P : Partition) : ℝ :=
  -- Σ_{i} sup_{x ∈ [x_i, x_{i+1}]} f(x) * (x_{i+1} - x_i)
  -- Here we use a simplified computation for evaluation
  sumSup f P.points

def lowerSum (f : ℝ → ℝ) (P : Partition) : ℝ :=
  sumInf f P.points

private def sumSup (f : ℝ → ℝ) : List ℝ → ℝ
  | [] => 0
  | [_] => 0
  | x :: y :: rest =>
    let sup_val := ℝ.max (f x) (f y)  -- simplification: sample endpoints
    sup_val * (y - x) + sumSup f (y :: rest)

private def sumInf (f : ℝ → ℝ) : List ℝ → ℝ
  | [] => 0
  | [_] => 0
  | x :: y :: rest =>
    let inf_val := ℝ.min (f x) (f y)
    inf_val * (y - x) + sumInf f (y :: rest)

/-! ## Darboux integral (upper and lower) -/

def upperIntegral (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- inf over all partitions of upper sum
  -- Stub: returns a placeholder; real implementation uses infimum
  0

def lowerIntegral (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- sup over all partitions of lower sum
  0

/-! ## Riemann integrability -/

def isRiemannIntegrable (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  upperIntegral f a b = lowerIntegral f a b

def riemannIntegral (f : ℝ → ℝ) (a b : ℝ) : ℝ :=
  -- When integrable, the common value
  upperIntegral f a b

/-! ## Darboux integrability criterion -/

def isDarbouxIntegrable (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  -- f is Darboux integrable iff ∀ ε > 0 ∃ P: U(f,P) - L(f,P) < ε
  ∀ (ε : ℝ), ε > 0 → ∃ (P : Partition), upperSum f P - lowerSum f P < ε

/-! ## Riemann sum -/

structure RiemannSum (f : ℝ → ℝ) (P : Partition) where
  tags : List ℝ  -- sample points, one per subinterval
  tagsValid : tags.length = P.numSubintervals
  value : ℝ  -- Σ f(t_i) * (x_{i+1} - x_i)
  deriving Repr

def riemannSumValue (f : ℝ → ℝ) (P : Partition) (tags : List ℝ) : ℝ :=
  evaluateRiemannSum f P.points tags

private def evaluateRiemannSum (f : ℝ → ℝ) : List ℝ → List ℝ → ℝ
  | [], _ => 0
  | [_], _ => 0
  | x :: y :: rest, t :: ts =>
    f t * (y - x) + evaluateRiemannSum f (y :: rest) ts
  | _, _ => 0

/-! ## Improper integrals -/

inductive ImproperIntegralKind
  | unboundedInterval  -- ∫_a^∞ or ∫_{-∞}^b or ∫_{-∞}^∞
  | unboundedFunction  -- f unbounded near a point
  | both
  deriving Repr, BEq

structure ImproperIntegral (f : ℝ → ℝ) where
  kind : ImproperIntegralKind
  lowerLimit : ℝ
  upperLimit : ℝ
  convergent : Prop
  value : ℝ
  conditionallyConvergent : Prop  -- converges but not absolutely
  deriving Repr

def isImproperIntegral (f : ℝ → ℝ) (a b : ℝ) : Prop :=
  -- f is improperly Riemann integrable on [a,b] if limits exist
  ∃ (I : ImproperIntegral f), I.convergent

/-! ## Regular partition helper -/

def uniformPartition (a b : ℝ) (n : Nat) (h : n > 0) : Partition where
  points := List.range (n + 1) |>.map (fun i => a + (b - a) * (↑i / ↑n))
  a := a
  b := b
  sorted := True.intro
  covers := True.intro
  nonempty := by
    have hpos : n + 1 ≥ 2 := by
      omega
    exact hpos

/-! ## #eval Tests -/

def testPartition : Partition :=
  { points := [0, 1, 2, 3]
    a := 0
    b := 3
    sorted := True.intro
    covers := True.intro
    nonempty := by decide
  }

#eval "Core.Basic: Partition with mesh: " ++ toString (Partition.mesh testPartition)

def f_sqr (x : ℝ) : ℝ := x * x
#eval "Core.Basic: upperSum(x^2, [0,1,2]) = " ++ toString (upperSum f_sqr { testPartition with points := [0, 1, 2] })
#eval "Core.Basic: lowerSum(x^2, [0,1,2]) = " ++ toString (lowerSum f_sqr { testPartition with points := [0, 1, 2] })
#eval "Core.Basic: RiemannIntegration: Partitions, Darboux sums, RiemannSum, ImproperIntegral defined"

end MiniRiemannIntegration
