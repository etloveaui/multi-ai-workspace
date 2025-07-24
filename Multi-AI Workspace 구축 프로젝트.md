네, 알겠습니다. 제공해주신 프로젝트 계획서와 파일 구조를 바탕으로, 다른 사람이 보거나 나중에 다시 봐도 모든 내용을 완벽하게 이해하고 사용할 수 있도록 **새로운 `README.md` 최종본**을 작성해 드리겠습니다.

-----

# **README.md**

## **Multi-AI Workspace**

### 1\. 프로젝트 개요

이 프로젝트는 단일화된 로컬 개발 환경에서 여러 AI 모델(Gemini, Kimi, Qwen)을 효율적으로 호출하고 관리하기 위해 구축되었습니다. `Claude Code` CLI를 중심으로 Kimi와 Qwen을 통합하고, Gemini는 독립적인 전용 스크립트를 통해 호출하는 하이브리드 방식을 사용합니다.

### 2\. 폴더 구조

```
/multi-ai-workspace
├── .vscode/
│   └── tasks.json          (VS Code 자동화 작업 파일)
├── scripts/
│   ├── Get-ApiKey.ps1      (API 키 로더)
│   ├── use-qwen.ps1        (Qwen 전환 스크립트)
│   ├── use-kimi.ps1        (Kimi 전환 스크립트)
│   ├── ask-gemini.ps1      (Gemini 실행 스크립트)
│   └── ask_gemini.py       (Gemini 파이썬 로직)
├── secrets/
│   └── my_sensitive_data.md (API 키 보관 파일 - Git 비공개)
├── venv/                   (파이썬 가상환경 - Git 비공개)
└── requirements.txt        (파이썬 라이브러리 목록)
```

### 3\. 초기 설정 (새로운 PC에서)

1.  **프로젝트 복제:** `git clone ...`

2.  **Claude Code CLI 설치:** `npm install -g @anthropic-ai/claude-code`

3.  **파이썬 가상환경 생성:** `python -m venv venv`

4.  **필요 라이브러리 설치:** `.\venv\Scripts\python.exe -m pip install -r requirements.txt`

5.  **API 키 파일 생성:** `secrets/my_sensitive_data.md` 파일을 만들고 본인의 API 키를 아래 형식에 맞춰 입력합니다.

    ```markdown
    ### Qwen (Alibaba Dashscope)
    - API Key: `sk-여기에_Qwen_API_키_입력`

    ---

    ### Kimi (Moonshot AI)
    - API Key: `sk-여기에_Kimi_API_키_입력`

    ---

    ### Gemini
    - API Key: `AIza... 여기에_Gemini_API_키_입력`
    ```

### 4\. 사용법

#### **A. Kimi / Qwen 사용법 (`Claude Code` CLI 통합 방식)**

1.  **AI 전환:** 터미널에 아래 스크립트 중 하나를 실행하여 대화 상대를 선택합니다.

      * Kimi로 전환: `. .\scripts\use-kimi.ps1`
      * Qwen으로 전환: `. .\scripts\use-qwen.ps1`

2.  **질문하기:** `claude` 명령어로 질문합니다.

      * **Kimi에게:** `claude "Kimi, 오늘 최신 IT 뉴스 3가지만 요약해줘."`
      * **Qwen에게 (모델 지정 필수):** `claude --model qwen3-coder-plus "파이썬으로 웹크롤러 만드는 법 알려줘"`

#### **B. Gemini 사용법 (전용 스크립트 방식)**

  * Gemini는 아래 전용 스크립트로 직접 질문합니다.

    ```powershell
    .\scripts\ask-gemini.ps1 "Gemini, 대한민국의 역사에 대해 설명해줘."
    ```

### 5\. AI에게 주는 지침 (System Prompt 예시)

`claude`나 Gemini와 대화를 시작할 때, 아래와 같은 지침을 먼저 주면 더 좋은 답변을 얻을 수 있습니다.

> "너는 나의 AI 코딩 어시스턴트야. 나는 지금 'Multi-AI Workspace'라는 파워쉘 및 파이썬 기반 프로젝트를 진행하고 있어. 내가 제공하는 코드나 아이디어에 대해 검토하고, 버그를 찾고, 더 효율적인 코드를 제안해줘. 답변은 항상 한국어로, 코드는 마크다운 형식으로 명확하게 설명해줘."

### 6\. 프로젝트 관리 팁

  * **라이브러리 추가 시:** 새로운 파이썬 라이브러리를 설치했다면, 항상 `.\venv\Scripts\python.exe -m pip freeze > requirements.txt` 명령어로 `requirements.txt` 파일을 업데이트하고 Git에 커밋하세요.
  * **보안:** `secrets` 폴더와 `venv` 폴더는 `.gitignore`에 반드시 포함되어 있어야 합니다. 절대로 API 키나 가상환경을 Git에 올리지 마세요.