# xLog
xLog is a PowerShell module to create log files.

Multiple logs files can be created at the same time in a script, each one with a different format. Additionaly to the log file, the entries can be displayed in the host (typically the console screen).

ENJOY IT!!! and please contact me for any doubt or improvement proposal.

[How to use it?](#How-to-use-it)



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

<ul>
	If this parameter is present, the timestamp will be this format 'yyyy-MM-dd HH:mm:ss.fff (+hh:mm)', being '(+hh:mm)' the time zone offset from UTC.<br>
	Otherwise timestamp will be 'yyyy-MM-dd HH:mm:ss.fff (+00:00)'. It is UTC time (Universal Time Coordinate).<br>
	Optional.<br>
</ul>

__-Reverse__

<ul>
	Entries will be added at the beginning of the file.<br>
	By default, new entries are added at the end of the file.<br>
	Optional.<br>
</ul>

__-Console__

<ul>
	Entries will be additionally shown in host (typically the console screen).<br>
	By default, entries are not shown.<br>
	Optional.<br>
</ul>

__-Encoding__ _{CharSet}_

<ul>
	Entries text messages will be encoded in the specificed character set.<br>
	Possible options and default value vary on PowerShell version. For example: 'ASCII' in versión 6 and 'UTF8NoBOM' in version 7.<br>
	See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.<br>
	Optional.<br>
</ul>

## How to add an entry to a log?

```PowerShell
Write-xLog [-Log] {object} [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] {string}
```

__-Log__ _{object}_

<ul>
	Object with the following information:<br>
	<ul>
		'xLog': TRUE. This is just a flag indicating that the variable is correct.<br>
		'File': Name of log file.<br>
		'LocalTime': Timestamp for log entries is UTC by default. If this parameter is present, the time will be based local time zone.<br>
		'Reverse': Entries are added at the end of the file by default. If this parameter is present, the entry is added at the beginning.<br>
		'Console': If this parameter is present, the entry is additionally written in host (typically the console screen).<br>
		'Encoding': Encode the entry in a specific character set. See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.<br>
	</ul>
	Mandatory.<br>
</ul>

__-Severity__ _{DEBUG | INFO | WARN | ERROR | FATAL}_

<ul>
	One of the following 'DEBUG', 'INFO', 'WARN', 'ERROR' or 'FATAL'.<br>
	Describe the severity of the logged event and generally follow these conventions:<br>
	<ul>
		DEBUG: Information that is helpful to developers.<br>
		INFO: General information.<br>
		WARN: An event that can potentially cause a process issue, but automatically recovered.<br>
		ERROR: Error which occurs on the process.<br>
		FATAL: Any error that is forcing a shutdown of the process.<br>
	</ul>
	Mandatory.<br>
</ul>

__-Message__ _{string}_

<ul>
	Text message describing the event.<br>
	Mandatory.<br>
</ul>

## How the log files looks like?

Example of log with timestamp on UTC and encoding ASCII

```
2020-05-11 07:27:18.863 (+00:00) | DEBUG | PowerShell version 7.0.0
2020-05-11 07:27:18.873 (+00:00) | INFO  | LOREM IPSUM
	Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
	Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
	Praesent at enim fermentum, porta nulla quis, elementum leo.
	Nulla fermentum diam a neque posuere ultricies.
	Praesent sem lorem, aliquam et purus.
2020-05-11 07:27:18.883 (+00:00) | WARN  | Current path: C:\Users\FERNAJL\OneDrive - Abbott\GitHub\PowerShell\xLog
2020-05-11 07:27:18.893 (+00:00) | ERROR | es-ES | Spanish (Spain, International Sort)
2020-05-11 07:27:18.901 (+00:00) | FATAL | Spanish special characters: ??????????????
```

Same entries with timestamp on local time zone, encoding UNICODE and written in reverse (the latest line in the top).

```
2020-05-11 09:27:18.823 (+02:00) | FATAL | Spanish special characters: áéíóúüñÁÉÍÓÚÜÑ
2020-05-11 09:27:18.784 (+02:00) | ERROR | es-ES | Spanish (Spain, International Sort)
2020-05-11 09:27:18.761 (+02:00) | WARN  | Current path: C:\Users\FERNAJL\OneDrive - Abbott\GitHub\PowerShell\xLog
2020-05-11 09:27:18.716 (+02:00) | INFO  | LOREM IPSUM
	Lorem ipsum dolor sit amet, consectetur adipiscing elit.
	Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
	Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
	Praesent at enim fermentum, porta nulla quis, elementum leo.
	Nulla fermentum diam a neque posuere ultricies.
	Praesent sem lorem, aliquam et purus.
2020-05-11 09:27:18.695 (+02:00) | DEBUG | PowerShell version 7.0.0
```
