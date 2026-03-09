# Linux 部署指南（AI 智能体友好）

## 目标与默认主线

- 目标：在 Linux + Trae IDE 中完成 OpenClaw 安装、首次引导、健康检查与基础排障。
- 默认主线：Node 22+ → OpenClaw CLI → `openclaw onboard --install-daemon` → `doctor/status/dashboard`。
- 工作目录：仓库根目录。

## 输入与输出约定

### 输入

- 终端：Trae IDE 内置终端（或系统终端）
- 可执行：`node`、`npm`、`openclaw`

### 输出（最小验收）

- `openclaw doctor` 无阻断级错误
- `openclaw status` 能显示服务状态
- `openclaw dashboard` 能打开或输出可访问地址

## Step 1：前置条件

- Node 版本：22+（必须）
- 推荐方式：使用 nvm 管理 Node（避免系统包管理器版本过旧）

## Step 2：安装 Node 22+（推荐 nvm）

如果你的系统已经有 Node 22+，可跳过本步骤。

```bash
node --version
```

若版本不足或未安装，建议按 nvm 官方方式安装并切换到 Node 22+（不同发行版命令略有差异）。

## Step 3：一键执行（推荐脚本入口）

从仓库根目录执行：

```bash
bash scripts/linux/setup.sh
bash scripts/linux/start.sh
bash scripts/linux/check.sh --dashboard
```

## Step 4：手动执行（脚本等价命令）

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon

openclaw doctor
openclaw status
openclaw dashboard
```

## Step 5：常见问题（Linux）

### 1) openclaw: command not found

```bash
npm prefix -g
echo "$PATH"
which openclaw || true
```

处理原则：
- 确认全局 npm bin 目录在 PATH 中（通常是 `$(npm prefix -g)/bin`）
- 重新打开终端后再试

### 2) Node 版本过旧

```bash
node --version
```

处理原则：
- 优先用 nvm 升级到 Node 22+
- 避免与系统自带 Node 产生 PATH 冲突（可用 `which node` 定位）

### 3) daemon 安装失败 / 权限问题

```bash
openclaw doctor
openclaw status
```

处理原则：
- 先把 `doctor` 输出作为唯一事实来源
- 确认是否在容器/受限环境中运行（systemd user service 可能不可用）

## 下一步

- 通用 Trae IDE 执行规范：`docs/common/trae-ide-guide.md`
- 统一排障与 FAQ：`docs/common/troubleshooting.md`、`docs/common/faq.md`
- 最小验收标准：`docs/common/acceptance.md`
