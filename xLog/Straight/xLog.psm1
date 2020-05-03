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
		[Parameter ( Mandatory=$true, Position=1  )][ValidateScript({
			if( -Not ($_ | Test-Path -IsValid) ){
				throw "Path name is not valid"
			}
			return $true
		})][String]$File,
		[Parameter ( Mandatory=$false )][Switch]$LocalTime,
		[Parameter ( Mandatory=$false )][Switch]$Reverse,
		[Parameter ( Mandatory=$false )][Switch]$Console,
		[Parameter ( Mandatory=$false )][String]$Encoding = 'default'
	)

	Write-Verbose ( 'Initializing log...' )

	# Create log object
	$ArgLog = @{
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

	Write-Verbose ( 'Log ' + $LogID + ' initialized.' )

	# Return object with log configuration
	return $Log
}
Export-ModuleMember -Function Initialize-xLog



# Write-xLog [-Log] <object> [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] <string>
function Write-xLog {
	[CmdletBinding()]
	param (
		[Parameter ( Mandatory=$true, Position=1 )][String]$Log,
		[Parameter ( Mandatory=$true, Position=2 )][ValidateSet('DEBUG','INFO','WARN','ERROR','FATAL')][String]$Severity,
		[Parameter ( Mandatory=$true, Position=3 )][String]$Message
	)

# 
$Log | Format-List
# 

	Write-Verbose ( 'Adding entry to log ' + $Log.File + '...' )

	# Set color based in severity
	$EntryColor = switch ( $Severity ) {
		'DEBUG' { 'Blue' }
		'INFO'  { 'Green' }
		'WARN'  { 'Yellow' }
		'ERROR' { 'Red' }
		'FATAL' { 'Red' }
		Default { Write-Error ('"' + $_ + '" is not a valid log severity') }
	}

	# Write text in console (if set)
	if ( $Log.Console ) {
		Write-Host ( ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) + ' | ' ) -NoNewline
		Write-Host ( '{0,-5}' -f $Severity ) -NoNewline -ForegroundColor $EntryColor
		Write-Host ( ' | ' + $Message )
	}

	# Set TimestampHeader
	$TimestampHeader = 'Timestamp' + ( &{ If( -Not $Log.LocalTime ) { ' ' + (Get-Date -Format '(UTCK)') } } )

	# Set TimestampString
	$TimestampString = ( &{ If( -Not $Log.LocalTime ) { ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) } else { ( Get-Date -Format FileDateTimeUniversal ) } } )
	
	# Add text formated based on type of log
	# $Line = $TimestampString.PadRight(24) + ' ' + $Severity.PadRight(8) + ' ' + ($Message+" "*45).Substring(0,45)
	# Out-File -FilePath $Log.File -Append -InputObject $Line
	# for($i=1; $i*45 -le $Message.Length; $i++){
	# 	$Line = ((" "*34)+($Message+" "*45).Substring($i*45,45))
	# 	Out-File -FilePath $Log.File -Append -InputObject $line
	# }

	Write-Verbose ( '    Entry added to log ' + $LogID )

}
Export-ModuleMember -Function Write-xLog

# Cut-xLog { -MaxLines <int> | -MaxTime <int> }
function Cut-xLog {
}
Export-ModuleMember -Function Write-xLog

