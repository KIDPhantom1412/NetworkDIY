NetworkDIY
==============================

本仓库备份了 Stanford **CS144 Fall 2025** 的 Starter Code，用于个人学习：基于现代 C++ 按顺序完成 Lab 0–7，最终实现一个可端到端通信的 TCP/IP 协议栈。

实验文档及其中英对照（机翻）在 [handouts](./handouts/) 文件夹中，学习流程与分支规范见 [学习方案](./学习方案.md) 和 [AGENTS.md](./AGENTS.md)。

## 使用方法

每个 Lab 的学习流程：

1. 读 `handouts/checkN.pdf` 实验文档
2. 实现对应源文件（见 `学习方案.md` 的各 Lab 明细）
3. 构建并用 ctest 验证
4. 提交实现，merge 下一个 starter 分支，进入下一个 Lab

## 构建与测试

```bash
cmake -S . -B build          # 配置（只需一次，merge 新分支后建议重跑一次）
cmake --build build          # 编译
ctest --test-dir build       # 跑全部测试（默认排除 speed_test 和 webget）
```

## 资源链接

| 资源名 | 链接 |
| :--- | :--- |
| CS144 官网 | https://cs144.github.io/ |
| CS144 Labs | https://github.com/CS144/minnow |

感谢 Stanford CS144 开源的顶级课程资源。
