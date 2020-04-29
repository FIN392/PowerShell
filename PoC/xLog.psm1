#
# xLog
#
# Author      : FIN392 - fin392@gmail.com
# Last update : 2020-04-04
# Version     : 0.1 - Initial release
# 
# For complete information on this PowerShell module go to:
# https://github.com/FIN392/PowerShell/blob/master/xLog/README
#


# Start-xLog [-File] <string> [-Format] {TXT | CSV | XML | HTML | JSON} [-UTC]
function Start-xLog {
<# 
    .SYNOPSIS
        Start a log file.

    .DESCRIPTION
        A global variable with name 'xLogID_{Log ID}' is created with information to be used by functions 'Write-xLog' and 'Stop-xLog'.
        This global variable is an array with 3 values:
            - Log filename
            - Log format
            - UTC value
        The specified file is created (including the full path if necessary) and headers lines are written in.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER File
        File name where log entries will be written.
        ATTENTION: If the file already exists will be OVERWRITTEN without notice.
        Mandatory.
        Example: 'C:\TEMP\Log.xt', '\\SERVER\SHARE\output.html', 'C:\Apps\Events.json', etc.

    .PARAMETER Format
        Log file format.
        Accepted values: 
            TXT   To be seen on a console.
            CSV   To be exported to other applications.
            XML   To be managed by XML viewers.
            HTML  To be displayed on a web browser.
            JSON  To exchange information with Java applications.
        Mandatory.

    .PARAMETER UTC
        Establish the time zone and format for the timestamp.
        If UTC parameter is present, the timestamp will be on UTC time zone (aka Zulu time) and format ISO 8601, '{yyyyMMdd}T{HHmmssffff}Z'.
        Otherwise timestamp will be on local time zone and format '{yyyy}-{MM}-{dd} {HH}:{mm}:{ss}.{ffff}'. Column header will include the time zone. For example '(UTC+02:00)'.
        Optional.

    .INPUTS
        None.

    .OUTPUTS
        *********************************************
        OBJECT **************************************
        *********************************************.

    .EXAMPLE
        Start-xLog -LogID MasterLog -File '.\Logs\20200407.txt' -Format TXT

        Create a TXT log file named '20200407.txt' on folder '.\Logs'.
        Timestamp will be set to local time zone and format '{yyyy}-{MM}-{dd} {HH}:{mm}:{ss}.{ffff}'.

    .EXAMPLE
        Start-xLog -LogID LogProcess01 -File 'C:\Outputs\Process01.csv' -Format CSV -UTC

        Create a CSV log file named 'Process01.csv' on folder 'C:\Outputs'.
        Timestamp will be set to UTC and ISO 8601 format ('{yyyyMMdd}T{HHmmssffff}Z').

    .LINK
        https://github.com/FIN392/PowerShell/tree/master/xLog

    .NOTES
        Author: FIN392 - fin392@gmail.com
#>
    [CmdletBinding()]
    param (
        [Parameter ( Mandatory=$true, Position=2 )]
            [ValidateScript({
                if( -Not ($_ | Test-Path -IsValid) ){
                    throw "Path name is not valid"
                }
                return $true
            })]
            [String]$File,
        [Parameter ( Mandatory=$true, Position=3 )]
            [ValidateSet('TXT','CSV','XML','HTML','JSON')]
            [String]$Format,
        [Parameter ( Mandatory=$false,Position=4 )]
            [Switch]$UTC
    )

    Write-Verbose ( 'Starting log ' + $LogID + '...' )

    # Create Log object
    $Log = @{
        'File'=$File;
        'Format'=$Format;
        'UTC'=$UTC;
    }
    $objLog = New-Object  -TypeName psobject -Property $Log

    # # return $objLog
    
    # New-Variable -Name xLogID_$LogID -Value @($File,$Format,$UTC) -Scope Global -Force

    # # Get xLogID_ variable 
    # $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Create folder
    if ( -Not ( Test-Path -Path ( split-path -Path ($objLog.File) -Parent ) ) ) {
        [void]( New-Item -ItemType Directory -Force -Path (split-path -Path $objLog.File -Parent) )
        Write-Verbose ( '    Created path "' + (split-path -Path $objLog.File -Parent) + '"' )
    }
    
    # Create file
    if ( -Not (Test-Path -Path $objLog.File) ) {
        [void]( New-Item -Path (split-path -Path $objLog.File -Parent) -Name (split-path -Path $objLog.File -Leaf) -ItemType 'file' )
        Write-Verbose ( '    Created file "' + (split-path -Path $objLog.File -Leaf) + '"' )
    }

    Write-Verbose ( '    Set log file to "' + (Resolve-Path -Path $objLog.File) + '"' )

    # Set TimestampHeader
    $TimestampHeader = 'Timestamp' + ( &{ If( -Not $objLog.UTC ) { ' ' + (Get-Date -Format '(UTCK)') } } )
    
    # Add headers to the file based on type of log
    switch ( $objLog.Format.ToUpper() ) {
        'TXT'   {
            Out-File -FilePath $objLog.File         -InputObject ( $TimestampHeader.PadRight(24) + ' Severity Message' + " "*38 )
            Out-File -FilePath $objLog.File -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
        }
        'CSV'   {
            Out-File -FilePath $objLog.File         -InputObject ( '"' + $TimestampHeader + '","Severity","Message"' )
        }
        'XML'   {
            Out-File -FilePath $objLog.File         -InputObject ( '<?xml version="1.0"?>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '<Log>' )
        }
        'HTML'  {
            Out-File -FilePath $objLog.File         -InputObject ( '<!DOCTYPE html>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '<html>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '	<head>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '		<style>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '			table, th, td {border:1px solid black;border-collapse:collapse;}' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '			th, td {padding:5px;text-align:left;}' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '		</style>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '	</head>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '	<body>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '		<table>' )
            Out-File -FilePath $objLog.File -Append -InputObject ( '			<tr><th>' + $TimestampHeader + '</th><th>Severity</th><th>Message</th></tr>' )
        }
        'JSON'   {
            Out-File -FilePath $objLog.File         -InputObject ('[')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Added ' + $objLog.Format.ToUpper() + ' headers to log file "' + $objLog.File + '"' )

    Write-Verbose ( '    Log ' + $LogID + ' started' )

    return $objLog

}
Export-ModuleMember -Function Start-xLog



# Write-xLog [-LogID] <string> [-Severity] {DEBUG | INFO | WARN | ERROR | FATAL} [-Message] <string> [-Console]
function Write-xLog {
<# 
    .SYNOPSIS
        Write a entry in a log file.

    .DESCRIPTION
        A new entry is appended to the log file with following information:
            - Timestamp (Local time or UTC based on -UTC parameter during initialation)
            - Severety
            - Message.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER LogID
        A name that will identify the log.
        Mandatory.
        Example: 'Log01', 'MasterLog', 'LogTransactions', etc.

    .PARAMETER Severity
        Type of log entry to be added:
                DEBUG: Fine-grained informational events that are most useful to debug an application.
                INFO: Informational messages that highlight the progress of the application at coarse-grained level.
                WARN: Potentially harmful situations.
                ERROR: Error events that might still allow the application to continue running.
                FATAL: Very severe error events that will presumably lead the application to abort.
        Mandatory.

    .PARAMETER Message
        Description of the event.
        Mandatory.

    .PARAMETER Console
        Establish if the entry should be displayed on console.
        Message will be displayed in the following format:
            {yyyy}-{MM}-{dd} {HH}:{mm}:{ss}.{ffff} | {Severity} | {Message}
        Severity is shown in color.
        Optional.

    .INPUTS
        None.

    .OUTPUTS
        None.

    .EXAMPLE
        Write-xLog -LogID MasterLog -Severity DEBUG -Message 'This is a debug text' -Console

        Display this line on console:
            2020-04-07 22:51:18.4794 | DEBUG | This is a debug text
        If the log was started as TXT, a line with this format will e added:
            2020-04-07 22:51:18.4794 DEBUG    This is a debug text                         

    .EXAMPLE
        Write-xLog -LogID LogProcess01 -Severity INFO -Message 'This is a information text'

        If the log was started as CSV, a line with this format will e added:
            "20200405T2356267338Z","INFO","This is a information text"

    .EXAMPLE
        Write-xLog -LogID ERRORS -Severity WARN -Message 'This is a warning text' -Console

        Display this line on console:
            2020-04-05 23:56:27.0048 | WARN  | This is a warning text
        If the log was started as XML, a line with this format will e added:
	        <Entry><Timestamp>20200405T2356270048Z</Timestamp><Severity>WARN</Severity><Message>This is a warning text</Message></Entry>

    .EXAMPLE
        Write-xLog -LogID L001 -Severity ERROR -Message 'This is a error text'

        If the log was started as HTML, a line with this format will e added:
		    <tr><td>2020-04-06 01:56:27.2878</td><td style="background-color:Red;">ERROR</td><td>This is a error text</td></tr>

    .EXAMPLE
        Write-xLog -LogID GeneralLog -Severity FATAL -Message 'This is an error text'

        If the log was started as JSON, a line with this format will e added:
            {"Timestamp":"20200405T2356277338Z","Severity":"FATAL","Message":"This is an error text"},

    .LINK
        https://github.com/FIN392/PowerShell/tree/master/xLog

    .NOTES
        Author: FIN392 - fin392@gmail.com
#>
    [CmdletBinding()]
    param (
        [Parameter ( Mandatory=$true, Position=1 )][String]$LogID,
        [Parameter ( Mandatory=$true, Position=2 )][ValidateSet('DEBUG','INFO','WARN','ERROR','FATAL')][String]$Severity,
        [Parameter ( Mandatory=$true, Position=3 )][String]$Message,
        [Parameter ( Mandatory=$false,Position=4 )][Switch]$Console
    )

    Write-Verbose ( 'Adding entry to log ' + $LogID + '...' )

    # Get xLogID_ variable 
    $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Set color based in severity
    $EntryColor = switch ( $Severity ) {
        'DEBUG' { 'Green' }
        'INFO'  { 'Green' }
        'WARN'  { 'Yellow' }
        'ERROR' { 'Red' }
        'FATAL' { 'Red' }
        Default { Write-Error ('"' + $_ + '" is not a valid log severity') }
    }

    # Write text in console (if set)
    if ( $Console ) {
        Write-Host ( ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) + ' | ' ) -NoNewline
        Write-Host ( '{0,-5}' -f $Severity ) -NoNewline -ForegroundColor $EntryColor
        Write-Host ( ' | ' + $Message )
    }

    # Set TimestampHeader
    $TimestampHeader = 'Timestamp' + ( &{ If( -Not $objLog.UTC ) { ' ' + (Get-Date -Format '(UTCK)') } } )

    # Set TimestampString
    $TimestampString = ( &{ If( -Not $objLog.UTC ) { ( Get-Date -Format 'yyyy-MM-dd HH:mm:ss.ffff' ) } else { ( Get-Date -Format FileDateTimeUniversal ) } } )
    
    # Add text formated based on type of log
    switch ( $objLog.Format.ToUpper() ) {
        'TXT'   {
            $Line = $TimestampString.PadRight(24) + ' ' + $Severity.PadRight(8) + ' ' + ($Message+" "*45).Substring(0,45)
            Out-File -FilePath $objLog.File -Append -InputObject $Line
            for($i=1; $i*45 -le $Message.Length; $i++){
                $Line = ((" "*34)+($Message+" "*45).Substring($i*45,45))
                Out-File -FilePath $objLog.File -Append -InputObject $line
            }
        }
        'CSV'   {
            Out-File -FilePath $objLog.File -Append -InputObject ('"' + $TimestampString + '","' + $Severity + '","' + $Message + '"')
        }
        'XML'   {
            Out-File -FilePath $objLog.File -Append -InputObject ('	<Entry><' + $TimestampHeader + '>' + $TimestampString + '</Timestamp><Severity>' + $Severity + '</Severity><Message>' + $Message + '</Message></Entry>')
        }
        'HTML'  {
            Out-File -FilePath $objLog.File -Append -InputObject ('			<tr><td>' + $TimestampString + '</td><td style="background-color:' + $EntryColor + ';">' + $Severity + '</td><td>' + $Message + '</td></tr>')
        }
        'JSON'   {
            Out-File -FilePath $objLog.File -Append -InputObject ('	{"' + $TimestampHeader + '":"' + $TimestampString + '","Severity":"' + $Severity + '","Message":"' + $Message + '"},')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Entry added to log ' + $LogID )

}
Export-ModuleMember -Function Write-xLog



# Stop-xLog [-LogID] <string>
function Stop-xLog {
<# 
    .SYNOPSIS
        Stop a log file.

    .DESCRIPTION
        The global variable with name 'xLogID_+{Log ID}' is deleted.
        Footer lines are written in the log file.
        VERBOSE Common parameter is available for detailed information of process.

    .PARAMETER LogID
        A name that will identify the log.
        Mandatory.
        Example: 'Log01', 'MasterLog', 'LogTransactions', etc.

    .INPUTS
        None.

    .OUTPUTS
        None.

    .EXAMPLE
        Stop-xLog -LogID MasterLog

        Footer lines are added to log file and global variable is removed.

    .LINK
        https://github.com/FIN392/PowerShell/tree/master/xLog

    .NOTES
        Author: FIN392 - fin392@gmail.com
#>
    [CmdletBinding()]
    Param(
        [Parameter( Mandatory=$true, ValueFromPipelineByPropertyName=$true )]
            [ValidateScript({
                if( -Not ($_ | Test-Path -IsValid) ){
                    throw "Path name is not valid"
                }
                return $true
            })]
            [String]$File,
   
        [Parameter( Mandatory=$true, ValueFromPipelineByPropertyName=$true )]
            [ValidateSet('TXT','CSV','XML','HTML','JSON')]
            [String]$Format,
   
        [Parameter( Mandatory=$true, ValueFromPipelineByPropertyName=$true )]
            [String] $UTC
     )

    Write-Verbose ( 'Closing log ' + $File + '...' )

    # # Get xLogID_ variable 
    # $LogInfo = Get-Variable -Name xLogID_$LogID -ValueOnly

    # Add footer based on type of log
    switch ( $Format.ToUpper() ) {
        'TXT'   {
            Out-File -FilePath $File -Append -InputObject ( "-"*24 + ' ' + "-"*8 + ' ' + "-"*45 )
        }
        'CSV'   {
            Out-File -FilePath $File -Append -InputObject ('"","","***EOF***"')
        }
        'XML'   {
            Out-File -FilePath $File -Append -InputObject ('</Log>')
        }
        'HTML'  {
            Out-File -FilePath $File -Append -InputObject ('		</table>')
            Out-File -FilePath $File -Append -InputObject ('	</body>')
            Out-File -FilePath $File -Append -InputObject ('</html>')
        }
        'JSON'   {
            Out-File -FilePath $File -Append -InputObject (']')
        }
        default { Write-Error ('"' + $_ + '" is not a valid log format') }
    }

    Write-Verbose ( '    Added ' + $Format.ToUpper() + ' footer to log file "' + $File + '"' )

    # # Remove xLogID_ variable 
    # Remove-Variable -Name xLogID_$LogID -Scope Global

    Write-Verbose ( '    Log ' + $File + ' stopped' )

}
Export-ModuleMember -Function Stop-xLog

