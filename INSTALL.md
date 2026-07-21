# Установка MyClipboard

Одна команда → иконка в системе → одно разрешение (на Mac) → горячая клавиша.

---

## macOS

![Три шага: Терминал → Menu Bar → Универсальный доступ](guides/macos-steps.png)

### 1. Установите

Откройте **Терминал**, вставьте и нажмите Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

### 2. Найдите иконку

Справа вверху в **Menu Bar** (рядом с часами). В Dock иконки **нет** — так и задумано. Иногда спрятана за **›**.

### 3. Разрешите вставку

**Системные настройки** → **Конфиденциальность и безопасность** → **Универсальный доступ** → включите **MyClipboard**.

### 4. Проверьте

Скопируйте текст → **⌘⌥V** → **Enter**.

| Клавиши | Действие |
|---------|----------|
| **⌘⌥V** | Панель истории |
| **⌘⇧V** | Быстрый цикл (отпустите — вставка) |

Обновление — снова та же команда в Терминале.

<details>
<summary>Установка мышкой (без Терминала)</summary>

1. Откройте [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases)
2. В **Assets** скачайте **только** файл с **`macOS`** в имени:  
   `MyClipboard-…-macOS.zip`  
   Файл `…-windows-x64.zip` — для Windows, на Mac он не нужен.
3. Распакуйте → перетащите `MyClipboard.app` в **Программы**
4. Правый клик → **Открыть** → **Открыть**
5. Универсальный доступ — как выше

</details>

<details>
<summary>Вставка не работает, хотя доступ «включён»</summary>

1. Универсальный доступ → выберите MyClipboard → **−**
2. **+** → Программы → MyClipboard → включите тумблер
3. Выйдите из MyClipboard (Quit) и откройте снова

</details>

---

## Windows

![Три шага: PowerShell → Трей → Ctrl+Alt+V](guides/windows-steps.png)

### 1. Установите

Откройте **PowerShell**, вставьте и нажмите Enter:

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Если Windows покажет предупреждение SmartScreen: **Подробнее** → **Выполнить в любом случае**.

### 2. Найдите иконку

В **трее** возле часов (стрелка ▲ вверх, если иконки свёрнуты).

### 3. Проверьте

Скопируйте текст → **Ctrl+Alt+V** (панель) или **Ctrl+Shift+V** (цикл).

Обновление — снова та же команда в PowerShell.

<details>
<summary>PowerShell запрещает скрипты</summary>

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

затем снова команду установки.

</details>

<details>
<summary>Установка из ZIP</summary>

1. Откройте [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases)
2. В **Assets** скачайте **только** файл с **`windows-x64`** в имени:  
   `MyClipboard-…-windows-x64.zip`  
   Файл `…-macOS.zip` — для Mac, на Windows он не нужен.
3. Распакуйте и запустите `MyClipboard.exe`

</details>

---

## Требования

| | |
|--|--|
| **macOS** | 14 (Sonoma)+ |
| **Windows** | 10 / 11, x64 (.NET отдельно не нужен) |
