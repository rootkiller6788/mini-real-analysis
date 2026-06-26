import MiniMeasureLebesgue

open MiniMeasureLebesgue

def main : IO Unit := do
  IO.println "════════════════════════════════════════════════════"
  IO.println "  MiniMeasureLebesgue v0.1.0"
  IO.println "  Measure Theory and Lebesgue Integration"
  IO.println "════════════════════════════════════════════════════"
  IO.println s!"  Sigma-algebras and measurable spaces"
  IO.println s!"  Measures: countable additivity, continuity"
  IO.println s!"  Lebesgue measure on ℝ — translation-invariant"
  IO.println s!"  Measurable functions and simple functions"
  IO.println s!"  Lebesgue integral: MCT, DCT, Fatou, Fubini, Radon-Nikodym"
  IO.println s!"  L^p spaces as Banach spaces"
  IO.println s!"  Bridges: algebra, topology, geometry, computation"
  IO.println ""
  let sampleMeasure : MeasureSpace := default
  IO.println s!"  #eval test: Sample MeasureSpace theory = {sampleMeasure.theory}"
  IO.println s!"  Sample σ-algebra: {repr (SigmaAlgebra.empty (α := Nat))}"
  IO.println ""
  IO.println "  Run `lake build` to compile."
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
