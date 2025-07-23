# Claude Code 백엔드를 Kimi로 설정하는 스크립트
. "$PSScriptRoot\Get-ApiKey.ps1"
Write-Host "Setting Claude Code backend to KIMI..." -ForegroundColor Cyan
$env:ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
$env:ANTHROPIC_AUTH_TOKEN=$(Get-ApiKey -ModelName "Kimi")
Write-Host "Done. You can now use 'claude' command with Kimi."