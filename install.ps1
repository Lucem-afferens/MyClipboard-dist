# Установка MyClipboard (Windows) с публичного канала релизов.
#
#   irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
#
$ErrorActionPreference = "Stop"

$Repo = if ($env:MYCLIPBOARD_DIST_REPO) { $env:MYCLIPBOARD_DIST_REPO } else { "Lucem-afferens/MyClipboard-dist" }
$Api = "https://api.github.com/repos/$Repo/releases?per_page=20"
$Dest = Join-Path $env:LOCALAPPDATA "Programs\MyClipboard"
$Tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("myclipboard-install-" + [guid]::NewGuid().ToString("n"))

Write-Host ""
Write-Host "========================================"
Write-Host "  MyClipboard — установка"
Write-Host "========================================"
Write-Host ""

if ($IsLinux -or $IsMacOS) {
    Write-Host "Эта команда для Windows."
    Write-Host ""
    Write-Host "На macOS в Терминале:"
    Write-Host "  curl -fsSL https://raw.githubusercontent.com/$Repo/main/install.sh | bash"
    Write-Host ""
    Write-Host "Инструкция: https://github.com/$Repo/blob/main/INSTALL.md"
    exit 1
}

New-Item -ItemType Directory -Force -Path $Tmp | Out-Null

try {
    Write-Host "→ Ищу сборку для Windows…"
    $releases = Invoke-RestMethod -Uri $Api -Headers @{ "User-Agent" = "MyClipboard-install" }
    $zipUrl = $null
    foreach ($rel in $releases) {
        foreach ($asset in $rel.assets) {
            $name = [string]$asset.name
            if ($name -like "MyClipboard*-windows-x64.zip") {
                $zipUrl = $asset.browser_download_url
                break
            }
        }
        if ($zipUrl) { break }
    }

    if (-not $zipUrl) {
        Write-Host ""
        Write-Host "✗ Сборка для Windows пока недоступна."
        Write-Host "  https://github.com/$Repo/releases"
        exit 1
    }

    $zipFile = Join-Path $Tmp "MyClipboard-windows.zip"
    Write-Host "→ Скачиваю…"
    Write-Host "  $zipUrl"
    Invoke-WebRequest -Uri $zipUrl -OutFile $zipFile

    $extract = Join-Path $Tmp "extracted"
    Expand-Archive -Path $zipFile -DestinationPath $extract -Force

    $exe = Get-ChildItem -Path $extract -Filter "MyClipboard.exe" -Recurse | Select-Object -First 1
    if (-not $exe) {
        throw "В архиве не найден MyClipboard.exe"
    }
    $appRoot = $exe.Directory.FullName

    $running = Get-Process -Name "MyClipboard" -ErrorAction SilentlyContinue
    if ($running) {
        Write-Host "→ Закрываю текущий MyClipboard…"
        $running | Stop-Process -Force
        Start-Sleep -Seconds 1
    }

    Write-Host "→ Устанавливаю в $Dest"
    if (Test-Path $Dest) {
        Remove-Item -Recurse -Force $Dest
    }
    New-Item -ItemType Directory -Force -Path $Dest | Out-Null
    Copy-Item -Path (Join-Path $appRoot "*") -Destination $Dest -Recurse -Force

    $targetExe = Join-Path $Dest "MyClipboard.exe"
    $startupDir = [Environment]::GetFolderPath("Startup")
    $shortcutPath = Join-Path $startupDir "MyClipboard.lnk"
    $wsh = New-Object -ComObject WScript.Shell
    $shortcut = $wsh.CreateShortcut($shortcutPath)
    $shortcut.TargetPath = $targetExe
    $shortcut.WorkingDirectory = $Dest
    $shortcut.Save()

    Write-Host "→ Запускаю…"
    Start-Process -FilePath $targetExe -WorkingDirectory $Dest

    Write-Host ""
    Write-Host "========================================"
    Write-Host "  Готово"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Что дальше:"
    Write-Host "  1. Иконка в трее возле часов (стрелка ▲, если свёрнуто)"
    Write-Host "  2. Скопируйте текст → Ctrl+Shift+V"
    Write-Host "  3. Если SmartScreen — Подробнее → Выполнить в любом случае"
    Write-Host ""
    Write-Host "Схема и подробности:"
    Write-Host "  https://github.com/$Repo/blob/main/INSTALL.md"
    Write-Host "Обновить позже — снова эта же команда."
    Write-Host ""
}
finally {
    if (Test-Path $Tmp) {
        Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
    }
}
