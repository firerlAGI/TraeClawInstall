---
name: "TraeClawInstall"
description: "统一执行 Traeclaw 仓库的 OpenClaw 安装、启动、验收与排障流程；当用户希望在本仓库一站式完成部署或检查时调用。"
---

# OpenClaw 仓库一体化技能

## 技能目标

将本仓库视为一个整体，统一完成 OpenClaw 的平台识别、安装、启动、验收与排障，不再拆分多个独立技能。

## 适用场景（何时调用）

- 用户要求“在本地部署openclaw”
- 用户要求“按这个仓库整体流程执行”
- 用户希望在 Trae IDE 内一站式完成部署和验证
- 用户未明确平台细节，但希望直接得到可执行路径
- 用户出现安装/启动异常，需要按仓库标准流程排障

## 输入前提

- 当前工作目录为仓库根目录
- 可使用终端执行命令
- 可访问仓库文档与脚本

## 决策路由

1. 识别平台：
   - Windows：优先 WSL2，走 `scripts/windows/wsl/*.sh`
   - macOS：走 `scripts/macos/*.sh`
   - Linux：走 `scripts/linux/*.sh`
2. 校验基线：
   - `node --version` 主版本需 `>=22`
   - `npm --version` 可用
   - `openclaw --version` 若不存在则由 setup 安装
3. 执行标准三步：
   - `setup -> start -> check`
4. 执行最小验收：
   - `openclaw doctor`
   - `openclaw status`
   - `openclaw dashboard`
5. 任一步失败则进入统一排障流程

## 标准执行步骤（SOP）

### Step 0：读取关键入口

- `README.md`
- `docs/common/trae-ide-guide.md`
- `docs/common/acceptance.md`
- `docs/common/troubleshooting.md`
- `docs/common/install-config-checklist.md`
- 对应平台 `docs/platforms/<platform>/README.md`

### Step 1：按平台脚本执行

- Windows（WSL2）：
  - `bash scripts/windows/wsl/setup.sh`
  - `bash scripts/windows/wsl/start.sh`
  - `bash scripts/windows/wsl/check.sh`
- macOS：
  - `bash scripts/macos/setup.sh`
  - `bash scripts/macos/start.sh`
  - `bash scripts/macos/check.sh`
- Linux：
  - `bash scripts/linux/setup.sh`
  - `bash scripts/linux/start.sh`
  - `bash scripts/linux/check.sh`

如需 dashboard，可在 check 步骤追加 `--dashboard`。

### Step 2：验收判定

- 必须完成 `doctor/status/dashboard` 三项检查
- 结论分为：通过 / 失败待修复

### Step 3：失败分诊

1. 保存首次报错行
2. 重跑：
   - `openclaw doctor`
   - `openclaw status`
3. 核对：
   - `which node || true`
   - `which openclaw || true`
   - `node --version || true`
   - `openclaw --version || true`
4. 按 `docs/common/troubleshooting.md` 对应章节修复
5. 每次只改一个变量并复验

## 输出约定

- 成功：给出平台、执行步骤、验收结果与可访问状态
- 失败：给出首个错误、已验证动作、下一步修复建议

## 约束

- 优先复用仓库现有文档和脚本，不创建平行流程
- 不写入真实密钥，仅使用示例配置
- Windows 场景优先在 WSL2 Linux 文件系统执行
