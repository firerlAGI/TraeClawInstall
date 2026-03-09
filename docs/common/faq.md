# FAQ（跨平台）

## Q1：Windows 为什么推荐 WSL2？

答：OpenClaw 官方路径在类 Unix 环境更稳定，WSL2 能让 Windows 与 Linux 命令主线保持一致，减少权限和 PATH 差异问题。

## Q2：必须用 Docker 吗？

答：本仓库默认主线不是 Docker，而是 OpenClaw CLI（`openclaw onboard --install-daemon`）。这样更贴合新手“快速可运行”路径。

## Q3：Node 必须是 22+ 吗？

答：是。建议优先满足 Node 22+ 再执行任何安装命令，否则会出现版本不兼容问题。

## Q4：`openclaw` 命令找不到怎么办？

答：先检查 PATH 与 npm 全局目录。参考 `docs/common/troubleshooting.md` 的“openclaw: command not found”章节。

## Q5：`npm install -g openclaw@latest` 权限报错怎么办？

答：优先使用 nvm 管理 Node，让全局 npm 目录位于用户空间，避免 EACCES。

## Q6：`openclaw doctor` 报错要先看哪一条？

答：先处理阻断级错误。每修一条就重跑一次 `doctor`，不要一次改很多项。

## Q7：`openclaw status` 显示不可连接怎么办？

答：先重跑 `openclaw onboard --install-daemon`，再执行 `openclaw status`；仍失败则进入统一排障文档。

## Q8：dashboard 打不开怎么办？

答：先执行 `openclaw dashboard`，如果有 URL 输出就手动复制到浏览器；若命令报错，先回到 `doctor` 排查。

## Q9：为什么文档强调“AI 智能体友好”？

答：Trae IDE 是 AI 编程助手，结构化文档（输入/输出、SOP、判定规则）更利于 AI 与人类协同执行并减少歧义。

## Q10：从哪里开始最快？

答：先看仓库根 README 的“快速开始”，再看 `docs/common/trae-ide-guide.md`，最后进入你的平台文档。

## Q11：`docker-compose` 能用，但 `docker compose` 报错怎么办？

答：优先确保你使用的是 Docker Compose v2（推荐通过 Docker Desktop 安装）。不少教程还在写 v1 命令，当前主流文档以 `docker compose`（空格）为准。

## Q12：为什么 Docker 场景会出现 `exit 137` 或构建中断？

答：常见是内存不足。OpenClaw 官方 Docker 文档建议镜像构建至少预留 2GB 内存；若资源偏小，`pnpm install` 阶段容易被系统 OOM 杀掉。

## Q13：Docker 部署里 OAuth 回调页报错是不是失败了？

答：不一定。在 Docker/无头环境里，OpenAI Codex OAuth 回调页可能显示浏览器错误；按官方说明复制最终重定向 URL 回贴到向导，通常可继续完成授权。

## Q14：`npm install -g openclaw@latest` 遇到 EACCES，最稳妥怎么处理？

答：优先用 nvm 这类 Node 版本管理器，让 npm 全局目录落在用户目录，避免 sudo 安装带来的权限后遗症；这是 npm 官方推荐路径。

## Q15：`openclaw` 安装后命令仍找不到，最容易漏哪一步？

答：最常漏的是全局 npm bin 目录没有进入 PATH。先执行 `npm prefix -g` 和 `echo "$PATH"` 对照检查；修正 shell 配置后需重开终端再试。

## Q16：Docker 模式下一直“连接不上”或反复要求配对，先看什么？

答：先确认网关访问地址是否仍是本机回环（如 `127.0.0.1:18789`）以及 bind/mode 是否被改偏；再用 `devices list` 检查是否存在待审批设备请求。
