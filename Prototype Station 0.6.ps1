# Set dark mode
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0

# PowerShell script to download and optionally install multiple applications

# Define download folder on Desktop
$desktopPath = [Environment]::GetFolderPath('Desktop')
$downloadFolder = Join-Path -Path $desktopPath -ChildPath "StationDownloads"

# Ensure the folder exists
if (-not (Test-Path -Path $downloadFolder)) {
    New-Item -ItemType Directory -Path $downloadFolder
    Write-Output "Created download folder at $downloadFolder"
}

# List of applications with URLs and file names
$applications = @(
    @{ Name = "Opera Browser"; URL = "https://net.geo.opera.com/opera/stable/windows"; FileName = "OperaSetup.exe" },
    @{ Name = "NordPass"; URL = "https://downloads.npass.app/windows/NordPassSetup.exe"; FileName = "NordPassSetup.exe" },
    @{ Name = "Obsidian"; URL = "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/Obsidian-1.7.7.exe"; FileName = "ObsidianSetup.exe" },
    @{ Name = "Stack"; URL = "https://api-se.getstack.app/download/win32/beta?arch=x64&next=true"; FileName = "StackSetup.exe" },
    @{ Name = "Telegram"; URL = "https://telegram.org/dl/desktop/win64"; FileName = "TelegramSetup.exe" }
)

# Download applications
foreach ($app in $applications) {
    $outputPath = Join-Path -Path $downloadFolder -ChildPath $app.FileName

    if (-not (Test-Path -Path $outputPath)) {
        Write-Output "Downloading $($app.Name)..."
        try {
            Invoke-WebRequest -Uri $app.URL -OutFile $outputPath
            Write-Output "$($app.Name) downloaded to $outputPath"
        } catch {
            Write-Output "Failed to download $($app.Name): $_"
        }
    } else {
        Write-Output "$($app.Name) is already downloaded."
    }
}

# Prompt the user to install each application
foreach ($app in $applications) {
    $outputPath = Join-Path -Path $downloadFolder -ChildPath $app.FileName

    if (Test-Path -Path $outputPath) {
        $response = Read-Host "Do you want to install $($app.Name)? (Yes/No)"

        if ($response -eq "Yes") {
            Write-Output "Installing $($app.Name)..."
            try {
                Start-Process -FilePath $outputPath -Wait
                Write-Output "$($app.Name) installation completed."
            } catch {
                Write-Output "Failed to install $($app.Name): $_"
            }
        } else {
            Write-Output "Skipped installation of $($app.Name)."
        }
    } else {
        Write-Output "Installation file for $($app.Name) not found. Skipping."
    }
}

# Ensure the Clipboard key exists
$clipboardPath = "HKCU:\Software\Microsoft\Clipboard"
if (-not (Test-Path $clipboardPath)) {
    New-Item -Path $clipboardPath -Force
}

# Enable Clipboard History
Set-ItemProperty -Path $clipboardPath -Name "EnableClipboardHistory" -Value 1

# Open Calculator
Start-Process "calc"

Write-Output "All tasks completed."
