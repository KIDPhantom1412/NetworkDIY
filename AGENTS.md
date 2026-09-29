# AGENTS.md

## 项目说明

本仓库是 Stanford **CS144 Fall 2025**（计算机网络，基于现代 C++）Lab 的 Starter Code 备份，用于个人学习。核心目标是按顺序完成 Lab 0–7，最终用 C++ 实现一个可端到端通信的 TCP/IP 协议栈。

- **学习路线**：以 `handouts/checkN.pdf` 实验文档为主线（`checkN_dual.pdf` 为中英对照版），不看视频课，纯 CS144 Lab 路线。详细计划见 `学习方案.md`。
- **目录结构**：
  - `src/` —— Lab 实现代码（`byte_stream`、后续的 `reassembler`、`tcp_receiver`、`tcp_sender` 等）
  - `util/` —— 课程提供的工具库（Socket、Address、EventLoop 等，一般不改）
  - `apps/` —— 应用程序（如 `webget.cc`）
  - `tests/` —— 测试代码
  - `handouts/` —— 实验文档 PDF
  - `writeups/` —— 每个 Lab 的简短报告（`checkN.md`）
- **构建与测试**（CMake + ctest）：

  ```bash
  cmake -S . -B build          # 配置（merge 新 starter 分支后重跑一次）
  cmake --build build          # 编译
  ctest --test-dir build       # 全部测试（默认排除 speed_test 和 webget）
  ctest --test-dir build -R <测试名>   # 单个测试
  ```

- **代码风格**：遵循 `.clang-format`；新增代码匹配周边现有代码的命名与结构；不随意改动 `util/` 下课程提供的代码。

## 分支规范

- **个人学习分支统一使用 `kid_` 前缀**，当前主工作分支为 `kid_lab`。所有 Lab 实现、报告都提交在 `kid_` 分支上。
- **`main` 保持干净**：不在 `main` 上写代码，它只作为 checkpoint 0 的原始基线。如需重新开始某个 Lab，可从 `main` 重新切分支。
- **官方 starter 分支只读**：`origin/checkN-startercode` 是课程各 Lab 的接口与测试代码，通过 `git merge` 合入 `kid_lab`，不直接在其上提交。
- **每个 Lab 的流程**：
  1. 在 `kid_lab` 上实现代码并通过对应测试
  2. `git add -A && git commit -m "Finish Lab N"` 提交
  3. 在 `writeups/checkN.md` 写简短报告（设计思路 + 踩坑）
  4. `git merge origin/checkN+1-startercode` 进入下一个 Lab，冲突解决后提交
- **merge 冲突取舍**：代码文件（如 `util/debug.hh`）通常采用 starter 分支版本；`README.md`、`学习方案.md` 等个人文档保留 `kid_lab` 版本。
- **提交信息**：简洁说明完成的内容，如 `Finish Lab 1: Reassembler`。
