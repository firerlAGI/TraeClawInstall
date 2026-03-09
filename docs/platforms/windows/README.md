# Windows 部署指南（WSL2 优先）

本仓库在 Windows 上的推荐运行方式是 **WSL2（Ubuntu）**：在 WSL2 里安装 Node/OpenClaw，并在 WSL2 终端执行脚本与命令。

## 目标与验收

- 目标：在 WSL2 内完成 OpenClaw CLI 安装、daemon 安装/启动，并通过最小健康检查。
- 最小验收：
  - `openclaw doctor` 无阻断级错误
  - `openclaw status` 显示服务可用（或可连接）
  - `openclaw dashboard` 能输出可访问地址（或能打开控制台）

## 输入与约定（AI 友好）

- **工作目录**：仓库根目录（包含 `docs/`、`scripts/`）。
- **优先终端**：Trae IDE 内置终端的 WSL2（或 Windows Terminal 的 WSL2）。
- **默认主线命令**：`onboard/doctor/status/dashboard`。
- **脚本入口**：
  - WSL 内（推荐）：`scripts/windows/wsl/*.sh`
  - Windows PowerShell 包装（可选）：`scripts/windows/*.ps1`（内部调用 WSL）

## 前置条件（只做一次）

### 1) 安装/启用 WSL2

在 Windows（管理员 PowerShell）执行：

```powershell
wsl --install
```

重启后确认 WSL 可用：

```powershell
wsl --status
wsl -l -v
```

建议使用 Ubuntu 22.04/24.04（任一均可）。

### 2) 在 WSL2 中准备基础工具

进入 WSL2（Ubuntu）后执行：

```bash
sudo apt update
sudo apt install -y curl ca-certificates git build-essential
```

### 3) 安装 Node 22+（推荐 nvm）

WSL2 内推荐用 nvm 管理 Node（避免全局 npm 权限问题）：

```bash
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.nvm/nvm.sh
nvm install 22
nvm use 22
node --version
```

判定规则：`node --version` 主版本必须 `>= 22`。

## 标准执行流程（WSL2 内）

从仓库根目录执行以下三条脚本（按顺序）：

### Step 1：安装（setup）

```bash
bash scripts/windows/wsl/setup.sh
```

### Step 2：启动（start）

```bash
bash scripts/windows/wsl/start.sh
```

### Step 3：验证（check）

```bash
bash scripts/windows/wsl/check.sh
```

如需要拉起控制台（dashboard），执行：

```bash
bash scripts/windows/wsl/check.sh --dashboard
```

## 可选：从 Windows PowerShell 直接触发（包装 WSL）

仅当你希望“在 Windows 侧一键触发 WSL 执行”时使用：

```powershell
# 可能需要允许当前会话执行本地脚本
Set-ExecutionPolicy -Scope Process Bypass

.\scripts\windows\setup.ps1
.\scripts\windows\start.ps1
.\scripts\windows\check.ps1
.\scripts\windows\check.ps1 -Dashboard
```

## 常见问题（Windows/WSL2）

- **`wsl` 不存在 / `wsl --status` 报错**：确认系统版本支持 WSL2，使用管理员 PowerShell 执行 `wsl --install` 并重启。
- **Node 版本不够（< 22）**：在 WSL2 内按上文用 nvm 安装 Node 22，并重新打开终端后再跑脚本。
- **`npm install -g` 权限问题**：优先使用 nvm（Node 安装在用户目录），避免 sudo 安装 Node。
- **在 `/mnt/c/...` 下运行很慢或权限异常**：建议把仓库 clone 到 WSL 的 Linux 文件系统（如 `~/Projects/Traeclaw`）再执行脚本。
- **DNS/网络导致安装失败**：先确认 WSL 能访问外网（如 `curl https://registry.npmjs.org/`），必要时配置代理或切换网络。

## 统一排障入口

- 最小验收标准：`docs/common/acceptance.md`
- 统一排障总表：`docs/common/troubleshooting.md`
- FAQ：`docs/common/faq.md`
