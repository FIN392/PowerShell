# First, the module needs to be imported
Import-Module -Name '.\xLog.psm1' -Force

# Then the log should be initialized. At this stage you choose several format options
$MyLog = Initialize-xLog -File '.\Logs\xLog.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'

# Now, simply add messages with the chosen severity to the log
Write-xLog -Log $MyLog -Severity DEBUG -Message 'LOREM IPSUM
    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
    Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
    Praesent at enim fermentum, porta nulla quis, elementum leo.
    Nulla fermentum diam a neque posuere ultricies.
    Praesent sem lorem, aliquam et purus.'
Write-xLog -Log $MyLog -Severity INFO  -Message ( 'PowerShell version ' + ( $PSVersionTable.PSVersion ) )
Write-xLog -Log $MyLog -Severity WARN  -Message ( 'Current path: ' + ( Get-Location ).Path )
Write-xLog -Log $MyLog -Severity ERROR -Message ( (Get-Host).CurrentCulture.Name )
Write-xLog -Log $MyLog -Severity FATAL -Message ( (Get-Host).CurrentCulture.DisplayName )


Get-Help Initialize-xLog -Detailed
Get-Help Write-xLog -Detailed

# Finally, if there are not more scripts running in the session, the module can be removed
Remove-Module -Name xLog -Force
