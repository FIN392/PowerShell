# First, the module needs to be imported
Import-Module -Name '.\xLog.psm1' -Force

# Then the log should be initialized. At this stage you choose several format options
$MyLog = Initialize-xLog -File '.\xLogs\xLog_LocalTime_Reverse_Unicode.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'

# Now, simply add messages with the chosen severity to the log
Write-xLog -Log $MyLog -Severity DEBUG -Message ( 'PowerShell version ' + ( $PSVersionTable.PSVersion ) )
Write-xLog -Log $MyLog -Severity INFO  -Message 'LOREM IPSUM
	Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
	Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
	Praesent at enim fermentum, porta nulla quis, elementum leo.
	Nulla fermentum diam a neque posuere ultricies.
	Praesent sem lorem, aliquam et purus.'
Write-xLog -Log $MyLog -Severity WARN  -Message ( 'Current path: ' + ( Get-Location ).Path )
Write-xLog -Log $MyLog -Severity ERROR -Message ( (Get-Host).CurrentCulture.Name + ' | ' + (Get-Host).CurrentCulture.DisplayName )
Write-xLog -Log $MyLog -Severity FATAL -Message ( 'Spanish special characters: áéíóúüñÁÉÍÓÚÜÑ' )

# Just another example. Different initialization but...
$MyLog = Initialize-xLog -File '.\xLogs\xLog_UTC_ASCII.txt' -Encoding 'ASCII'

# ...same entries. (See different encoding for Spanish special characters)
Write-xLog -Log $MyLog -Severity DEBUG -Message ( 'PowerShell version ' + ( $PSVersionTable.PSVersion ) )
Write-xLog -Log $MyLog -Severity INFO  -Message 'LOREM IPSUM
	Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
	Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
	Praesent at enim fermentum, porta nulla quis, elementum leo.
	Nulla fermentum diam a neque posuere ultricies.
	Praesent sem lorem, aliquam et purus.'
Write-xLog -Log $MyLog -Severity WARN  -Message ( 'Current path: ' + ( Get-Location ).Path )
Write-xLog -Log $MyLog -Severity ERROR -Message ( (Get-Host).CurrentCulture.Name + ' | ' + (Get-Host).CurrentCulture.DisplayName )
Write-xLog -Log $MyLog -Severity FATAL -Message ( 'Spanish special characters: áéíóúüñÁÉÍÓÚÜÑ' )

# Finally, if there are not more scripts running in the session, the module can be removed
Remove-Module -Name xLog -Force

# 
# Check log files created at '.\xLogs\'.
# 