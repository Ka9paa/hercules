# hercules.ps1

function Show-Menu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "     Hercules Power Tool"
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "1. Debloat Windows"
    Write-Host "2. Install Common Software"
    Write-Host "3. Apply Performance Optimizations"
    Write-Host "4. Exit"
    Write-Host ""
}

function Debloat-Windows {
    Write-Host "`nStarting Windows Debloat..." -ForegroundColor Yellow
    # Basic Debloat Example – you can expand this
    Get-AppxPackage *xbox* | Remove-AppxPackage
    Get-AppxPackage *bing* | Remove-AppxPackage
    Write-Host "Debloat Complete.`n" -ForegroundColor Green
    Pause
}

function Install-CommonSoftware {
    Write-Host "`nInstalling Common Apps..." -ForegroundColor Yellow
    $apps = @(
        "Google.Chrome",
        "Notepad++.Notepad++",
        "7zip.7zip",
        "Mozilla.Firefox",
        "Git.Git"
    )

    foreach ($app in $apps) {
        winget install --id=$app --accept-source-agreements --accept-package-agreements
    }

    Write-Host "Software Installation Complete.`n" -ForegroundColor Green
    Pause
}

function Apply-Optimizations {
    Write-Host "`nApplying Performance Tweaks..." -ForegroundColor Yellow
    powercfg -setactive SCHEME_MIN
    bcdedit /set useplatformclock true
    bcdedit /set disabledynamictick yes
    bcdedit /set useplatformtick yes
    Write-Host "Optimizations Applied.`n" -ForegroundColor Green
    Pause
}

do {
    Show-Menu
    $choice = Read-Host "Choose an option (1-4)"

    switch ($choice) {
        "1" { Debloat-Windows }
        "2" { Install-CommonSoftware }
        "3" { Apply-Optimizations }
        "4" { Write-Host "Goodbye!" -ForegroundColor Cyan }
        default { Write-Host "Invalid selection." -ForegroundColor Red; Pause }
    }
} while ($choice -ne "4")
