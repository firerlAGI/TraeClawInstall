#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[linux-start][error] $*"; exit 1; }

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

command -v openclaw >/dev/null 2>&1 || die "未找到 openclaw。请先执行：bash scripts/linux/setup.sh"

log "[linux-start] 执行首次引导（可重复）：openclaw onboard --install-daemon"
openclaw onboard --install-daemon

log "[linux-start] 查看状态：openclaw status"
openclaw status
