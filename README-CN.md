# Mini Real Analysis（迷你实分析）

一套**从零开始的 Lean 4 实现**，涵盖大学层次的实分析、微积分基础与测度论。每个子包对应 MIT 及其他顶尖大学课程，使用 Lean 4 证明助手和内核库从第一性原理构建实分析的基础。

## 子包

| 子包 | 主题 | 核心课程 |
|------|------|----------|
| [mini-real-numbers](mini-real-numbers/) | 实数构造、完备性、阿基米德性质 | MIT 18.100A, Harvard Math 112 |
| [mini-sequence-series](mini-sequence-series/) | 序列、级数、收敛判别法、幂级数 | MIT 18.100A, Berkeley Math 104 |
| [mini-continuity](mini-continuity/) | 极限、连续性、一致连续性、介值定理与极值定理 | MIT 18.100A, Stanford Math 115 |
| [mini-differentiation](mini-differentiation/) | 导数、中值定理、泰勒展开、凸性 | MIT 18.100A, Princeton MAT 215 |
| [mini-riemann-integration](mini-riemann-integration/) | 黎曼积分、微积分基本定理、反常积分 | MIT 18.100A, Harvard Math 112 |
| [mini-function-sequences](mini-function-sequences/) | 逐点/一致收敛、Arzela-Ascoli、Stone-Weierstrass | MIT 18.100B, Berkeley Math 105 |
| [mini-metric-topology](mini-metric-topology/) | 度量空间、开/闭集、完备性、紧性 | MIT 18.100B, Cambridge Part II |
| [mini-measure-lebesgue](mini-measure-lebesgue/) | 勒贝格测度、可测集、外测度、Caratheodory | MIT 18.102, Stanford Math 172 |

## 设计理念

- **零外部依赖** -- 纯 Lean 4，仅导入内核模块及同级子包
- **自包含子包** -- 每个子包拥有独立的 `lakefile.lean`、Core/、Morphisms/、Constructions/、Theorems/
- **理论到代码的映射** -- 每个模块包含内联 `#eval` 示例和定理陈述

## 构建

```bash
cd mini-real-numbers
lake build
lake env lean --run Test/Smoke.lean
```

需要 **Lean 4** 和 **Lake**。

## 项目结构

```
6. mini-real-analysis/
├── mini-real-numbers/              # 实数构造、完备性
├── mini-sequence-series/           # 序列、级数、收敛判别法
├── mini-continuity/                # 极限、连续性、介值/极值定理
├── mini-differentiation/           # 导数、中值定理、泰勒展开
├── mini-riemann-integration/       # 黎曼积分、微积分基本定理、反常积分
├── mini-function-sequences/        # 一致收敛、Arzela-Ascoli、Stone-Weierstrass
├── mini-metric-topology/           # 度量空间、完备性、紧性
└── mini-measure-lebesgue/          # 勒贝格测度、Caratheodory 扩张
```

## 许可证

MIT
