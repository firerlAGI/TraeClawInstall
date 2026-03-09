# OpenClaw Trae IDE 跨平台部署仓库 Spec

## Why
需要一个面向新手、可复制执行的 GitHub 仓库，教会 Windows / macOS / Linux 用户使用 Trae IDE 部署并验证 OpenClaw 可运行，降低环境差异导致的失败率。

## What Changes
- 新增一个公开仓库骨架：文档目录、脚本目录、示例配置目录与基础仓库元信息文件。
- 新增面向 Trae IDE 的“统一操作路径”：如何打开工作区、执行脚本、查看日志、完成健康检查。
- 新增三套分平台部署指南（Windows/macOS/Linux），结构一致，命令可复制执行。
- 新增分平台脚本入口：`setup`（准备环境）、`start`（启动 OpenClaw）、`check`（健康检查）。
- 新增排障与 FAQ：把高频错误收敛到固定入口，提供可执行的自检步骤。
- 明确 OpenClaw 的默认安装与验证命令：以 Node 22+ 与 OpenClaw CLI（`openclaw`）为主线，包含 `openclaw onboard`、`openclaw doctor`、`openclaw status`、`openclaw dashboard`。

## Impact
- Affected specs: 文档体系、脚本体系、仓库结构、部署与验收流程
- Affected code: 将新增仓库文件（README、docs、scripts、examples 等）；不对 OpenClaw 上游代码做强依赖修改

## ADDED Requirements
### Requirement: 仓库骨架
系统 SHALL 提供一个 GitHub 仓库骨架，包含 docs、scripts、examples 等目录，并能承载跨平台部署教程。

#### Scenario: 新用户首次打开仓库
- **WHEN** 用户在 Trae IDE 打开仓库根目录
- **THEN** 用户能从 README 进入对应系统教程并找到唯一推荐的启动入口（脚本或统一命令）

### Requirement: Trae IDE 教学路径
系统 SHALL 提供一份 Trae IDE 通用说明，覆盖打开项目、运行命令、查看输出/日志、常见失败处理。

#### Scenario: 在 Trae IDE 运行启动脚本
- **WHEN** 用户按文档在 Trae IDE 终端执行启动命令
- **THEN** 用户能看到清晰的预期输出，并在失败时根据下一步指引定位问题

### Requirement: 分平台部署指南一致性
系统 SHALL 为 Windows/macOS/Linux 分别提供部署指南，且三者章节结构保持一致（前置条件、安装、配置、启动、验证、排障）。

#### Scenario: 读者从任意平台指南开始
- **WHEN** 读者进入任一平台文档
- **THEN** 能在固定章节中快速找到“启动”和“验证”步骤，且命名与路径与其他平台一致

### Requirement: OpenClaw 默认安装与启动路径
系统 SHALL 以 OpenClaw 官方推荐路径作为默认主线：Node 22+ + 全局安装 OpenClaw CLI，并通过 `openclaw onboard --install-daemon` 完成首次配置与网关守护进程安装。

#### Scenario: 新用户按默认路径部署
- **WHEN** 用户按文档安装 Node 22+ 并安装 OpenClaw CLI
- **THEN** 用户可以在终端完成 `openclaw onboard --install-daemon` 并获得可继续执行的下一步指引（如启动、状态查看或打开 dashboard）

### Requirement: Windows 运行方式（WSL2 优先）
系统 SHALL 在 Windows 指南中将 WSL2 作为首选运行环境路径（以降低依赖与权限差异），并把“非 WSL2 的 Windows 运行方式”明确标注为可选/不推荐路径（若上游支持）。

#### Scenario: Windows 用户从零开始
- **WHEN** 用户在 Windows 上按文档启用并进入 WSL2
- **THEN** 后续命令与 Linux 指南保持最大一致性（同一套 OpenClaw CLI 命令与验收动作）

### Requirement: 健康检查与验收标准
系统 SHALL 提供健康检查入口（脚本或命令），并在文档中定义最小验收标准（例如：进程存活、端口可访问、关键日志出现）。

#### Scenario: 用户完成部署后验证
- **WHEN** 用户执行健康检查
- **THEN** 能获得明确的“通过/失败”结果，并在失败时给出下一步排查入口

### Requirement: 安全与配置示例
系统 SHALL 使用示例配置文件承载环境变量示例，且不得提交任何真实密钥或敏感信息。

#### Scenario: 用户需要填写配置
- **WHEN** 用户复制示例配置并填写本地值
- **THEN** 文档明确指出哪些字段必须填、哪些可选，以及如何验证配置是否生效

## MODIFIED Requirements
无。

## REMOVED Requirements
无。
