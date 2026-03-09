#!/usr/bin/env bash
set -euo pipefail

log() { printf '%s\n' "$*"; }
die() { log "[setup][error] $*"; exit 1; }

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$ROOT_DIR"

log "[setup] repo: $ROOT_DIR"

command -v node >/dev/null 2>&1 || die "未找到 node。请先在 WSL2 安装 Node 22+（推荐 nvm），再重试。"
command -v npm >/dev/null 2>&1 || die "未找到 npm。请确认 Node 安装完整后重试。"

NODE_MAJOR="$(node -p "process.versions.node.split('.')[0]")"
if [[ "$NODE_MAJOR" -lt 22 ]]; then
  die "Node 版本过低：$(node --version)（需要 >= 22）。请升级后重试。"
fi

if ! command -v openclaw >/dev/null 2>&1; then
  log "[setup] 安装 OpenClaw CLI：npm install -g openclaw@latest"
  npm install -g openclaw@latest
else
  log "[setup] 已存在 openclaw：$(openclaw --version || true)"
fi

log "[setup] 执行首次引导并安装 daemon：openclaw onboard --install-daemon"
openclaw onboard --install-daemon

log "[setup] 完成"
