# OpenClaw Trae IDE 跨平台部署仓库

本仓库用于帮助新手在 Trae IDE 中，按统一路径完成 OpenClaw 的安装、启动与验收。  
默认主线：**Node 22+ + OpenClaw CLI + WSL2（Windows 优先）**。

官方参考：
- https://docs.openclaw.ai/start/getting-started
- https://docs.openclaw.ai/install

## 快速开始（统一入口）

1. 检查 Node 版本（需 22+）：

```bash
node --version
```

2. 安装 OpenClaw CLI（推荐官方安装脚本或 npm 全局安装）：

```bash
npm install -g openclaw@latest
```

3. 首次引导并安装守护进程：

```bash
openclaw onboard --install-daemon
```

4. 执行基础验收命令：

```bash
openclaw doctor
openclaw status
openclaw dashboard
```

## 平台导航

- Windows（推荐 WSL2）：`docs/platforms/windows/`
- macOS：`docs/platforms/macos/`
- Linux：`docs/platforms/linux/`

## Trae IDE 使用路径

- 通用指南：`docs/common/trae-ide-guide.md`
- AI 使用说明：`docs/common/ai-agent-usage.md`
- 安装配置检查清单：`docs/common/install-config-checklist.md`
- 飞书配置步骤与常见坑：`docs/common/feishu-setup-pitfalls.md`
- 最小验收标准：`docs/common/acceptance.md`
- 统一排障：`docs/common/troubleshooting.md`
- FAQ：`docs/common/faq.md`
- 在 Trae IDE 打开仓库根目录
- 在内置终端执行 `scripts/` 下对应平台脚本
- 失败时先执行 `openclaw doctor`，再回到对应平台文档排障

## AI 友好目录结构

```text
.
├── docs/
│   ├── common/
│   └── platforms/
│       ├── windows/
│       ├── macos/
│       └── linux/
├── scripts/
│   ├── windows/
│   ├── macos/
│   └── linux/
├── examples/
├── README.md
├── CONTRIBUTING.md
├── LICENSE
└── .gitignore
```

设计原则：
- 单一事实来源：跨平台共通内容放 `docs/common/`
- 平台隔离：各平台命令与排障放在 `docs/platforms/*`
- 脚本镜像文档结构：便于 AI/人类按目录推断入口与依赖关系
