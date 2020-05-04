# 2020-05-04 00:54:37.053 (+02:00) | DEBUG | xxxxxxxxxxxxxxxx
# 2020-05-04 00:54:37.068 (+02:00) | INFO  | xxxxxxxxxxxxxxxx
# 2020-05-04 00:54:37.084 (+02:00) | WARN  | xxxxxxxxxxxxxxxx
# 2020-05-04 00:54:37.099 (+02:00) | ERROR | xxxxxxxxxxxxxxxx
# 2020-05-04 00:54:37.115 (+02:00) | FATAL | xxxxxxxxxxxxxxxx

Import-Module -Name '.\xLog.psm1' -Force

$MyLog = Initialize-xLog -File '.\Logs\xLog.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'

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

Remove-Module -Name xLog -Force
