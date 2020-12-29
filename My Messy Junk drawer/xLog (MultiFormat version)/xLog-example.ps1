Import-Module -Name '.\xLog.psm1' -Force

Initialize-xLog -LogID LOG01 -File '.\Logs\xLog.txt'  -Format TXT
Initialize-xLog -LogID LOG02 -File '.\Logs\xLog.csv'  -Format CSV
Initialize-xLog -LogID LOG03 -File '.\Logs\xLog.xml'  -Format XML  -UTC
Initialize-xLog -LogID LOG04 -File '.\Logs\xLog.html' -Format HTML
Initialize-xLog -LogID LOG05 -File '.\Logs\xLog.json' -Format JSON -UTC

Write-xLog -LogID LOG01 -Console -Severity DEBUG -Message 'This is a debug text'
Write-xLog -LogID LOG01 -Console -Severity INFO  -Message 'This is a information text'
Write-xLog -LogID LOG01 -Console -Severity WARN  -Message 'This is a warning text'
Write-xLog -LogID LOG01 -Console -Severity ERROR -Message 'LOREM IPSUM. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nisi arcu, commodo et ante id, tempus rutrum diam. Fusce fermentum aliquet metus ut posuere. Etiam at libero augue. Praesent at enim fermentum, porta nulla quis, elementum leo. Nulla fermentum diam a neque posuere ultricies. Praesent sem lorem, aliquam et purus.'
Write-xLog -LogID LOG01 -Console -Severity FATAL -Message 'This is an fatal text'

Write-xLog -LogID LOG02 -Console -Severity DEBUG -Message 'This is a debug text'
Write-xLog -LogID LOG02 -Console -Severity INFO  -Message 'This is a information text'
Write-xLog -LogID LOG02 -Console -Severity WARN  -Message 'This is a warning text'
Write-xLog -LogID LOG02 -Console -Severity ERROR -Message 'LOREM IPSUM. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nisi arcu, commodo et ante id, tempus rutrum diam. Fusce fermentum aliquet metus ut posuere. Etiam at libero augue. Praesent at enim fermentum, porta nulla quis, elementum leo. Nulla fermentum diam a neque posuere ultricies. Praesent sem lorem, aliquam et purus.'
Write-xLog -LogID LOG02 -Console -Severity FATAL -Message 'This is an fatal text'

Write-xLog -LogID LOG03 -Console -Severity DEBUG -Message 'This is a debug text'
Write-xLog -LogID LOG03 -Console -Severity INFO  -Message 'This is a information text'
Write-xLog -LogID LOG03 -Console -Severity WARN  -Message 'This is a warning text'
Write-xLog -LogID LOG03 -Console -Severity ERROR -Message 'LOREM IPSUM. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nisi arcu, commodo et ante id, tempus rutrum diam. Fusce fermentum aliquet metus ut posuere. Etiam at libero augue. Praesent at enim fermentum, porta nulla quis, elementum leo. Nulla fermentum diam a neque posuere ultricies. Praesent sem lorem, aliquam et purus.'
Write-xLog -LogID LOG03 -Console -Severity FATAL -Message 'This is an fatal text'

Write-xLog -LogID LOG04 -Console -Severity DEBUG -Message 'This is a debug text'
Write-xLog -LogID LOG04 -Console -Severity INFO  -Message 'This is a information text'
Write-xLog -LogID LOG04 -Console -Severity WARN  -Message 'This is a warning text'
Write-xLog -LogID LOG04 -Console -Severity ERROR -Message 'LOREM IPSUM. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nisi arcu, commodo et ante id, tempus rutrum diam. Fusce fermentum aliquet metus ut posuere. Etiam at libero augue. Praesent at enim fermentum, porta nulla quis, elementum leo. Nulla fermentum diam a neque posuere ultricies. Praesent sem lorem, aliquam et purus.'
Write-xLog -LogID LOG04 -Console -Severity FATAL -Message 'This is an fatal text'

Write-xLog -LogID LOG05 -Console -Severity DEBUG -Message 'This is a debug text'
Write-xLog -LogID LOG05 -Console -Severity INFO  -Message 'This is a information text'
Write-xLog -LogID LOG05 -Console -Severity WARN  -Message 'This is a warning text'
Write-xLog -LogID LOG05 -Console -Severity ERROR -Message 'LOREM IPSUM. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus nisi arcu, commodo et ante id, tempus rutrum diam. Fusce fermentum aliquet metus ut posuere. Etiam at libero augue. Praesent at enim fermentum, porta nulla quis, elementum leo. Nulla fermentum diam a neque posuere ultricies. Praesent sem lorem, aliquam et purus.'
Write-xLog -LogID LOG05 -Console -Severity FATAL -Message 'This is an fatal text'

Close-xLog -LogID LOG01
Close-xLog -LogID LOG02
Close-xLog -LogID LOG03
Close-xLog -LogID LOG04
Close-xLog -LogID LOG05

Remove-Module -Name xLog -Force
