Import-Module -Name '.\xLog.psm1' -Force

$MyLog = Start-xLog -File '.\Logs\Log_TXT.txt' -Format TXT -UTC

$MyLog | Format-Table -AutoSize -Wrap

# Write-xLog -LogID LOG01 -Console -Severity DEBUG -Message 'This is a debug text'
# Write-xLog -LogID LOG01 -Console -Severity INFO  -Message 'This is a information text'
# Write-xLog -LogID LOG01 -Console -Severity WARN  -Message 'This is a warning text'
# Write-xLog -LogID LOG01 -Console -Severity ERROR -Message 'This is a error long text with many characters and many information'
# Write-xLog -LogID LOG01 -Console -Severity FATAL -Message 'This is an fatal text'

$MyLog | Stop-xLog

$MyLog | Format-Table -AutoSize -Wrap


