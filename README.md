# MyClipboard

История буфера обмена. Локально. Без облака и аналитики.

## Что умеет

- Копируете — появляется в локальной истории; вставка горячей клавишей
- Поиск, избранное (★), автозапуск при входе
- macOS: также изображения/файлы, цикл ⌘⇧V, заметки и пресеты
- Без облака, аккаунта и аналитики; фильтры privacy (менеджеры паролей и скрытый буфер)

| | macOS | Windows |
|--|--------|---------|
| Где | Menu Bar | Трей |
| Типы | Текст, изображения, файлы | Только текст |
| Hotkey | **⌘⌥V** панель · **⌘⇧V** цикл | **Ctrl+Shift+V** панель |

## Установка за минуту

### macOS

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

Потом: **Menu Bar** (справа вверху) → **Универсальный доступ** → проверка **⌘⌥V**.

### Windows

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Потом: иконка в **трее** → **Ctrl+Shift+V**.

---

Наглядно, со схемами: **[INSTALL.md](INSTALL.md)** · [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases)

В Releases два ZIP — нужен **один**: `…-macOS.zip` или `…-windows-x64.zip`. Оба качать не надо.

| | |
|--|--|
| macOS | 14+ |
| Windows | 10/11 x64 |
