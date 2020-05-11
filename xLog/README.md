# xLog
xLog is a PowerShell module to create log files.

Multiple logs files can be created at the same time in a script, each one with a different format. Additionaly to the log file, the entries can be displayed in the host (typically the console screen).

## How to use it?

First, the module needs to be imported:

```PowerShell
Import-Module -Name '.\xLog.psm1' -Force
```

Then initialized the log:

```PowerShell
$MyLog = Initialize-xLog -File '.\xLogs\xLog_LocalTime_Reverse_Unicode.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'
```

Add entries:

```PowerShell
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
```

Finally, if there are not more scripts running in the session, the module can be removed:

```PowerShell
Remove-Module -Name xLog -Force
```

## How to initialize a log?

```PowerShell
{object} = Initialize-xLog [-File] {string} [-LocalTime] [-Reverse] [-Console] [-Encoding {CharSet}]
```

__-File__ _{string}_

<ul>
File name where log entries will be written.<br>
Example: 'C:\TEMP\Log.xt', '\\SERVER\SHARE\output.txt', 'C:\Apps\Events.log', etc.<br>
ATTENTION: If the file already exists entries are added to existing ones.<br>
Mandatory.<br>
</ul>

__-LocalTime__

If this parameter is present, the timestamp will be this format 'yyyy-MM-dd HH:mm:ss.fff (+hh:mm)', being '(+hh:mm)' the time zone offset from UTC.<br>
Otherwise timestamp will be 'yyyy-MM-dd HH:mm:ss.fff (+00:00)'. It is UTC time (Universal Time Coordinate).<br>
Optional.<br>

__-Reverse__

Entries will be added at the beginning of the file.<br>
By default, new entries are added at the end of the file.<br>
Optional.<br>

__-Console__

Entries will be additionally shown in host (typically the console screen).<br>
By default, entries are not shown.<br>
Optional.<br>

__-Encoding__ _{CharSet}_

Entries text messages will be encoded in the specificed character set.<br>
Possible options and default value vary on PowerShell version. For example: 'ASCII' in versión 6 and 'UTF8NoBOM' in version 7.<br>
See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.<br>
Optional.<br>

## How to add an entry to a log?

```PowerShell
Write-xLog [-Log] {object} [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] {string}
```

-Log {object}

-Severity {DEBUG | INFO | WARN | ERROR | FATAL}

-Message {string}






ENJOY IT!!! and please contact me for any doubt or improvement proposal.

## File Format Examples

### TXT (with timestamp in local time)
```
Timestamp (UTC+02:00)    Severity Message                                      
------------------------ -------- ---------------------------------------------
2020-04-08 11:01:31.8987 DEBUG    This is a debug text                         
2020-04-08 11:01:31.9277 INFO     This is a information text                   
2020-04-08 11:01:31.9527 WARN     This is a warning text                       
2020-04-08 11:01:31.9797 ERROR    This is a error long text with many character
                                  s and many information                       
2020-04-08 11:01:32.0267 FATAL    This is an fatal text                        
------------------------ -------- ---------------------------------------------
```
### CSV (with UTC timestamp)
```
"Timestamp","Severity","Message"
"20200408T0901323177Z","DEBUG","This is a debug text"
"20200408T0901323417Z","INFO","This is a information text"
"20200408T0901323727Z","WARN","This is a warning text"
"20200408T0901323957Z","ERROR","This is a error long text with many characters and many information"
"20200408T0901324287Z","FATAL","This is an fatal text"
"","","***EOF***"
```

