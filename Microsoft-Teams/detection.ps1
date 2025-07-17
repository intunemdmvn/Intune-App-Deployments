$NewTeams = $null
$windowsAppsPath = "%ProgramFiles%\WindowsApps"
$NewTeamsSearch = "MSTeams_*_x64__*"
$NewTeams = Get-ChildItem -Path $windowsAppsPath -Directory -Filter $NewTeamsSearch -ErrorAction SilentlyContinue
if ($NewTeams ) {
    Write-Host "New Teams found"
    exit 0
} else {
    Write-Host "New Teams not found"
    exit 1
}