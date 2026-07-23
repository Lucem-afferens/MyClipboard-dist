# Установка MyClipboard (Windows) с публичного канала релизов.
#
#   irm https://raw.githubusercontent.com/Lucem-afferens/MyClipboard-dist/main/install.ps1 | iex
#
$ErrorActionPreference = "Stop"

$Repo = if ($env:MYCLIPBOARD_DIST_REPO) { $env:MYCLIPBOARD_DIST_REPO } else { "Lucem-afferens/MyClipboard-dist" }
$Api = "https://api.github.com/repos/$Repo/releases?per_page=20"
$Dest = Join-Path $env:LOCALAPPDATA "Programs\MyClipboard"
$Tmp = Join-Path ([System.IO.Path]::GetTempPath()) ("myclipboard-install-" + [guid]::NewGuid().ToString("n"))

# Text progress like macOS `curl --progress-bar` (Invoke-WebRequest only shows byte spam).
function Download-WithProgress {
    param(
        [Parameter(Mandatory = $true)][string]$Uri,
        [Parameter(Mandatory = $true)][string]$OutFile
    )

    # Prefer curl.exe when present (Windows 10+): same UX as install.sh.
    $curl = Get-Command curl.exe -ErrorAction SilentlyContinue
    if ($curl) {
        & curl.exe -fL --progress-bar -A "MyClipboard-install" -o $OutFile -- $Uri
        if ($LASTEXITCODE -ne 0) {
            throw "Не удалось скачать сборку (curl exit $LASTEXITCODE)."
        }
        return
    }

    $request = [System.Net.HttpWebRequest]::Create($Uri)
    $request.UserAgent = "MyClipboard-install"
    $request.AllowAutoRedirect = $true
    $response = $request.GetResponse()
    try {
        $total = [int64]$response.ContentLength
        $stream = $response.GetResponseStream()
        $file = [System.IO.File]::Create($OutFile)
        try {
            $buffer = New-Object byte[] 81920
            $readTotal = [int64]0
            $lastPct = -1
            while (($n = $stream.Read($buffer, 0, $buffer.Length)) -gt 0) {
                $file.Write($buffer, 0, $n)
                $readTotal += $n
                if ($total -gt 0) {
                    $pct = [int](($readTotal * 100L) / $total)
                    if ($pct -ne $lastPct) {
                        $lastPct = $pct
                        $barLen = 30
                        $filled = [int](($pct * $barLen) / 100)
                        if ($filled -gt $barLen) { $filled = $barLen }
                        $bar = ("#" * $filled) + ("-" * ($barLen - $filled))
                        $line = "  [{0}] {1,3}%  {2:N1}/{3:N1} MB" -f `
                            $bar, $pct, ($readTotal / 1MB), ($total / 1MB)
                        Write-Host -NoNewline ("`r" + $line)
                    }
                }
                else {
                    Write-Host -NoNewline ("`r  Скачано {0:N1} MB…" -f ($readTotal / 1MB))
                }
            }
            Write-Host ""
        }
        finally {
            $file.Dispose()
            $stream.Dispose()
        }
    }
    finally {
        $response.Dispose()
    }
}

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
    Download-WithProgress -Uri $zipUrl -OutFile $zipFile

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
    $wsh = New-Object -ComObject WScript.Shell

    $startupDir = [Environment]::GetFolderPath("Startup")
    $startupShortcut = Join-Path $startupDir "MyClipboard.lnk"
    $sc = $wsh.CreateShortcut($startupShortcut)
    $sc.TargetPath = $targetExe
    $sc.WorkingDirectory = $Dest
    $sc.Save()

    # Start Menu so Windows Search / «Пуск» can find the app again.
    $startMenuDir = Join-Path $env:APPDATA "Microsoft\Windows\Start Menu\Programs"
    New-Item -ItemType Directory -Force -Path $startMenuDir | Out-Null
    $startMenuShortcut = Join-Path $startMenuDir "MyClipboard.lnk"
    $sc2 = $wsh.CreateShortcut($startMenuShortcut)
    $sc2.TargetPath = $targetExe
    $sc2.WorkingDirectory = $Dest
    $sc2.Description = "MyClipboard — менеджер буфера обмена"
    $sc2.Save()

    Write-Host "→ Запускаю…"
    Start-Process -FilePath $targetExe -WorkingDirectory $Dest

    Write-Host ""
    Write-Host "========================================"
    Write-Host "  Готово"
    Write-Host "========================================"
    Write-Host ""
    Write-Host "Что дальше:"
    Write-Host "  1. Иконка в трее возле часов (стрелка ▲ / ^, если свёрнуто)"
    Write-Host "  2. Панель: Ctrl+Alt+V · цикл: Ctrl+Shift+V"
    Write-Host "  3. В «Пуск» появится MyClipboard (поиск Windows тоже найдёт)"
    Write-Host "  4. Если SmartScreen — Подробнее → Выполнить в любом случае"
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
