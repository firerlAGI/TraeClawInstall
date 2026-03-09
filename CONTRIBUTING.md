# 贡献指南（简版）

## 提交流程

1. 保持改动小而清晰：一次提交只做一件事
2. 提交信息使用中文，格式：

```text
<类型>: <简短描述>
```

常用类型：`feat` / `fix` / `refactor` / `chore` / `docs` / `test`

## 目录约定

- 新增文档：优先放在 `docs/common/` 或 `docs/platforms/<platform>/`
- 新增脚本：与文档保持镜像结构，优先放在 `scripts/<platform>/`；仅跨平台公共逻辑放 `scripts/common/`
- 示例配置：只允许放示例（不得提交真实密钥），放在 `examples/`
