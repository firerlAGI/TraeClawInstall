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
