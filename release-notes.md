Канал **Preview** (текущая линейка **0.1.0**). Обновление — снова команда установки ниже. Автообновления Sparkle на этом канале не основной путь.

macOS (сборка `4e9df07`+): заметки, правка текста, пресеты/токены, двойной клик = вставка, Finder-картинки → Фото.

## Установка (рекомендуется)

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

Menu Bar (справа вверху) → Универсальный доступ → **⌘⌥V**.

### Windows

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Трей → **Ctrl+Alt+V** (панель) · **Ctrl+Shift+V** (цикл).

macOS + Windows: текст, изображения, файлы; панель с пресетами/заметками; быстрый цикл.

Пошагово со схемами: [INSTALL.md](https://github.com/Lucem-afferens/MyClipboard-dist/blob/main/INSTALL.md)

---

## Если ставите вручную из Assets

В релизе **два** ZIP — скачайте **только один**, под свою систему. Оба качать не нужно.

| Ваша система | Файл |
|--------------|------|
| **Mac** | `MyClipboard-…-macOS.zip` |
| **Windows** | `MyClipboard-…-windows-x64.zip` |

Дальше: Mac — `.app` в Программы; Windows — запустить `MyClipboard.exe` из архива.
