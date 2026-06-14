#!/usr/bin/env bash
#
# Claude Code 스킬 환경 복원 스크립트
# 새 컴퓨터에서: git clone <repo> && cd claude-skills-setup && ./install.sh
#
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILLS_SRC="$SCRIPT_DIR/skills"
SKILLS_DST="$HOME/.claude/skills"

echo "==> 1) 폴더 스킬 복사 ($SKILLS_DST)"
mkdir -p "$SKILLS_DST"
for d in "$SKILLS_SRC"/*/; do
  name="$(basename "$d")"
  rm -rf "$SKILLS_DST/$name"
  cp -r "$d" "$SKILLS_DST/$name"
  echo "    ✔ $name"
done

# claude CLI 가 있어야 플러그인 설치 가능
if ! command -v claude >/dev/null 2>&1; then
  echo "==> claude CLI 가 없어 플러그인 단계는 건너뜁니다. (폴더 스킬은 설치됨)"
  exit 0
fi

echo "==> 2) 마켓플레이스 등록 (이미 있으면 무시됨)"
# 공식 마켓플레이스는 기본 등록되어 있으나, 누락 대비해 시도
claude plugin marketplace add anthropics/claude-plugins-official 2>/dev/null || true
claude plugin marketplace add obra/superpowers-marketplace 2>/dev/null || true

echo "==> 3) 플러그인 설치"
PLUGINS=(
  "superpowers@superpowers-marketplace"
  "claude-code-setup@claude-plugins-official"
  "clangd-lsp@claude-plugins-official"
)
for p in "${PLUGINS[@]}"; do
  echo "    - $p"
  claude plugin install "$p" 2>&1 | tail -1 || echo "      (설치 실패/이미 설치됨)"
done

echo
echo "==> 완료. Claude Code 를 재시작하면 모든 스킬이 로드됩니다."
