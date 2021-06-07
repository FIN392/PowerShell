#
# xLog
#
# Author      : FIN392 - fin392@gmail.com
# Last update : 2020-05-03
# Version     : 0.2 - Initial release
# 
# For more information on this PowerShell module go to:
# https://github.com/FIN392/PowerShell/tree/master/xLog
#


# {object} = Initialize-xLog [-File] {string} [-LocalTime] [-Reverse] [-Console] [-Encoding {CharSet}]
function Initialize-xLog {
<# 
	.SYNOPSIS
		Initialize a log file.

	.DESCRIPTION
		Return a object with the following information:
			'xLog'     : TRUE. This is just a flag indicating that the variable is correct.
			'File'     : Name of log file.
			'LocalTime': Timestamp for log entries is UTC by default. If this parameter is present, the time will be based local time zone.
			'Reverse'  : Entries are added at the end of the file by default. If this parameter is present, the entry is added at the beginning.
			'Console'  : If this parameter is present, the entry is additionally shown in host (typically the console screen).
			'Encoding' : Encode the entry in a specific character set. See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.
		If it does not exist, the specified file is created (including the full path if necessary).
		The common parameter VERBOSE is available for detailed information of process.

	.PARAMETER File
		File name where log entries will be written.
		Example: 'C:\TEMP\Log.xt', '\\SERVER\SHARE\output.txt', 'C:\Apps\Events.log', etc.
		ATTENTION: If the file already exists entries are added to existing ones.
		Mandatory.

	.PARAMETER LocalTime
		If this parameter is present, the timestamp will be this format 'yyyy-MM-dd HH:mm:ss.fff (+hh:mm)', being '(+hh:mm)' the time zone offset from UTC.
		Otherwise timestamp will be 'yyyy-MM-dd HH:mm:ss.fff (+00:00)'. It is UTC time (Universal Time Coordinate).
		Optional.

	.PARAMETER Reverse
		Entries will be added at the beginning of the file.
		By default, new entries are added at the end of the file.
		Optional.

	.PARAMETER Console
		Entries will be additionally shown in host (typically the console screen).
		By default, entries are not shown.
		Optional.

	.PARAMETER Encoding
		Entries text messages will be encoded in the specificed character set.
		Possible options and default value vary on PowerShell version. For example: 'ASCII' in versión 6 and 'UTF8NoBOM' in version 7.
		See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.
		Optional.

	.INPUTS
		None.

	.OUTPUTS
		Return a object with the following information:
			'xLog'     : TRUE. This is just a flag indicating that the variable is correct.
			'File'     : Name of log file.
			'LocalTime': Timestamp for log entries is UTC by default. If this parameter is present, the time will be based local time zone.
			'Reverse'  : Entries are added at the end of the file by default. If this parameter is present, the entry is added at the beginning.
			'Console'  : If this parameter is present, the entry is additionally written in host (typically the console screen).
			'Encoding' : Encode the entry in a specific character set. See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.

	.EXAMPLE
		$MyLog = Initialize-xLog -File '.\Logs\xLog.txt'
	
		Entries will be added to file '.\Logs\xLog.txt'.
		Timestamp will be set to local time zone and format 'yyyy-MM-dd HH:mm:ss.fff (+00:00)'.
		Log entries will be added at the end of the file.		

	.EXAMPLE
		$MyLog = Initialize-xLog -File '.\Logs\xLog.txt' -LocalTime -Reverse -Console -Encoding 'Unicode'

		Entries will be added to file '.\Logs\xLog.txt'.
		Timestamp will be set to local time zone and format 'yyyy-MM-dd HH:mm:ss.fff (+hh:mm)', being '(+hh:mm)' the time zone offset from UTC. 
		Log entries will be added at the beginning of the file (reverse mode).
		Entry will be written in host (typically the console screen).
		Text message will be encoded as 'Unicode'.

	.LINK
		https://github.com/FIN392/PowerShell/tree/master/xLog

	.NOTES
		Author: FIN392 - fin392@gmail.com
#>
	[CmdletBinding()]
	param (
		[Parameter ( Mandatory=$true, Position=1 )]
			[ValidateScript({
				if( -Not ($_ | Test-Path -IsValid) ){
					throw "Path name is not valid"
				}
				return $true
			})]
			[String]$File,
		[Parameter ( Mandatory=$false )][Switch]$LocalTime,
		[Parameter ( Mandatory=$false )][Switch]$Reverse,
		[Parameter ( Mandatory=$false )][Switch]$Console,
		[Parameter ( Mandatory=$false )][String]$Encoding = 'default'
	)

	$ErrorActionPreference = 'Stop'

	Write-Verbose ( 'Initializing log...' )

	# Create log object
	$ArgLog = @{
		'xLog'=$true;
		'File'=$File;
		'LocalTime'=$LocalTime;
		'Reverse'=$Reverse;
		'Console'=$Console;
		'Encoding'=$Encoding
	}
	$Log = New-Object -TypeName psobject -Property $ArgLog

	# Create folder if do not exist
	if ( -Not ( Test-Path -Path ( split-path -Path ($Log.File) -Parent ) ) ) {
		[void]( New-Item -ItemType Directory -Force -Path (split-path -Path $Log.File -Parent) )
		Write-Verbose ( '    Created path "' + (split-path -Path $Log.File -Parent) + '"' )
	}
	
	# Create file if do not exist
	if ( -Not (Test-Path -Path $Log.File) ) {
		[void]( New-Item -Path (split-path -Path $Log.File -Parent) -Name (split-path -Path $Log.File -Leaf) -ItemType 'file' )
		Write-Verbose ( '    Created file "' + (split-path -Path $Log.File -Leaf) + '"' )
	}

	Write-Verbose ( '    Set log file to "' + (Resolve-Path -Path $Log.File) + '"' )

	Write-Verbose ( 'Log initialized.' )

	# Return object with log configuration
	return $Log

}
Export-ModuleMember -Function Initialize-xLog



