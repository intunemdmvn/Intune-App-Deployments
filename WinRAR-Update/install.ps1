# $trigger = New-ScheduledTaskTrigger -Weekly -At 3AM -DaysOfWeek Monday -WeeksInterval 1
$trigger = New-ScheduledTaskTrigger -Daily -At 12AM
$action = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-NoProfile -ExecutionPolicy ByPass -NonInteractive -WindowStyle Hidden -File "C:\IntuneScripts\winrar-update.ps1"'
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest
$splat = @{
    TaskName = 'Update WinRAR Daily'
    Trigger = $trigger
    Action = $action
    Settings = $settings
    Principal = $principal
    TaskPath = '\IntuneTasks\'
}
Register-ScheduledTask @splat
