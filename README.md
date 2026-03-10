# OpenClaw Trae IDE 跨平台部署仓库

Fire 和 Trae IDE 共同设计本仓库，由Trae完成代码开发，在此致谢😘

只需要会四件事：

1. 在 Trae IDE 中新建一个项目。  
2. 把本仓库链接 `https://github.com/firerlAGI/TraeClawInstall` 放在对话框中，说：“帮我下载这个仓库到本地”。  
3. Trae IDE 下载完成后，在 Trae IDE 设置中将仓库目录下的 `SKILL.md` 添加到技能列表。  
4. 对 Trae 智能体说：“帮我部署 openclaw 到本地”。

本项目为AI智能体阅读友好型，所有的文件都是AI智能体可以直接阅读并执行的，不需要用人类用户手动操作。

官方参考：
- https://docs.openclaw.ai/start/getting-started
- https://docs.openclaw.ai/install

以下为智能体可以阅读的内容：

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
- 飞书自检脚本：`scripts/common/feishu-verify.sh`
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
│   ├── common/
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
