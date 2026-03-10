# 安装配置检查清单（AI 可勾选）

## 使用说明

- 场景：用于安装 OpenClaw 前后的逐项核对，避免漏步骤。
- 用法：AI 或人工执行每一项后，将 `- [ ]` 改为 `- [x]`。
- 判定：所有“必选项”勾选完成后，进入最小验收流程。

## 0. 基础环境（必选）

- [ ] 先判断当前系统：Windows / macOS / Linux（Windows 优先走 WSL2）
- [ ] 在 Trae IDE 中打开仓库根目录
- [ ] 可用终端正常（Windows 推荐 WSL2）
- [ ] `node --version` 主版本 `>= 22`
- [ ] `npm --version` 可正常返回版本

## 1. CLI 安装与可用性（必选）

- [ ] 已执行 `npm install -g openclaw@latest`（或官方等价安装方式）
- [ ] `openclaw --version` 可返回版本号
- [ ] `which openclaw`（或平台等价命令）能定位到可执行文件

## 2. 首次引导与服务（必选）

- [ ] 已执行 `openclaw onboard --install-daemon`
- [ ] `openclaw status` 可显示服务状态
- [ ] 若有报错，已保存首次报错原文

## 3. 平台脚本执行（按需）

- [ ] Windows（WSL2）：已执行 `scripts/windows/wsl/setup.sh`
- [ ] Windows（WSL2）：已执行 `scripts/windows/wsl/start.sh`
- [ ] Windows（WSL2）：已执行 `scripts/windows/wsl/check.sh`
- [ ] macOS：已执行 `scripts/macos/setup.sh`
- [ ] macOS：已执行 `scripts/macos/start.sh`
- [ ] macOS：已执行 `scripts/macos/check.sh`
- [ ] Linux：已执行 `scripts/linux/setup.sh`
- [ ] Linux：已执行 `scripts/linux/start.sh`
- [ ] Linux：已执行 `scripts/linux/check.sh`

## 4. 最小验收（必选）

- [ ] 已执行 `openclaw doctor`
- [ ] `doctor` 无阻断级错误
- [ ] 已执行 `openclaw status`
- [ ] 已执行 `openclaw dashboard`
- [ ] dashboard 可打开或输出可访问地址

## 5. 失败处理（出现问题时必选）

- [ ] 已重跑 `openclaw doctor` 与 `openclaw status`
- [ ] 已核对 PATH 与版本（`which node` / `which openclaw` / 版本命令）
- [ ] 已按 `docs/common/troubleshooting.md` 对应章节排障

## 6. 完成判定

- [ ] 必选项均已勾选完成
- [ ] 当前环境可稳定重复执行 `status` 与 `doctor`
