<#
.SYNOPSIS
    Lab Initialization Script for Windows 11 / Server 2022
.DESCRIPTION
    This script debloats the OS, configures environment settings, 
    and downloads the Sysinternals Suite to C:\Tools.
#>

# 1. Set Execution Policy to allow local scripts
Set-ExecutionPolicy RemoteSigned -Force

# 2. Create the Tools directory
$toolsPath = "C:\Tools"
if (!(Test-Path $toolsPath)) {
    New-Item -ItemType Directory -Path $toolsPath
}

# 3. Download Sysinternals Suite directly from Microsoft
Write-Host "Downloading Sysinternals Suite..." -ForegroundColor Cyan
$url = "https://download.sysinternals.com/files/SysinternalsSuite.zip"
$zipFile = "$toolsPath\Sysinternals.zip"
Invoke-WebRequest -Uri $url -OutFile $zipFile

Write-Host "Extracting tools..." -ForegroundColor Cyan
Expand-Archive -Path $zipFile -DestinationPath $toolsPath -Force
Remove-Item $zipFile

# 4. Debloat Windows 11 (Remove common consumer apps)
Write-Host "Removing pre-installed bloatware..." -ForegroundColor Yellow
$apps = @(
    "*MicrosoftTeams*",
    "*OneDrive*",
    "*Skype*",
    "*ZuneVideo*",
    "*ZuneMusic*",
    "*BingNews*",
    "*Weather*"
)

foreach ($app in $apps) {
    Get-AppxPackage -Name $app -AllUsers | Remove-AppxPackage -ErrorAction SilentlyContinue
}

# 5. Optimization Tweaks
Write-Host "Applying system optimizations..." -ForegroundColor Green
# Disable Hibernation to save disk space (important for 512GB NVMe)
powercfg -h off

# Disable the Windows "Consumer Experience" (Stop auto-installing candy crush etc)
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\CloudContent"
if (!(Test-Path $registryPath)) { New-Item $registryPath -Force }
Set-ItemProperty -Path $registryPath -Name "DisableWindowsConsumerFeatures" -Value 1

Write-Host "Initialization complete. Tools are located in $toolsPath." -ForegroundColor Green
Write-Host "Please restart the VM before taking your Golden Image snapshot."
