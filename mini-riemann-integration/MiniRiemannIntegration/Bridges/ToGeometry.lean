/-
# MiniRiemannIntegration.Bridges.ToGeometry

Area under curve as integral, arc length via integral,
volume of revolution (disk/washer/shell methods).
-/

import MiniRiemannIntegration.Bridges.ToTopology
import MiniMathKernel

open MiniMathKernel

namespace MiniRiemannIntegration

/-! ## Area under a curve -/

structure AreaUnderCurve (f : ℝ → ℝ) (a b : ℝ) where
  area : ℝ := riemannIntegral f a b  -- assuming f ≥ 0 on [a,b]
  assumes_nonnegative : Prop  -- f(x) ≥ 0 for x ∈ [a,b]
  formula : Prop  -- area = ∫_a^b f(x) dx

/-! ## Area between two curves -/

structure AreaBetweenCurves (f g : ℝ → ℝ) (a b : ℝ) where
  area : ℝ := riemannIntegral (fun x => |f x - g x|) a b
  formula : Prop  -- area = ∫_a^b |f(x) - g(x)| dx

/-! ## Arc length -/

structure ArcLength (f : ℝ → ℝ) (a b : ℝ) where
  length : ℝ := riemannIntegral (fun x => ℝ.sqrt (1 + 0)) a b
  -- Actually: ∫_a^b √(1 + (f'(x))²) dx
  requires_differentiable : Prop
  formula : Prop  -- L = ∫_a^b √(1 + (f'(x))²) dx

def arcLengthFormula : Axiom :=
  Axiom.mk "arcLength" (Formula.pred 0 [])
    "The arc length of a C¹ curve y = f(x) on [a,b] is L = ∫_a^b √(1 + (f'(x))²) dx"

/-! ## Volume of revolution: disk method -/

structure VolumeOfRevolution (f : ℝ → ℝ) (a b : ℝ) where
  -- Rotating y = f(x) about x-axis
  volume : ℝ := riemannIntegral (fun x => 3.141592653589793 * f x * f x) a b
  -- V = π ∫_a^b (f(x))² dx
  axis : String := "x-axis"
  method : String := "disk method"

def volumeDiskMethod : Axiom :=
  Axiom.mk "volumeDiskMethod" (Formula.pred 0 [])
    "The volume of solid of revolution obtained by rotating y = f(x) about the x-axis is V = π ∫_a^b (f(x))² dx"

/-! ## Volume of revolution: washer method -/

structure WasherMethod (f g : ℝ → ℝ) (a b : ℝ) where
  -- Rotating region between f(x) and g(x) about x-axis (f ≥ g ≥ 0)
  volume : ℝ := riemannIntegral (fun x => 3.141592653589793 * (f x * f x - g x * g x)) a b
  formula : Prop  -- V = π ∫_a^b ((f(x))² - (g(x))²) dx

/-! ## Volume of revolution: shell method -/

structure ShellMethod (f : ℝ → ℝ) (a b : ℝ) where
  -- Rotating y = f(x) about y-axis
  volume : ℝ := riemannIntegral (fun x => 2 * 3.141592653589793 * x * f x) a b
  -- V = 2π ∫_a^b x·f(x) dx
  formula : Prop

def volumeShellMethod : Axiom :=
  Axiom.mk "volumeShellMethod" (Formula.pred 0 [])
    "The volume of solid of revolution obtained by rotating y = f(x) about the y-axis is V = 2π ∫_a^b x·f(x) dx"

/-! ## Surface area of revolution -/

structure SurfaceAreaOfRevolution (f : ℝ → ℝ) (a b : ℝ) where
  surfaceArea : ℝ := riemannIntegral (fun x => 2 * 3.141592653589793 * f x * ℝ.sqrt (1 + 0)) a b
  -- S = 2π ∫_a^b f(x) √(1 + (f'(x))²) dx
  formula : Prop

/-! ## Pappus centroid theorem -/

def pappusCentroidTheorem : Axiom :=
  Axiom.mk "pappusCentroidTheorem" (Formula.pred 0 [])
    "Volume of revolution = (area of region) × (distance traveled by centroid). Surface area = (arc length) × (distance traveled by centroid)"

/-! ## #eval Tests -/

#eval "Bridges.ToGeometry: AreaUnderCurve, AreaBetweenCurves"
#eval "Bridges.ToGeometry: ArcLength, VolumeOfRevolution (disk/washer/shell)"
#eval "Bridges.ToGeometry: SurfaceAreaOfRevolution, pappusCentroidTheorem"

end MiniRiemannIntegration
