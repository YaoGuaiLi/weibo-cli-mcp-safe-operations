---
name: weibo-cli-mcp-safe-operations
description: Use when an agent must initialize, inspect, automate, or operate Weibo through weibo-cli or the official MCP server, especially when OAuth, local media, publishing, AI-content declarations, quotas, billing, or safe sharing with other agents is involved.
---

# Weibo CLI/MCP Safe Operations

## Author and project scope

- Author: **YaoEIF**
- Homepage: https://github.com/YaoGuaiLi/weibo-cli-mcp-safe-operations
- Email: yaoguaili@foxmail.com

This is an independent third-party Agent Skill guiding agents to use **Weibo's official CLI and MCP** more effectively and safely. It is **not** a reverse-engineering project for Weibo protocols or undocumented capabilities, and is not an official Weibo product.

**Billing notice:** Weibo CLI/MCP are official services with paid usage. Trial access may be limited; service eligibility, Credit pricing, quotas and expiry are governed by Weibo's current official terms. Installing this Skill does not purchase service, grant API access, or bypass billing.

Initialization guide: [Environment setup](references/environment-init.md). Public config: [MCP example](references/mcp-config.example.json). Improvement proposals: [Change-log template](references/safety-change-log.template.md).

## Core contract

Use the official Weibo CLI and MCP only. This Skill contains no account credentials. **Environment inspection is always step 1.** Default mode is read-only. Publishing, uploading, commenting, liking, following, messaging, deletion, paid-content creation, and account/profile changes require a separate, explicit confirmation immediately before that specific action.

“Ensure unrestricted capability” means inspect documented access, trial/paid status, quotas, and errors—not bypass them. Never extract, print, copy, or share tokens, cookies, OAuth codes, keychain files, or browser sessions.

## Step 1: environment check

Check without mutating Weibo content:

```powershell
weibo-cli version
weibo-cli doctor
weibo-cli me --output table
weibo-cli commands list --available --output json
mcporter config list --json
mcporter list weibo --schema --json
```

Report separately: CLI installed/version; OAuth status; developer verification; service/plan; trial/paid access; available command/tool counts; read/write methods; quota and price fields. A catalog entry is not proof that a call succeeded. Do not call `article_preview` during a “no side effect” check: it creates/overwrites a temporary preview.

If authorization is missing or expired, direct the human to the official OAuth flow. Do not ask for or accept tokens. Do not silently switch accounts. If a service is unavailable by region, report it; do not bypass geo, payment, or entitlement controls.

## CLI and MCP choice

They currently expose the same official command catalog when authorized, with normalized names such as `statuses/update` ↔ `statuses_update`; still compare the live schemas because catalogs change. CLI is preferred for scripts, logs, schedules, and local file paths. MCP is preferred for conversational analysis and drafting. Neither is inherently safer: the operation method and confirmation gate determine risk.

MCP config (credentials are obtained through OAuth, never placed in JSON):

```json
{
  "mcpServers": {
    "weibo": {
      "type": "streamableHttp",
      "url": "https://cli.weibo.com/mcp"
    }
  }
}
```

Each other agent/client should perform its own official OAuth authorization unless it is demonstrably the same client and credential store. Never package the current account’s OAuth cache in a Skill.

## Read-only operations

Read-only candidates include user/profile lookup, timelines, status details, comments/followers/friends lists, search, tags, trends, statistics, and live schema discovery. Check method and side-effect notes first. GET does not automatically mean side-effect-free. Never infer that read permission authorizes publishing.

For reads, use bounded retries only for safe/idempotent requests. Do not retry ambiguous POST/upload/publish calls; first verify whether the operation succeeded to avoid duplicates.

## Write gate

Before any write, show the human:

1. exact tool/command and HTTP method;
2. target account and visibility;
3. complete text and selected media;
4. `mblog_statement` value;
5. expected side effect and whether it is reversible;
6. trial/paid quota and expected Credit cost.

Ask for explicit confirmation for that exact payload and operation. “Set up”, “prepare”, “make it ready”, or “test” is not publish permission. Never use a real account for a harmless-looking test post unless the human explicitly approves the exact post.

High-risk operations (delete, article publishing, paid columns, profile changes, mass interactions) require a second confirmation. `article_publish` can publish an article and a short Weibo together and is not reversible; never call it casually.

## Local media

CLI publishing tools may accept a local file path. MCP cannot read a caller’s `C:\...`, `/home/...`, or `file://` path. For MCP image upload, use a Data URL, Base64, or a server-accessible HTTPS URL. Preserve originals; validate format/size locally; do not upload during initialization. Multi-image publishing commonly requires `statuses_upload_pic` followed by `statuses_upload_url_text`; both are writes.

Discover video support from the live catalog; do not infer it from image support.

## AI/content declaration

For publishing tools that expose `mblog_statement`, use the value required by the content:

- `0` no declaration
- `1` AI generated
- `2` fictional/dramatized
- `3` reposted content
- `4` self-created content

The field is optional in the live schema, but its omission does **not** prove the server’s final default behavior. If content is AI-generated, follow Weibo’s documented requirement and set `mblog_statement=1`. Do not choose CLI vs MCP to evade labeling. Some upload tools may not expose this field; select a documented publishing path that does when a declaration is required.

## Controlled self-evolution

“Self-evolution” means maintaining a human-reviewable, non-secret change log of observed catalog changes, compatibility issues, and proposed workflow improvements. It does not authorize self-modifying system prompts, Skill files, security gates, permissions, OAuth settings, or persistent processes.

Record proposals only after the run, excluding tokens, account identifiers, private content, and personal data. Ask the owner before persisting or publishing a Skill update. Never learn from a failed write by retrying automatically.

## Public-sharing checklist

Before sharing this Skill:

- remove credentials, OAuth links, callbacks, tokens, cookies, account IDs, and local paths;
- keep the MCP endpoint public and the OAuth step human-driven;
- make live schema discovery mandatory because commands, prices, and quotas change;
- keep default mode read-only;
- require per-action confirmation for writes;
- document region, plan, trial, and Credit limits without bypass advice.

## Stop conditions

Stop and ask the human when account identity is ambiguous, OAuth is missing/expired, a write payload is incomplete, cost/quota is unclear, a request conflicts with “do not affect my account,” a tool returns an ambiguous timeout, or a proposed self-evolution would persist policy/credential changes.
