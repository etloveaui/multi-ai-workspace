# Claude Code 백엔드를 Qwen으로 설정하는 스크립트
. "$PSScriptRoot\Get-ApiKey.ps1"
Write-Host "Setting Claude Code backend to QWEN..." -ForegroundColor Green
$env:ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy"
$env:ANTHROPIC_AUTH_TOKEN=$(Get-ApiKey -ModelName "Qwen")
Write-Host "Done. You can now use 'claude' command with Qwen."