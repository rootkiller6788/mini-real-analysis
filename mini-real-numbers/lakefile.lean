import Lake
open Lake DSL

package «mini-real-numbers» where

@[default_target]
lean_lib «MiniRealNumbers» where
  roots := #[`MiniRealNumbers]

require «mini-object-kernel» from "../../0. mini-math-kernel/mini-object-kernel"
