import Lake
open Lake DSL

package «mini-function-sequences» where

@[default_target]
lean_lib «MiniFunctionSequences» where
  roots := #[`MiniFunctionSequences]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
require «mini-metric-topology» from "../mini-metric-topology"
require «mini-continuity» from "../mini-continuity"
