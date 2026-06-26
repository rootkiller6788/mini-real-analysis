import Lake
open Lake DSL

package «mini-continuity» where

@[default_target]
lean_lib «MiniContinuity» where
  roots := #[`MiniContinuity]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
require «mini-real-numbers» from "../mini-real-numbers"
require «mini-sequence-series» from "../mini-sequence-series"
