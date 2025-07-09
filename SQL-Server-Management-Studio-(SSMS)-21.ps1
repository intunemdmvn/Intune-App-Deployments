#-----------------------------------------------------------------------------------
# Create offline installer
"C:\Users\Admin\Downloads\vs_SSMS.exe" --layout "C:\Users\Admin\Downloads\SSMS"

#-----------------------------------------------------------------------------------
# Install command:
vs_SSMS.exe --quiet --norestart --wait
# Uninstall command:
"%ProgramFiles(x86)%\Microsoft Visual Studio\Installer\setup.exe" uninstall --installPath "%ProgramFiles%\Microsoft SQL Server Management Studio 21\Release" --quiet && timeout /t 300

#-----------------------------------------------------------------------------------
# Detection rules
Rule type        : File
Path             : %ProgramFiles%\Microsoft SQL Server Management Studio 21\Release\Common7\IDE
File or folder   : SSMS.exe
Detection method : File or folder exists
