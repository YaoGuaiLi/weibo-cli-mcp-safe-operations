# 微博 CLI/MCP 安全运营 Skill

面向 AI Agent 的第三方使用指南，指导 Agent 更好、更安全地使用 **微博官方 MCP 和 CLI**。

**本项目不是微博协议逆向项目，不提供非官方接口、逆向能力或绕过平台权限的方案，也不是微博官方产品。**

> **费用说明：微博 CLI 和 MCP 属于微博官方服务，涉及官方收费。** 体验服务、正式 Credit、接口价格、额度及有效期以微博官方当前规则为准。安装本 Skill 不代表开通官方服务，也不免除调用费用。

## 作者

- 作者：**YaoEIF**
- 主页：https://github.com/YaoGuaiLi/weibo-cli-mcp-safe-operations
- 邮箱：yaoguaili@foxmail.com

## 功能与边界

- **第一步始终是环境检查**：运行环境、工具版本、OAuth、开发者认证、服务状态、配额和实时能力目录。
- 默认只读；上传、发布、评论、点赞、删除等写操作必须获得人工确认。
- 根据实时 schema 选择 CLI 或 MCP，不把历史目录当作永久能力承诺。
- 区分 CLI 本地图片路径与 MCP Base64/Data URL/HTTPS 图片输入。
- 按官方要求处理 AI 内容声明，不把省略参数等同于不打标。
- 不含凭证；不同客户端按需独立完成官方 OAuth。
- 受控自进化：记录非敏感问题与改进建议，经人工审批后更新，不自动削弱安全规则。

Skill 是对 Agent 的行为指导，并不是运行时权限沙箱。使用方应配合 MCP 客户端工具审批、操作白名单及最小权限设置。

## 安装与首次使用

1. 下载仓库，保留 `SKILL.md` 与 `references/` 的目录关系。
2. 将文件夹放入目标 Agent 支持的 skills 目录，或通过客户端的 Skill 导入功能安装。具体发现路径由客户端决定。
3. 让 Agent 阅读 [SKILL.md](SKILL.md)，首先执行 [环境初始化指南](references/environment-init.md)。
4. 安装依赖、修改配置、OAuth 授权和购买服务是独立步骤；按实际需要由使用方确认。
5. 首次验证只读取能力目录和少量已授权查询，不发布测试微博，不上传素材。

MCP 配置示例见 [mcp-config.example.json](references/mcp-config.example.json)。不同客户端的配置字段可能不同，请按对应客户端文档适配。

**不要将 Token、Cookie、OAuth 缓存、回调授权码、私人账号数据或运行日志提交到此仓库。**

## 官方文档

- [微博 CLI 使用手册](https://open.weibo.com/cli/manual#manual)
- [微博 MCP 接入说明](https://open.weibo.com/cli/manual/mcp)

## 验证范围

本 Skill 基于官方文档、授权后的 CLI/MCP 工具目录及少量只读查询编写。未为验证默认打标行为发布测试内容。工具目录可发现不等于当前套餐可调用；正式费用和额外权限必须分别核实。

## 反馈与更新

通过 GitHub Issues 提交经过脱敏的环境、版本、错误与复现步骤。自进化提案格式见 [变更记录模板](references/safety-change-log.template.md)。不要上传凭证或私人素材。
