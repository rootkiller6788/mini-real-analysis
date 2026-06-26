import Lake
open Lake DSL

package «mini-metric-topology» where

@[default_target]
lean_lib «MiniMetricTopology» where
  roots := #[`MiniMetricTopology]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
