import Lake
open Lake DSL

package «mini-sequence-series» where

@[default_target]
lean_lib «MiniSequenceSeries» where
  roots := #[`MiniSequenceSeries, `Benchmark, `Computation, `Test, `docs]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
