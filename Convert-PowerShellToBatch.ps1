function Convert-PowerShellToBatch {
    param (
        [Parameter(Mandatory)]
        [string]
        $Path
    )
    process {
        $encoded = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes((Get-Content -Path $Path -Raw -Encoding UTF8)))
        $newPath = [Io.Path]::ChangeExtension($Path, ".bat")
        "@echo off`n`npowershell.exe -NoExit -encodedCommand $encoded" | Set-Content -Path $newPath -Encoding ASCII
    }
}

Convert-PowerShellToBatch -Path "C:\Path\To\YourScript.ps1"
