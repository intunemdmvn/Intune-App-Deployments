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

$latestVersion = '7.12.0'

# If the installed version is older than the latest version. 
# Stop WinRAR if it running then install the update
if ($installedVersion -lt $latestVersion) {

    $process = Get-Process -ProcessName 'WinRAR' -ErrorAction SilentlyContinue
    if ($process) {
        Stop-Process -ProcessName 'WinRAR' -Force
    }

    Start-Process -FilePath ".\setup.exe" -ArgumentList '-s1' -Wait
}
