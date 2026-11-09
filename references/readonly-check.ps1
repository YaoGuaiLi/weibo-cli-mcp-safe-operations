# Read-only initialization and discovery. No publishing or account mutation.
$ErrorActionPreference = 'Stop'
weibo-cli version
weibo-cli doctor
weibo-cli me --output table
weibo-cli commands list --available --output json
mcporter config list --json
mcporter list weibo --schema --json
