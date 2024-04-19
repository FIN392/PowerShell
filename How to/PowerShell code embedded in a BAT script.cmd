# 2>NUL & @CLS & PUSHD "%~dp0" & "%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoLogo -NoProfile -ExecutionPolicy Bypass "[IO.File]::ReadAllText('%~f0') | Invoke-Expression" & POPD & EXIT /B

#
# You Pwershell code goes here
#
Write-Host "Hello, World!"
Start-Sleep 5
