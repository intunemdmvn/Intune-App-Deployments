# Change working directory to the script's location
Set-Location -Path $PSScriptRoot

Write-Host ""
Write-Host "Installing runtime packages..."

# Determine if the system is 64-bit
$Is64Bit = $False
if ($([System.Environment]::Is64BitOperatingSystem)) {
    $Is64Bit = $True
}

# Define the installation function
function InstallRuntime {
    param (
        [string]$Executable,
        [string]$Arguments
    )
    
    Write-Host "Installing $Executable..."
    Start-Process -FilePath $Executable -ArgumentList $Arguments -Wait
}

# Install runtimes
if (-not $Is64Bit) {
    # 32-bit system
    InstallRuntime "vcredist2005_x86.exe" "/q"
    InstallRuntime "vcredist2008_x86.exe" "/qb"
    InstallRuntime "vcredist2010_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2012_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2013_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2015_2017_2019_2022_x86.exe" "/passive /norestart"
} else {
    # 64-bit system
    InstallRuntime "vcredist2005_x86.exe" "/q"
    InstallRuntime "vcredist2005_x64.exe" "/q"
    InstallRuntime "vcredist2008_x86.exe" "/qb"
    InstallRuntime "vcredist2008_x64.exe" "/qb"
    InstallRuntime "vcredist2010_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2010_x64.exe" "/passive /norestart"
    InstallRuntime "vcredist2012_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2012_x64.exe" "/passive /norestart"
    InstallRuntime "vcredist2013_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2013_x64.exe" "/passive /norestart"
    InstallRuntime "vcredist2015_2017_2019_2022_x86.exe" "/passive /norestart"
    InstallRuntime "vcredist2015_2017_2019_2022_x64.exe" "/passive /norestart"
}

Write-Host ""
Write-Host "Installation completed successfully!"
exit