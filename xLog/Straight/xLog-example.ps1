
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



# Import-Module -Name '.\xLog.psm1' -Force

# $xLog = Initialize-xLog -File '.\Logs\xLog.txt' -UTC -Reverse -MaxLines 1000

# Write-xLog $xLog -Severity DEBUG - Message 'xxxxx'


1..100 | ForEach-Object { Add-Content -Path .\LogExample.txt -Value "This is line $_." }

Measure-Command -Expression {
    $Log = Get-Content -Path .\LogExample.txt
}



# Remove-Module -Name xLog -Force
