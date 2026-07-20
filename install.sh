#!/usr/bin/env bash
# Установка MyClipboard с публичного канала релизов.
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

if [[ ! -w "$DEST" ]]; then
  DEST="$HOME/Applications"
  mkdir -p "$DEST"
  echo "→ Установка в $DEST (нет прав на /Applications)"
else
  echo "→ Установка в $DEST"
fi

echo "→ Ищу последнюю сборку…"
ZIP_URL="$(
  curl -fsSL "${API}?per_page=15" | python3 -c '
import json, sys
releases = json.load(sys.stdin)
for rel in releases:
    for asset in rel.get("assets") or []:
        name = asset.get("name") or ""
        if name.endswith(".zip") and "MyClipboard" in name:
            print(asset["browser_download_url"])
            raise SystemExit(0)
raise SystemExit(1)
' 2>/dev/null || true
)"

if [[ -z "${ZIP_URL:-}" ]]; then
  echo ""
  echo "✗ Установочный файл пока недоступен."
  echo "  https://github.com/${REPO}/releases"
  exit 1
fi

ZIP_FILE="$TMP/MyClipboard.zip"
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
