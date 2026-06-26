import MiniRealNumbers

open MiniRealNumbers

def main : IO Unit := do
  IO.println "════════════════════════════════════════"
  IO.println "  MiniRealNumbers v0.1.0"
  IO.println "  Real Numbers: Complete Ordered Field"
  IO.println "════════════════════════════════════════"
  IO.println s!"  Complete Ordered Field with Dedekind cuts"
  IO.println s!"  Cauchy sequences and completeness"
  IO.println s!"  Supremum/infimum, Archimedean property"
  IO.println s!"  Uniqueness of ℝ up to unique isomorphism"
  IO.println ""
  let x : RealNumbers := 42.0
  IO.println s!"  #eval test: repr({x}) = {repr x}"
  IO.println ""
  IO.println "  Run `lake build` to compile."
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
