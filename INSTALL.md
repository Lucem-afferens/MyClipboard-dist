# Установка MyClipboard

Скрипт установки определяет ОС и ставит нужную сборку. Если открыть «чужую» команду — покажет правильную для вашей системы.

---

## macOS

### Быстрый старт

Открой **Терминал**, вставь и нажми Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

Потом: **Системные настройки** → **Конфиденциальность и безопасность** → **Универсальный доступ** → включи **MyClipboard**.

Проверка: скопируй текст → **⌘⌥V** → **Enter**.

Обновление — снова та же команда.

### Вручную

1. [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases) → файл `MyClipboard-…-macOS.zip`
2. Распакуйте → перетащите **MyClipboard.app** в **Программы**
3. Правый клик → **Открыть** → **Открыть**
4. Универсальный доступ — как выше

---

## Windows

### Быстрый старт

Открой **PowerShell**, вставь и нажми Enter:

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Проверка: скопируй текст → **Ctrl+Shift+V**.

Обновление — снова та же команда.

Если PowerShell ругается на политику скриптов:

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

затем снова команду установки.

### Вручную

1. [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases) → `MyClipboard-…-windows-x64.zip`
2. Распакуйте папку в удобное место (или `%LocalAppData%\Programs\MyClipboard`)
3. Запустите **MyClipboard.exe**

---

## Требования

- **macOS:** 14+
- **Windows:** 10/11 x64 (отдельный .NET SDK не нужен — сборка self-contained)
