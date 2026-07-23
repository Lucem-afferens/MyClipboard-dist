# Установка MyClipboard

**Одна команда — самый быстрый и простой способ.** Ниже — по шагам; ZIP — альтернатива, если Терминал / PowerShell не хотите.

---

## macOS

![Три шага: Терминал → Menu Bar → Универсальный доступ](guides/macos-steps.png)

### Рекомендуется: одна команда

Откройте **Терминал**, вставьте и нажмите Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.sh | bash
```

### Дальше

1. Иконка в **Menu Bar** справа вверху (в Dock её нет). Иногда спрятана за **›**.
2. **Системные настройки** → **Конфиденциальность и безопасность** → **Универсальный доступ** → включите **MyClipboard**.
3. Скопируйте текст → **⌘⌥V** → **Enter**.

| Клавиши | Действие |
|---------|----------|
| **⌘⌥V** | Панель истории |
| **⌘⇧V** | Быстрый цикл (отпустите — вставка) |

Обновление — снова та же команда.

### Альтернатива: ZIP без Терминала

1. [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases) → **Assets**
2. Скачайте **только** `MyClipboard-…-macOS.zip` (файл `…-windows-x64.zip` на Mac не нужен)
3. Распакуйте → перетащите `MyClipboard.app` в **Программы**
4. Правый клик → **Открыть** → **Открыть**
5. Универсальный доступ — как выше

<details>
<summary>Вставка не работает, хотя доступ «включён»</summary>

1. Универсальный доступ → выберите MyClipboard → **−**
2. **+** → Программы → MyClipboard → включите тумблер
3. Quit MyClipboard и откройте снова

</details>

---

## Windows

![Три шага: PowerShell → Трей → Ctrl+Alt+V](guides/windows-steps.png)

### Рекомендуется: одна команда

Откройте **PowerShell**, вставьте и нажмите Enter:

```powershell
irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
```

Если SmartScreen: **Подробнее** → **Выполнить в любом случае**.

На Windows **не нужно** включать доступ в «Параметры → Конфиденциальность» (аналога macOS «Универсальный доступ» нет).

### Дальше

1. Иконка в **трее** возле часов (стрелка ▲, если свёрнуто).
2. Скопируйте текст → **Ctrl+Alt+V** (панель) или **Ctrl+Shift+V** (цикл).
3. Если авто-вставка не сработала — **Ctrl+V** вручную (так бывает в окнах от администратора).

Обновление — снова та же команда.

### Альтернатива: ZIP

1. [Releases](https://github.com/Lucem-afferens/MyClipboard-dist/releases) → **Assets**
2. Скачайте **только** `MyClipboard-…-windows-x64.zip` (файл `…-macOS.zip` на Windows не нужен)
3. Распакуйте и запустите `MyClipboard.exe`

<details>
<summary>PowerShell запрещает скрипты</summary>

```powershell
Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
```

затем снова команду установки.

</details>

---

## Требования

| | |
|--|--|
| **macOS** | 14 (Sonoma)+ |
| **Windows** | 10 / 11, x64 (.NET отдельно не нужен) |
