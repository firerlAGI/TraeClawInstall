# OpenClaw 飞书配置步骤与常见坑

## 适用范围

- 场景：已完成 OpenClaw CLI 安装，希望接入飞书作为消息入口。
- 默认路径：优先使用 OpenClaw 内置 Feishu 渠道（`channels.feishu`）。
- 参考来源：
  - OpenClaw 飞书渠道文档（zh-CN）：https://docs.openclaw.ai/zh-CN/channels/feishu
  - 飞书官方插件文章：https://www.feishu.cn/content/article/7613711414611463386

## Step 0：先做最小基线检查

```bash
openclaw --version
openclaw gateway status
openclaw plugins list
```

通过标准：
- `openclaw` 命令可用；
- 网关可启动/可重启；
- 插件列表能正常输出（用于后续排查插件冲突）。

## Step 1：在飞书开放平台创建应用

1. 创建企业自建应用并添加“机器人”能力。
2. 在“凭证与基础信息”记录 `App ID`（`cli_xxx`）与 `App Secret`。
3. 在“权限管理”按官方页面批量导入权限。
4. 进入“版本管理与发布”，创建版本并发布。

注意：
- `App Secret` 不要写入仓库；
- 权限改动后要重新发布版本，否则线上仍按旧权限运行。

## Step 2：在 OpenClaw 添加飞书渠道

方式 A（首次安装推荐）：

```bash
openclaw onboard
```

方式 B（已装好 OpenClaw）：

```bash
openclaw channels add
```

根据提示选择 Feishu，填入 `App ID` 与 `App Secret`。

## Step 3：配置事件订阅（高频踩坑点）

在飞书后台“事件与回调”：
- 订阅方式选择“长连接（WebSocket）”；
- 添加事件 `im.message.receive_v1`。

前置条件（缺一不可）：
- 已执行过 `openclaw channels add`（或 `onboard` 中完成飞书配置）；
- 网关处于运行状态（`openclaw gateway status` 为可用）。

否则常见现象：长连接配置“保存失败”或“看似保存但消息收不到”。

## Step 4：启动与配对

```bash
openclaw gateway restart
openclaw logs --follow
```

在飞书给机器人发消息后，若收到配对码，在终端批准：

```bash
openclaw pairing list feishu
openclaw pairing approve feishu <CODE>
```

## 仓库内程序与脚本

- 验收脚本：`scripts/common/feishu-verify.sh`
- 配置示例：`examples/openclaw.feishu.example.json`

执行方式：

```bash
bash scripts/common/feishu-verify.sh
```

## 文档脚本示例（用于验收与回归）

> 下面脚本用于“改完配置后快速自检”，可直接复制到终端执行。

```bash
bash scripts/common/feishu-verify.sh
```

使用建议：
- 先看 `plugins list`，再看 `logs --follow`；
- 若日志无入站事件，优先回查“事件订阅 + 应用发布 + 网关状态”三项。

## 常见坑与处理

1. **事件订阅已配，但机器人收不到消息**  
   优先检查：网关是否在跑、事件是否为 `im.message.receive_v1`、应用是否已发布。

2. **群里不回复，但私聊正常**  
   优先检查：是否需要 `@`（`requireMention`）、`groupPolicy` 是否限制了群。

3. **总是出现配对码，无法持续对话**  
   优先检查：是否批准了最新配对码（`openclaw pairing approve feishu <CODE>`）。

4. **国际版 Lark 可登录但消息异常**  
   优先检查：是否设置 `domain: "lark"`（适用于 Lark 国际版租户）。

5. **切换飞书方案后行为异常**  
   优先检查：`openclaw plugins list` 中飞书相关插件状态是否符合预期（避免混用状态残留）。

6. **API 调用量偏高或配额吃紧**  
   可按需关闭：
   - `typingIndicator`
   - `resolveSenderNames`

## 快速定位命令

```bash
openclaw gateway status
openclaw gateway restart
openclaw logs --follow
openclaw plugins list
openclaw pairing list feishu
```
