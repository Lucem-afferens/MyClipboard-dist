#!/usr/bin/env bash
# Установка MyClipboard (macOS) с публичного канала релизов.
#
#   curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
#
set -euo pipefail

REPO="${MYCLIPBOARD_DIST_REPO:-Lucem-afferens/MyClipboard-dist}"
API="https://api.github.com/repos/${REPO}/releases"
DEST="/Applications"
APP_NAME="MyClipboard.app"
TMP="$(mktemp -d "${TMPDIR:-/tmp}/myclipboard-install.XXXXXX")"
trap 'rm -rf "$TMP"' EXIT

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   MyClipboard — установка                ║"
echo "╚══════════════════════════════════════════╝"
echo ""

OS="$(uname -s 2>/dev/null || echo unknown)"
if [[ "$OS" != "Darwin" ]]; then
  echo "Эта команда для macOS."
  echo ""
  echo "На Windows откройте PowerShell и выполните:"
  echo "  irm https://raw.githubusercontent.com/${REPO}/main/install.ps1 | iex"
  echo ""
  echo "Инструкция: https://github.com/${REPO}/blob/main/INSTALL.md"
  exit 1
fi

if [[ ! -w "$DEST" ]]; then
  DEST="$HOME/Applications"
  mkdir -p "$DEST"
  echo "→ Установка в $DEST (нет прав на /Applications)"
else
  echo "→ Установка в $DEST"
fi

echo "→ Ищу сборку для macOS…"
ZIP_URL="$(
  curl -fsSL "${API}?per_page=20" | python3 -c '
import json, sys
releases = json.load(sys.stdin)

def pick(assets, predicate):
    for a in assets:
        name = a.get("name") or ""
        if predicate(name):
            return a["browser_download_url"]
    return None

for rel in releases:
    assets = rel.get("assets") or []
    url = pick(assets, lambda n: n.endswith(".zip") and "macOS" in n and "MyClipboard" in n)
    if url:
        print(url); raise SystemExit(0)
    # совместимость со старым именем MyClipboard-0.1.0.zip
    url = pick(assets, lambda n: n.endswith(".zip") and "MyClipboard" in n and "windows" not in n.lower())
    if url:
        print(url); raise SystemExit(0)
raise SystemExit(1)
' 2>/dev/null || true
)"

if [[ -z "${ZIP_URL:-}" ]]; then
  echo ""
  echo "✗ Сборка для macOS пока недоступна."
  echo "  https://github.com/${REPO}/releases"
  exit 1
fi

ZIP_FILE="$TMP/MyClipboard-macOS.zip"
echo "→ Скачиваю…"
echo "  $ZIP_URL"
curl -fL --progress-bar -o "$ZIP_FILE" "$ZIP_URL"

echo "→ Распаковываю…"
ditto -x -k "$ZIP_FILE" "$TMP/extracted"

APP_SRC="$(find "$TMP/extracted" -name "$APP_NAME" -type d | head -n 1)"
if [[ -z "$APP_SRC" || ! -d "$APP_SRC" ]]; then
  echo "✗ В архиве не найден $APP_NAME" >&2
  exit 1
fi

if pgrep -x "MyClipboard" >/dev/null 2>&1; then
  echo "→ Закрываю текущий MyClipboard…"
  osascript -e 'tell application "MyClipboard" to quit' >/dev/null 2>&1 || true
  sleep 1
  pkill -x "MyClipboard" >/dev/null 2>&1 || true
fi

TARGET="$DEST/$APP_NAME"
echo "→ Копирую в $TARGET"
rm -rf "$TARGET"
ditto "$APP_SRC" "$TARGET"

echo "→ Снимаю карантин macOS…"
xattr -dr com.apple.quarantine "$TARGET" 2>/dev/null || true

echo "→ Запускаю…"
open "$TARGET" || true

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Готово                                 ║"
echo "╚══════════════════════════════════════════╝"
echo ""
echo "1) Иконка MyClipboard должна появиться в Menu Bar (справа вверху)."
echo ""
echo "2) Системные настройки → Конфиденциальность → Универсальный доступ"
echo "   → включи MyClipboard"
echo "   (если уже в списке — «−», затем «+» и снова Программы → MyClipboard)"
echo ""
echo "3) Проверка: скопируйте текст → ⌘⌥V → Enter."
echo ""
echo "Инструкция: https://github.com/${REPO}/blob/main/INSTALL.md"
echo "Обновить позже — снова эта же команда."
echo ""
