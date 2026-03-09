# 最小验收标准（AI 智能体友好）

## 目标

用一组稳定、可重复的命令判断 OpenClaw 是否“已安装 + 可运行 + 可自检”。

## 输入与输出

### 输入

- 终端：Trae IDE 内置终端（Windows 推荐 WSL2）
- 前置：Node 22+，可访问 npm registry

### 输出

- 通过：所有验收命令返回成功，且无阻断级错误
- 不通过：任一命令失败；按“失败处理”进入排障路径

## 验收命令（按顺序）

### Step 1：版本与 PATH 基线

```bash
node --version
npm --version
openclaw --version
```

判定：
- `node` 主版本 `>= 22`
- `openclaw` 命令存在并能返回版本号

### Step 2：首次引导与 daemon（可重复执行）

```bash
openclaw onboard --install-daemon
```

判定：
- 命令正常结束，并给出下一步提示或完成信息

### Step 3：健康检查与状态

```bash
openclaw doctor
openclaw status
```

判定：
- `doctor` 无阻断级错误
- `status` 能显示服务状态（运行/可连接等）

### Step 4：控制台入口

```bash
openclaw dashboard
```

判定：
- 能打开浏览器或输出可访问地址

## 失败处理（统一入口）

按顺序执行，不要跳步：

1. 复制保存首次报错行
2. 重跑 `openclaw doctor` 与 `openclaw status`
3. 确认 PATH 与版本：

```bash
which node || true
which openclaw || true
node --version || true
openclaw --version || true
```

4. 进入排障总表：`docs/common/troubleshooting.md`
