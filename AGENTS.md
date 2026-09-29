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

## 阅读 handout PDF 的方法

AI agent 无法直接读取 PDF（二进制格式），统一使用 `scripts/read-pdf.sh`。其内部通过 **Windows 侧的 uv + PyMuPDF** 实现（共享环境说明见 `~/.agents/AGENTS.md`）：因为 Windows 进程看不到 WSL 文件系统，脚本和 PDF 会先暂存到 Windows `%TEMP%`（`C:\Users\xiang\AppData\Local\Temp\read-pdf`）再调用 `uv.exe`。Python 依赖由 uv 按 PEP 723 内联元数据（`scripts/read-pdf.py` 文件头）自动管理，无需在 WSL 或 Windows 全局安装任何 Python 包。

- **读文字**：`bash scripts/read-pdf.sh text handouts/checkN.pdf [起始页] [结束页]`，文本输出到 stdout 直接阅读；省略页码则输出全文。
- **看页面图示**（报文格式图、时序图等纯文本提取不到的内容）：`bash scripts/read-pdf.sh render handouts/checkN.pdf 起始页 结束页 /tmp/<前缀> [dpi]`（dpi 默认 150），再用 ReadMediaFile 读取输出的 PNG。渲染产物一律放 `/tmp`，不进入项目目录。

## 分支规范

- **远程仓库**：`kid` = 自己的仓库（KIDPhantom1412/NetworkDIY，public，日常 push 目标；也存有全部 starter 分支作为备份，保证仓库自包含）；`origin` = 原备份仓库（rinevard/NetworkDIY，只用于获取 starter 分支；若原仓库失效，改用 `kid/checkN-startercode` 作为 merge 来源）。
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
