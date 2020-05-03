
# Timestamp (UTC+02:00)    Severity Message                                      
# ------------------------ -------- ---------------------------------------------
# 2020-05-03 10:38:57.2435 DEBUG    This is a debug text                         
# 2020-05-03 10:38:57.2591 INFO     This is a information text                   
# 2020-05-03 10:38:57.2904 WARN     This is a warning text                       
# 2020-05-03 10:38:57.3060 ERROR    This is a error long text with many character
#                                   s and many information                       
# 2020-05-03 10:38:57.3372 FATAL    This is an fatal text                        

# Timestamp (UTC)          Severity Message                                      
# ------------------------ -------- ---------------------------------------------
# 20200503T0838574779Z

# 2020-05-03 08:38:57.4779 (UTC+00:00) | INFO  | xxxxxxxxxxxx
# 2020-05-03 08:38:57.4779 (UTC+05:30) | ERROR | xxxxxxxxxxxx



Import-Module -Name '.\xLog.psm1' -Force

$MyLog = Initialize-xLog -File '.\Logs\xLog.txt' -LocalTime -Reverse  -Console -Verbose

$MyLog | Format-List

Write-xLog -Log $MyLog -Severity DEBUG -Message 'xxxxx' -Verbose



# Remove-Item -Path '.\LogExample.txt' -ErrorAction Ignore 
# 1..100 | ForEach-Object { Add-Content -Path '.\LogExample.txt' -Value "This is line $_." }


# $LogFile = '.\LogExample.txt'
# $MaxLines = 5
# $LogEntry = 'XXXXXX'
# $UTC = $true
# $Reverse = $false

# if ( $Reverse ) {
#     $Log = Get-Content -Path $LogFile
#     Set-Content -Path $LogFile -Value $LogEntry,$Log -Force
# } else {
#     Add-Content -Path $LogFile -Value $LogEntry -Force
# }


# Remove-Module -Name xLog -Force
