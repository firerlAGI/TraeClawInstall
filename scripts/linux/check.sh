#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[linux-check][error] $*"; exit 1; }

DASHBOARD="0"
if [[ "${1:-}" == "--dashboard" ]]; then
  DASHBOARD="1"
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

command -v openclaw >/dev/null 2>&1 || die "未找到 openclaw。请先执行：bash scripts/linux/setup.sh"

log "[linux-check] openclaw doctor"
openclaw doctor

log "[linux-check] openclaw status"
openclaw status

if [[ "$DASHBOARD" == "1" ]]; then
  log "[linux-check] openclaw dashboard"
  openclaw dashboard
fi

log "[linux-check] 完成"
