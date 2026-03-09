# AI 使用说明（仓库操作手册）

## 1. 文档目标

- 面向执行型 AI 智能体，提供“可直接落地”的仓库使用路径。
- 目标结果：在目标平台完成 OpenClaw 的安装、启动、验收与基础排障。

## 2. 仓库定位

- 这是一个“部署与操作仓库”，不是业务应用源码仓库。
- 核心内容是文档（`docs/`）与脚本（`scripts/`）的镜像结构。
- 默认主线：Node 22+ → OpenClaw CLI → `onboard` → `doctor/status/dashboard`。

## 3. 输入 / 输出约定

### 输入

- 工作目录：仓库根目录。
- 可用终端：Trae IDE 内置终端（Windows 优先 WSL2）。
- 前置能力：可执行 `node`、`npm`、`openclaw`（若未安装，按流程安装）。

### 输出

- 成功：`openclaw doctor` 无阻断错误，`openclaw status` 可用，`openclaw dashboard` 可打开或输出可访问地址。
- 失败：保留首次报错原文，并进入统一排障流程。

## 4. 决策路由（先判定，再执行）

按以下顺序判定：

1. 识别平台：
   - Windows：优先走 `docs/platforms/windows/README.md` 与 `scripts/windows/wsl/*.sh`
   - macOS：走 `docs/platforms/macos/README.md` 与 `scripts/macos/*.sh`
   - Linux：走 `docs/platforms/linux/README.md` 与 `scripts/linux/*.sh`
2. 确认 Node 主版本是否 `>= 22`。
3. 确认 `openclaw` 是否存在；不存在则先安装 CLI。
4. 执行标准三步：`setup` → `start` → `check`。
5. 验收失败则进入 `docs/common/troubleshooting.md`。

## 5. 标准执行流程（SOP）

### Step 0：确认在仓库根目录

```bash
pwd
ls
```

### Step 1：基线检查

```bash
node --version
npm --version
openclaw --version
```

判定规则：

- Node 主版本必须 `>= 22`。
- `openclaw --version` 必须可返回版本号。

### Step 2：执行平台脚本

按平台执行：

- Windows（WSL2 内）：

```bash
bash scripts/windows/wsl/setup.sh
bash scripts/windows/wsl/start.sh
bash scripts/windows/wsl/check.sh
```

- macOS：

```bash
bash scripts/macos/setup.sh
bash scripts/macos/start.sh
bash scripts/macos/check.sh
```

- Linux：

```bash
bash scripts/linux/setup.sh
bash scripts/linux/start.sh
bash scripts/linux/check.sh
```

如需 dashboard：

```bash
bash scripts/<platform>/check.sh --dashboard
```

说明：Windows 需要替换为 `scripts/windows/wsl/check.sh --dashboard`。

### Step 3：最小验收

```bash
openclaw doctor
openclaw status
openclaw dashboard
```

## 6. 失败处理规则

失败时必须执行以下动作，不可跳步：

1. 保存首次报错行。
2. 重跑：

```bash
openclaw doctor
openclaw status
```

3. 检查路径与版本：

```bash
which node || true
which openclaw || true
node --version || true
openclaw --version || true
```

4. 进入 `docs/common/troubleshooting.md` 对应章节逐条消障。

## 7. 文件入口索引（给 AI 的最短路径）

- 总入口：`README.md`
- 通用执行：`docs/common/trae-ide-guide.md`
- 验收标准：`docs/common/acceptance.md`
- 统一排障：`docs/common/troubleshooting.md`
- 平台入口：
  - `docs/platforms/windows/README.md`
  - `docs/platforms/macos/README.md`
  - `docs/platforms/linux/README.md`

## 8. 执行约束

- 一次只改一个变量，避免并发改动导致定位困难。
- 所有操作优先复用现有文档与脚本，不新增平行流程。
- 不在仓库中写入真实密钥；仅可使用 `examples/.env.example` 作为示例。
- Windows 场景优先在 WSL2 Linux 文件系统运行，避免 `/mnt/c/...` 性能与权限问题。

## 9. 推荐执行模板（可直接复用）

```text
任务目标：
在 <平台> 上完成 OpenClaw 安装、启动和验收。

执行顺序：
1) 读取 README.md 与对应平台 README
2) 执行 setup/start/check
3) 运行 doctor/status/dashboard
4) 若失败，按 troubleshooting.md 逐条修复

完成判定：
- doctor 无阻断错误
- status 可用
- dashboard 可访问
```
