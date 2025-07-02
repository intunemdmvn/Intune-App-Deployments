@echo off
cd /d "%~dp0"
setup.exe uninstall --productId Microsoft.VisualStudio.Product.Professional --channelId VisualStudio.17.Release --quiet
timeout /t 300