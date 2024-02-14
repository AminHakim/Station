# Set dark mode
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0

# PowerShell script to open multiple websites

# List of URLs to open
$urls = @(
    "https://www.opera.com/computer/thanks?ni=eapgx&os=windows",
    "https://downloads.npass.app/windows/NordPassSetup.exe",
    "https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/Obsidian.1.5.3.exe",
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

# Wait for 10 seconds
Start-Sleep -Seconds 10

# Define the path to the Downloads folder
$downloadsPath = [System.Environment]::GetFolderPath('Download')

# Get all .exe files in the Downloads folder
$exeFiles = Get-ChildItem -Path $downloadsPath -Filter *.exe

# List of expected installer names without the '.exe' extension
$expectedInstallers = @(
    "NordPassSetup",
    "Stack Next SE Setup 4.9.1-beta.0-x64",
    "Obsidian.1.5.3",
    "OperaGXSetup",
    "tsetup-x64.4.14.13"
)

# Loop through each expected installer name
foreach ($installerName in $expectedInstallers) {
    # Find the corresponding .exe file in the Downloads folder
    $installerFile = $exeFiles | Where-Object { $_.Name -like "$installerName*.exe" }
    
    # If the installer file is found, execute it and wait for completion
    if ($installerFile) {
        $filePath = Join-Path $downloadsPath $installerFile.Name
        Start-Process -FilePath $filePath -Wait
    }
}

