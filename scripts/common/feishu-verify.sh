#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[feishu-verify][error] $*"; exit 1; }

if ! command -v openclaw >/dev/null 2>&1; then
  die "未找到 openclaw，请先安装并完成基础引导。"
fi

log "[1/6] 版本"
openclaw --version

log "[2/6] 网关状态"
openclaw gateway status || true

log "[3/6] 插件状态"
openclaw plugins list

log "[4/6] 待审批配对"
openclaw pairing list feishu || true

log "[5/6] 重启网关"
openclaw gateway restart

log "[6/6] 实时日志"
openclaw logs --follow
