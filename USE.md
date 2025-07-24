네, 알겠습니다. 이전의 모든 복잡한 과정은 잊어버리시고, 처음부터 가장 간단하고 올바른 방법으로 다시 설명해 드리겠습니다.

**'Claude Code CLI' 설치**는 이미 완료하셨으니, 그 다음 단계부터 시작하겠습니다.

-----

### **2단계: API 키를 안전하게 보관할 파일 만들기**

프로젝트 폴더(multi-ai-workspace) 안에 `secrets` 라는 새 폴더를 만드세요. 그 다음, `secrets` 폴더 안에 `my_sensitive_data.md` 라는 새 파일을 만들고 아래 내용을 붙여넣으세요.

**`sk-`로 시작하는 본인의 API 키**를 각 위치에 정확히 입력해야 합니다.

**파일 위치:** `secrets/my_sensitive_data.md`

```markdown
### Qwen (Alibaba Dashscope)
- **API Key:** `sk-Qwen_API_키를_여기에_붙여넣으세요`

---

### Kimi (Moonshot AI)
- **API Key:** `sk-Kimi_API_키를_여기에_붙여넣으세요`
```

-----

### **3단계: API 키를 읽어오는 스크립트 만들기**

`scripts` 폴더에 `Get-ApiKey.ps1` 라는 파일을 만들고, 아래 코드를 그대로 붙여넣으세요. 이 스크립트는 위에서 만든 비밀 파일에서 키를 안전하게 읽어오는 역할을 합니다.

**파일 위치:** `scripts/Get-ApiKey.ps1`

```powershell
function Get-ApiKey {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ModelName
    )
    $secretsFile = Join-Path $PSScriptRoot "../secrets/my_sensitive_data.md"
    $fileContent = Get-Content -Path $secretsFile -Raw

    $blocks = $fileContent -split '---'
    foreach ($block in $blocks) {
        if ($block -match "### $ModelName") {
            $lines = $block -split "`r`n"
            foreach ($line in $lines) {
                if ($line -match "API Key:") {
                    $key = ($line -split '`')[1]
                    if ($key) {
                        return $key
                    }
                }
            }
        }
    }
    throw "API Key for '$ModelName' not found."
}
```

-----

### **4단계: AI 모델 전환 스크립트 만들기**

`scripts` 폴더에 `use-qwen.ps1` 과 `use-kimi.ps1` 두 개의 파일을 만들고, 각각 아래 코드를 붙여넣으세요. 이 스크립트들이 `claude` 명령어의 대화 상대를 바꿔주는 핵심입니다.

**`use-qwen.ps1` 파일**

```powershell
# Claude Code 백엔드를 Qwen으로 설정
Write-Host "Setting Claude Code backend to QWEN..." -ForegroundColor Green
. "$PSScriptRoot\Get-ApiKey.ps1"
$qwenKey = Get-ApiKey -ModelName "Qwen"

$env:ANTHROPIC_BASE_URL="https://dashscope.aliyuncs.com/api/v2/apps/claude-code-proxy"
$env:ANTHROPIC_AUTH_TOKEN=$qwenKey
Write-Host "Done. You can now use 'claude --model qwen3-coder-plus ...' command."
```

**`use-kimi.ps1` 파일**

```powershell
# Claude Code 백엔드를 Kimi로 설정
Write-Host "Setting Claude Code backend to KIMI..." -ForegroundColor Cyan
. "$PSScriptRoot\Get-ApiKey.ps1"
$kimiKey = Get-ApiKey -ModelName "Kimi"

$env:ANTHROPIC_BASE_URL="https://api.moonshot.ai/anthropic"
$env:ANTHROPIC_AUTH_TOKEN=$kimiKey
Write-Host "Done. You can now use 'claude' command with Kimi."
```

-----

### **5단계: 최종 사용법**

이제 모든 준비가 끝났습니다. 터미널에서 아래와 같이 사용하시면 됩니다.

#### **Qwen Coder 사용하기**

1.  Qwen으로 대화 상대 전환:
    ```powershell
    . .\scripts\use-qwen.ps1
    ```
2.  `--model` 옵션을 붙여 Qwen에게 질문:
    ```powershell
    claude --model qwen3-coder-plus "파이썬으로 웹 스크래핑 하는 코드 예시 보여줘"
    ```

#### **Kimi 사용하기**

1.  Kimi로 대화 상대 전환:
    ```powershell
    . .\scripts\use-kimi.ps1
    ```
2.  `claude` 명령어로 Kimi에게 질문:
    ```powershell
    claude "오늘 날짜로 최신 IT 뉴스 3가지만 요약해줘"
    ```