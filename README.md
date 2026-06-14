# claude-skills-setup

여러 컴퓨터에서 동일한 Claude Code 스킬 환경을 재현하기 위한 저장소.

비전 기반 AI + 로보틱스(매니퓰레이션/네비게이션) 개발 워크플로우에 맞춘 구성.

## 빠른 설치

```bash
git clone <이-저장소-URL> claude-skills-setup
cd claude-skills-setup
./install.sh
```

설치 후 **Claude Code를 재시작**하면 스킬이 로드됩니다.

## 구성

### 폴더 스킬 (`skills/` — 저장소에 직접 포함, 버전 고정)

| 스킬 | 용도 |
|------|------|
| `docx` `pptx` `xlsx` `pdf` | MS Office / PDF 문서 작업 |
| `doc-coauthoring` | 설계문서·스펙·RFC 구조화 작성 |
| `frontend-design` | 의도적인 UI 디자인 가이드 |
| `web-artifacts-builder` | React/Tailwind 인터랙티브 HTML 아티팩트 |
| `webapp-testing` | Playwright 웹앱 테스트 |
| `canvas-design` | PNG/PDF 비주얼 아트 |
| `algorithmic-art` | p5.js 제너러티브 아트 |
| `mcp-builder` | MCP 서버 제작 (로봇·센서·외부도구 연동) |
| `skill-creator` | 새 스킬 직접 제작 |

출처: [anthropics/skills](https://github.com/anthropics/skills)

### 플러그인 (`install.sh`가 마켓플레이스에서 설치)

| 플러그인 | 마켓플레이스 | 용도 |
|----------|-------------|------|
| `superpowers` | obra/superpowers-marketplace | 개발 방법론 14종 (TDD, 디버깅, 계획, 리뷰 등) |
| `claude-code-setup` | anthropics/claude-plugins-official | 코드베이스 분석→자동화 추천 |
| `clangd-lsp` | anthropics/claude-plugins-official | C/C++ LSP |

## 업데이트

폴더 스킬을 최신으로 갱신하려면:

```bash
git clone --depth 1 https://github.com/anthropics/skills /tmp/anthropic-skills
# 원하는 스킬만 갱신, 예:
cp -r /tmp/anthropic-skills/skills/docx ./skills/docx
git add -A && git commit -m "update docx skill"
```

## 메모

- 폴더 스킬은 저장소에 박제(vendoring)되어 오프라인·버전고정 재현 가능.
- 플러그인은 버전 관리되는 외부 마켓플레이스에서 설치(스크립트).
- NVIDIA TAO/DeepStream 계열 스킬은 해당 생태계 전용이라 의도적으로 제외.
