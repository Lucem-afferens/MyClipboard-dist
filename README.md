# MyClipboard

Локальный менеджер истории буфера обмена. Без облака и аналитики.

## Установка

Скрипт сам проверяет систему: на Mac — только macOS-сборка, на Windows — только Windows.

### macOS

Открой **Терминал**, вставь и нажми Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

Потом: **Системные настройки** → **Конфиденциальность** → **Универсальный доступ** → включи **MyClipboard**.

### Windows

Открой **PowerShell**, вставь и нажми Enter:

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Иконка появится в трее (возле часов). Горячая клавиша: **Ctrl+Shift+V**.

---

Пошагово: [INSTALL.md](INSTALL.md) · [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases)

## Требования

| | |
|--|--|
| **macOS** | 14 (Sonoma) или новее |
| **Windows** | 10 или 11 (x64) |
