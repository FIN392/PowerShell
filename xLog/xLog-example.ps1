# First, the module needs to be imported
Import-Module -Name '.\xLog.psm1' -Force

# Then the log should be initialized. At this stage you choose several format options
$MyLog = Initialize-xLog -File '.\Logs\xLog.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'

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
Write-xLog -Log $MyLog -Severity ERROR -Message ( (Get-Host).CurrentCulture.Name )
Write-xLog -Log $MyLog -Severity FATAL -Message ( (Get-Host).CurrentCulture.DisplayName )



# Finally, if there are not more scripts running in the session, the module can be removed
Remove-Module -Name xLog -Force

# How looks like the created log:
# 	2020-05-11 08:52:38.615 (+02:00) | FATAL | Spanish (Spain, International Sort)
# 	2020-05-11 08:52:38.513 (+02:00) | ERROR | es-ES
# 	2020-05-11 08:52:38.488 (+02:00) | WARN  | Current path: C:\Users\FERNAJL\OneDrive - Abbott\GitHub\PowerShell\xLog\Straight
# 	2020-05-11 08:52:38.461 (+02:00) | INFO  | LOREM IPSUM
# 	        Lorem ipsum dolor sit amet, consectetur adipiscing elit.
# 	        Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
# 	        Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
# 	        Praesent at enim fermentum, porta nulla quis, elementum leo.
# 	        Nulla fermentum diam a neque posuere ultricies.
# 	        Praesent sem lorem, aliquam et purus.
# 	2020-05-11 08:52:38.425 (+02:00) | DEBUG | PowerShell version 7.0.0


# Import-Module -Name '.\xLog.psm1' -Force
# Get-Help Initialize-xLog -Detailed
# Get-Help Write-xLog -Detailed
# Remove-Module -Name xLog -Force

