# Environment initialization (safe, public)

Run these checks before any other Weibo action. The sequence is diagnostic and does not publish or mutate content.

## CLI

```powershell
node --version
npm --version
weibo-cli version
weibo-cli doctor
weibo-cli me --output table
weibo-cli commands list --available --output json
```

If `weibo-cli` is missing, install the official package only after the owner approves package installation:

```powershell
npm install -g @weibo-ai/weibo-cli
```

Then ask the owner to complete the official browser/device OAuth flow. Never request tokens in chat.

## MCP

Add the sanitized config from `mcp-config.example.json` to the target client, connect, and complete its own official OAuth flow. Then discover tools:

```powershell
mcporter config list --json
mcporter list weibo --schema --json
```

Do not call `article_preview` as an initialization probe: it creates or overwrites temporary preview state. Do not invoke any POST tool just to test connectivity.

## Report

Return a table with: installed versions; login/OAuth status; developer verification; service/plan; region/entitlement errors; CLI available count; MCP tool count; read/write counts; trial/paid flags; price fields; and any schema differences. Redact account IDs and all credentials. A catalog entry means “exposed,” not “successfully tested.” Test at most one safe profile GET if the owner has authorized account reading.
