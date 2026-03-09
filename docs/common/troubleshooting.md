# 统一排障（AI 智能体友好）

## 总原则

- 单一事实来源：以 `openclaw doctor` 输出为主，不要凭感觉猜。
- 最小化变量：一次只改一个因素（只换 Node 版本 / 只重装 openclaw / 只改 PATH）。

## 0) 先跑基线（所有平台通用）

```bash
node --version
npm --version
openclaw --version

openclaw doctor
openclaw status
```

把输出分成两类：
- 环境问题：Node 版本、PATH、npm 全局目录、权限
- OpenClaw 问题：daemon/状态/配置

## 1) openclaw: command not found

### 诊断

```bash
npm prefix -g
echo "$PATH"
which openclaw || true
```

### 处理

- macOS/Linux：把 `$(npm prefix -g)/bin` 加到 PATH（重开终端后生效）
- Windows：优先在 WSL2 内执行（参考 `docs/platforms/windows/README.md`）

## 2) Node 版本过旧（< 22）

### 诊断

```bash
node --version
which node || true
```

### 处理

- 推荐用 nvm 安装并切换到 Node 22+
- 如系统自带 Node 过旧，避免 PATH 指向旧版本

## 3) npm 全局安装权限错误（EACCES / permission denied）

### 诊断

```bash
npm prefix -g
```

### 处理

- 优先使用 nvm（Node 安装在用户目录，避免 sudo）
- 不建议用 sudo 直接 `npm install -g`（会增加权限混乱概率）

## 4) openclaw doctor 报错

处理原则：
- 把 `doctor` 的阻断项逐条消掉
- 每修复一条，就重跑 `openclaw doctor` 验证

## 5) status 显示不可连接 / daemon 未运行

### 诊断

```bash
openclaw status
```

### 处理

- 重新执行：

```bash
openclaw onboard --install-daemon
openclaw status
```

若仍失败：
- macOS：检查系统后台项目/权限设置
- Linux：若在容器或无 systemd user 环境中运行，daemon 可能不可用
- Windows：确认在 WSL2 内执行，并尽量在 WSL Linux 文件系统下运行（非 `/mnt/c`）

## 6) dashboard 打不开

### 诊断

```bash
openclaw dashboard
```

### 处理

- 记录输出的 URL 并手动在浏览器打开
- 若无输出或报错，先回到 `openclaw doctor` 排查

## 7) Windows/WSL2 特有问题

- WSL 不可用：管理员 PowerShell 执行 `wsl --install` 并重启
- 运行很慢：把仓库 clone 到 WSL 内（如 `~/Projects/...`），不要在 `/mnt/c/...` 下跑
- 网络问题：在 WSL 内先确认 `curl https://registry.npmjs.org/` 可用

## 下一步

- 最小验收清单：`docs/common/acceptance.md`
- 平台指南入口：`docs/platforms/*/README.md`
