#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[check][error] $*"; exit 1; }

DASHBOARD=0
if [[ "${1:-}" == "--dashboard" ]]; then
  DASHBOARD=1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

log "[check] repo: $ROOT_DIR"

command -v openclaw >/dev/null 2>&1 || die "未找到 openclaw。请先执行：bash scripts/macos/setup.sh"

log "[check] 运行健康检查：openclaw doctor"
openclaw doctor

log "[check] 运行状态检查：openclaw status"
openclaw status

if [[ "$DASHBOARD" -eq 1 ]]; then
  log "[check] 打开控制台：openclaw dashboard"
  openclaw dashboard
else
  log "[check] 跳过 dashboard（如需执行：bash scripts/macos/check.sh --dashboard）"
fi

log "[check] 通过（满足最小验收后可继续）"
