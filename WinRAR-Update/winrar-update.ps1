
# GitHub API URL for the app manifest
$apiUrl = "https://api.github.com/repos/microsoft/winget-pkgs/contents/manifests/r/RARLab/WinRAR"

# Fetch version folders then filter only version folders
$versions = Invoke-RestMethod -Uri $apiUrl -Headers @{ 'User-Agent' = 'PowerShell' }
$versionFolders = $versions | Where-Object { $_.type -eq "dir" }

# Extract and sort version numbers then get the latest version
$sortedVersions = $versionFolders | ForEach-Object { $_.name } | Sort-Object {[version]$_} -Descending
$latestVersion = $sortedVersions[0]

# Get contents of the latest version folder then find the .installer.yaml file
$latestApiUrl = "$apiUrl/$latestVersion"
$latestFiles = Invoke-RestMethod -Uri $latestApiUrl -Headers @{ 'User-Agent' = 'PowerShell' }
$installerFile = $latestFiles | Where-Object { $_.name -like "*.installer.yaml" }

# Download and parse YAML content to get the Url of the latest installer file.
$yamlUrl = $installerFile.download_url
$yamlContent = Invoke-RestMethod -Uri $yamlUrl -Headers @{ 'User-Agent' = 'PowerShell' }
$installerUrl = ($yamlContent -join "`n") -match "InstallerUrl:\s+(http.*)" | ForEach-Object { $Matches[1] }

# Get the installed version of WinRAR to the $installedVersion variable
$regPaths = @(
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall",
    "HKLM:\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall"
)

foreach ($regPath in $regPaths) {
    $apps = Get-ChildItem $regPath -ErrorAction SilentlyContinue
    foreach ($app in $apps) {
        $props = Get-ItemProperty $app.PSPath
        if ($props.DisplayName -like "*WinRAR*") {
            $installedVersion = $($props.DisplayVersion)
        }
    }
}

# If the installed version is older than the latest version. 
# Download the latest installer then starting update process.
if ($installedVersion -lt $latestVersion) {
    $webClient = [System.Net.WebClient]::new()
    $webClient.DownloadFile($installerUrl, "$env:TEMP\winrar-latest.exe")

    Start-Process -FilePath "$env:TEMP\winrar-latest.exe" -ArgumentList '-s1' -Wait
}