#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[start][error] $*"; exit 1; }

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT_DIR"

log "[start] repo: $ROOT_DIR"

command -v openclaw >/dev/null 2>&1 || die "未找到 openclaw。请先执行：bash scripts/windows/wsl/setup.sh"

log "[start] 检查当前状态：openclaw status"
if ! openclaw status; then
  log "[start] status 失败，尝试重新执行 onboard（安装/修复 daemon）：openclaw onboard --install-daemon"
  openclaw onboard --install-daemon
  log "[start] 重新检查状态：openclaw status"
  openclaw status
fi

log "[start] 启动流程结束（如需控制台：openclaw dashboard）"
