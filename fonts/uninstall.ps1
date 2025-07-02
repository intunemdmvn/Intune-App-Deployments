#List all fonts from the font directory (.TTF and .OTF)
$Fonts = @(Get-ChildItem -Path "*.ttf")
$Fonts += @(Get-ChildItem -Path "*.otf")

#Remove the fonts from the Font Directory

foreach($Font in $Fonts) {
    Remove-Item -Path "$env:windir\Fonts\$($Font.Name)" -Force
    Remove-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts" -Name $Font.Name -Force
}