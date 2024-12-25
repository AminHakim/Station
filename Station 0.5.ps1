# Set dark mode
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0

# PowerShell script to open multiple websites

# List of URLs to open
$urls = @(
    "https://www.opera.com/computer/thanks?ni=eapgx&os=windows",
    "https://downloads.npass.app/windows/NordPassSetup.exe",
    "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.7.7/Obsidian-1.7.7.exe",
    "https://api-se.getstack.app/download/win32/beta?arch=x64&next=true",
    "https://telegram.org/dl/desktop/win64"
)

# Loop through each URL and open it
foreach ($url in $urls) {
    Start-Process $url
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
