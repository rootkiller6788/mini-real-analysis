import MiniMetricTopology

open MiniMetricTopology

def main : IO Unit := do
  IO.println "════════════════════════════════════════"
  IO.println "  MiniMetricTopology v0.1.0"
  IO.println "  Metric Spaces: Topology Induced by Distance"
  IO.println "════════════════════════════════════════"
  IO.println s!"  Metric spaces, open/closed sets, balls"
  IO.println s!"  Isometries, contractions, Lipschitz maps"
  IO.println s!"  Completeness, compactness, connectedness"
  IO.println s!"  Product, subspace, quotient constructions"
  IO.println s!"  Completion and universal properties"
  IO.println ""
  IO.println "  Run `lake build` to compile."
  IO.println "  Run `lake env lean --run Test/Basic.lean` for tests."
