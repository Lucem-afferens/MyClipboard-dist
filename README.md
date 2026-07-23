<p align="center">
  <img src="./assets/readme/hero.svg" width="100%" alt="MyClipboard — история буфера обмена локально на macOS и Windows, без облака и аналитики">
</p>

<p align="center">
  <a href="#установка"><strong>Установить</strong></a>
  ·
  <a href="INSTALL.md">Пошагово</a>
  ·
  <a href="https://github.com/Lucem-afferens/MyClipboard-dist/releases">Releases</a>
  ·
  <a href="release-notes.md">Что нового</a>
</p>

---

<p align="center">
  <img src="./assets/readme/workflow.svg" width="100%" alt="Копируете → история сохраняется локально → вставляете горячей клавишей">
</p>

История буфера обмена для **macOS** (Menu Bar) и **Windows** (трей): текст, изображения и файлы остаются на вашем диске. Без аккаунта, без облака, без аналитики.

<p align="center">
  <img src="guides/macos-steps.png" width="48%" alt="macOS: Терминал → Menu Bar → Универсальный доступ">
  &nbsp;
  <img src="guides/windows-steps.png" width="48%" alt="Windows: PowerShell → трей → горячая клавиша">
</p>

---

<p align="center">
  <img src="./assets/readme/section-install.svg" width="100%" alt="Установка">
</p>

**Одна команда** — скрипт сам скачает нужный ZIP и поставит приложение.

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

Дальше: **Menu Bar** (справа вверху) → **Системные настройки → Универсальный доступ** → включите MyClipboard → **⌘⌥V**.

### Windows

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Дальше: иконка в **трее** → **Ctrl+Alt+V**.

Подробно со схемами: **[INSTALL.md](INSTALL.md)**

---

<p align="center">
  <img src="./assets/readme/section-hotkeys.svg" width="100%" alt="Горячие клавиши">
</p>

| | Панель истории | Быстрый цикл |
|--|----------------|--------------|
| **macOS** | **⌘⌥V** | **⌘⇧V** |
| **Windows** | **Ctrl+Alt+V** | **Ctrl+Shift+V** |

Панель: поиск и выбор записи → Enter. Цикл: листайте, отпустите — вставка.

---

<p align="center">
  <img src="./assets/readme/section-zip.svg" width="100%" alt="Скачать ZIP">
</p>

Если удобнее мышкой — [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases) → **Assets** → **один** файл под вашу систему:

| Система | Файл |
|---------|------|
| **Mac** | `MyClipboard-…-macOS.zip` |
| **Windows** | `MyClipboard-…-windows-x64.zip` |

Mac: распакуйте → `MyClipboard.app` в **Программы**. Windows: запустите `MyClipboard.exe`. Дальше — те же шаги с доступом / треем.

---

## Требования

| | |
|--|--|
| macOS | 14+ |
| Windows | 10 / 11, x64 |

Обновление: снова та же команда установки (или новый ZIP из Releases).

Что нового: [release-notes.md](release-notes.md)
