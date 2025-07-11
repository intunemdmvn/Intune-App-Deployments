if (Get-ScheduledTask -TaskName 'Update WinRAR Daily') {
    Write-Host "Detected."
    exit 0
} else {
    Write-Host "Not found."    
    exit 1
}