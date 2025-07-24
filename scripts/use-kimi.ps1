# Claude Code 백엔드를 Kimi로 설정
Write-Host "Setting Claude Code backend to KIMI..." -ForegroundColor Cyan
. "$PSScriptRoot\Get-ApiKey.ps1"
$kimiKey = Get-ApiKey -ModelName "Kimi"

$env:ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
$env:ANTHROPIC_AUTH_TOKEN=$kimiKey
Write-Host "Done. You can now use 'claude' command with Kimi."