#
# xLog
#
# Author      : FIN392 - fin392@gmail.com
# Last update : 2020-05-03
# Version     : 0.2 - Initial release
# 
# For complete information on this PowerShell module go to:
# https://github.com/FIN392/PowerShell/blob/master/xLog/README
#


# <object> = Initialize-xLog [-File] <string> [-LocalTime] [-Reverse] [-Console] [-Encoding <"unknown;string;unicode;bigendianunicode;utf8;utf7;utf32;ascii;default;oem">]
function Initialize-xLog {
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



# Write-xLog [-Log] <object> [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] <string>
function Write-xLog {
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
		'DEBUG' { ((Get-Host).UI.RawUI.ForegroundColor),((Get-Host).UI.RawUI.BackgroundColor) }
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