# Write-xLog [-Log] {object} [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] {string}
function Write-xLog {
<# 
	.SYNOPSIS
		Write an entry in the format defined in the specified log file.

	.DESCRIPTION
		Write an entry in the log with this format:
			yyyy-MM-dd HH:mm:ss.fff (+hh:mm) | {Severity} | {Text message}
		'(+hh:mm)' is '(+00:00)' or the time zone offset from UTC.
		{Severity} is one of the following 'DEBUG', 'INFO', 'WARN', 'ERROR' or 'FATAL'.
		{Text message} is encoded in the specified character set.
		The common parameter VERBOSE is available for detailed information of process.

	.PARAMETER Log
		Object with the following information:
			'xLog'     : TRUE. This is just a flag indicating that the variable is correct.
			'File'     : Name of log file.
			'LocalTime': Timestamp for log entries is UTC by default. If this parameter is present, the time will be based local time zone.
			'Reverse'  : Entries are added at the end of the file by default. If this parameter is present, the entry is added at the beginning.
			'Console'  : If this parameter is present, the entry is additionally written in host (typically the console screen).
			'Encoding' : Encode the entry in a specific character set. See additional information in the parameter '-Encoding' of cmdlet 'Set-Content'.
		Mandatory.

	.PARAMETER Severity
		One of the following 'DEBUG', 'INFO', 'WARN', 'ERROR' or 'FATAL'.
		Describe the severity of the logged event and generally follow these conventions:
			DEBUG - Information that is helpful to developers.
			INFO  - General information.
			WARN  - An event that can potentially cause a process issue, but automatically recovered.
			ERROR - Error which occurs on the process.
			FATAL - Any error that is forcing a shutdown of the process.
		Mandatory.

	.PARAMETER Message
		Text message describing the event.
		Mandatory.

	.INPUTS
		None.

	.OUTPUTS
		None.

	.EXAMPLE
		Write-xLog -Log $MyLog -Severity DEBUG -Message 'LOREM IPSUM
		    Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    		Phasellus nisi arcu, commodo et ante id, tempus rutrum diam.
    		Fusce fermentum aliquet metus ut posuere. Etiam at libero augue.
    		Praesent at enim fermentum, porta nulla quis, elementum leo.
    		Nulla fermentum diam a neque posuere ultricies.
    		Praesent sem lorem, aliquam et purus.'

		Add a paragraph to the log file with information for developers (DEBUG).		

	.EXAMPLE
		Write-xLog -Log $MyLog -Severity INFO  -Message ( 'PowerShell version ' + ( $PSVersionTable.PSVersion ) )

		Add information about the PowerShell version to the log.

	.LINK
		https://github.com/FIN392/PowerShell/tree/master/xLog

	.NOTES
		Author: FIN392 - fin392@gmail.com
#>
	[CmdletBinding()]
	param (
		[Parameter ( Mandatory=$true, Position=1 )][object]$Log,
		[Parameter ( Mandatory=$true, Position=2 )]
			[ValidateSet('DEBUG','INFO','WARN','ERROR','FATAL')]
			[String]$Severity,
		[Parameter ( Mandatory=$true, Position=3 )][String]$Message
	)

	$ErrorActionPreference = 'Stop'

	Write-Verbose ( 'Adding entry to log...' )

	if ( -not $Log.xLog) {
		Write-Error ('Value of -Log parameter is not a valid xLog object')
	}

	# Set color based in severity
	$Color = switch ( $Severity ) {
		'DEBUG' { ((Get-Host).UI.RawUI.BackgroundColor),((Get-Host).UI.RawUI.ForegroundColor) }
		'INFO'  { 'Green',((Get-Host).UI.RawUI.BackgroundColor) }
		'WARN'  { 'Yellow',((Get-Host).UI.RawUI.BackgroundColor) }
		'ERROR' { 'Red',((Get-Host).UI.RawUI.BackgroundColor) }
		'FATAL' { 'White','Red' }
		Default { Write-Error ('"' + $_ + '" is not a valid log severity') }
	}

	# Set Timestamp
	if ( $Log.LocalTime ) {
		$Timestamp = (Get-Date).ToString( "yyyy-MM-dd HH:mm:ss.fff (K)" )
	} else {
		$Timestamp = (Get-Date).ToUniversalTime().ToString( "yyyy-MM-dd HH:mm:ss.fff (+00:00)" )
	}

	# Write text in console if requested
	if ( $Log.Console ) {
		Write-Host ( $Timestamp + ' | ' ) -NoNewline
		Write-Host ( '{0,-5}' -f $Severity.ToUpper() ) -NoNewline -ForegroundColor $Color[0] -BackgroundColor $Color[1]
		Write-Host ( ' | ' + $Message )
	}

	# Log entry to add
	$LogEntry = $Timestamp.PadRight(24) + ' | ' + $Severity.ToUpper().PadRight(5) + ' | ' + $Message

	#Add at top or botton of file
	if ( $Log.Reverse ) {
	    $LogContent = Get-Content -Path $Log.File
	    Set-Content -Path $Log.File -Value $LogEntry,$LogContent -Force -Encoding $Log.Encoding
	} else {
	    Add-Content -Path $Log.File -Value $LogEntry -Force -Encoding $Log.Encoding
	}
	# Out-File -FilePath $Log.File -Append -Encoding $Log.Encoding -InputObject $LogEntry

	Write-Verbose ( 'Entry added to log.' )

}
Export-ModuleMember -Function Write-xLog
