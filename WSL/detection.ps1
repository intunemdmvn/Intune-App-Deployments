$OptionalFeatures = Get-WmiObject -Class Win32_OptionalFeature
if ( $OptionalFeatures | Where-Object {($_.Name -Match "VirtualMachinePlatform") -and ($_.InstallState -eq 1)} ){
$true
}