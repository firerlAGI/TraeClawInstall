# Trae IDE 通用指南（AI 智能体友好）

## 目标与适用范围

- 目标：用一条统一路径，在 Trae IDE 内完成 OpenClaw 的安装、启动、健康检查与初步排障。
- 适用对象：首次接触 Trae IDE / OpenClaw 的用户，以及需要稳定执行步骤的 AI 智能体。
- 默认主线：Node 22+ → OpenClaw CLI → `openclaw onboard --install-daemon` → `doctor/status/dashboard`。

## 输入与输出约定

### 输入

- 工作目录：仓库根目录。
- 终端环境：Trae IDE 内置终端（Windows 推荐 WSL2）。
- 必备工具：`node`、`npm`、`openclaw` 可在终端调用。

### 输出

- 通过：`openclaw doctor` 无阻断错误，`openclaw status` 显示服务可用，`openclaw dashboard` 可打开控制台。
- 失败：终端输出明确错误信息，并按“失败处理流程”进入下一步定位。

## 标准执行流程（SOP）

### Step 1：打开项目与终端

1. 在 Trae IDE 中打开仓库根目录（包含 `README.md`、`docs/`、`scripts/`）。
2. 打开内置终端并确认当前目录是仓库根目录：

```bash
pwd
ls
```

3. 若目录不正确，切换到仓库根目录后再继续执行。

### Step 2：检查基础环境

```bash
node --version
npm --version
openclaw --version
```

判定规则：
- `node --version` 主版本需 `>= 22`。
- `openclaw --version` 能返回版本号；若命令不存在，先安装 CLI（见 Step 3）。

### Step 3：安装与首次引导

```bash
npm install -g openclaw@latest
openclaw onboard --install-daemon
```

预期结果：
- 安装过程结束无致命报错。
- `onboard` 执行后给出下一步提示（如状态检查或 dashboard 入口）。

### Step 4：运行健康检查

```bash
openclaw doctor
openclaw status
openclaw dashboard
```

验收标准（最小）：
- `doctor`：关键依赖检查通过，未出现阻断级错误。
- `status`：核心服务处于运行或可连接状态。
- `dashboard`：可打开 Web 控制台（或输出可访问地址）。

## 日志与输出查看规范

### 在 Trae IDE 终端查看输出

- 实时观察：直接执行命令并读取终端输出。
- 复查最近执行：优先聚焦 `ERROR`、`failed`、`permission`、`not found` 关键字。
- 重跑原则：每次只改一个变量（例如仅升级 Node 或仅重装 CLI），避免混合变更。

### 常用定位命令

```bash
openclaw doctor
openclaw status
which node
which openclaw
```

用途说明：
- `doctor`：快速聚合环境问题。
- `status`：确认服务是否已启动。
- `which`：确认当前生效的可执行文件路径，排查 PATH 冲突。

## 失败处理流程（通用）

按顺序执行，不要跳步：

1. **记录错误原文**：保留首次报错行，避免二次信息污染。
2. **执行基线检查**：运行 `openclaw doctor` 与 `openclaw status`。
3. **确认版本与路径**：检查 `node --version`（需 22+）与 `which openclaw`。
4. **回到平台文档**：根据系统进入对应文档继续排障。
5. **最小化复现**：只执行一条失败命令，确认问题是否稳定复现。

## 下一步指引（按平台）

- Windows（推荐 WSL2）：`/docs/platforms/windows/`
- macOS：`/docs/platforms/macos/`
- Linux：`/docs/platforms/linux/`

建议执行顺序：
1. 先完成本通用指南。
2. 再进入对应平台文档执行平台特有步骤。
3. 若平台步骤失败，回到本指南“失败处理流程”做统一基线检查。

## 示例配置（无密钥）

- 示例文件：`examples/.env.example`
- 当前字段说明：
  - `OPENCLAW_HOME`：OpenClaw 的 home 路径（可选）
  - `OPENCLAW_STATE_DIR`：可变状态目录（可选）
  - `OPENCLAW_CONFIG_PATH`：配置文件路径（可选）

生效验证方式：
1. 在当前终端导出你需要的变量
2. 运行 `openclaw doctor`
3. 运行 `openclaw status`

## 安全基线配置（AI 智能体可执行）

### 目标

- 在安装第三方 skill 前，先完成来源与扫描结果核验。
- 在本机或服务器上，先完成一次 OpenClaw 安全基线体检。

### 输入与输出约定

#### 输入

- 已安装 OpenClaw CLI，且 `openclaw --version` 可用。
- 已安装或可通过 `npx` 调用 ClawHub CLI。

#### 输出

- 通过：待安装 skill 的扫描结果可见且风险可接受；`openclaw security audit` 无阻断级问题。
- 失败：任一项无法通过时，停止上线并先修复阻断项。

### SOP-A：ClawHub + VirusTotal 扫描核验（安装前）

1. 先搜索候选 skill：

```bash
clawhub search "security"
```

2. 查看目标 skill 详情与元信息：

```bash
clawhub inspect <skill-slug>
```

3. 在 ClawHub 技能页面确认扫描状态：
   - 优先 `benign`
   - 若为 `suspicious` 或 `malicious`，停止安装
4. 仅在核验通过后执行安装：

```bash
npx clawhub@latest install <skill-slug>
```

判定规则：
- 无扫描信息或来源不明：按高风险处理，不安装。
- 需要额外下载不透明二进制或执行未知脚本：按高风险处理，不安装。

### SOP-B：openclaw security audit 本地体检

1. 先执行标准审计：

```bash
openclaw security audit
```

2. 再执行深度审计：

```bash
openclaw security audit --deep
```

3. 若有可自动修复项，可先预览后修复：

```bash
openclaw security audit --fix
```

验收标准：
- 阻断级风险为 0。
- 网关暴露、认证缺失、危险配置开关等关键项已处理。
- 修复后重复执行 `openclaw security audit --deep`，结果稳定。

### 失败处理

1. 记录首条报错与对应命令。
2. 回退最近新增 skill 或配置改动。
3. 再次执行 `openclaw security audit --deep` 验证回退后状态。
