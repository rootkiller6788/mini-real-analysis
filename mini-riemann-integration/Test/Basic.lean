/-
# Test.Basic

~8 #eval tests on partitions, Riemann sums, and integrals.
-/

import MiniRiemannIntegration
import MiniMathKernel

open MiniRiemannIntegration
open MiniMathKernel

/-! ## Test 1: Partition creation and mesh -/

def testPartition1 : Partition :=
  { points := [0, 1, 3, 6, 10]
    a := 0
    b := 10
    sorted := True.intro
    covers := True.intro
    nonempty := by decide
  }

#eval "Test 1: Partition mesh = " ++ toString (Partition.mesh testPartition1)
#eval "Test 1: Num subintervals = " ++ toString (Partition.numSubintervals testPartition1)

/-! ## Test 2: Darboux sums for f(x) = x on [0, 2] -/

def f_identity (x : ℝ) : ℝ := x

def testPartition2 : Partition :=
  { points := [0, 0.5, 1, 1.5, 2]
    a := 0
    b := 2
    sorted := True.intro
    covers := True.intro
    nonempty := by decide
  }

#eval "Test 2: upperSum(f(x)=x, [0,0.5,1,1.5,2]) = " ++ toString (upperSum f_identity testPartition2)
#eval "Test 2: lowerSum(f(x)=x, [0,0.5,1,1.5,2]) = " ++ toString (lowerSum f_identity testPartition2)

/-! ## Test 3: Upper/Lower sums for f(x) = x^2 -/

def f_square (x : ℝ) : ℝ := x * x

def testPartition3 : Partition :=
  { points := [0, 1, 2]
    a := 0
    b := 2
    sorted := True.intro
    covers := True.intro
    nonempty := by decide
  }

#eval "Test 3: upperSum(f(x)=x^2, [0,1,2]) = " ++ toString (upperSum f_square testPartition3)
#eval "Test 3: lowerSum(f(x)=x^2, [0,1,2]) = " ++ toString (lowerSum f_square testPartition3)

/-! ## Test 4: Riemann sum value -/

def tags : List ℝ := [0.25, 0.75, 1.25, 1.75]
#eval "Test 4: RiemannSum value for f(x)=x on [0,0.5,1,1.5,2] = " ++
  toString (riemannSumValue f_identity testPartition2 tags)

/-! ## Test 5: Uniform partition -/

def uniform_part : Partition := uniformPartition 0 1 4 (by decide)
#eval "Test 5: Uniform partition [0,1] with 4 subintervals: points = " ++
  toString uniform_part.points

/-! ## Test 6: Riemann integrability check (stub) -/

#eval "Test 6: isRiemannIntegrable (stub): always false for the stub implementation"

/-! ## Test 7: L¹ norm -/

def f_constant (x : ℝ) : ℝ := 3
#eval "Test 7: L1Norm f(x)=3 on [0,2] (stub) = " ++ toString (L1Norm f_constant 0 2)

/-! ## Test 8: L² norm -/

#eval "Test 8: L2Norm f(x)=3 on [0,2] (stub) = " ++ toString (L2Norm f_constant 0 2)

/-! ## Test summary -/

#eval "Test.Basic: 8 tests completed — partitions, Darboux sums, Riemann sums, uniform partitions, norms"
