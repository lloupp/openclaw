#!/bin/bash
# Script para salvar memória do Alfred no GitHub

WORKSPACE="/home/node/.openclaw/workspace"
REPO="${GITHUB_REPO:-lloupp/openclaw}"
TOKEN="${GITHUB_TOKEN}"
BRANCH="main"

if [ -z "$TOKEN" ]; then
  echo "GITHUB_TOKEN não definido"
  exit 1
fi

cd "$WORKSPACE"

# Configura git
git config --global user.email "alfred@openclaw.ai"
git config --global user.name "Alfred"

# Clona ou atualiza o repo
if [ ! -d ".git" ]; then
  git clone "https://${TOKEN}@github.com/${REPO}.git" /tmp/openclaw-memory
  cp -r /tmp/openclaw-memory/.git .
  git remote set-url origin "https://${TOKEN}@github.com/${REPO}.git"
fi

# Commit e push dos arquivos de memória
git add SOUL.md AGENTS.md 2>/dev/null
git diff --cached --quiet || git commit -m "Alfred: atualiza memória $(date '+%Y-%m-%d %H:%M')"
git push origin "$BRANCH" 2>/dev/null

echo "Memória salva com sucesso!"
