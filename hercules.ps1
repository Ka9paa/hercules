# hercules.ps1

function Show-Menu {
    Clear-Host
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "     Hercules Power Tool"
    Write-Host "==============================" -ForegroundColor Cyan
    Write-Host "1. Debloat Windows"
    Write-Host "2. Install Common Software"
    Write-Host "3. Apply Performance Optimizations"
    Write-Host "4. Apply Registry Tweaks"
    Write-Host "5. Disable Unnecessary Services"
    Write-Host "6. Remove Bloatware"
    Write-Host "7. Exit"
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

function Apply-RegistryTweaks {
    Write-Host "`nApplying Registry Tweaks..." -ForegroundColor Yellow
    # Disable Telemetry
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection" -Name "AllowTelemetry" -Value 0
    # Disable Windows Defender
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiSpyware" -Value 1
    # Disable Windows Defender Antivirus
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender" -Name "DisableAntiVirus" -Value 1
    # Disable Windows Defender Real-Time Protection
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection" -Name "DisableRealtimeMonitoring" -Value 1
    Write-Host "Registry Tweaks Applied.`n" -ForegroundColor Green
    Pause
}

function Disable-Services {
    Write-Host "`nDisabling Unnecessary Services..." -ForegroundColor Yellow
    $services = @(
        "Xbox Live Auth Manager",
        "Xbox Live Networking Service",
        "dmwappushsvc",
        "DiagTrack",
        "WMPNetworkSvc"
    )

    foreach ($service in $services) {
        Set-Service -Name $service -StartupType Disabled
        Stop-Service -Name $service -Force
    }

    Write-Host "Services Disabled.`n" -ForegroundColor Green
    Pause
}

function Remove-Bloatware {
    Write-Host "`nRemoving Bloatware..." -ForegroundColor Yellow
    $bloatware = @(
        "Microsoft.3DBuilder",
        "Microsoft.BingWeather",
        "Microsoft.GetHelp",
        "Microsoft.MicrosoftOfficeHub",
        "Microsoft.MicrosoftSolitaireCollection",
        "Microsoft.Messaging",
        "Microsoft.MicrosoftStickyNotes",
        "Microsoft.MSPaint",
        "Microsoft.OneConnect",
        "Microsoft.OneNote",
        "Microsoft.People",
        "Microsoft.SkypeApp",
        "Microsoft.StorePurchaseApp",
        "Microsoft.XboxApp",
        "Microsoft.XboxGameOverlay",
        "Microsoft.XboxGamingOverlay",
        "Microsoft.XboxIdentityProvider",
        "Microsoft.XboxSpeechToTextOverlay",
        "Microsoft.YourPhone",
        "Microsoft.ZuneMusic",
        "Microsoft.ZuneVideo"
    )

    foreach ($app in $bloatware) {
        Get-AppxPackage -AllUsers $app | Remove-AppxPackage
    }

    Write-Host "Bloatware Removed.`n" -ForegroundColor Green
    Pause
}

do {
    Show-Menu
    $choice = Read-Host "Choose an option (1-7)"

    switch ($choice) {
        "1" { Debloat-Windows }
        "2" { Install-CommonSoftware }
        "3" { Apply-Optimizations }
        "4" { Apply-RegistryTweaks }
        "5" { Disable-Services }
        "6" { Remove-Bloatware }
        "7" { Write-Host "Goodbye!" -ForegroundColor Cyan }
        default { Write-Host "Invalid selection." -ForegroundColor Red; Pause }
    }
} while ($choice -ne "7")
