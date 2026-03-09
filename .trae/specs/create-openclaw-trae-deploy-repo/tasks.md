# Tasks
- [x] Task 0: 确认 OpenClaw 官方安装与验收命令
  - [x] SubTask 0.1: 基于官方文档确定 Node 版本要求与安装方式
  - [x] SubTask 0.2: 明确默认主线命令（onboard/doctor/status/dashboard）
  - [x] SubTask 0.3: 明确 Windows 的推荐运行方式（WSL2）

- [x] Task 1: 建立仓库基础结构与入口文档
  - [x] SubTask 1.1: 创建 README、LICENSE、CONTRIBUTING、.gitignore
  - [x] SubTask 1.2: 创建 docs、scripts、examples 目录骨架
  - [x] SubTask 1.3: 在 README 提供分平台导航与快速开始入口

- [x] Task 2: 编写 Trae IDE 通用使用指南
  - [x] SubTask 2.1: 说明在 Trae IDE 中打开项目与终端
  - [x] SubTask 2.2: 说明运行部署命令与查看日志的方式
  - [x] SubTask 2.3: 补充通用失败处理与下一步指引

- [x] Task 3: 完成 Windows（WSL2 优先）部署指南与脚本
  - [x] SubTask 3.1: 编写 Windows/WSL2 前置条件、安装、启动、验证文档
  - [x] SubTask 3.2: 提供 Windows 入口脚本（可为 PowerShell 包装 WSL 或 WSL 内脚本入口）
  - [x] SubTask 3.3: 添加 Windows 常见问题排查项

- [x] Task 4: 完成 macOS 部署指南与脚本
  - [x] SubTask 4.1: 编写 macOS 前置条件、安装、启动、验证文档
  - [x] SubTask 4.2: 提供 setup.sh、start.sh、check.sh
  - [x] SubTask 4.3: 添加 macOS 常见问题排查项

- [ ] Task 5: 完成 Linux 部署指南与脚本
  - [ ] SubTask 5.1: 编写 Linux 前置条件、安装、启动、验证文档
  - [ ] SubTask 5.2: 提供 setup.sh、start.sh、check.sh
  - [ ] SubTask 5.3: 添加 Linux 常见问题排查项

- [ ] Task 6: 完成统一验收、FAQ 与最终校对
  - [ ] SubTask 6.1: 编写统一健康检查与最小验收标准
  - [ ] SubTask 6.2: 汇总跨平台 FAQ 并链接到对应排障步骤
  - [ ] SubTask 6.3: 统一命名、路径、命令格式并做最终走查

# Task Dependencies
- Task 1 depends on Task 0
- Task 2 depends on Task 1
- Task 3 depends on Task 1
- Task 4 depends on Task 1
- Task 5 depends on Task 1
- Task 6 depends on Task 2, Task 3, Task 4, Task 5
