# macOS 部署指南

本指南面向 **macOS（Intel / Apple Silicon）**，在本机完成 OpenClaw CLI 安装、daemon 安装/启动，并通过最小健康检查。

## 目标与验收

- 目标：完成 OpenClaw CLI 安装、首次引导（安装 daemon），并能正常查看状态与打开控制台。
- 最小验收：
  - `openclaw doctor` 无阻断级错误
  - `openclaw status` 显示服务可用（或可连接）
  - `openclaw dashboard` 能输出可访问地址（或能打开控制台）

## 输入与约定（AI 友好）

- **工作目录**：仓库根目录（包含 `docs/`、`scripts/`）。
- **优先终端**：Trae IDE 内置终端（或系统 Terminal/iTerm2）。
- **默认主线命令**：`onboard/doctor/status/dashboard`。
- **脚本入口**：`scripts/macos/{setup,start,check}.sh`

## 前置条件（只做一次）

### 1) 安装基础工具（Command Line Tools）

如尚未安装，执行：

```bash
xcode-select --install
```

### 2) 安装 Node 22+（二选一）

判定规则：`node --version` 主版本必须 `>= 22`。

#### 方案 A：Homebrew（简单）

安装 Homebrew（如已安装可跳过）：

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

安装 Node：

```bash
brew install node@22
node --version
npm --version
```

#### 方案 B：nvm（更稳定，避免全局 npm 权限问题）

```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 22
nvm use 22
node --version
```

## 标准执行流程（macOS）

从仓库根目录执行以下三条脚本（按顺序）：

### Step 1：安装（setup）

```bash
bash scripts/macos/setup.sh
```

### Step 2：启动（start）

```bash
bash scripts/macos/start.sh
```

### Step 3：验证（check）

```bash
bash scripts/macos/check.sh
```

如需要拉起控制台（dashboard），执行：

```bash
bash scripts/macos/check.sh --dashboard
```

## 常见问题（macOS）

- **Node 版本不够（< 22）**：按“前置条件”升级 Node 后再执行脚本。
- **`npm install -g` 报权限错误（EACCES）**：优先使用 nvm 方案；或检查是否用 Homebrew 安装 Node 且全局目录权限异常。
- **`openclaw status` 连不上 / daemon 未启动**：先执行 `bash scripts/macos/setup.sh` 重新跑 `openclaw onboard --install-daemon`，再执行 `bash scripts/macos/start.sh`。
- **后台进程被系统拦截**：检查「系统设置 → 通用 → 登录项与扩展（后台项目）」里是否需要允许相关后台项。

## 统一排障入口

- 最小验收标准：`docs/common/acceptance.md`
- 统一排障总表：`docs/common/troubleshooting.md`
- FAQ：`docs/common/faq.md`
